import MapboxMaps
import MapboxNavigationCore
import MapboxNavigationUIKit
import UIKit

class CustomDayStyle: Style {
    // Speed Limit View
    var customSpeedLimitTextColor: UIColor?
    var customSpeedLimitBackgroundColor: UIColor?
    var customSpeedLimitBorderColor: UIColor?
    
    // Bottom Banner
    var customBottomBannerBackgroundColor: UIColor?
    var customBottomBannerTimeRemainingTextColor: UIColor?
    var customBottomBannerDistanceRemainingTextColor: UIColor?
    var customBottomBannerArrivalTimeTextColor: UIColor?
    
    // Way Name View
    var customWayNameBackgroundColor: UIColor?
    var customWayNameTextColor: UIColor?
    
    // Top Banner
    var customTopBannerBackgroundColor: UIColor?
    var customTopBannerPrimaryTextColor: UIColor?
    var customTopBannerSecondaryTextColor: UIColor?
    var customTopBannerDistanceTextColor: UIColor?
    var customTopBannerSeparatorColor: UIColor?
    
    // Resume Button
    var customResumeButtonBackgroundColor: UIColor?
    var customResumeButtonTextColor: UIColor?
    var customResumeButtonBorderColor: UIColor?
    
    // Floating Buttons
    var customFloatingButtonsBackgroundColor: UIColor?
    var customFloatingButtonsBorderColor: UIColor?
    var customFloatingButtonsTextColor: UIColor?
    
    // Maneuver View
    var customManeuverViewPrimaryColor: UIColor?
    var customManeuverViewSecondaryColor: UIColor?
    var customManeuverViewPrimaryColorHighlighted: UIColor?
    var customManeuverViewSecondaryColorHighlighted: UIColor?
    
    // Steps List
    var customStepsBackgroundColor: UIColor?
    var customStepsPrimaryTextColor: UIColor?
    var customStepsSecondaryTextColor: UIColor?
    var customStepsManeuverViewPrimaryColor: UIColor?
    var customStepsManeuverViewSecondaryColor: UIColor?
    var customStepsSeparatorColor: UIColor?
    
    // Lane View
    var customLaneViewBackgroundColor: UIColor?
    var customLaneViewForegroundColor: UIColor?
    var customLaneViewSeparatorColor: UIColor?
    
    // Next Banner View
    var customNextBannerBackgroundColor: UIColor?
    var customNextBannerPrimaryTextColor: UIColor?
    var customNextBannerSecondaryTextColor: UIColor?
    var customNextBannerDistanceTextColor: UIColor?
    
    // Progress Bar
    var customProgressBarProgressColor: UIColor?
    var customProgressBarBackgroundColor: UIColor?
    
    // Exit View
    var customExitViewForegroundColor: UIColor?
    var customExitViewBorderColor: UIColor?
    var customExitViewHighlightColor: UIColor?

    // Route Shield
    var customRouteShieldForegroundColor: UIColor?
    var customRouteShieldBorderColor: UIColor?
    var customRouteShieldHighlightColor: UIColor?

    // Distance Labels
    var customDistanceRemainingColor: UIColor?
    var customDistanceUnitColor: UIColor?
    var customDistanceValueColor: UIColor?

    // Navigation Map
    var customRouteColor: UIColor?
    var customRouteAlternateColor: UIColor?
    var customRouteCasingColor: UIColor?
    var customRouteAlternateCasingColor: UIColor?
    var customTraversedRouteColor: UIColor?
    var customManeuverArrowColor: UIColor?
    var customRouteAnnotationSelectedColor: UIColor?
    var customRouteAnnotationColor: UIColor?
    var customRouteAnnotationTextColor: UIColor?
    var customRouteAnnotationSelectedTextColor: UIColor?
    var customRouteAnnotationMoreTimeTextColor: UIColor?
    var customRouteAnnotationLessTimeTextColor: UIColor?
    var customWaypointColor: UIColor?
    var customWaypointStrokeColor: UIColor?

    // Instructions Card
    var customInstructionsCardBackgroundColor: UIColor?
    var customInstructionsCardSeparatorColor: UIColor?
    var customInstructionsCardHighlightedSeparatorColor: UIColor?

    // Feedback
    var customFeedbackBackgroundColor: UIColor?
    var customFeedbackTextColor: UIColor?
    var customFeedbackCellColor: UIColor?
    var customFeedbackSubtypeCircleColor: UIColor?
    var customFeedbackSubtypeCircleOutlineColor: UIColor?

    // End of Route
    var customEndOfRouteButtonTextColor: UIColor?
    var customEndOfRouteCommentBackgroundColor: UIColor?
    var customEndOfRouteCommentTextColor: UIColor?
    var customEndOfRouteContentBackgroundColor: UIColor?
    var customEndOfRouteTitleTextColor: UIColor?

