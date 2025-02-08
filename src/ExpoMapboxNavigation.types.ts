import { ViewStyle, StyleProp } from "react-native";

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

  // Speed Limit View (5)
  speedLimitBackgroundColor?: string;
  speedLimitTextColor?: string;
  speedLimitBorderColor?: string;

  // Floating Stack (6)
  floatingStackBackgroundColor?: string;
  floatingButtonsBackgroundColor?: string;

  // Way Name Label (8)
  wayNameViewBackgroundColor?: string;
};
