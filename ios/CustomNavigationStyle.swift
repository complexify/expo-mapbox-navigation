import Foundation
import MapboxMaps
import MapboxNavigationUIKit
import UIKit
import MapboxNavigation
import MapboxCoreNavigation
import MapboxDirections

class CustomDayStyle: StandardDayStyle {
    var customSpeedLimitTextColor: UIColor?
    var customSpeedLimitBackgroundColor: UIColor?
    var customSpeedLimitBorderColor: UIColor?
    var customBottomBannerBackgroundColor: UIColor?
    var customBottomBannerTimeRemainingTextColor: UIColor?
    var customBottomBannerDistanceRemainingTextColor: UIColor?
    var customBottomBannerArrivalTimeTextColor: UIColor?
    var customWayNameBackgroundColor: UIColor?
    var customTopBannerBackgroundColor: UIColor?
    var customTopBannerPrimaryTextColor: UIColor?
    var customTopBannerSecondaryTextColor: UIColor?
    var customTopBannerDistanceTextColor: UIColor?
    var customResumeButtonBackgroundColor: UIColor?
    var customResumeButtonTextColor: UIColor?
    var customResumeButtonBorderColor: UIColor?
    var customFloatingButtonsBackgroundColor: UIColor?
    var customFloatingButtonsBorderColor: UIColor?
    var customFloatingButtonsTextColor: UIColor?
    
    // Information Stack (2)
    var customInformationStackBackgroundColor: UIColor?
    var customInformationStackTextColor: UIColor?
    
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
    
    // Maneuver View
    var customManeuverViewPrimaryColor: UIColor?
    var customManeuverViewSecondaryColor: UIColor?
    var customManeuverViewPrimaryColorHighlighted: UIColor?
    var customManeuverViewSecondaryColorHighlighted: UIColor?
    
    // Instructions Card
    var customInstructionsCardBackgroundColor: UIColor?
    var customInstructionsCardSeparatorColor: UIColor?
    var customInstructionsCardHighlightedSeparatorColor: UIColor?
    
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
    
    // Rating Control
    var customRatingControlNormalColor: UIColor?
    var customRatingControlSelectedColor: UIColor?
    
    required init() {
        super.init()
        styleType = .day
    }
    