    // Road Shield Colors
    var customRoadShieldBlackColor: UIColor?
    var customRoadShieldBlueColor: UIColor?
    var customRoadShieldGreenColor: UIColor?
    var customRoadShieldRedColor: UIColor?
    var customRoadShieldWhiteColor: UIColor?
    var customRoadShieldYellowColor: UIColor?
    var customRoadShieldDefaultColor: UIColor?

    // Button Properties
    var customButtonTextColor: UIColor?
    var customCancelButtonTintColor: UIColor?
    var customPreviewButtonTintColor: UIColor?
    var customStartButtonTintColor: UIColor?
    var customDismissButtonBackgroundColor: UIColor?
    var customDismissButtonTextColor: UIColor?
    var customBackButtonBackgroundColor: UIColor?
    var customBackButtonTintColor: UIColor?
    var customBackButtonTextColor: UIColor?
    var customBackButtonBorderColor: UIColor?

    // Navigation View
    var customNavigationViewBackgroundColor: UIColor?

    // Distance Label Properties
    var customDistanceLabelUnitTextColor: UIColor?
    var customDistanceLabelValueTextColor: UIColor?

    // Rating Control
    var customRatingControlNormalColor: UIColor?
    var customRatingControlSelectedColor: UIColor?

    // Steps Properties
    var customStepsBackgroundViewColor: UIColor?
    var customStepsTableHeaderTintColor: UIColor?
    var customStepsTableHeaderTextColor: UIColor?
    var customStepInstructionsBackgroundColor: UIColor?
    var customStepTableViewCellBackgroundColor: UIColor?

    // Next Instruction
    var customNextInstructionNormalTextColor: UIColor?
    var customNextInstructionContainedTextColor: UIColor?

    // Secondary Label Properties
    var customSecondaryLabelNormalTextColor: UIColor?
    var customSecondaryLabelFont: UIFont?

    // Stylable Label
    var customStylableLabelNormalTextColor: UIColor?

    // CarPlay Properties
    var customCarPlayCompassBackgroundColor: UIColor?

    required init() {
        super.init()
        styleType = .day
        mapStyleURL = URL(string: StyleURI.light.rawValue)!
        previewMapStyleURL = mapStyleURL
        statusBarStyle = .darkContent
    }
    
    override func apply() {
        super.apply()
        
        let traitCollection = UIScreen.main.traitCollection
        
        // Top Banner
        if let topBannerBg = customTopBannerBackgroundColor {
            TopBannerView.appearance(for: traitCollection).backgroundColor = topBannerBg
        }
        
        // Bottom Banner
        if let bottomBannerBg = customBottomBannerBackgroundColor {
            BottomBannerView.appearance(for: traitCollection).backgroundColor = bottomBannerBg
        }
        
        // Way Name View
        if let bgColor = customWayNameBackgroundColor {
            WayNameView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        
        // Maneuver View
        if let primaryColor = customManeuverViewPrimaryColor {
            ManeuverView.appearance(for: traitCollection).primaryColor = primaryColor
        }
        if let secondaryColor = customManeuverViewSecondaryColor {
            ManeuverView.appearance(for: traitCollection).secondaryColor = secondaryColor
        }
        
        // Steps List
        if let bgColor = customStepsBackgroundColor {
            StepsBackgroundView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        
        // Lane View
        if let bgColor = customLaneViewBackgroundColor {
            LanesView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        
        // Next Banner
        if let bgColor = customNextBannerBackgroundColor {
            NextBannerView.appearance(for: traitCollection).backgroundColor = bgColor
        }

        // Distance Labels
        if let unitColor = customDistanceUnitColor {
            DistanceLabel.appearance(for: traitCollection).unitTextColor = unitColor
        }
        if let valueColor = customDistanceValueColor {
            DistanceLabel.appearance(for: traitCollection).valueTextColor = valueColor
        }

        Task { @MainActor in
            // Navigation Map
            if let routeColor = customRouteColor {
                NavigationMapView.appearance(for: traitCollection).routeColor = routeColor
            }
            if let alternateColor = customRouteAlternateColor {
                NavigationMapView.appearance(for: traitCollection).routeAlternateColor = alternateColor
            }
            if let casingColor = customRouteCasingColor {
                NavigationMapView.appearance(for: traitCollection).routeCasingColor = casingColor
            }
            if let traversedColor = customTraversedRouteColor {
                NavigationMapView.appearance(for: traitCollection).traversedRouteColor = traversedColor
            }
            if let arrowColor = customManeuverArrowColor {
                NavigationMapView.appearance(for: traitCollection).maneuverArrowColor = arrowColor
            }
        }

        // Button Properties
        if let textColor = customButtonTextColor {
            Button.appearance(for: traitCollection).textColor = textColor
        }
        
        if let dismissBgColor = customDismissButtonBackgroundColor {
            DismissButton.appearance(for: traitCollection).backgroundColor = dismissBgColor
        }
    }
} 