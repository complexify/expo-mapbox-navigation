import Foundation
import MapboxMaps
import MapboxNavigationUIKit
import UIKit

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
    
    // New properties for maneuver view
    var customManeuverViewPrimaryColor: UIColor?
    var customManeuverViewSecondaryColor: UIColor?
    var customManeuverViewTextColor: UIColor?
    var customManeuverViewBackgroundColor: UIColor?
    
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
        
        // Top Banner - Current Direction Bar (ManeuverView)
        if let primaryColor = customManeuverViewPrimaryColor {
            ManeuverView.appearance(for: traitCollection).primaryColor = primaryColor
        }
        if let secondaryColor = customManeuverViewSecondaryColor {
            ManeuverView.appearance(for: traitCollection).secondaryColor = secondaryColor
        }
        
        // Current Direction Background and Text
        if let bgColor = customManeuverViewBackgroundColor {
            ManeuverView.appearance(for: traitCollection).backgroundColor = bgColor
        }
        if let textColor = customManeuverViewTextColor {
            StepInstructionsView.appearance(for: traitCollection).primaryLabel.textColor = textColor
            StepInstructionsView.appearance(for: traitCollection).secondaryLabel.textColor = textColor
        }
    }
}
