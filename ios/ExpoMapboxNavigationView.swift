import ExpoModulesCore
import MapboxNavigationCore
import MapboxMaps
import MapboxNavigationUIKit
import MapboxDirections
import Combine


class ExpoMapboxNavigationView: ExpoView {
    private let onRouteProgressChanged = EventDispatcher()
    private let onCancelNavigation = EventDispatcher()
    private let onWaypointArrival = EventDispatcher()
    private let onFinalDestinationArrival = EventDispatcher()
    private let onRouteChanged = EventDispatcher()
    private let onUserOffRoute = EventDispatcher()
    private let onRoutesLoaded = EventDispatcher()

    let controller = ExpoMapboxNavigationViewController()

    required init(appContext: AppContext? = nil) {
        super.init(appContext: appContext)
        clipsToBounds = true
        addSubview(controller.view)

        controller.onRouteProgressChanged = onRouteProgressChanged
        controller.onCancelNavigation = onCancelNavigation
        controller.onWaypointArrival = onWaypointArrival
        controller.onFinalDestinationArrival = onFinalDestinationArrival
        controller.onRouteChanged = onRouteChanged
        controller.onUserOffRoute = onUserOffRoute
        controller.onRoutesLoaded = onRoutesLoaded
    }

    override func layoutSubviews() {
        controller.view.frame = bounds
    }
}


class ExpoMapboxNavigationViewController: UIViewController {
    static let navigationProvider: MapboxNavigationProvider = MapboxNavigationProvider(coreConfig: .init(locationSource: .live))
    var mapboxNavigation: MapboxNavigation? = nil
    var routingProvider: RoutingProvider? = nil
    var navigation: NavigationController? = nil
    var tripSession: SessionController? = nil

    var currentCoordinates: Array<CLLocationCoordinate2D>? = nil
    var currentWaypointIndices: Array<Int>? = nil
    var currentLocale: Locale = Locale.current
    var currentRouteProfile: String? = nil
    var currentRouteExcludeList: Array<String>? = nil
    var currentMapStyle: String? = nil
    var isUsingRouteMatchingApi: Bool = false

    var onRouteProgressChanged: EventDispatcher? = nil
    var onCancelNavigation: EventDispatcher? = nil
    var onWaypointArrival: EventDispatcher? = nil
    var onFinalDestinationArrival: EventDispatcher? = nil
    var onRouteChanged: EventDispatcher? = nil
    var onUserOffRoute: EventDispatcher? = nil
    var onRoutesLoaded: EventDispatcher? = nil

    var calculateRoutesTask: Task<Void, Error>? = nil
    private var routeProgressCancellable: AnyCancellable? = nil
    private var waypointArrivalCancellable: AnyCancellable? = nil
    private var reroutingCancellable: AnyCancellable? = nil
    private var sessionCancellable: AnyCancellable? = nil

    var currentRouteColor: UIColor?
    var currentRouteAlternateColor: UIColor?
    var currentRouteCasingColor: UIColor?
    var currentRouteAlternateCasingColor: UIColor?
    var currentTraversedRouteColor: UIColor?
    var currentManeuverArrowColor: UIColor?

    var currentTopBannerBackgroundColor: UIColor?
    var currentTopBannerPrimaryTextColor: UIColor?
    var currentTopBannerSecondaryTextColor: UIColor?
    var currentTopBannerDistanceTextColor: UIColor?
    var currentTopBannerSeparatorColor: UIColor?

    var currentBottomBannerBackgroundColor: UIColor?
    var currentBottomBannerTimeRemainingTextColor: UIColor?
    var currentBottomBannerDistanceRemainingTextColor: UIColor?
    var currentBottomBannerArrivalTimeTextColor: UIColor?

    var currentInformationStackBackgroundColor: UIColor?
    var currentInformationStackTextColor: UIColor?
    var currentFloatingStackBackgroundColor: UIColor?
    var currentFloatingButtonsBackgroundColor: UIColor?
    var currentSpeedLimitBackgroundColor: UIColor?
    var currentSpeedLimitTextColor: UIColor?
    var currentWayNameViewBackgroundColor: UIColor?
    var currentResumeButtonBackgroundColor: UIColor?
    var currentResumeButtonTextColor: UIColor?

