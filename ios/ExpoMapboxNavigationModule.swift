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

      Prop("stepsBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setStepsBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("stepsPrimaryTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setStepsPrimaryTextColor(hexColor: hexColor)
          }
      }

      Prop("stepsSecondaryTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setStepsSecondaryTextColor(hexColor: hexColor)
          }
      }

      Prop("stepsManeuverViewPrimaryColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setStepsManeuverViewPrimaryColor(hexColor: hexColor)
          }
      }

      Prop("laneViewBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setLaneViewBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("stepsManeuverViewSecondaryColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.customDayStyle.customStepsManeuverViewSecondaryColor = UIColor(hex: hexColor)
              view.controller.update()
          }
      }

      Prop("stepsSeparatorColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.customDayStyle.customStepsSeparatorColor = UIColor(hex: hexColor)
              view.controller.update()
          }
      }

      Prop("laneViewForegroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.customDayStyle.customLaneViewForegroundColor = UIColor(hex: hexColor)
              view.controller.update()
          }
      }

      // Next Banner View
      Prop("nextBannerBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setNextBannerBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("nextBannerPrimaryTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setNextBannerPrimaryTextColor(hexColor: hexColor)
          }
      }

      Prop("nextBannerSecondaryTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setNextBannerSecondaryTextColor(hexColor: hexColor)
          }
      }

      Prop("nextBannerDistanceTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setNextBannerDistanceTextColor(hexColor: hexColor)
          }
      }

      // Progress Bar
      Prop("progressBarProgressColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setProgressBarProgressColor(hexColor: hexColor)
          }
      }

      Prop("progressBarBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setProgressBarBackgroundColor(hexColor: hexColor)
          }
      }

      // Maneuver View
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

      Prop("maneuverViewPrimaryColorHighlighted") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setManeuverViewPrimaryColorHighlighted(hexColor: hexColor)
          }
      }

      Prop("maneuverViewSecondaryColorHighlighted") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setManeuverViewSecondaryColorHighlighted(hexColor: hexColor)
          }
      }

      // Instructions Card
      Prop("instructionsCardBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setInstructionsCardBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("instructionsCardSeparatorColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setInstructionsCardSeparatorColor(hexColor: hexColor)
          }
      }

      Prop("instructionsCardHighlightedSeparatorColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setInstructionsCardHighlightedSeparatorColor(hexColor: hexColor)
          }
      }

      // Exit View
      Prop("exitViewForegroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setExitViewForegroundColor(hexColor: hexColor)
          }
      }

      Prop("exitViewBorderColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setExitViewBorderColor(hexColor: hexColor)
          }
      }

      Prop("exitViewHighlightColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setExitViewHighlightColor(hexColor: hexColor)
          }
      }

      // Route Shield
      Prop("routeShieldForegroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setRouteShieldForegroundColor(hexColor: hexColor)
          }
      }

      Prop("routeShieldBorderColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setRouteShieldBorderColor(hexColor: hexColor)
          }
      }

      Prop("routeShieldHighlightColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setRouteShieldHighlightColor(hexColor: hexColor)
          }
      }

      // Distance Labels
      Prop("distanceRemainingColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setDistanceRemainingColor(hexColor: hexColor)
          }
      }

      Prop("distanceUnitColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setDistanceUnitColor(hexColor: hexColor)
          }
      }

      Prop("distanceValueColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setDistanceValueColor(hexColor: hexColor)
          }
      }

      // Rating Control
      Prop("ratingControlNormalColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setRatingControlNormalColor(hexColor: hexColor)
          }
      }

      Prop("ratingControlSelectedColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setRatingControlSelectedColor(hexColor: hexColor)
          }
      }
    }
  }
}