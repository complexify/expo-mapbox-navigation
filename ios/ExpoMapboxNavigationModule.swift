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

      // Way Name View
      Prop("wayNameViewTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setWayNameViewTextColor(hexColor: hexColor)
          }
      }

      // Steps List
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

      Prop("stepsManeuverViewSecondaryColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setStepsManeuverViewSecondaryColor(hexColor: hexColor)
          }
      }

      Prop("stepsSeparatorColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setStepsSeparatorColor(hexColor: hexColor)
          }
      }

      // Lane View
      Prop("laneViewBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setLaneViewBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("laneViewForegroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setLaneViewForegroundColor(hexColor: hexColor)
          }
      }

      Prop("laneViewSeparatorColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.controller.setLaneViewSeparatorColor(hexColor: hexColor)
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

      // Instructions Card
      Prop("instructionsCardBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setInstructionsCardBackgroundColor(hexColor: hexColor)
          }
      }
      
      Prop("instructionsCardSeparatorColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setInstructionsCardSeparatorColor(hexColor: hexColor)
          }
      }
      
      Prop("instructionsCardHighlightedSeparatorColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setInstructionsCardHighlightedSeparatorColor(hexColor: hexColor)
          }
      }
      
      // Exit View
      Prop("exitViewForegroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setExitViewForegroundColor(hexColor: hexColor)
          }
      }
      
      Prop("exitViewBorderColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setExitViewBorderColor(hexColor: hexColor)
          }
      }
      
      Prop("exitViewHighlightColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setExitViewHighlightColor(hexColor: hexColor)
          }
      }

      // Route Shield Colors
      Prop("roadShieldBlackColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setRoadShieldBlackColor(hexColor: hexColor)
          }
      }

      Prop("roadShieldBlueColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setRoadShieldBlueColor(hexColor: hexColor)
          }
      }

      Prop("roadShieldGreenColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setRoadShieldGreenColor(hexColor: hexColor)
          }
      }

      Prop("roadShieldRedColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setRoadShieldRedColor(hexColor: hexColor)
          }
      }

      Prop("roadShieldWhiteColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setRoadShieldWhiteColor(hexColor: hexColor)
          }
      }

      Prop("roadShieldYellowColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setRoadShieldYellowColor(hexColor: hexColor)
          }
      }

      Prop("roadShieldDefaultColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setRoadShieldDefaultColor(hexColor: hexColor)
          }
      }

      // Button Properties
      Prop("buttonTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setButtonTextColor(hexColor: hexColor)
          }
      }

      Prop("cancelButtonTintColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setCancelButtonTintColor(hexColor: hexColor)
          }
      }

      Prop("previewButtonTintColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setPreviewButtonTintColor(hexColor: hexColor)
          }
      }

      Prop("startButtonTintColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setStartButtonTintColor(hexColor: hexColor)
          }
      }

      Prop("dismissButtonBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setDismissButtonBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("dismissButtonTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setDismissButtonTextColor(hexColor: hexColor)
          }
      }

      Prop("backButtonBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setBackButtonBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("backButtonTintColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setBackButtonTintColor(hexColor: hexColor)
          }
      }

      Prop("backButtonTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setBackButtonTextColor(hexColor: hexColor)
          }
      }

      Prop("backButtonBorderColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setBackButtonBorderColor(hexColor: hexColor)
          }
      }

      // Navigation View
      Prop("navigationViewBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setNavigationViewBackgroundColor(hexColor: hexColor)
          }
      }

      // Distance Label Properties
      Prop("distanceLabelUnitTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setDistanceLabelUnitTextColor(hexColor: hexColor)
          }
      }

      Prop("distanceLabelValueTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setDistanceLabelValueTextColor(hexColor: hexColor)
          }
      }

      // Rating Control
      Prop("ratingControlNormalColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setRatingControlNormalColor(hexColor: hexColor)
          }
      }

      Prop("ratingControlSelectedColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setRatingControlSelectedColor(hexColor: hexColor)
          }
      }

      // Steps Properties
      Prop("stepsBackgroundViewColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setStepsBackgroundViewColor(hexColor: hexColor)
          }
      }

      Prop("stepsTableHeaderTintColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setStepsTableHeaderTintColor(hexColor: hexColor)
          }
      }

      Prop("stepsTableHeaderTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setStepsTableHeaderTextColor(hexColor: hexColor)
          }
      }

      Prop("stepInstructionsBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setStepInstructionsBackgroundColor(hexColor: hexColor)
          }
      }

      Prop("stepTableViewCellBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setStepTableViewCellBackgroundColor(hexColor: hexColor)
          }
      }

      // Next Instruction
      Prop("nextInstructionNormalTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setNextInstructionNormalTextColor(hexColor: hexColor)
          }
      }

      Prop("nextInstructionContainedTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setNextInstructionContainedTextColor(hexColor: hexColor)
          }
      }

      // Secondary Label Properties
      Prop("secondaryLabelNormalTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setSecondaryLabelNormalTextColor(hexColor: hexColor)
          }
      }

      // Stylable Label
      Prop("stylableLabelNormalTextColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setStylableLabelNormalTextColor(hexColor: hexColor)
          }
      }

      // CarPlay Properties
      Prop("carPlayCompassBackgroundColor") { (view: ExpoMapboxNavigationView, color: String?) in
          if let hexColor = color {
              view.setCarPlayCompassBackgroundColor(hexColor: hexColor)
          }
      }
    }
  }
}