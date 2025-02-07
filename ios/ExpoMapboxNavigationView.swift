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

    var topBannerBackgroundColor: UIColor?
    var topBannerPrimaryTextColor: UIColor?
    var topBannerSecondaryTextColor: UIColor?
    var topBannerDistanceTextColor: UIColor?
    var topBannerSeparatorColor: UIColor?

    var bottomBannerBackgroundColor: UIColor?
    var bottomBannerTimeRemainingTextColor: UIColor?
    var bottomBannerDistanceRemainingTextColor: UIColor?
    var bottomBannerArrivalTimeTextColor: UIColor?

    var informationStackBackgroundColor: UIColor?
    var informationStackTextColor: UIColor?
    var resumeButtonBackgroundColor: UIColor?
    var resumeButtonTextColor: UIColor?
    var speedLimitBackgroundColor: UIColor?
    var speedLimitTextColor: UIColor?
    var floatingStackBackgroundColor: UIColor?
    var floatingButtonsBackgroundColor: UIColor?
    var wayNameViewBackgroundColor: UIColor?
    var wayNameViewTextColor: UIColor?

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
        topBannerBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setTopBannerPrimaryTextColor(hexColor: String) {
        topBannerPrimaryTextColor = UIColor(hex: hexColor)
        update()
    }

    func setTopBannerSecondaryTextColor(hexColor: String) {
        topBannerSecondaryTextColor = UIColor(hex: hexColor)
        update()
    }

    func setTopBannerDistanceTextColor(hexColor: String) {
        topBannerDistanceTextColor = UIColor(hex: hexColor)
        update()
    }

    func setTopBannerSeparatorColor(hexColor: String) {
        topBannerSeparatorColor = UIColor(hex: hexColor)
        update()
    }

    func setBottomBannerBackgroundColor(hexColor: String) {
        bottomBannerBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setBottomBannerTimeRemainingTextColor(hexColor: String) {
        bottomBannerTimeRemainingTextColor = UIColor(hex: hexColor)
        update()
    }

    func setBottomBannerDistanceRemainingTextColor(hexColor: String) {
        bottomBannerDistanceRemainingTextColor = UIColor(hex: hexColor)
        update()
    }

    func setBottomBannerArrivalTimeTextColor(hexColor: String) {
        bottomBannerArrivalTimeTextColor = UIColor(hex: hexColor)
        update()
    }

    func setInformationStackBackgroundColor(hexColor: String) {
        informationStackBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setInformationStackTextColor(hexColor: String) {
        informationStackTextColor = UIColor(hex: hexColor)
        update()
    }

    func setResumeButtonBackgroundColor(hexColor: String) {
        resumeButtonBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setResumeButtonTextColor(hexColor: String) {
        resumeButtonTextColor = UIColor(hex: hexColor)
        update()
    }

    func setSpeedLimitBackgroundColor(hexColor: String) {
        speedLimitBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setSpeedLimitTextColor(hexColor: String) {
        speedLimitTextColor = UIColor(hex: hexColor)
        update()
    }

    func setFloatingStackBackgroundColor(hexColor: String) {
        floatingStackBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setFloatingButtonsBackgroundColor(hexColor: String) {
        floatingButtonsBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setWayNameViewBackgroundColor(hexColor: String) {
        wayNameViewBackgroundColor = UIColor(hex: hexColor)
        update()
    }

    func setWayNameViewTextColor(hexColor: String) {
        wayNameViewTextColor = UIColor(hex: hexColor)
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

    func onRoutesCalculated(navigationRoutes: NavigationRoutes){
        onRoutesLoaded?()

        let navigationViewController = NavigationViewController(
            navigationRoutes: navigationRoutes,
            navigationOptions: NavigationOptions(
                styles: [.dayStyle],
                navigationMapView: nil,
                voiceController: ExpoMapboxNavigationViewController.navigationProvider.routeVoiceController,
                eventsManager: ExpoMapboxNavigationViewController.navigationProvider.eventsManager()
            )
        )

        let navigationView = navigationViewController.navigationView

        // Customize top banner colors
        let topBanner = navigationView.topBannerContainerView
        topBanner.backgroundColor = topBannerBackgroundColor ?? UIColor(hex: "#FFFFFF")
        let instructionsView = navigationView.instructionsBannerView
        instructionsView.primaryLabel.textColor = topBannerPrimaryTextColor ?? UIColor(hex: "#000000")
        instructionsView.secondaryLabel.textColor = topBannerSecondaryTextColor ?? UIColor(hex: "#666666")
        instructionsView.distanceLabel.textColor = topBannerDistanceTextColor ?? UIColor(hex: "#666666")
        instructionsView.separatorView.backgroundColor = topBannerSeparatorColor ?? UIColor(hex: "#EEEEEE")
        
        // Customize bottom banner colors
        let bottomBanner = navigationView.bottomBannerContainerView
        bottomBanner.backgroundColor = bottomBannerBackgroundColor ?? UIColor(hex: "#FFFFFF")
        let bottomView = navigationView.bottomBannerView
        bottomView.timeRemainingLabel.textColor = bottomBannerTimeRemainingTextColor ?? UIColor(hex: "#000000")
        bottomView.distanceRemainingLabel.textColor = bottomBannerDistanceRemainingTextColor ?? UIColor(hex: "#666666")
        bottomView.arrivalTimeLabel.textColor = bottomBannerArrivalTimeTextColor ?? UIColor(hex: "#666666")

        let navigationMapView = navigationView.navigationMapView
        navigationMapView?.puckConfiguration = .puck2D()

        if let style = currentMapStyle {
            navigationMapView?.mapView.mapboxMap.loadStyle(StyleURI(rawValue: style)) { _ in
                navigationMapView?.localizeLabels(locale: self.currentLocale)
                do {
                    try navigationMapView?.mapView.mapboxMap.localizeLabels(into: self.currentLocale)
                } catch {
                    print("Failed to localize map labels: \(error)")
                }
            }
        }

        let cancelButton = navigationView.bottomBannerContainerView.findViews(subclassOf: CancelButton.self).first
        cancelButton?.addTarget(self, action: #selector(cancelButtonClicked), for: UIControl.Event.touchUpInside)

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
        navigationViewController.didMove(toParent: self)
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

        // 2. Information Stack
        let infoStack = navigationView.informationStackView
        infoStack.backgroundColor = informationStackBackgroundColor ?? UIColor(hex: "#FFFFFF")
        for view in infoStack.arrangedSubviews {
            if let label = view as? UILabel {
                label.textColor = informationStackTextColor ?? UIColor(hex: "#000000")
            }
        }

        // 4. Resume Button
        let resumeButton = navigationView.resumeButton
        resumeButton.backgroundColor = resumeButtonBackgroundColor ?? UIColor(hex: "#FFFFFF")
        resumeButton.setTitleColor(resumeButtonTextColor ?? UIColor(hex: "#000000"), for: UIControl.State.normal)

        // 5. Speed Limit View
        let speedLimitView = navigationView.speedLimitView
        speedLimitView.backgroundColor = speedLimitBackgroundColor ?? UIColor(hex: "#FFFFFF")
        if let speedLabel = speedLimitView.subviews.first as? UILabel {
            speedLabel.textColor = speedLimitTextColor ?? UIColor(hex: "#000000")
        }

        // 6. Floating Stack
        let floatingStack = navigationView.floatingStackView
        floatingStack.backgroundColor = floatingStackBackgroundColor ?? UIColor(hex: "#FFFFFF")
        for button in floatingStack.arrangedSubviews {
            if let floatingButton = button as? UIButton {
                floatingButton.backgroundColor = floatingButtonsBackgroundColor ?? UIColor(hex: "#FFFFFF")
            }
        }

        // 8. Way Name Label
        let wayNameView = navigationView.wayNameView
        wayNameView.backgroundColor = wayNameViewBackgroundColor ?? UIColor(hex: "#FFFFFF")
        wayNameView.label.textColor = wayNameViewTextColor ?? UIColor(hex: "#000000")
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
