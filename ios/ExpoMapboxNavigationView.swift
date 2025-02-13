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

    func setStepsBackgroundColor(hexColor: String) {
        customDayStyle.customStepsBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setStepsPrimaryTextColor(hexColor: String) {
        customDayStyle.customStepsPrimaryTextColor = UIColor(hex: hexColor)
        update()
    }

    func setStepsSecondaryTextColor(hexColor: String) {
        customDayStyle.customStepsSecondaryTextColor = UIColor(hex: hexColor)
        update()
    }

    func setStepsManeuverViewPrimaryColor(hexColor: String) {
        customDayStyle.customStepsManeuverViewPrimaryColor = UIColor(hex: hexColor)
        update()
    }

    func setLaneViewBackgroundColor(hexColor: String) {
        customDayStyle.customLaneViewBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setNextBannerBackgroundColor(hexColor: String) {
        customDayStyle.customNextBannerBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setNextBannerPrimaryTextColor(hexColor: String) {
        customDayStyle.customNextBannerPrimaryTextColor = UIColor(hex: hexColor)
        update()
    }

    func setNextBannerSecondaryTextColor(hexColor: String) {
        customDayStyle.customNextBannerSecondaryTextColor = UIColor(hex: hexColor)
        update()
    }

    func setNextBannerDistanceTextColor(hexColor: String) {
        customDayStyle.customNextBannerDistanceTextColor = UIColor(hex: hexColor)
        update()
    }

    func setProgressBarProgressColor(hexColor: String) {
        customDayStyle.customProgressBarProgressColor = UIColor(hex: hexColor)
        update()
    }

    func setProgressBarBackgroundColor(hexColor: String) {
        customDayStyle.customProgressBarBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setManeuverViewPrimaryColor(hexColor: String) {
        customDayStyle.customManeuverViewPrimaryColor = UIColor(hex: hexColor)
        update()
    }

    func setManeuverViewSecondaryColor(hexColor: String) {
        customDayStyle.customManeuverViewSecondaryColor = UIColor(hex: hexColor)
        update()
    }

    func setManeuverViewPrimaryColorHighlighted(hexColor: String) {
        customDayStyle.customManeuverViewPrimaryColorHighlighted = UIColor(hex: hexColor)
        update()
    }

    func setManeuverViewSecondaryColorHighlighted(hexColor: String) {
        customDayStyle.customManeuverViewSecondaryColorHighlighted = UIColor(hex: hexColor)
        update()
    }

    func setInstructionsCardBackgroundColor(hexColor: String) {
        customDayStyle.customInstructionsCardBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setInstructionsCardSeparatorColor(hexColor: String) {
        customDayStyle.customInstructionsCardSeparatorColor = UIColor(hex: hexColor)
        update()
    }

    func setInstructionsCardHighlightedSeparatorColor(hexColor: String) {
        customDayStyle.customInstructionsCardHighlightedSeparatorColor = UIColor(hex: hexColor)
        update()
    }

    func setExitViewForegroundColor(hexColor: String) {
        customDayStyle.customExitViewForegroundColor = UIColor(hex: hexColor)
        update()
    }

    func setExitViewBorderColor(hexColor: String) {
        customDayStyle.customExitViewBorderColor = UIColor(hex: hexColor)
        update()
    }

    func setExitViewHighlightColor(hexColor: String) {
        customDayStyle.customExitViewHighlightColor = UIColor(hex: hexColor)
        update()
    }

    func setRouteShieldForegroundColor(hexColor: String) {
        customDayStyle.customRouteShieldForegroundColor = UIColor(hex: hexColor)
        update()
    }

    func setRouteShieldBorderColor(hexColor: String) {
        customDayStyle.customRouteShieldBorderColor = UIColor(hex: hexColor)
        update()
    }

    func setRouteShieldHighlightColor(hexColor: String) {
        customDayStyle.customRouteShieldHighlightColor = UIColor(hex: hexColor)
        update()
    }

    func setDistanceRemainingColor(hexColor: String) {
        customDayStyle.customDistanceRemainingColor = UIColor(hex: hexColor)
        update()
    }

    func setDistanceUnitColor(hexColor: String) {
        customDayStyle.customDistanceUnitColor = UIColor(hex: hexColor)
        update()
    }

    func setDistanceValueColor(hexColor: String) {
        customDayStyle.customDistanceValueColor = UIColor(hex: hexColor)
        update()
    }

    func setRatingControlNormalColor(hexColor: String) {
        customDayStyle.customRatingControlNormalColor = UIColor(hex: hexColor)
        update()
    }

    func setRatingControlSelectedColor(hexColor: String) {
        customDayStyle.customRatingControlSelectedColor = UIColor(hex: hexColor)
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