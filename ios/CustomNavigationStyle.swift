import MapboxNavigation
import UIKit

class CustomNavigationStyle: DayStyle {
    var speedLimitTextColor: UIColor?
    var speedLimitBackgroundColor: UIColor?
    var speedLimitBorderColor: UIColor?
    var bottomBannerBackgroundColor: UIColor?
    var wayNameTextColor: UIColor?
    var wayNameBackgroundColor: UIColor?
    
    required init() {
        super.init()
        styleType = .day
    }
    
    override func apply() {
        super.apply()
        
        // Speed limit customization
        if let textColor = speedLimitTextColor {
            SpeedLimitView.appearance().textColor = textColor
        }
        if let bgColor = speedLimitBackgroundColor {
            SpeedLimitView.appearance().signBackColor = bgColor
        }
        if let borderColor = speedLimitBorderColor {
            SpeedLimitView.appearance().regulatoryBorderColor = borderColor
        }
        
        // Bottom banner customization
        if let bottomBannerBg = bottomBannerBackgroundColor {
            BottomBannerView.appearance().backgroundColor = bottomBannerBg
        }
        
        // Way name customization
        if let textColor = wayNameTextColor {
            WayNameView.appearance().textColor = textColor
        }
        if let bgColor = wayNameBackgroundColor {
            WayNameView.appearance().backgroundColor = bgColor.withAlphaComponent(0.8)
        }
    }
} 