    let customDayStyle = CustomDayStyle()

    private var bottomSheetViewController: UIViewController?
    private var bottomSheetPanGestureRecognizer: UIPanGestureRecognizer?
    private var bottomSheetTopConstraint: NSLayoutConstraint?
    private let bottomSheetHeight: CGFloat = 300 // Adjust this value as needed

    init() {
        super.init(nibName: nil, bundle: nil)
        mapboxNavigation = ExpoMapboxNavigationViewController.navigationProvider.mapboxNavigation
        routingProvider = mapboxNavigation!.routingProvider()
        navigation = mapboxNavigation!.navigation()
        tripSession = mapboxNavigation!.tripSession()

        routeProgressCancellable = navigation!.routeProgress.sink { progressState in
            if(progressState != nil){
               self.onRouteProgressChanged?([
                    "distanceRemaining": progressState!.routeProgress.distanceRemaining,
                    "distanceTraveled": progressState!.routeProgress.distanceTraveled,
                    "durationRemaining": progressState!.routeProgress.durationRemaining,
                    "fractionTraveled": progressState!.routeProgress.fractionTraveled,
                ])
            }
        }

        waypointArrivalCancellable = navigation!.waypointsArrival.sink { arrivalStatus in
            let event = arrivalStatus.event
            if event is WaypointArrivalStatus.Events.ToFinalDestination {
                self.onFinalDestinationArrival?()
            } else if event is WaypointArrivalStatus.Events.ToWaypoint {
                self.onWaypointArrival?()
            }
        }

        reroutingCancellable = navigation!.rerouting.sink { rerouteStatus in
            self.onRouteChanged?()            
        }

        sessionCancellable = tripSession!.session.sink { session in 
            let state = session.state
            switch state {
                case .activeGuidance(let activeGuidanceState):
                    switch(activeGuidanceState){
                        case .offRoute:
                            self.onUserOffRoute?()
                        default: break
                    }
                default: break
            }
        }

    }

    deinit {
        routeProgressCancellable?.cancel()
        waypointArrivalCancellable?.cancel()
        reroutingCancellable?.cancel()
        sessionCancellable?.cancel()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Task { @MainActor in tripSession?.setToIdle() } // Stops navigation
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("This controller should not be loaded through a story board")
    }


    func setCoordinates(coordinates: Array<CLLocationCoordinate2D>) {
        currentCoordinates = coordinates
        update()
    }

    func setLocale(locale: String?) {
        if(locale != nil){
            currentLocale = Locale(identifier: locale!)
        } else {
            currentLocale = Locale.current
        }
        update()
    }

    func setIsUsingRouteMatchingApi(useRouteMatchingApi: Bool?){
        isUsingRouteMatchingApi = useRouteMatchingApi ?? false
        update()
    }

    func setWaypointIndices(waypointIndices: Array<Int>?){
        currentWaypointIndices = waypointIndices
        update()
    }

    func setRouteProfile(profile: String?){
        currentRouteProfile = profile
        update()
    }

    func setRouteExcludeList(excludeList: Array<String>?){
        currentRouteExcludeList = excludeList
        update()
    }

    func setMapStyle(style: String?){
        currentMapStyle = style
        update()
    }

     func setIsMuted(isMuted: Bool?){
        if(isMuted != nil){
            ExpoMapboxNavigationViewController.navigationProvider.routeVoiceController.speechSynthesizer.muted = isMuted!
        }
    }

    func setRouteColor(hexColor: String) {
        currentRouteColor = UIColor(hex: hexColor)
        update()
    }

    func setRouteAlternateColor(hexColor: String) {
        currentRouteAlternateColor = UIColor(hex: hexColor)
        update()
    }

    func setRouteCasingColor(hexColor: String) {
        currentRouteCasingColor = UIColor(hex: hexColor)
        update()
    }

