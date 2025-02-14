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
        
        // Speed Limit View
        if let textColor = customSpeedLimitTextColor {
            SpeedLimitView.appearance(for: traitCollection).textColor = textColor
        }
        if let bgColor = customSpeedLimitBackgroundColor {
            SpeedLimitView.appearance(for: traitCollection).signBackColor = bgColor
        }
        if let borderColor = customSpeedLimitBorderColor {
            SpeedLimitView.appearance(for: traitCollection).regulatoryBorderColor = borderColor
        }
        
        // Bottom Banner
        if let bottomBannerBg = customBottomBannerBackgroundColor {
            BottomBannerView.appearance(for: traitCollection).backgroundColor = bottomBannerBg
        }
        if let timeRemainingColor = customBottomBannerTimeRemainingTextColor {
            TimeRemainingLabel.appearance(for: traitCollection).textColor = timeRemainingColor
        }
        if let distanceRemainingColor = customBottomBannerDistanceRemainingTextColor {
            DistanceRemainingLabel.appearance(for: traitCollection).textColor = distanceRemainingColor
        }
        if let arrivalTimeColor = customBottomBannerArrivalTimeTextColor {
            ArrivalTimeLabel.appearance(for: traitCollection).textColor = arrivalTimeColor
        }
        
        // Way Name View
        if let bgColor = customWayNameBackgroundColor {
            WayNameLabel.appearance(for: traitCollection).backgroundColor = bgColor.withAlphaComponent(0.8)
        }
        if let textColor = customWayNameTextColor {
            WayNameLabel.appearance(for: traitCollection).textColor = textColor
        }
        
        // Top Banner
        if let topBannerBg = customTopBannerBackgroundColor {
            InstructionsBannerView.appearance(for: traitCollection).backgroundColor = topBannerBg
        }
        if let primaryTextColor = customTopBannerPrimaryTextColor {
            PrimaryLabel.appearance(for: traitCollection).textColor = primaryTextColor
        }
        if let secondaryTextColor = customTopBannerSecondaryTextColor {
            SecondaryLabel.appearance(for: traitCollection).textColor = secondaryTextColor
        }
        if let distanceTextColor = customTopBannerDistanceTextColor {
            DistanceLabel.appearance(for: traitCollection).textColor = distanceTextColor
        }
        if let separatorColor = customTopBannerSeparatorColor {
            SeparatorView.appearance(for: traitCollection).backgroundColor = separatorColor
        }
        
        // Resume Button
        if let resumeBgColor = customResumeButtonBackgroundColor {
            ResumeButton.appearance(for: traitCollection).backgroundColor = resumeBgColor
        }
        if let resumeTextColor = customResumeButtonTextColor {
            ResumeButton.appearance(for: traitCollection).tintColor = resumeTextColor
        }
        if let resumeBorderColor = customResumeButtonBorderColor {
            ResumeButton.appearance(for: traitCollection).borderColor = resumeBorderColor
        }
        
        // Floating Buttons
        if let floatingBgColor = customFloatingButtonsBackgroundColor {
            FloatingButton.appearance(for: traitCollection).backgroundColor = floatingBgColor
        }
        if let floatingTextColor = customFloatingButtonsTextColor {
            FloatingButton.appearance(for: traitCollection).tintColor = floatingTextColor
        }
        if let floatingBorderColor = customFloatingButtonsBorderColor {
            FloatingButton.appearance(for: traitCollection).borderColor = floatingBorderColor
        }
        
        // Maneuver View
        if let primaryColor = customManeuverViewPrimaryColor {
            ManeuverView.appearance(for: traitCollection).primaryColor = primaryColor
        }
        if let secondaryColor = customManeuverViewSecondaryColor {
            ManeuverView.appearance(for: traitCollection).secondaryColor = secondaryColor
        }
        if let primaryHighlightedColor = customManeuverViewPrimaryColorHighlighted {
            ManeuverView.appearance(for: traitCollection).primaryColorHighlighted = primaryHighlightedColor
        }
        if let secondaryHighlightedColor = customManeuverViewSecondaryColorHighlighted {
            ManeuverView.appearance(for: traitCollection).secondaryColorHighlighted = secondaryHighlightedColor
        }
        
        // Steps List
        if let bgColor = customStepsBackgroundColor {
            StepsBackgroundView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        if let primaryTextColor = customStepsPrimaryTextColor {
            StepInstructionsView.appearance(for: traitCollection).primaryLabel.textColor = primaryTextColor
        }
        if let secondaryTextColor = customStepsSecondaryTextColor {
            StepInstructionsView.appearance(for: traitCollection).secondaryLabel.textColor = secondaryTextColor
        }
        
        // Lane View
        if let bgColor = customLaneViewBackgroundColor {
            LaneView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        if let fgColor = customLaneViewForegroundColor {
            LaneView.appearance(for: traitCollection).primaryColor = fgColor
        }
        if let separatorColor = customLaneViewSeparatorColor {
            LaneView.appearance(for: traitCollection).backgroundColor = separatorColor.withAlphaComponent(0.5)
        }
        
        // Next Banner View
        if let bgColor = customNextBannerBackgroundColor {
            NextBannerView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        if let primaryTextColor = customNextBannerPrimaryTextColor {
            NextBannerView.appearance(for: traitCollection).primaryInstruction.textColor = primaryTextColor
        }
        if let secondaryTextColor = customNextBannerSecondaryTextColor {
            NextBannerView.appearance(for: traitCollection).secondaryInstruction.textColor = secondaryTextColor
        }
        if let distanceTextColor = customNextBannerDistanceTextColor {
            NextBannerView.appearance(for: traitCollection).distance.textColor = distanceTextColor
        }
        
        // Progress Bar
        if let progressColor = customProgressBarProgressColor {
            RouteProgressView.appearance(for: traitCollection).tintColor = progressColor
        }
        if let backgroundColor = customProgressBarBackgroundColor {
            RouteProgressView.appearance(for: traitCollection).backgroundColor = backgroundColor
        }

        // Exit View
        if let foregroundColor = customExitViewForegroundColor {
            ExitView.appearance(for: traitCollection).foregroundColor = foregroundColor
        }
        if let borderColor = customExitViewBorderColor {
            ExitView.appearance(for: traitCollection).borderColor = borderColor
        }
        if let highlightColor = customExitViewHighlightColor {
            ExitView.appearance(for: traitCollection).highlightColor = highlightColor
        }

        // Route Shield
        if let foregroundColor = customRouteShieldForegroundColor {
            GenericRouteShield.appearance(for: traitCollection).foregroundColor = foregroundColor
        }
        if let borderColor = customRouteShieldBorderColor {
            GenericRouteShield.appearance(for: traitCollection).borderColor = borderColor
        }
        if let highlightColor = customRouteShieldHighlightColor {
            GenericRouteShield.appearance(for: traitCollection).highlightColor = highlightColor
        }

        // Instructions Card
        if let bgColor = customInstructionsCardBackgroundColor {
            InstructionsCardContainerView.appearance(
                for: traitCollection,
                whenContainedInInstancesOf: [InstructionsCardCell.self]
            ).customBackgroundColor = bgColor
        }
        if let separatorColor = customInstructionsCardSeparatorColor {
            InstructionsCardContainerView.appearance(
                for: traitCollection,
                whenContainedInInstancesOf: [InstructionsCardCell.self]
            ).separatorColor = separatorColor
        }
        if let highlightedSeparatorColor = customInstructionsCardHighlightedSeparatorColor {
            InstructionsCardContainerView.appearance(
                for: traitCollection,
                whenContainedInInstancesOf: [InstructionsCardCell.self]
            ).highlightedSeparatorColor = highlightedSeparatorColor
        }

        // Feedback
        if let feedbackBgColor = customFeedbackBackgroundColor {
            FeedbackStyleView.appearance(for: traitCollection).backgroundColor = feedbackBgColor
            FeedbackCollectionView.appearance(for: traitCollection).backgroundColor = feedbackBgColor
        }
        if let feedbackTextColor = customFeedbackTextColor {
            UILabel.appearance(
                for: traitCollection,
                whenContainedInInstancesOf: [FeedbackViewController.self]
            ).textColor = feedbackTextColor
        }
        if let feedbackCellColor = customFeedbackCellColor {
            FeedbackCollectionView.appearance(for: traitCollection).cellColor = feedbackCellColor
        }

        // Road Shield Colors
        if let blackColor = customRoadShieldBlackColor {
            WayNameLabel.appearance(for: traitCollection).roadShieldBlackColor = blackColor
            InstructionLabel.appearance(for: traitCollection).roadShieldBlackColor = blackColor
        }
        if let blueColor = customRoadShieldBlueColor {
            WayNameLabel.appearance(for: traitCollection).roadShieldBlueColor = blueColor
            InstructionLabel.appearance(for: traitCollection).roadShieldBlueColor = blueColor
        }
        if let greenColor = customRoadShieldGreenColor {
            WayNameLabel.appearance(for: traitCollection).roadShieldGreenColor = greenColor
            InstructionLabel.appearance(for: traitCollection).roadShieldGreenColor = greenColor
        }
        if let redColor = customRoadShieldRedColor {
            WayNameLabel.appearance(for: traitCollection).roadShieldRedColor = redColor
            InstructionLabel.appearance(for: traitCollection).roadShieldRedColor = redColor
        }
        if let whiteColor = customRoadShieldWhiteColor {
            WayNameLabel.appearance(for: traitCollection).roadShieldWhiteColor = whiteColor
            InstructionLabel.appearance(for: traitCollection).roadShieldWhiteColor = whiteColor
        }
        if let yellowColor = customRoadShieldYellowColor {
            WayNameLabel.appearance(for: traitCollection).roadShieldYellowColor = yellowColor
            InstructionLabel.appearance(for: traitCollection).roadShieldYellowColor = yellowColor
        }
        if let defaultColor = customRoadShieldDefaultColor {
            WayNameLabel.appearance(for: traitCollection).roadShieldDefaultColor = defaultColor
            InstructionLabel.appearance(for: traitCollection).roadShieldDefaultColor = defaultColor
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
            if let alternateCasingColor = customRouteAlternateCasingColor {
                NavigationMapView.appearance(for: traitCollection).routeAlternateCasingColor = alternateCasingColor
            }
            if let traversedColor = customTraversedRouteColor {
                NavigationMapView.appearance(for: traitCollection).traversedRouteColor = traversedColor
            }
            if let arrowColor = customManeuverArrowColor {
                NavigationMapView.appearance(for: traitCollection).maneuverArrowColor = arrowColor
            }
            if let selectedColor = customRouteAnnotationSelectedColor {
                NavigationMapView.appearance(for: traitCollection).routeAnnotationSelectedColor = selectedColor
            }
            if let annotationColor = customRouteAnnotationColor {
                NavigationMapView.appearance(for: traitCollection).routeAnnotationColor = annotationColor
            }
            if let annotationTextColor = customRouteAnnotationTextColor {
                NavigationMapView.appearance(for: traitCollection).routeAnnotationTextColor = annotationTextColor
            }
            if let selectedTextColor = customRouteAnnotationSelectedTextColor {
                NavigationMapView.appearance(for: traitCollection).routeAnnotationSelectedTextColor = selectedTextColor
            }
            if let moreTimeTextColor = customRouteAnnotationMoreTimeTextColor {
                NavigationMapView.appearance(for: traitCollection).routeAnnotationMoreTimeTextColor = moreTimeTextColor
            }
            if let lessTimeTextColor = customRouteAnnotationLessTimeTextColor {
                NavigationMapView.appearance(for: traitCollection).routeAnnotationLessTimeTextColor = lessTimeTextColor
            }
            if let waypointColor = customWaypointColor {
                NavigationMapView.appearance(for: traitCollection).waypointColor = waypointColor
            }
            if let waypointStrokeColor = customWaypointStrokeColor {
                NavigationMapView.appearance(for: traitCollection).waypointStrokeColor = waypointStrokeColor
            }
        }

        // Button Properties
        if let textColor = customButtonTextColor {
            Button.appearance(for: traitCollection).textColor = textColor
        }
        
        if let cancelTintColor = customCancelButtonTintColor {
            CancelButton.appearance(for: traitCollection).tintColor = cancelTintColor
        }
        
        if let previewTintColor = customPreviewButtonTintColor {
            PreviewButton.appearance(for: traitCollection).tintColor = previewTintColor
        }
        
        if let startTintColor = customStartButtonTintColor {
            StartButton.appearance(for: traitCollection).tintColor = startTintColor
        }
        
        if let dismissBgColor = customDismissButtonBackgroundColor {
            DismissButton.appearance(for: traitCollection).backgroundColor = dismissBgColor
        }
        
        if let dismissTextColor = customDismissButtonTextColor {
            DismissButton.appearance(for: traitCollection).textColor = dismissTextColor
        }
        
        if let backBgColor = customBackButtonBackgroundColor {
            BackButton.appearance(for: traitCollection).backgroundColor = backBgColor
        }
        
        if let backTintColor = customBackButtonTintColor {
            BackButton.appearance(for: traitCollection).tintColor = backTintColor
        }
        
        if let backTextColor = customBackButtonTextColor {
            BackButton.appearance(for: traitCollection).textColor = backTextColor
        }
        
        if let backBorderColor = customBackButtonBorderColor {
            BackButton.appearance(for: traitCollection).borderColor = backBorderColor
        }

        // Navigation View
        if let navBgColor = customNavigationViewBackgroundColor {
            NavigationView.appearance(for: traitCollection).backgroundColor = navBgColor
        }

        // Distance Label Properties
        if let unitTextColor = customDistanceLabelUnitTextColor {
            DistanceLabel.appearance(for: traitCollection).unitTextColor = unitTextColor
        }
        
        if let valueTextColor = customDistanceLabelValueTextColor {
            DistanceLabel.appearance(for: traitCollection).valueTextColor = valueTextColor
        }

        // Rating Control
        if let normalColor = customRatingControlNormalColor {
            RatingControl.appearance(for: traitCollection).normalColor = normalColor
        }
        
        if let selectedColor = customRatingControlSelectedColor {
            RatingControl.appearance(for: traitCollection).selectedColor = selectedColor
        }

        // Steps Properties
        if let bgViewColor = customStepsBackgroundViewColor {
            StepsBackgroundView.appearance(for: traitCollection).backgroundColor = bgViewColor
        }
        
        if let headerTintColor = customStepsTableHeaderTintColor {
            StepInstructionsView.appearance(for: traitCollection).tintColor = headerTintColor
        }
        
        if let headerTextColor = customStepsTableHeaderTextColor {
            StepInstructionsView.appearance(for: traitCollection).textColor = headerTextColor
        }
        
        if let instructionsBgColor = customStepInstructionsBackgroundColor {
            StepInstructionsView.appearance(for: traitCollection).backgroundColor = instructionsBgColor
        }
        
        if let cellBgColor = customStepTableViewCellBackgroundColor {
            StepTableViewCell.appearance(for: traitCollection).backgroundColor = cellBgColor
        }

        // Next Instruction
        if let normalTextColor = customNextInstructionNormalTextColor {
            NextInstructionLabel.appearance(for: traitCollection).normalTextColor = normalTextColor
        }
        
        if let containedTextColor = customNextInstructionContainedTextColor {
            NextInstructionLabel.appearance(
                for: traitCollection,
                whenContainedInInstancesOf: [NextBannerView.self]
            ).normalTextColor = containedTextColor
        }

        // Secondary Label Properties
        if let normalTextColor = customSecondaryLabelNormalTextColor {
            SecondaryLabel.appearance(for: traitCollection).normalTextColor = normalTextColor
        }

        // Stylable Label
        if let normalTextColor = customStylableLabelNormalTextColor {
            StylableLabel.appearance(for: traitCollection).normalTextColor = normalTextColor
        }

        // CarPlay Properties
        if let compassBgColor = customCarPlayCompassBackgroundColor {
            CarPlayCompassView.appearance(for: traitCollection).backgroundColor = compassBgColor
        }
    }
} 