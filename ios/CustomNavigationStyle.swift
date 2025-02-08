import Foundation
import MapboxMaps
import MapboxNavigationUIKit
import UIKit

class CustomDayStyle: StandardDayStyle {
    var customSpeedLimitTextColor: UIColor?
    var customSpeedLimitBackgroundColor: UIColor?
    var customSpeedLimitBorderColor: UIColor?
    var customBottomBannerBackgroundColor: UIColor?
    var customWayNameBackgroundColor: UIColor?
    
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
        
        if let bgColor = customWayNameBackgroundColor {
            WayNameView.appearance(for: traitCollection).backgroundColor = bgColor.withAlphaComponent(0.8)
        }
    }
}