    func setRouteAlternateCasingColor(hexColor: String) {
        currentRouteAlternateCasingColor = UIColor(hex: hexColor)
        update()
    }

    func setTraversedRouteColor(hexColor: String) {
        currentTraversedRouteColor = UIColor(hex: hexColor)
        update()
    }

    func setManeuverArrowColor(hexColor: String) {
        currentManeuverArrowColor = UIColor(hex: hexColor)
        update()
    }

    func setTopBannerBackgroundColor(hexColor: String) {
        customDayStyle.customTopBannerBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setTopBannerPrimaryTextColor(hexColor: String) {
        customDayStyle.customTopBannerPrimaryTextColor = UIColor(hex: hexColor)
        update()
    }

    func setTopBannerSecondaryTextColor(hexColor: String) {
        customDayStyle.customTopBannerSecondaryTextColor = UIColor(hex: hexColor)
        update()
    }

    func setTopBannerDistanceTextColor(hexColor: String) {
        customDayStyle.customTopBannerDistanceTextColor = UIColor(hex: hexColor)
        update()
    }

    func setTopBannerSeparatorColor(hexColor: String) {
        currentTopBannerSeparatorColor = UIColor(hex: hexColor)
    }

    func setBottomBannerBackgroundColor(hexColor: String) {
        customDayStyle.customBottomBannerBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setBottomBannerTimeRemainingTextColor(hexColor: String) {
        customDayStyle.customBottomBannerTimeRemainingTextColor = UIColor(hex: hexColor)
        update()
    }

    func setBottomBannerDistanceRemainingTextColor(hexColor: String) {
        customDayStyle.customBottomBannerDistanceRemainingTextColor = UIColor(hex: hexColor)
        update()
    }

    func setBottomBannerArrivalTimeTextColor(hexColor: String) {
        customDayStyle.customBottomBannerArrivalTimeTextColor = UIColor(hex: hexColor)
        update()
    }

    func setInformationStackBackgroundColor(hexColor: String) {
        currentInformationStackBackgroundColor = UIColor(hex: hexColor)
        // Apply color in onRoutesCalculated
    }

    func setInformationStackTextColor(hexColor: String) {
        currentInformationStackTextColor = UIColor(hex: hexColor)
        // Apply color in onRoutesCalculated
    }

    func setFloatingStackBackgroundColor(hexColor: String) {
        currentFloatingStackBackgroundColor = UIColor(hex: hexColor)
        // Apply color in onRoutesCalculated
    }

    func setFloatingButtonsBackgroundColor(hexColor: String) {
        customDayStyle.customFloatingButtonsBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setFloatingButtonsTextColor(hexColor: String) {
        customDayStyle.customFloatingButtonsTextColor = UIColor(hex: hexColor)
        update()
    }

    func setFloatingButtonsBorderColor(hexColor: String) {
        customDayStyle.customFloatingButtonsBorderColor = UIColor(hex: hexColor)
        update()
    }

    func setSpeedLimitBackgroundColor(hexColor: String) {
        customDayStyle.customSpeedLimitBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setSpeedLimitTextColor(hexColor: String) {
        customDayStyle.customSpeedLimitTextColor = UIColor(hex: hexColor)
        update()
    }

    func setWayNameViewBackgroundColor(hexColor: String) {
        customDayStyle.customWayNameBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setResumeButtonBackgroundColor(hexColor: String) {
        customDayStyle.customResumeButtonBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setResumeButtonTextColor(hexColor: String) {
        customDayStyle.customResumeButtonTextColor = UIColor(hex: hexColor)
        update()
    }

    func setResumeButtonBorderColor(hexColor: String) {
        customDayStyle.customResumeButtonBorderColor = UIColor(hex: hexColor)
        update()
    }

    func setSpeedLimitBorderColor(hexColor: String) {
        customDayStyle.customSpeedLimitBorderColor = UIColor(hex: hexColor)
        update()
    }

    func update(){
        calculateRoutesTask?.cancel()

        if(currentCoordinates != nil){
            let waypoints = currentCoordinates!.enumerated().map {
                let index = $0
                let coordinate = $1
                var waypoint = Waypoint(coordinate: coordinate) 
                waypoint.separatesLegs = currentWaypointIndices == nil ? true : currentWaypointIndices!.contains(index)
                return waypoint
            }

            if(isUsingRouteMatchingApi){
                calculateMapMatchingRoutes(waypoints: waypoints)
            } else {
                calculateRoutes(waypoints: waypoints)
            }
        }
    }

    func calculateRoutes(waypoints: Array<Waypoint>){
        let routeOptions = NavigationRouteOptions(
            waypoints: waypoints, 
            profileIdentifier: currentRouteProfile != nil ? ProfileIdentifier(rawValue: currentRouteProfile!) : nil,
            queryItems: [URLQueryItem(name: "exclude", value: currentRouteExcludeList?.joined(separator: ","))],
            locale: currentLocale, 
            distanceUnit: currentLocale.usesMetricSystem ? LengthFormatter.Unit.meter : LengthFormatter.Unit.mile
        )

        calculateRoutesTask = Task {
            switch await self.routingProvider!.calculateRoutes(options: routeOptions).result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let navigationRoutes):
                onRoutesCalculated(navigationRoutes: navigationRoutes)
            }
        }
    }

    func calculateMapMatchingRoutes(waypoints: Array<Waypoint>){
        let matchOptions = NavigationMatchOptions(
            waypoints: waypoints, 
            profileIdentifier: currentRouteProfile != nil ? ProfileIdentifier(rawValue: currentRouteProfile!) : nil,
            queryItems: [URLQueryItem(name: "exclude", value: currentRouteExcludeList?.joined(separator: ","))],
            distanceUnit: currentLocale.usesMetricSystem ? LengthFormatter.Unit.meter : LengthFormatter.Unit.mile
        )
        matchOptions.locale = currentLocale


        calculateRoutesTask = Task {
            switch await self.routingProvider!.calculateRoutes(options: matchOptions).result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let navigationRoutes):
                onRoutesCalculated(navigationRoutes: navigationRoutes)
            }
        }
    }

    @objc func cancelButtonClicked(_ sender: AnyObject?) {
        onCancelNavigation?()
    }

    func onRoutesCalculated(navigationRoutes: NavigationRoutes) {
        onRoutesLoaded?()

        let topBanner = TopBannerViewController()
        topBanner.instructionsBannerView.distanceFormatter.locale = currentLocale
        
        let bottomBanner = BottomBannerViewController()
        bottomBanner.distanceFormatter.locale = currentLocale
        bottomBanner.dateFormatter.locale = currentLocale

        // Add pan gesture recognizer to bottom banner
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleBottomBannerPan(_:)))
        bottomBanner.view.addGestureRecognizer(panGesture)
        
        // Setup bottom sheet
        setupBottomSheet()

        let navigationOptions = NavigationOptions(
            mapboxNavigation: self.mapboxNavigation!,
            voiceController: ExpoMapboxNavigationViewController.navigationProvider.routeVoiceController,
            eventsManager: ExpoMapboxNavigationViewController.navigationProvider.eventsManager(),
            styles: [customDayStyle],
            topBanner: topBanner,
            bottomBanner: bottomBanner
        )

        let navigationViewController = NavigationViewController(
            navigationRoutes: navigationRoutes,
            navigationOptions: navigationOptions
        )

        let navigationMapView = navigationViewController.navigationMapView
        navigationMapView!.puckType = .puck2D(.navigationDefault)

        let style = currentMapStyle != nil ? StyleURI(rawValue: currentMapStyle!) : StyleURI.streets
        navigationMapView!.mapView.mapboxMap.loadStyle(style!, completion: { _ in
            navigationMapView!.localizeLabels(locale: self.currentLocale)
            do{
                try navigationMapView!.mapView.mapboxMap.localizeLabels(into: self.currentLocale)
            } catch {}
        })
 

        let cancelButton = navigationViewController.navigationView.bottomBannerContainerView.findViews(subclassOf: CancelButton.self)[0]
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)

