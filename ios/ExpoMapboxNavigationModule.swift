import ExpoModulesCore

public class ExpoMapboxNavigationModule: Module {

  public func definition() -> ModuleDefinition {
    Name("ExpoMapboxNavigation")

    View(ExpoMapboxNavigationView.self) {
      Events("onRouteProgressChanged", "onCancelNavigation", "onWaypointArrival", "onFinalDestinationArrival", "onRouteChanged", "onUserOffRoute", "onRoutesLoaded")

      Prop("coordinates") { (view: ExpoMapboxNavigationView, coordinates: Array<Dictionary<String, Any>>) in
         var points: Array<CLLocationCoordinate2D> = []
         for coordinate in coordinates {
            let longValue = coordinate["longitude"]
            let latValue = coordinate["latitude"]
            if let long = longValue as? Double, let lat = latValue as? Double {
                points.append(CLLocationCoordinate2D(latitude: lat, longitude: long))
            }
          }
          view.controller.setCoordinates(coordinates: points) 
      }

      Prop("locale") { (view: ExpoMapboxNavigationView, locale: String?) in
          view.controller.setLocale(locale: locale) 
      }

      Prop("useRouteMatchingApi"){ (view: ExpoMapboxNavigationView, useRouteMatchingApi: Bool?) in
          view.controller.setIsUsingRouteMatchingApi(useRouteMatchingApi: useRouteMatchingApi) 
      }

      Prop("waypointIndices"){ (view: ExpoMapboxNavigationView, indices: Array<Int>?) in
          view.controller.setWaypointIndices(waypointIndices: indices) 
      }

      Prop("routeProfile"){ (view: ExpoMapboxNavigationView, profile: String?) in
          view.controller.setRouteProfile(profile: profile) 
      }

      Prop("routeExcludeList"){ (view: ExpoMapboxNavigationView, excludeList: Array<String>?) in
          view.controller.setRouteExcludeList(excludeList: excludeList) 
      }

      Prop("mapStyle"){ (view: ExpoMapboxNavigationView, style: String?) in
          view.controller.setMapStyle(style: style) 
      }

      Prop("mute"){ (view: ExpoMapboxNavigationView, isMuted: Bool?) in
          view.controller.setIsMuted(isMuted: isMuted) 
      }

      Prop("routeColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setRouteColor(hexColor: hexColor)
          }
      }

      Prop("routeAlternateColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setRouteAlternateColor(hexColor: hexColor)
          }
      }

      Prop("routeCasingColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setRouteCasingColor(hexColor: hexColor)
          }
      }

      Prop("routeAlternateCasingColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setRouteAlternateCasingColor(hexColor: hexColor)
          }
      }

      Prop("traversedRouteColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setTraversedRouteColor(hexColor: hexColor)
          }
      }

      Prop("maneuverArrowColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setManeuverArrowColor(hexColor: hexColor)
          }
      }

      Prop("topBannerBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setTopBannerBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("topBannerPrimaryTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setTopBannerPrimaryTextColor(hexColor: hexColor)
          }
      }

      Prop("topBannerSecondaryTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setTopBannerSecondaryTextColor(hexColor: hexColor)
          }
      }

      Prop("topBannerDistanceTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setTopBannerDistanceTextColor(hexColor: hexColor)
          }
      }

      Prop("topBannerSeparatorColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setTopBannerSeparatorColor(hexColor: hexColor)
          }
      }

      Prop("bottomBannerBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setBottomBannerBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("bottomBannerTimeRemainingTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setBottomBannerTimeRemainingTextColor(hexColor: hexColor)
          }
      }

      Prop("bottomBannerDistanceRemainingTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setBottomBannerDistanceRemainingTextColor(hexColor: hexColor)
          }
      }

      Prop("bottomBannerArrivalTimeTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setBottomBannerArrivalTimeTextColor(hexColor: hexColor)
          }
      }

      Prop("informationStackBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setInformationStackBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("informationStackTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setInformationStackTextColor(hexColor: hexColor)
          }
      }

      Prop("floatingStackBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setFloatingStackBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("floatingButtonsBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setFloatingButtonsBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("floatingButtonsTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setFloatingButtonsTextColor(hexColor: hexColor)
          }
      }

      Prop("floatingButtonsBorderColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setFloatingButtonsBorderColor(hexColor: hexColor)
          }
      }

      Prop("speedLimitBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setSpeedLimitBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("speedLimitTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setSpeedLimitTextColor(hexColor: hexColor)
          }
      }

      Prop("wayNameViewBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setWayNameViewBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("resumeButtonBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setResumeButtonBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("resumeButtonTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setResumeButtonTextColor(hexColor: hexColor)
          }
      }

      Prop("speedLimitBorderColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setSpeedLimitBorderColor(hexColor: hexColor)
          }
      }

      Prop("maneuverViewPrimaryColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setManeuverViewPrimaryColor(hexColor: hexColor)
          }
      }

      Prop("maneuverViewSecondaryColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setManeuverViewSecondaryColor(hexColor: hexColor)
          }
      }

      Prop("maneuverViewTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setManeuverViewTextColor(hexColor: hexColor)
          }
      }

      Prop("maneuverViewBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setManeuverViewBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("instructionsTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setInstructionsTextColor(hexColor: hexColor)
          }
      }

      Prop("instructionsBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setInstructionsBackgroundColor(hexColor: hexColor)
          }
      }
    }
  }
}