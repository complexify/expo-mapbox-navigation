import { ViewStyle, StyleProp } from "react-native/types";

type ProgressEvent = {
  distanceRemaining: number;
  distanceTraveled: number;
  durationRemaining: number;
  fractionTraveled: number;
};

export type ExpoMapboxNavigationViewProps = {
  coordinates: Array<{ latitude: number; longitude: number }>;
  waypointIndices?: number[];
  useRouteMatchingApi?: boolean;
  locale?: string;
  routeProfile?: string;
  routeExcludeList?: string[];
  mapStyle?: string;
  mute?: boolean;
  routeColor?: string;
  routeAlternateColor?: string;
  routeCasingColor?: string;
  routeAlternateCasingColor?: string;
  traversedRouteColor?: string;
  maneuverArrowColor?: string;
  onRouteProgressChanged?: (event: { nativeEvent: ProgressEvent }) => void;
  onCancelNavigation?: () => void;
  onWaypointArrival?: (event: {
    nativeEvent: ProgressEvent | undefined;
  }) => void;
  onFinalDestinationArrival?: () => void;
  onRouteChanged?: () => void;
  onUserOffRoute?: () => void;
  onRoutesLoaded?: () => void;
  style?: StyleProp<ViewStyle>;

  // Top Banner (1)
  topBannerBackgroundColor?: string;
  topBannerPrimaryTextColor?: string;
  topBannerSecondaryTextColor?: string;
  topBannerDistanceTextColor?: string;
  topBannerSeparatorColor?: string;

  // Information Stack (2)
  informationStackBackgroundColor?: string;
  informationStackTextColor?: string;

  // Bottom Banner (3)
  bottomBannerBackgroundColor?: string;
  bottomBannerTimeRemainingTextColor?: string;
  bottomBannerDistanceRemainingTextColor?: string;
  bottomBannerArrivalTimeTextColor?: string;

  // Resume Button (4)
  resumeButtonBackgroundColor?: string;
  resumeButtonTextColor?: string;
  resumeButtonBorderColor?: string;

  // Speed Limit View (5)
  speedLimitBackgroundColor?: string;
  speedLimitTextColor?: string;
  speedLimitBorderColor?: string;

  // Floating Stack (6)
  floatingStackBackgroundColor?: string;
  floatingButtonsBackgroundColor?: string;
  floatingButtonsTextColor?: string;
  floatingButtonsBorderColor?: string;

  // Way Name Label (8)
  wayNameViewBackgroundColor?: string;
  wayNameViewTextColor?: string;

  // Steps List
  stepsBackgroundColor?: string;
  stepsPrimaryTextColor?: string;
  stepsSecondaryTextColor?: string;
  stepsManeuverViewPrimaryColor?: string;
  stepsManeuverViewSecondaryColor?: string;
  stepsSeparatorColor?: string;

  // Lane View
  laneViewBackgroundColor?: string;
  laneViewForegroundColor?: string;
  laneViewSeparatorColor?: string;

  // Next Banner View
  nextBannerBackgroundColor?: string;
  nextBannerPrimaryTextColor?: string;
  nextBannerSecondaryTextColor?: string;
  nextBannerDistanceTextColor?: string;

  // Progress Bar
  progressBarProgressColor?: string;
  progressBarBackgroundColor?: string;

  // Maneuver View (Direction Arrow)
  maneuverViewPrimaryColor?: string;
  maneuverViewSecondaryColor?: string;
  maneuverViewPrimaryColorHighlighted?: string;
  maneuverViewSecondaryColorHighlighted?: string;

  // Instructions View
  instructionsTextColor?: string;       // Color for all instruction text
  instructionsBackgroundColor?: string; // Background color for instruction panels

  // Instructions Card
  instructionsCardBackgroundColor?: string;
  instructionsCardSeparatorColor?: string;
  instructionsCardHighlightedSeparatorColor?: string;

  // Exit View
  exitViewForegroundColor?: string;
  exitViewBorderColor?: string;
  exitViewHighlightColor?: string;

  // Route Shield
  routeShieldForegroundColor?: string;
  routeShieldBorderColor?: string;
  routeShieldHighlightColor?: string;

  // Distance Labels
  distanceRemainingColor?: string;
  distanceUnitColor?: string;
  distanceValueColor?: string;

  // Navigation Map
  routeAnnotationSelectedColor?: string;
  routeAnnotationColor?: string;
  routeAnnotationTextColor?: string;
  routeAnnotationSelectedTextColor?: string;
  routeAnnotationMoreTimeTextColor?: string;
  routeAnnotationLessTimeTextColor?: string;
  waypointColor?: string;
  waypointStrokeColor?: string;

  // Feedback
  feedbackBackgroundColor?: string;
  feedbackTextColor?: string;
  feedbackCellColor?: string;
  feedbackSubtypeCircleColor?: string;
  feedbackSubtypeCircleOutlineColor?: string;

  // End of Route
  endOfRouteButtonTextColor?: string;
  endOfRouteCommentBackgroundColor?: string;
  endOfRouteCommentTextColor?: string;
  endOfRouteContentBackgroundColor?: string;
  endOfRouteTitleTextColor?: string;

  // Road Shield Colors
  roadShieldBlackColor?: string;
  roadShieldBlueColor?: string;
  roadShieldGreenColor?: string;
  roadShieldRedColor?: string;
  roadShieldWhiteColor?: string;
  roadShieldYellowColor?: string;
  roadShieldDefaultColor?: string;

  // Button Properties
  buttonTextColor?: string;
  cancelButtonTintColor?: string;
  previewButtonTintColor?: string;
  startButtonTintColor?: string;
  dismissButtonBackgroundColor?: string;
  dismissButtonTextColor?: string;
  backButtonBackgroundColor?: string;
  backButtonTintColor?: string;
  backButtonTextColor?: string;
  backButtonBorderColor?: string;

  // Navigation View
  navigationViewBackgroundColor?: string;

  // Distance Label Properties
  distanceLabelUnitTextColor?: string;
  distanceLabelValueTextColor?: string;

  // Rating Control
  ratingControlNormalColor?: string;
  ratingControlSelectedColor?: string;

  // Steps Properties
  stepsBackgroundViewColor?: string;
  stepsTableHeaderTintColor?: string;
  stepsTableHeaderTextColor?: string;
  stepInstructionsBackgroundColor?: string;
  stepTableViewCellBackgroundColor?: string;

  // Next Instruction
  nextInstructionNormalTextColor?: string;
  nextInstructionContainedTextColor?: string;

  // Secondary Label Properties
  secondaryLabelNormalTextColor?: string;

  // Stylable Label
  stylableLabelNormalTextColor?: string;

  // CarPlay Properties
  carPlayCompassBackgroundColor?: string;
};