    override func apply() {
        super.apply()
        
        let traitCollection = UIScreen.main.traitCollection
        
        // Speed limit customization
        if let textColor = customSpeedLimitTextColor {
            SpeedLimitView.appearance(for: traitCollection).textColor = textColor
        }
        if let bgColor = customSpeedLimitBackgroundColor {
            SpeedLimitView.appearance(for: traitCollection).signBackColor = bgColor
        }
        if let borderColor = customSpeedLimitBorderColor {
            SpeedLimitView.appearance(for: traitCollection).regulatoryBorderColor = borderColor
        }
        
        // Bottom banner customization
        if let bottomBannerBg = customBottomBannerBackgroundColor {
            BottomBannerView.appearance(for: traitCollection).backgroundColor = bottomBannerBg
        }
        
        // Bottom banner text colors
        if let timeRemainingColor = customBottomBannerTimeRemainingTextColor {
            TimeRemainingLabel.appearance(for: traitCollection).textColor = timeRemainingColor
        }
        if let distanceRemainingColor = customBottomBannerDistanceRemainingTextColor {
            DistanceRemainingLabel.appearance(for: traitCollection).textColor = distanceRemainingColor
        }
        if let arrivalTimeColor = customBottomBannerArrivalTimeTextColor {
            ArrivalTimeLabel.appearance(for: traitCollection).textColor = arrivalTimeColor
        }
        
        // Way name customization
        if let bgColor = customWayNameBackgroundColor {
            WayNameView.appearance(for: traitCollection).backgroundColor = bgColor.withAlphaComponent(0.8)
        }
        
        // Top banner customization
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
        
        // Resume button customization
        if let resumeBgColor = customResumeButtonBackgroundColor {
            ResumeButton.appearance(for: traitCollection).backgroundColor = resumeBgColor
        }
        if let resumeTextColor = customResumeButtonTextColor {
            ResumeButton.appearance(for: traitCollection).tintColor = resumeTextColor
        }
        if let resumeBorderColor = customResumeButtonBorderColor {
            ResumeButton.appearance(for: traitCollection).borderColor = resumeBorderColor
        }
        
        // Set default values for border width and corner radius
        ResumeButton.appearance(for: traitCollection).borderWidth = 1.0
        ResumeButton.appearance(for: traitCollection).cornerRadius = 4.0
        
        // Floating buttons customization
        if let floatingBgColor = customFloatingButtonsBackgroundColor {
            FloatingButton.appearance(for: traitCollection).backgroundColor = floatingBgColor
        }
        if let floatingTextColor = customFloatingButtonsTextColor {
            FloatingButton.appearance(for: traitCollection).tintColor = floatingTextColor
        }
        if let floatingBorderColor = customFloatingButtonsBorderColor {
            FloatingButton.appearance(for: traitCollection).borderColor = floatingBorderColor
        }
        
        // Set default values for floating buttons
        FloatingButton.appearance(for: traitCollection).borderWidth = 1.0
        FloatingButton.appearance(for: traitCollection).cornerRadius = 4.0
        
        // Information Stack
        if let bgColor = customInformationStackBackgroundColor {
            StepsBackgroundView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        if let textColor = customInformationStackTextColor {
            StepsTableHeaderView.appearance(for: traitCollection).normalTextColor = textColor
        }
        
        // Steps List
        if let bgColor = customStepsBackgroundColor {
            StepInstructionsView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        if let primaryTextColor = customStepsPrimaryTextColor {
            PrimaryLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [StepInstructionsView.self])
                .normalTextColor = primaryTextColor
        }
        if let secondaryTextColor = customStepsSecondaryTextColor {
            SecondaryLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [StepInstructionsView.self])
                .normalTextColor = secondaryTextColor
        }
        if let maneuverPrimaryColor = customStepsManeuverViewPrimaryColor {
            ManeuverView.appearance(for: traitCollection, whenContainedInInstancesOf: [StepInstructionsView.self])
                .primaryColor = maneuverPrimaryColor
        }
        if let maneuverSecondaryColor = customStepsManeuverViewSecondaryColor {
            ManeuverView.appearance(for: traitCollection, whenContainedInInstancesOf: [StepInstructionsView.self])
                .secondaryColor = maneuverSecondaryColor
        }
        if let separatorColor = customStepsSeparatorColor {
            SeparatorView.appearance(for: traitCollection).backgroundColor = separatorColor
        }
        
        // Lane View
        if let bgColor = customLaneViewBackgroundColor {
            LanesView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        if let fgColor = customLaneViewForegroundColor {
            LaneView.appearance(for: traitCollection).primaryColor = fgColor
        }
        if let separatorColor = customLaneViewSeparatorColor {
            // Apply to lane view separators if available
        }
        
        // Next Banner View
        if let bgColor = customNextBannerBackgroundColor {
            NextBannerView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        if let primaryTextColor = customNextBannerPrimaryTextColor {
            NextInstructionLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [NextBannerView.self])
                .normalTextColor = primaryTextColor
        }
        if let secondaryTextColor = customNextBannerSecondaryTextColor {
            // Apply to secondary text in next banner
        }
        if let distanceTextColor = customNextBannerDistanceTextColor {
            DistanceLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [NextBannerView.self])
                .valueTextColor = distanceTextColor
        }
        
        // Progress Bar
        if let progressColor = customProgressBarProgressColor {
            // Apply to progress bar progress color
        }
        if let bgColor = customProgressBarBackgroundColor {
            // Apply to progress bar background
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
        
        // Instructions Card
        if let bgColor = customInstructionsCardBackgroundColor {
            InstructionsCardContainerView.appearance(for: traitCollection).customBackgroundColor = bgColor
        }
        if let separatorColor = customInstructionsCardSeparatorColor {
            InstructionsCardContainerView.appearance(for: traitCollection).separatorColor = separatorColor
        }
        if let highlightedSeparatorColor = customInstructionsCardHighlightedSeparatorColor {
            InstructionsCardContainerView.appearance(for: traitCollection).highlightedSeparatorColor = highlightedSeparatorColor
        }
        
        // Exit View
        if let fgColor = customExitViewForegroundColor {
            ExitView.appearance(for: traitCollection).foregroundColor = fgColor
        }
        if let borderColor = customExitViewBorderColor {
            ExitView.appearance(for: traitCollection).borderColor = borderColor
        }
        if let highlightColor = customExitViewHighlightColor {
            ExitView.appearance(for: traitCollection).highlightColor = highlightColor
        }
        
        // Route Shield
        if let fgColor = customRouteShieldForegroundColor {
            GenericRouteShield.appearance(for: traitCollection).foregroundColor = fgColor
        }
        if let borderColor = customRouteShieldBorderColor {
            GenericRouteShield.appearance(for: traitCollection).borderColor = borderColor
        }
        if let highlightColor = customRouteShieldHighlightColor {
            GenericRouteShield.appearance(for: traitCollection).highlightColor = highlightColor
        }
        
        // Distance Labels
        if let remainingColor = customDistanceRemainingColor {
            DistanceRemainingLabel.appearance(for: traitCollection).normalTextColor = remainingColor
        }
        if let unitColor = customDistanceUnitColor {
            DistanceLabel.appearance(for: traitCollection).unitTextColor = unitColor
        }
        if let valueColor = customDistanceValueColor {
            DistanceLabel.appearance(for: traitCollection).valueTextColor = valueColor
        }
        
        // Rating Control
        if let normalColor = customRatingControlNormalColor {
            RatingControl.appearance(for: traitCollection).normalColor = normalColor
        }
        if let selectedColor = customRatingControlSelectedColor {
            RatingControl.appearance(for: traitCollection).selectedColor = selectedColor
        }
    }
}