        navigationViewController.delegate = self
        addChild(navigationViewController)
        view.addSubview(navigationViewController.view)
        navigationViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navigationViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navigationViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        didMove(toParent: self)
        mapboxNavigation!.tripSession().startActiveGuidance(with: navigationRoutes, startLegIndex: 0)
    
        // Apply custom colors if set
        if let routeColor = currentRouteColor {
            navigationMapView?.routeColor = routeColor
        }
        if let alternateColor = currentRouteAlternateColor {
            navigationMapView?.routeAlternateColor = alternateColor
        }
        if let casingColor = currentRouteCasingColor {
            navigationMapView?.routeCasingColor = casingColor
        }
        if let alternateCasingColor = currentRouteAlternateCasingColor {
            navigationMapView?.routeAlternateCasingColor = alternateCasingColor
        }
        if let traversedColor = currentTraversedRouteColor {
            navigationMapView?.traversedRouteColor = traversedColor
        }
        if let arrowColor = currentManeuverArrowColor {
            navigationMapView?.maneuverArrowColor = arrowColor
        }
    }

    private func setupBottomSheet() {
        bottomSheetViewController = UIViewController()
        guard let bottomSheet = bottomSheetViewController else { return }
        
        bottomSheet.view.backgroundColor = .white
        bottomSheet.view.layer.cornerRadius = 16
        bottomSheet.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomSheet.view.clipsToBounds = true
        
        // Add shadow
        bottomSheet.view.layer.shadowColor = UIColor.black.cgColor
        bottomSheet.view.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomSheet.view.layer.shadowRadius = 3
        bottomSheet.view.layer.shadowOpacity = 0.2
        
        addChild(bottomSheet)
        view.addSubview(bottomSheet.view)
        bottomSheet.didMove(toParent: self)
        
        bottomSheet.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Position bottom sheet initially off screen
        bottomSheetTopConstraint = bottomSheet.view.topAnchor.constraint(equalTo: view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            bottomSheet.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheet.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheet.view.heightAnchor.constraint(equalToConstant: bottomSheetHeight),
            bottomSheetTopConstraint!
        ])
        
        // Add some sample content to the bottom sheet
        let label = UILabel()
        label.text = "Bottom Sheet Content"
        label.textAlignment = .center
        
        bottomSheet.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: bottomSheet.view.centerXAnchor),
            label.topAnchor.constraint(equalTo: bottomSheet.view.topAnchor, constant: 20)
        ])
    }
    
    @objc private func handleBottomBannerPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            // Update bottom sheet position based on pan
            let newConstant = view.frame.height - bottomSheetHeight + translation.y
            bottomSheetTopConstraint?.constant = min(view.frame.height, max(newConstant, view.frame.height - bottomSheetHeight))
            
        case .ended:
            // Determine whether to show or hide based on velocity and position
            let shouldShow = velocity.y < 0 || bottomSheetTopConstraint?.constant ?? 0 < view.frame.height - bottomSheetHeight/2
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.bottomSheetTopConstraint?.constant = shouldShow ? 
                    self.view.frame.height - self.bottomSheetHeight : 
                    self.view.frame.height
                self.view.layoutIfNeeded()
            }
            
        default:
            break
        }
    }
}
extension ExpoMapboxNavigationViewController: NavigationViewControllerDelegate {
    func navigationViewController(_ navigationViewController: NavigationViewController, didRerouteAlong route: Route) {}

    func navigationViewControllerDidDismiss(
        _ navigationViewController: NavigationViewController,
        byCanceling canceled: Bool
    ) { }
}

extension UIView {
    func findViews<T: UIView>(subclassOf: T.Type) -> [T] {
        return recursiveSubviews.compactMap { $0 as? T }
    }

    var recursiveSubviews: [UIView] {
        return subviews + subviews.flatMap { $0.recursiveSubviews }
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}