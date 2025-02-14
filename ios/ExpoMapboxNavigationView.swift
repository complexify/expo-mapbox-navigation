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

    // Steps List
    func setStepsBackgroundColor(hexColor: String) {
        controller.customDayStyle.customStepsBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setStepsPrimaryTextColor(hexColor: String) {
        controller.customDayStyle.customStepsPrimaryTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setStepsSecondaryTextColor(hexColor: String) {
        controller.customDayStyle.customStepsSecondaryTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setStepsManeuverViewPrimaryColor(hexColor: String) {
        controller.customDayStyle.customStepsManeuverViewPrimaryColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setStepsManeuverViewSecondaryColor(hexColor: String) {
        controller.customDayStyle.customStepsManeuverViewSecondaryColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setStepsSeparatorColor(hexColor: String) {
        controller.customDayStyle.customStepsSeparatorColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Lane View
    func setLaneViewBackgroundColor(hexColor: String) {
        controller.customDayStyle.customLaneViewBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setLaneViewForegroundColor(hexColor: String) {
        controller.customDayStyle.customLaneViewForegroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setLaneViewSeparatorColor(hexColor: String) {
        controller.customDayStyle.customLaneViewSeparatorColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Next Banner View
    func setNextBannerBackgroundColor(hexColor: String) {
        controller.customDayStyle.customNextBannerBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setNextBannerPrimaryTextColor(hexColor: String) {
        controller.customDayStyle.customNextBannerPrimaryTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setNextBannerSecondaryTextColor(hexColor: String) {
        controller.customDayStyle.customNextBannerSecondaryTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setNextBannerDistanceTextColor(hexColor: String) {
        controller.customDayStyle.customNextBannerDistanceTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Progress Bar
    func setProgressBarProgressColor(hexColor: String) {
        controller.customDayStyle.customProgressBarProgressColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setProgressBarBackgroundColor(hexColor: String) {
        controller.customDayStyle.customProgressBarBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Instructions Card
    func setInstructionsCardBackgroundColor(hexColor: String) {
        controller.customDayStyle.customInstructionsCardBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    func setInstructionsCardSeparatorColor(hexColor: String) {
        controller.customDayStyle.customInstructionsCardSeparatorColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    func setInstructionsCardHighlightedSeparatorColor(hexColor: String) {
        controller.customDayStyle.customInstructionsCardHighlightedSeparatorColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    // Exit View
    func setExitViewForegroundColor(hexColor: String) {
        controller.customDayStyle.customExitViewForegroundColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    func setExitViewBorderColor(hexColor: String) {
        controller.customDayStyle.customExitViewBorderColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    func setExitViewHighlightColor(hexColor: String) {
        controller.customDayStyle.customExitViewHighlightColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    // Route Shield
    func setRouteShieldForegroundColor(hexColor: String) {
        controller.customDayStyle.customRouteShieldForegroundColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    func setRouteShieldBorderColor(hexColor: String) {
        controller.customDayStyle.customRouteShieldBorderColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    func setRouteShieldHighlightColor(hexColor: String) {
        controller.customDayStyle.customRouteShieldHighlightColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    // Distance Labels
    func setDistanceRemainingColor(hexColor: String) {
        controller.customDayStyle.customDistanceRemainingColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    func setDistanceUnitColor(hexColor: String) {
        controller.customDayStyle.customDistanceUnitColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setDistanceValueColor(hexColor: String) {
        controller.customDayStyle.customDistanceValueColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    // Navigation Map
    func setRouteAnnotationSelectedColor(hexColor: String) {
        controller.customDayStyle.customRouteAnnotationSelectedColor = UIColor(hex: hexColor)
        controller.update()
    }
    
    func setRouteAnnotationColor(hexColor: String) {
        controller.customDayStyle.customRouteAnnotationColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Route Shield Colors
    func setRoadShieldBlackColor(hexColor: String) {
        controller.customDayStyle.customRoadShieldBlackColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setRoadShieldBlueColor(hexColor: String) {
        controller.customDayStyle.customRoadShieldBlueColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setRoadShieldGreenColor(hexColor: String) {
        controller.customDayStyle.customRoadShieldGreenColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setRoadShieldRedColor(hexColor: String) {
        controller.customDayStyle.customRoadShieldRedColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setRoadShieldWhiteColor(hexColor: String) {
        controller.customDayStyle.customRoadShieldWhiteColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setRoadShieldYellowColor(hexColor: String) {
        controller.customDayStyle.customRoadShieldYellowColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setRoadShieldDefaultColor(hexColor: String) {
        controller.customDayStyle.customRoadShieldDefaultColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Button Properties
    func setButtonTextColor(hexColor: String) {
        controller.customDayStyle.customButtonTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setCancelButtonTintColor(hexColor: String) {
        controller.customDayStyle.customCancelButtonTintColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setPreviewButtonTintColor(hexColor: String) {
        controller.customDayStyle.customPreviewButtonTintColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setStartButtonTintColor(hexColor: String) {
        controller.customDayStyle.customStartButtonTintColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setDismissButtonBackgroundColor(hexColor: String) {
        controller.customDayStyle.customDismissButtonBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setDismissButtonTextColor(hexColor: String) {
        controller.customDayStyle.customDismissButtonTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setBackButtonBackgroundColor(hexColor: String) {
        controller.customDayStyle.customBackButtonBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setBackButtonTintColor(hexColor: String) {
        controller.customDayStyle.customBackButtonTintColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setBackButtonTextColor(hexColor: String) {
        controller.customDayStyle.customBackButtonTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setBackButtonBorderColor(hexColor: String) {
        controller.customDayStyle.customBackButtonBorderColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Navigation View
    func setNavigationViewBackgroundColor(hexColor: String) {
        controller.customDayStyle.customNavigationViewBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Distance Label Properties
    func setDistanceLabelUnitTextColor(hexColor: String) {
        controller.customDayStyle.customDistanceLabelUnitTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setDistanceLabelValueTextColor(hexColor: String) {
        controller.customDayStyle.customDistanceLabelValueTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Rating Control
    func setRatingControlNormalColor(hexColor: String) {
        controller.customDayStyle.customRatingControlNormalColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setRatingControlSelectedColor(hexColor: String) {
        controller.customDayStyle.customRatingControlSelectedColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Steps Properties
    func setStepsBackgroundViewColor(hexColor: String) {
        controller.customDayStyle.customStepsBackgroundViewColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setStepsTableHeaderTintColor(hexColor: String) {
        controller.customDayStyle.customStepsTableHeaderTintColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setStepsTableHeaderTextColor(hexColor: String) {
        controller.customDayStyle.customStepsTableHeaderTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setStepInstructionsBackgroundColor(hexColor: String) {
        controller.customDayStyle.customStepInstructionsBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setStepTableViewCellBackgroundColor(hexColor: String) {
        controller.customDayStyle.customStepTableViewCellBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Next Instruction
    func setNextInstructionNormalTextColor(hexColor: String) {
        controller.customDayStyle.customNextInstructionNormalTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setNextInstructionContainedTextColor(hexColor: String) {
        controller.customDayStyle.customNextInstructionContainedTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Secondary Label Properties
    func setSecondaryLabelNormalTextColor(hexColor: String) {
        controller.customDayStyle.customSecondaryLabelNormalTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    // Stylable Label
    func setStylableLabelNormalTextColor(hexColor: String) {
        controller.customDayStyle.customStylableLabelNormalTextColor = UIColor(hex: hexColor)
        controller.update()
    }

    // CarPlay Properties
    func setCarPlayCompassBackgroundColor(hexColor: String) {
        controller.customDayStyle.customCarPlayCompassBackgroundColor = UIColor(hex: hexColor)
        controller.update()
    }

    func setRouteCasingColor(hexColor: String) {
        customDayStyle.customRouteCasingColor = UIColor(hex: hexColor)
        update()
    }

    func setRouteAlternateCasingColor(hexColor: String) {
        customDayStyle.customRouteAlternateCasingColor = UIColor(hex: hexColor)
        update()
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

    func setManeuverViewPrimaryColorHighlighted(hexColor: String) {
        customDayStyle.customManeuverViewPrimaryColorHighlighted = UIColor(hex: hexColor)
        update()
    }

    func setManeuverViewSecondaryColorHighlighted(hexColor: String) {
        customDayStyle.customManeuverViewSecondaryColorHighlighted = UIColor(hex: hexColor)
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

    func calculateRoutes(waypoints: Array<Waypoint>) {
        let routeOptions = NavigationRouteOptions(
            waypoints: waypoints, 
            profileIdentifier: currentRouteProfile != nil ? ProfileIdentifier(rawValue: currentRouteProfile!) : nil,
            queryItems: [URLQueryItem(name: "exclude", value: currentRouteExcludeList?.joined(separator: ","))],
            locale: currentLocale, 
            distanceUnit: currentLocale.usesMetricSystem ? LengthFormatter.Unit.meter : LengthFormatter.Unit.mile
        )

        calculateRoutesTask = Task {
            do {
                let result = try await self.routingProvider!.calculateRoutes(options: routeOptions)
                switch result.result {
                case .success(let navigationRoutes):
                    onRoutesCalculated(navigationRoutes: navigationRoutes)
                case .failure(let error):
                    print("Route calculation error: \(error.localizedDescription)")
                }
            } catch {
                print("Failed to calculate routes: \(error.localizedDescription)")
            }
        }
    }

    func calculateMapMatchingRoutes(waypoints: Array<Waypoint>) {
        let matchOptions = NavigationMatchOptions(
            waypoints: waypoints, 
            profileIdentifier: currentRouteProfile != nil ? ProfileIdentifier(rawValue: currentRouteProfile!) : nil,
            queryItems: [URLQueryItem(name: "exclude", value: currentRouteExcludeList?.joined(separator: ","))],
            distanceUnit: currentLocale.usesMetricSystem ? LengthFormatter.Unit.meter : LengthFormatter.Unit.mile
        )
        matchOptions.locale = currentLocale

        calculateRoutesTask = Task {
            do {
                let result = try await self.routingProvider!.calculateRoutes(options: matchOptions)
                switch result.result {
                case .success(let navigationRoutes):
                    onRoutesCalculated(navigationRoutes: navigationRoutes)
                case .failure(let error):
                    print("Map matching error: \(error.localizedDescription)")
                }
            } catch {
                print("Failed to match routes: \(error.localizedDescription)")
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
        if let casingColor = customDayStyle.customRouteCasingColor {
            navigationMapView?.routeCasingColor = casingColor
        }
        if let arrowColor = customDayStyle.customManeuverArrowColor {
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