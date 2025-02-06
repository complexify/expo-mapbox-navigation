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
    }
  }
}
