# Product history

Below you can find the complete product history of the HERE SDK, including all past changelog updates up to the latest release. The latest changelog for your edition is also available [here](https://www.here.com/docs/bundle/sdk-for-flutter-navigate-edition-changelog/page/README.html) - or it can be found offline as part of the [HERE SDK package](https://platform.here.com/portal/sdk).

## Deprecations and beta versions

The team behind the HERE SDK is continuously reviewing and improving available APIs to provide both flexibility and ease of use, alongside consistent interfaces.

To ensure stable APIs across releases, we adhere to a deprecation process. Deprecated APIs are maintained for two major versions starting from the subsequent major release after their deprecation is announced in our changelog. This typically spans a period of six to nine months. You can always check the API Reference to see which versions are affected and when an interface was marked as deprecated.

Some of our new and potentially unstable APIs are designated as "beta" in our API Reference. Beta releases do not follow a deprecation process unless otherwise specified. If you choose to use beta APIs, please note that they may contain bugs and exhibit unexpected behaviors.

We value your feedback and are always interested in hearing suggestions for further improvements.

## History of changelog updates

HERE SDK {{book.hsdkVersion}} is a stable release. This is our most recent release. We usually release updates twice per month.

Below you can find all changes since the initial release.

### Version 4.21.1.0

#### New Features

- Routing: Added `ViolatedRestriction.Details.maxWeight`. Added `VehicleRestrictionMaxWeight` to store the max permitted weight along with the weight restrictions type. <!-- HERESUP-6108 -->
- Map view: Added enum value `MapMeasure.Kind.distanceInMeters` to highlight the unit. This replaces the deprecated `MapMeasure.Kind.DISTANCE`. <!-- HERESDK-2152 -->
- Added `EngineBaseURL.isolineRoutingEngine` enum value to allow to provide a custom URL for use with the `IsolineRoutingEngine`. <!-- HERESUP-8583 -->
- This version of the HERE SDK is delivered with map data v153 for `CatalogType.optimizedClientMap` catalog and v84 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-5399 -->
- Routing: Added `section.noThroughRestriction` which indicates an area allowed to enter only for residents or when vehicles make a stop. Added the related `span.noThroughRestriction` property. <!-- HERESUP-6108 -->
- Positioning: Added `setLastKnownLocationPersistent()` to `LocationEngine` for use with Android devices. This allows to optionally disable storing the last known location across application sessions. By default, it is enabled. <!-- POSTI-4216 -->
- Routing: The `RoutingEngine` has been improved to use the `zstd` encoding on Android and the `brotli` encoding on iOS when initiating requests to reduce the size of responses. <!-- HERESDK-1934 -->
- Navigation: Added the property `visualNavigator.locationAccuracyVisualized()` to control the horizontal accuracy halo of the default `LocationIndicator`. <!-- HERESDK-2241 -->
- Map view: Added `publicTransit` constant to `MapFeatures` and `publicTransitAll` and `publicTransitAsia` constants to `MapFeatureModes` to enable/disable a dedicated  public transit layer. Note that this is a **beta** release of this feature. <!-- HERESDK-5095 -->
- Map style update: Added a dedicated set of truck restriction icons to support all hybrid `MapScheme` styles. <!-- CARTO-418 -->
- Positioning: On Android devices it is no longer necessary to use the `ConsentEngine` and the process has been simplified. Now, the new method `locationEngine.confirmHEREPrivacyNoticeInclusion()` can be called to confirm that a user is informed about the data collection and the related HERE Privacy Notice. The app can decide how to present this information. Customers that have received an exceptional permission from HERE to not collect data, can use the `LocationEngine` by calling `locationEngine.confirmHEREPrivacyNoticeException()` instead. Note that the `LocationEngine` won't provide locations unless one of the two new methods is called. The "Positioning" app on [GitHub](https://github.com/heremaps/here-sdk-examples) shows an example how to use the new API. More information can be found in the [Developer Guide](https://www.here.com/docs/bundle/sdk-for-flutter-navigate-developer-guide/page/topics/get-locations.html). <!-- POSTI-4104 -->
- Traffic: Added `additionalPolylines` field to `TrafficLocation` class. Traffic API v7 response data may contain a set of smaller polylines rather than a continuous polyline. The current HSDK implementation doesn't take that into account and treats the data as one contiguous polyline, which can lead to visual bugs when displaying a polyline on the map. A new `additionalPolylines` field has been introduced to store all `GeoPolyline` objects after the first gap between links. <!-- HERESUP-4954 -->

#### API Changes - Breaking

- Map style update: Enabled the diplay of POI categories that have previously not been visible on the map including the following main categories: business-services-areas; leisure-outdoor; medical POIs within the emergency category; all shopping categories. The change also includes a promotion of car parking POIs from start zoom level 18 to 17. <!-- CARTO-316 -->

#### API Changes - Deprecations

- Map view: Deprecated enum value `MapMeasureKind.distance`. Use `MapMeasureKind.distanceInMeters` instead. <!-- HERESDK-2152 -->
- Positioning: The `ConsentEngine` has been deprecated. Use instead the newly added methods `locationEngine.confirmHEREPrivacyNoticeInclusion()` or `locationEngine.confirmHEREPrivacyNoticeException()`. The "Positioning" example app on [GitHub](https://github.com/heremaps/here-sdk-examples) shows how to use the new API. <!-- POSTI-4119 -->
- Routing: Deprecated the attributes `Section.evDetails` and `Route.evDetails`. Use `Section.consumptionInKilowattHours` and `Route.consumptionInKilowattHours` instead. <!-- HERESDK-4431 -->
- Routing: Deprecated `maxGrossWeightInKilograms`. Use instead `maxWeight`. <!-- HERESUP-6108 -->

#### Resolved Issues

- Traffic: `TrafficEngine`: Polylines for traffic flow and incidents are now always provided as expected. Note that this issue occurred only in South Korea. <!-- HERESUP-4954 -->
- Search: Fixed an issue related to EV charging stations for `SearchEngine.searchByPickedPlace()` and `SearchEngine.searchPickedPlace(). <!-- HERESDK-5563 -->
- Map view: Fixed icon creation by `IconProvider.createVehicleRestrictionIcon()` when input parameter `pickingResult` was created from `PickVehicleRestrictionsResult.withVehicleRestriction()` or `PickVehicleRestrictionsResult.withVehicleRestrictionAndCountryCode()`. <!-- HERESDK-5239 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does now load map tiles after enabling the online mode again _or_ after restoring a lost network connection. <!-- OAM-1797 -->
- Offline maps: Fixed a crash that occurred when the `SDKNativeEngine` was initialized with `CatalogVersionHint.latest` and immediately disposed. <!-- HERESDK-5395 -->

#### Known Issues

- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately shows the updated size of a `Region`. However, this does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Map view: After losing internet connection and then reconnecting, some roads on the map may fail to render correctly, causing parts of the map to appear incomplete. <!-- HERESUP-6405 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->  

## Changes from Previous Releases

This section documents major changes from past releases. We encourage you to use the latest release, {{book.hsdkVersion}}.
  
### Version 4.21.0.0

#### New Features

- Removed the beta tag from `SDKOptions.authenticationMode` as the API is now considered to be stable. <!-- HERESDK-5478 -->
- This version of the HERE SDK is delivered with map data v150 for `CatalogType.optimizedClientMap` catalog and v84 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-5073 -->
- Search: Added attribute `id` to `EVChargingPool`, which represents a HERE ID of the charging pool. Added attributes to `Evse`: - `cpoId`, which represents the unique ID of an EVSE in the system of the CPO - `cpoEvseEmi3Id`, which represents identifier in Emi3 format of the EVSE within the Charge Point Operator (CPO) platform - `status`, which represents status of the EVSE such as `AVAILABLE`, `OCCUPIED` etc - `lastUpdated`, which represents the last update time of the dynamic connector availability information - `connectors`, which represents the list of connectors of the EVSE. <!-- HERESDK-4980 -->
- A `dataPath` field was added to `SDKOptions` which allows the HERE SDK to store data for internal use. Such data includes: offline search indices, positioning content, usage data information. More information can be found in the API Reference. <!-- HERESDK-1925 -->
- Map view: Added `PolygonTileDataSource` and `PolygonTileSource` APIs to allow users to inject custom polygon tile sources into the HERE SDK. Note that this is a `beta` release of this feature. <!-- HERESDK-438 -->
- Routing: Added `Waypoint.chargingStop`, allowing a waypoint to be designated as a charging stop. <!-- HERESDK-5142 -->
- Map view: Added support to group multiple truck restriction icons per road segment for roads with multiple restrictions. Note that this is a **beta** release of this feature. <!-- HERESDK-4374 -->

#### API Changes - Breaking

- Navigation: Removed already deprecated `RealisticView` and `RealisticViewWarning.realisticView`. Please use `RealisticViewVectorImage` and `RealisticViewWarning.realisticViewVectorImage` instead. <!-- HERESDK-5150 -->
- Added support for 16 KB page sizes. Affected architectures are `x86_64` and `arm64-v8a`. In addition, the Android `compileSdk` and `targetSdkVersion` have been raised from 34 to 35. This change is backward compatible with older and current devices. To test your app in new environment, follow the [Android documentation](https://developer.android.com/guide/practices/page-sizes#16kb-emulator). This change requires at least Gradle version 8.2 or higher and at least Android Gradle Plugin version 8.2.2 or higher. For newer Gradle versions there is a known issue: A possible error may look like "Missing classes detected while running R8". Such a message is a [known AGP issue](https://issuetracker.google.com/issues/282544776). The example apps on GitHub show how to fix this in two simple steps. For more details, take a look at the troubleshooting section of the Developer Guide. <!-- HERESDK-4510 -->
- Map view: Changed behaviour of `PanListener` and `PinchRotateListener`. Pan gesture is now cancelled when pinch-rotate gesture starts. If two finger panning is detected during pinch-rotate, then pan gesture is started and both pan and pinch-rotate events are emitted. When pinch-rotate gesture finishes, then pan gesture (if in progress), also finishes. <!-- HERESDK-4845 -->
- Removed the previously deprecated `TimeRule.asString`. Use `TimeRule.timeRuleString` instead. <!-- HERESDK-5149 -->
- Navigation: Removed the previously deprecated `TextNotificationType.SpeedCameraWarning`. Use `TextNotificationType.SafetyCameraWarning` instead. <!-- HERESDK-2071 -->

#### API Changes - Deprecations

- Navigation: Deprecated the `Lane.directionCategory`. Use instead `Lane.directions`. Note that this API has been already deprecated with HERE SDK 4.20.5. The initial deprecation of `Lane.recommendationState` has been reverted and is no longer deprecated. <!-- HERESDK-4576 -->
- Routing: Deprecated the attribute `Waypoint.isChargingStation`. Use `Waypoint.chargingStop` instead. <!-- HERESDK-5142 -->
- Deprecated the fields `accessKeyId`, `accessKeySecret` and other related constructors. Use instead the static methods offered by `AuthenticationMode`, which are now preferred when initializing `SDKOptions` and the HERE SDK. Take a look at the "HelloMap" example app on GitHub for a usage example. <!-- HERESDK-1464 -->

#### Resolved Issues

- Map view: Some customers see a "Failed to cache texture" error message in their logs. This message can be ignored. We switched the log level for texture caching failures from `error` to `debug` since such a caching failure doesn't affect the expected usage of a texture, for example, when being used with the `MapImage` class. <!-- HERESUP-4724 -->
- Positioning: Fixed crash due to a timing issue for rare cases when the `LocationEngine` is stopped and started again. <!-- HERESUP-5640 -->
- Map view: Changed behavior of `TwoFingerPanListener`. Now, we detect a two-finger-pan gesture only after a vertical movement of at least 5 mm. Previously, it was detected already after 1.5 mm which led to accidental detections of two-finger-pan gestures for some cases. <!-- HERESDK-5111 -->
- Offline routing: Fixed an issue where roundabouts will be avoided on long routes. <!-- HERESUP-5108 -->
- Routing: Fixed a potential ANR that could occur when destroying the `RoutingEngine` while tasks were still pending. <!-- HERESDK-4553 -->
- Map view: Fixed an issue with the pinch-rotate gesture where unintended map translation occurred during rotation in certain scenarios, ensuring consistent behavior. <!-- HERESDK-4845 -->
- Fixed rare occurrence of an ANR freeze during application shutdown. This release fixed also ANRs that happened after a clean install with empty cache and offline maps installed or when the app is using `MapDownloader` functionality or creates the `OfflineSearchEngine`, `OfflineRoutingEngine` or the `Navigator`. This fix addresses also potential ANRs due to a very slow internet connection. <!-- HERESUP-3346 -->
- MapView: MapView: Fixed `mapView.takeScreenshot()` to avoid interfering with the map renderer when called frequently, for example, during camera animations. <!-- HERESUP-3320 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `TrafficEngine`: Polylines for traffic flow and incidents are not always provided as expected, sometimes polylines may be missing. <!-- HERESUP-4954 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately shows the updated size of a `Region`. However, this does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Map view: After losing internet connection and then reconnecting, some roads on the map may fail to render correctly, causing parts of the map to appear incomplete. <!-- HERESUP-6405 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->  
  
### Version 4.20.5.0

#### New Features

- This version of the HERE SDK is delivered with map data v148 for `CatalogType.optimizedClientMap` catalog and v84 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-4986 -->
- Positioning: Android only: Data enabling to calculate position estimates locally is persisted between application usage sessions. This reduces the number of cloud API calls. <!-- POSTI-195 -->
- Navigation: Gujarati and Tamil voice packages have been released and are now available for navigation purpose. <!-- HERESDK-4398 -->
- Search: Added new attributes to `EVChargingStation` to provide more detailed connector information:
- `occupiedConnectorCount`: Number of connectors currently in use.
- `outOfServiceConnectorCount`: Number of connectors out of service.
-`reservedConnectorCount`: Number of connectors reserved.
- `lastUpdated`: Timestamp of the last update for `availableConnectorCount` and `occupiedConnectorCount`. <!-- HERESDK-4980 -->
- Navigation: Added `Lane.directions` and `Lane.directionsOnRoute` to indicate which lane directions follow the route. `Lane.directions` lists all lane directions that are available for a given lane. <!-- HERESDK-4576 -->
- Offline Routing: Added support to avoid segments in the offline routing. Now, the `AvoidanceOptions.segments` field can be used with the `OfflineRoutingEngine` to define segments that should be avoided during route computation. <!-- HERESDK-2295 -->

#### API Changes - Breaking

- MapView: Replaced property `LocationIndicator.haloColor` to configure the color of the accuracy indicator halo of the `LocationIndicator` with setter and getter methods `void LocationIndicator.setHaloColor(LocationIndicatorIndicatorStyle, ui.Color)` and `ui.Color LocationIndicator.getHaloColor(LocationIndicatorIndicatorStyle)`, specifying the applicable style. Note that this is a **beta** release of this feature. <!-- HERESDK-2354 -->

#### API Changes - Deprecations

- Deprecated `paymentIsRequired` and `subscriptionIsRequired` fields from `EVChargingPoolDetails`. Current values are always set to false. <!-- HERESDK-4549 -->
- `LayerConfiguration.Feature.traffic` has been deprecated and will be removed in v4.23.0. Please use `LayerConfiguration.Feature.rdsTraffic` instead. <!-- HERESDK-4653 -->

#### Resolved Issues

- Navigation: Fixed mismatch in maneuver and section distances in `RouteProgress` object. <!-- HERESUP-5439 -->
- Navigation: Android: Fixed a bug which caused the lane information from `ManeuverViewLaneAssistanceListener` to be missing when the `ManeuverNotificationOptions.enableLaneRecommendation` was set to true. <!-- HERESUP-4526 -->
- Navigation: Fixed a bug where environmental zone warnings were not displayed as expected. <!-- HERESDK-4906 -->
- Navigation: Fixed missing lane assistance that happened when lane arrows on the street lead to semi-public streets and parking areas. For example malls in USA and similar bigger parking places. <!-- HERESDK-2587 -->
- Routing: Fixed incorrect route parsing when tolls are enabled. The problem occurred when the name of the toll systems are not available when calculating a route with tolls. <!-- HERESUP-5912 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Offline maps: Map Loader: When a feature configuration is applied, then the `MapDownloader` does not accurately shows the updated size of a `Region`. However, this does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->  
  
### Version 4.20.4.0

#### New Features

- Navigation: Added `Lane.laneMarkings` to indicate the divider markings between lanes. <!-- HERESDK-4575 -->
- Indoor map: Added support for UUID based identifier for venues. <!-- INDR-2168 -->
- Updated `pubspec` to use `intl` version ^0.19.0 and `meta` version ^1.12.0, as required by the HERE SDK. Previously, `intl` and `meta` versions have not been specified explicitely. <!-- HERESDK-4830 -->
- Map view: Added `LineTileDataSource` and `LineTileSource` APIs to allow users to inject custom line tile sources. Note that this is a **beta** release of this feature. <!-- HERESDK-4384 -->
- This version of the HERE SDK is delivered with map data v145 for `CatalogType.optimizedClientMap` catalog and v83 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-4797 -->
- We have released a new version of the [HERE SDK Reference Application](https://github.com/heremaps/here-sdk-ref-app-flutter). With version [1.12.0](https://github.com/heremaps/here-sdk-ref-app-flutter/releases/tag/1.12.0) we added support for HERE SDK 4.20.0.0, including minor fixes or other improvements. <!-- HERESDK-4168 -->

#### API Changes - Deprecations

- Search: Deprecated `EVChargingStation` constructor. Use `EVChargingStation.withDefaults` instead. <!-- HERESDK-4803 -->

#### Resolved Issues

- Navigation: Fixed an issue with `SectionProgress` regarding the remaining duration when pre- and/or post-actions are present, for example, when a ferry needs to be taken. <!-- HERESUP-4414 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map Loader: When a feature configuration is applied, then the `MapDownloader` does not accurately shows the updated size of a `Region`. However, this does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->  
  
### Version 4.20.3.0

#### New Features

- Map view: Calling `MapContentSettings.enablePoiCategory()` to specify a category filter is now also including embedded carto POIs in Japan. <!-- HERESDK-2432 -->
- Search: Added `businessAndServicesPetrolGasolineStation` constant to class `PlaceCategory`. It represents businesses that sell fuel, oil, and other motoring supplies. <!-- HERESDK-4658 -->
- EV Routing: Added `EVMobilityServiceProviderPreferences` that represents sets of E-Mobility Service Providers' ID grouped by preference level. Added new field `EVCarOptions.evMobilityServiceProviderPreferences`. <!-- HERESDK-4574 -->
- Added `GeoPolygon.withGeoBox([GeoBox] geoBox)` and `GeoPolyline.withGeoBox([GeoBox] geoBox)` to construct a `GeoPolygon` or a `GeoPolyline` from a `GeoBox`. <!-- HERESDK-2718 -->
- Routing: Moved attribute `occupantsNumber` from `RouteOptions` to the corresponding transport mode options instead. It is added to the following transport mode options: `CarOptions`, `EVCarOptions`, `BusOptions`, `PrivateBusOptions`, `TruckOptions`, `EVTruckOptions`, `ScooterOptions`. <!-- HERESUP-367 -->
- EV Routing: Added `Waypoint.isChargingStation` so that a waypoint added by an app needs to be used as a stop at a charging station, even if battery specifications indicate a stop is not required. <!-- HERESDK-4699 -->
- Map view: Added property `LocationIndicator.haloColor` to configure the color of the accuracy halo for the active `LocationIndicatorIndicatorStyle` setting. Note that this is a **beta** release of this feature. <!-- HERESDK-2354 -->
- Routing: Added `AllowOptions` class to the following transport mode options: `CarOptions`, `EVCarOptions`, `BusOptions`, `PrivateBusOptions`, `TruckOptions`, `EVTruckOptions`. It contains options that need to be explicitly allowed by a user. <!-- HERESUP-367 -->

#### API Changes - Deprecations

- Routing: Deprecated `RouteOptions.occupantsNumber`. Use `occupantsNumber` of the corresponding transport mode options instead, like `CarOptions.occupants_number`. <!-- HERESUP-367 -->

#### Resolved Issues

- Map view: Fixed memory leak on hybrid map schemes. Rendering to an offscreen texture causes a memory leak on ARM Mali Android devices with driver versions 32-38. The problem is on the GPU driver side in the memory allocator and related to AFBC (ARM Frame Buffer Compression) that needs to be disabled. <!-- HERESUP-2042 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map view: `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- HERESDK-2102 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->  
  
### Version 4.20.2.0

#### New Features

- Map view: Added `MapFeature.ambientOcclusion` with `MapFeatureMode.ambientOcclusionAll` to enable/disable an ambient occlusion (AO) effect. This enhances the realism of a rendered 3D map scene by adding subtle shadows in areas where objects meet or where surfaces are close together. Currently, on Android AO may result in a crash when switching to custom raster layers. Note that this is a beta release of this feature. <!-- HERESDK-3983 -->
- Map view: Added support to show multiple truck restriction icons per road segment. Note that this is a beta release of this feature. <!-- HERESDK-4372 -->
- Traffic: Added `TrafficQueryError.invalidIn`, `TrafficQueryError.invalidParameter` and `TrafficQueryError.internalError`. Note that this is a beta release of this feature. <!-- HERESDK-3585 -->
- Navigation: Added `ManeuverNotificationOptions.enableLaneRecommendation` to enable/disable the lane recommendation in the maneuver notifications. The lane recommendation, if enabled, will be given only for the `ManeuverNotificationType.distance` notification type. <!-- HERESDK-4396 -->
- Map view: Added `PointTileDataSource` and `PointTileSource` APIs to allow users to inject custom point tile sources into the HERE SDK. A possible use case is to add a large amount of custom data, for example, adding multiple charging stations to the map. A usage example is shown in the "CustomPointTileSource" example app. Note that this is a beta release of this feature. <!-- HERESDK-4364 -->
- This version of the HERE SDK is delivered with map data v143 for `CatalogType.optimizedClientMap` catalog and v83 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-4570 -->

#### API Changes - Breaking

- Traffic: Renamed `TrafficQueryError.invalidIncidentId` to `TrafficQueryError.invalidIncident`. Note that this is a beta release of this feature. <!-- HERESDK-3585 -->

#### API Changes - Deprecations

- Routing: Deprecated the attribute `Toll.tollSystem`. Use the new attribute `Toll.tollSystems` instead. Note that this change was already included in HERE SDK 4.20.1.0. <!-- HERESDK-4347 -->
- Navigation: Deprecated warning notification distance options specific to each warner. For getting and setting the warning notification distances use the methods `getWarningNotificationDistances()` and `setWarningNotificationDistances()` from `NavigatorInterface` instead. Some of the warner options classes were also deprecated since they will be empty after the removal of the warning notification distance options. Note that the deprecations have been already introduced with HERE SDK 4.20.1.0. List of deprecated properties and classes: `BorderCrossingWarningOptions.urbanWarningDistanceInMeters`, `BorderCrossingWarningOptions.ruralWarningDistanceInMeters`, `BorderCrossingWarningOptions.highwayWarningDistanceInMeters`, `DangerZoneWarningOptions`, `EnvironmentalZoneWarningOptions`, `LowSpeedZoneWarningOptions`, `RailwayCrossingWarningOptions`, `RealisticViewWarningOptions.urbanWarningDistanceInMeters`, `RealisticViewWarningOptions.ruralWarningDistanceInMeters`, `RealisticViewWarningOptions.highwayWarningDistanceInMeters`, `RoadSignWarningOptions.urbanWarningDistanceInMeters`, `RoadSignWarningOptions.ruralWarningDistanceInMeters`, `RoadSignWarningOptions.highwayWarningDistanceInMeters`, `SafetyCameraWarningOptions`, `TollStopWarningOptions`, `TruckRestrictionsWarningOptions.urbanWarningDistanceInMeters`, `TruckRestrictionsWarningOptions.ruralWarningDistanceInMeters`, `TruckRestrictionsWarningOptions.highwayWarningDistanceInMeters`, `NavigatorInterface.environmentalZoneWarningOptions`, `NavigatorInterface.safetyCameraWarningOptions`, `NavigatorInterface.dangerZoneWarningOptions`, `NavigatorInterface.tollStopWarningOptions`, `NavigatorInterface.railwayCrossingWarningOptions`, `NavigatorInterface.lowSpeedZoneWarningOptions`. <!-- HERESDK-4273 -->

#### Resolved Issues

- Navigation: Fixed an issue with the `adas` layer configuration. <!-- HERESDK-4225 -->
- Positioning: Optimized GPS (GNSS) power consumption when it is enabled with a location update interval that is clearly longer than 1 second, but rather half a minute or longer. <!-- POSTI-4053 -->
- Routing: Fixed incorrect routing when both max speed on segments and avoid segments are not empty when requesting a route. When both were set, only the former was being used. <!-- HERESUP-2314 -->
- Navigation: Fixed a bug for maneuver generation related to plural junctions. <!-- HERESDK-2710 -->
- Routing: Fixed next road numbers selection giving priority to those from signpost. <!-- HERESUP-1471 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map view: `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- HERESDK-2102 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->  

### Version 4.20.1.0

#### New Features

- Routing: Added `RoutingEngine.calculateTrafficOnRouteWithCurrentCharge()` method to calculate traffic also for EV car routes. Additionally, `consumptionInKilowattHours` field has been added to `TrafficOnSpan` that indicates the power consumption in kilowatt-hours (kWh) necessary to traverse the span. Also, `departurePlace` and `arrivalPlace` have been added to `TrafficOnSection` containing, among other properties, the estimated battery charge in kWh when leaving/arriving to a section. <!-- HERESDK-4231 -->
- This version of the HERE SDK is delivered with map data v139 for `CatalogType.optimizedClientMap` catalog and v83 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-4344 -->
- Offline maps: Removed the beta status from `MapDownloader` and `MapUpdater`. The offline maps feature is now considered to be stable and any future changes will follow a strict deprecation process. <!-- HERESDK-3976 -->
- Map view: Added `MapLayerMapMeasureDependentStorageLevels.withStorageLevelOffset()` method to create `MapLayerMapMeasureDependentStorageLevels` instances.  Updated the documentation for `MapLayerBuilder.withMapMeasureDependentStorageLevels()` method to clarify that the default mapping will now use a storage level that is one level lower than the corresponding map measure. <!-- HERESUP-543 -->
- Map view: Removed beta status for `MapMeasureDependentRenderSize`, representing a render size, described as map measure dependent values. The feature is now considered to be stable and any future changes will follow a strict deprecation process. <!-- HERESDK-3518 -->
- Routing: Added `Toll.tollSystems` to replace the deprecated `Toll.tollSystem`. <!-- HERESDK-4347 -->
- Navigation: Added get/set method for `WarningNotificationDistances` for all warners. Use this setting instead of the deprecated individual warning options for each warner. The deprecated `highwayWarningDistanceInMeters` is replaced by `fastSpeedDistanceInMeters`. The deprecated `ruralWarningDistanceInMeters` is replaced by `regularSpeedDistanceInMeters`. The deprecated `urbanWarningDistanceInMeters` is replaced by `slowSpeedDistanceInMeters`. <!-- HERESDK-4273 -->

#### API Changes - Breaking

- Map view: Improved gesture detection: Gesture types 'GestureType.Pan' and 'GestureType.PinchRotate' can now be detected simultaneously when using two fingers. <!-- HERESDK-4528 -->
- The minimum supported iOS version for the HERE SDK has been raised from iOS 13 to iOS 15. <!-- HERESDK-4433 -->
- The minimum supported Android API level was raised from Android 23 to Android 24. <!-- HERESDK-4434 -->

#### API Changes - Deprecations

- Map view: Deprecated constructor for `MapLayerMapMeasureDependentStorageLevels`. Use `MapLayerMapMeasureDependentStorageLevels.withStorageLevelOffset()` method to create `MapLayerMapMeasureDependentStorageLevels` instances instead. <!-- HERESUP-543 -->

#### Resolved Issues

- `OfflineRoutingEngine`: Fixed offline routing to be calculated even though specified avoid areas are not included in the loaded map data. <!-- HERESUP-743 -->
- Navigation: Maneuver notifications in Arabic have been improved by adding diacritic to the templates in order to improve the voice notification quality by specifying how TTS engines should pronounce them. <!-- HERESDK-4592 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map view: `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- HERESDK-2102 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->  

### Version 4.20.0.0

#### New Features

- Routing: Added `calculateJamFactor()` method to `DynamicSpeedInfo` class. <!-- HERESDK-3696 -->
- Map view: Added `Style.update(Style)` and `HereMap.getStyle()` that supports the customization of predefined map styles. All `MapScheme` styles are supported. The new style definition `General.Labels.Scale.Factor` is made available to control the size of labels on the map. Note that this is a beta release of this feature. <!-- HERESDK-3578 -->
- The latest supported Flutter version was raised from 3.22.2 to 3.24.1. The latest supported Dart version was updated accordingly from 3.4.3 to 3.5.1. The minimum supported Flutter version was raised from 3.13.9 to 3.22.3. The minimum supported Dart version was updated accordingly from 3.1.5 to 3.4.4. Other versions may also work, but are not guaranteed to be supported. The HERE SDK plugin is now built with the minimum supported Flutter version 3.22.3. <!-- HERESDK-4130 -->
- Navigation: Added support for elevation and slope data. <!-- HERESDK-3501 -->
- Upgraded all the pubspec files in 'sdk/flutter/variant_overrides/**/pubspec.yaml.in' to use Flutter version 3.22.3 and Dart version 3.4.4, as required by the HERE SDK. Previously, they were using Flutter version 3.13.9 and Dart version 3.1.5. <!-- HERESDK-4080 -->
- Navigation: Added `NavigatorInterface.setTrafficOnRoute()` to set the traffic on route data that is generated with `RoutingEngine.calculateTrafficOnRoute()`. Events provided by the `RouteProgressListener` will use the new traffic on route data to calculate the ETA. <!-- HERESDK-3801 -->
- This version of the HERE SDK is delivered with map data v136 for `CatalogType.optimizedClientMap` catalog and v81 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERSDK-4056 -->

#### API Changes - Breaking

- Search: Removed the previously deprecated method `CategoryQuery.withCorridor`. Please use `CategoryQuery.withCorridorAndCenter`. Removed SearchError.polylineTooLong, as the HERE SDK resolves too long polyline issues by itself. <!-- HERESDK-2001 -->
- **Upcoming breaking change**: The minimum supported Android API version is planned to be raised from API 23 - Android 6 (Marshmallow) to API 24 - Android 7 (Nougat) with HERE SDK 4.20.1.0. <!-- ESD-123 -->
- Navigation: Removed previously deprecated `TruckRestrictionWarningType`. Please check all `TruckRestrictionWarning` fields in order to announce/display the correct truck restriction. <!-- HERESDK-4324 -->
- Routing: Deprecated `RoutingEngine.calculateIsoline()`. Please use the `IsolineRoutingEngine` instead. <!-- HERESDK-3315 -->

#### API Changes - Deprecations

- Routing: Deprecated `TrafficSpeed` class, please use `DynamicSpeedInfo` class instead. Deprecated `trafficSpeed` property in `Span` class, please use `dynamicSpeedInfo` property instead. <!-- HERESDK-3696 -->
- Navigation: Removed previously deprecated `SpatialManeuverNotificationListener`. Use instead `EventTextListener`. <!-- HERESDK-1931 -->
- Navigation: Removed previously deprecated `SpatialManeuverAzimuthListener`. Use instead `EventTextListener`. <!-- HERESDK-1932 -->
- Navigation: Removed the previously deprecated `ManeuverNotificationListener`. Use instead `EventTextListener`. <!-- HERESDK-1930 -->
- Routing: Removed already deprecated `Unknown` from `RoadType`. `Unknown` was never returned and `null` is used instead in specific cases. <!-- HERESDK-4346 -->

#### Resolved Issues

- Navigation: Fixed maneuver generation module to generate maneuvers in various cases of relevant road name change. <!-- HERESDK-3149 -->
- Map view: Fixed the rendering of SVG icons on the map when an SVG contains a `<m>` tag. <!-- HERESDK-4046 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is now including two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. <!-- HERESDK-1502 -->
- Fixed extremely low truck speed limit on some highways and rural roads. <!-- HERESUP-2014 -->
- Map view: Fixed invalid result of `MapCamera.boundingBox()` when using globe projection and enabled `MapFeatureModes.terrain3d` in areas with negative altitude. <!-- HERESDK-4262 -->
- Navigation: Fixed issues with missing maneuvers during guidance. <!-- HERESDK-2582 -->

#### Known Issues

- The _API Reference_ you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the _API Reference_ we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map view: `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- HERESDK-2102 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->  

### Version 4.19.5.0

#### New Features

- Exposed `LogControl.setCustomAppender()` to enable custom log settings. <!-- HERESUP-472 -->
- Search: Added `SearchInterface`, a common abstract class for `SearchEngine` and `OfflineSearchEngine`. This will make it easier to switch between both engines for hybrid online / offline use cases. <!-- HERESDK-3856 -->
- Map view: Added `vehicleRestriction` member to `PickMapContentResult.VehicleRestrictionResult`. <!-- HERESDK-3002 -->
- Map view: Added `MapContentSettings.setPoiCategoriesVisibility()` and `MapContentSettings.resetPoiCategoriesVisibility()` to control the visibility of POI categories on the map view. <!-- HERESDK-3751 -->

#### API Changes - Breaking

- **Upcoming breaking change**: The minimum supported Android API version will be raised from API 23 - Android 6 (Marshmallow) to API 24 - Android 7 (Nougat) with the next major release HERE SDK 4.20.0.0 which is planned for end of September 2024. <!-- ESD-123 -->

#### API Changes - Deprecations

- Map view: Deprecated `MapScene.setPoiVisibility()`. Use `MapContentSettings.setPoiCategoriesVisibility()` and `MapContentSettings.resetPoiCategoriesVisibility()` instead. <!-- HERESDK-3751 -->
- Map view: The following members of `PickMapContentResult.VehicleRestrictionResult` have been deprecated: `text`, `restrictionType`, `restrictionCategory`, `timeIntervals`. Use `vehicleRestriction` instead. Map view: Constructors of `PickMapContentResult.VehicleRestrictionResult` class with the following parameters have been deprecated: `text`, `restrictionType`, `restrictionCategory`, `timeIntervals`. Use constructors with `vehicleRestriction` instead. <!-- HERESDK-3002 -->
- `SDKOptions.customEngineBaseUrls` has been deprecated in favour of `SDKOptions.customEngineOptions`. The new API allows setting a specific URL for online services as well as custom authentication parameters. <!-- HERESDK-3662 -->
- Search: Deprecated methods `SearchEngine.searchByPlaceIdWithLanguageCode` and `OfflineSearchEngine.searchByPlaceIdWithLanguageCode`. Please use `SearchInterface.searchByPlaceId` instead. Deprecated methods `SearchEngine.searchPickedPlace` and `OfflineSearchEngine.searchPickedPlace`. Please use `SearchInterface.searchByPickedPlace` instead. Deprecated methods `SearchEngine.suggest(TextQuery, SearchOptions, SuggestCallback)` and `OfflineSearchEngine.suggest(TextQuery, SearchOptions, SuggestCallback)`. Please use `SearchInterface.suggestByText` instead. Note that the `OfflineSearchEngine` is only supported by the _Navigate Edition_. <!-- HERESDK-3856 -->

#### Resolved Issues

- Positioning: We no longer report the bearing value when it has a high level of uncertainty. This should fix issues such as for the `VisualNavigator` where the `LocationIndicator` is occasionally spinnig. Note that this fix was already included in HERE SDK 4.19.4.0. <!-- HERESDK-4098 -->
- Routing: Fixed insecure deletion of resources to prevent possible crashes when shutting down the `RoutingEngine`. Now, the HERE SDK will wait until all routing requests will finish before destructing affected objects. <!-- HERESDK-3875 -->
- Routing: Fixed wrong turn orientation that happened when multiple streets on a junction go straight ahead. <!-- OLPSUP-30920 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->
- Routing: Added missing specification detail about corridor radius in `AvoidanceOptions`. In addition, the limit of segments in `AvoidanceOptions` has been updated to match the routing limits provided by the backend. Please consult the API Reference for more details. <!-- HERESDK-4098 -->

#### Known Issues

- The _API Reference_ you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the _API Reference_ we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map view: `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- HERESDK-2102 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (ie. the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- HERESDK-1502 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->  

### Version 4.19.4.0

#### New Features

- Search: Added `PlaceFilter_EV.eMobilityServiceProviderPartnerIDs` filter to retrieve EV charging stations with at least one e-Mobility service provider from the given list. The feature is available as closed-alpha. Note that this feature was already added with HERE SDK 4.19.3.0. <!-- HERESDK-1885 -->
- Search: Added `EMobilityServiceProvider` that represents e-Mobility service provider. Added `EVChargingPool.eMobilityServiceProviders`. The feature is available as closed-alpha. Note that this feature was already added with HERE SDK 4.19.3.0. <!-- HERESDK-3552 -->
- This version of the HERE SDK is delivered with map data v135 for `CatalogType.optimizedClientMap` catalog and v80 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-3960 -->
- Map view: Added 'MapScheme.topoDay' and 'MapScheme.topoNight', topographic map schemes highlighting geographic features such as elevation, landforms, and natural landscapes to provide a clear representation of the terrain. Added 'MapFeatures.contours' feature and 'MapFeatureModes.contoursAll' feature mode to visualize height lines. Take a look at the "HikingDiary" [example app](https://github.com/heremaps/here-sdk-examples) for a usage scenario. <!-- HERESDK-3016 -->

#### API Changes - Breaking

- **Upcoming breaking change**: The minimum supported Android API version will be raised from API 23 - Android 6 (Marshmallow) to API 24 - Android 7 (Nougat) with the next major release HERE SDK 4.20.0.0 which is planned for end of September 2024. <!-- ESD-123 -->

#### Resolved Issues

- Navigation: Fixed wrong speed limits for trucks in Estonia. <!-- HERESDK-3567 -->
- Navigation: Fixed missing maneuver texts generated by Mandarin and Cantonese voice packages. <!-- HERESDK-3284 -->

#### Known Issues

- The _API Reference_ you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the _API Reference_ we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map view: `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- HERESDK-2102 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (ie. the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- HERESDK-1502 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.19.3.0

#### New Features

- This version of the HERE SDK is delivered with map data v133 for `CatalogType.optimizedClientMap` catalog and v80 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-3796 -->
- Routing: Added properties `axleCount`, `trailerCount`, and `trailerAxleCount` to `CarSpecifications`. <!-- HERESDK-3753 -->
- Routing: Added field `avoidBoundingBoxAreasOptions` and `avoidPolygonAreasOptions` to avoid rectangular and polygon shaped area during route calculation including exceptions area (rectangular and polygon shaped) for this calculation. <!-- HERESDK-3678 -->
- Routing: Added the field `AvoidanceOptions.avoidCorridorAreasOptions` to avoid corridor-shaped areas during route calculation, including exception areas (rectangular, polygonal, and corridor-shaped) for this calculation. Added corridor shape as an exception area for the `AvoidanceOptions.avoidBoundingBoxAreasOptions` and `AvoidanceOptions.avoidPolygonAreasOptions` fields. Added support for exception areas for offline routing, if supported by your edition. <!-- HERESDK-3511 -->

#### API Changes - Breaking

- The upcoming major release of the HERE SDK 4.20.0.0, scheduled for release at the end of September 2024, will update the minimum supported Android API version from API 23 (Android 6, Marshmallow) to API 24 (Android 7, Nougat). <!-- ESD-123 -->

#### API Changes - Deprecations

- Routing: Deprecated `avoidBoundingBoxAreas` and `avoidPolygonAreas`. Use `avoidBoundingBoxAreasOptions.avoidBoundingBoxArea` and `avoidPolygonAreasOptions.avoidPolygonArea` respectively instead. <!-- HERESDK-3678 -->
- Navigation: The `RoadType` was replaced with `TimingProfile`. Because of this reason, the methods `getManeuverNotificationTimingOptions()` and `setManeuverNotificationTimingOptions()` with parameter of type `RoadType` are now deprecated. Please use these methods with parameters of type `TimingProfile`. <!-- HERESDK-3536 -->

#### Resolved Issues

- Navigation: Fixed missing pre action and post action duration in `SectionProgress.remainingDuration` that happens when a section contains a pre and post action duration. <!-- HERESDK-3668 -->
- Map view: Fixed the rounding logic for the values displayed on truck restriction icons in the map view and those created using `IconProvider`. <!-- HERESDK-2439 -->
- Navigation: Fixed map-matched location jumps when approaching an intermediate `WayPoint` that requires driving along the same route to and from the waypoint. <!-- HERESDK-166 -->

#### Known Issues

- The _API Reference_ you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the _API Reference_ we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map view: `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- HERESDK-2102 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (ie. the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- HERESDK-1502 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.19.2.0

#### New Features

- Map style update: Increased road shield icon display density. Aligned start zoom level to show the icon. <!-- CARTO-432 -->
- Routing: Added property `TruckSpecifications.trailerAxleCount` for toll cost calculation. <!-- HERESDK-3653 -->
- Map view: Android: Added `TileKey`, `TileSource` and `RasterTileSource` APIs to allow users to inject custom raster tile sources into HERE SDK. Added `RasterDataSource` constructor over a raster tile source. This allows you to display custom raster tiles loaded from the local file system or from a custom backend hosting a format that does not need to be known by the HERE SDK. Find a usage example in the "custom_raster_tile_source_app" example app. Note that this is a beta release of this feature. <!-- HERESDK-587 -->
- Routing: Added `occupantsNumber` to `RouteOptions` for bus. <!-- HERESDK-3667 -->
- Routing: Added `transponders` property to `TollFare` to publish transponder names with toll cost. <!-- HERESDK-3701 -->
- This version of the HERE SDK is delivered with map data v132 for `CatalogType.optimizedClientMap` catalog and v80 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-3428 -->

#### API Changes - Breaking

- Map view: Removed `uninitializedLights` state from the enum `MapSceneLightsAttributeSettingError`. This change is due to the implementation of a solution that ensures the Light Source API becomes available immediately after the scene load is completed. Note that this is a beta release of this feature. <!-- HERESDK-3565 -->
- Map style update: Improved the map schemes `liteHybridDay` and `liteHybridNight` to enhance the readability of street labels, POI labels, ski run and chair lift labels, and exit billboards. For the enriched Japan map, also road facilities billboards, traffic intersection billboards and other Japan specific billboards have been improved. <!-- CARTO-466 -->
- **Upcoming breaking change**: The minimum supported Android API version will be raised from API 23 - Android 6 (Marshmallow) to API 24 - Android 7 (Nougat) with the next major release HERE SDK 4.20.0.0 which is planned for end of September 2024. <!-- ESD-123 -->

#### Resolved Issues

- Navigation: Fixed missing maneuvers when straight lane count is less than either any left/right lane count only. <!-- HERESDK-3182 -->
- Offline search: Fixed address search in Japan by significantly improving performance and extending search possibility for address elements such as sub-block and house number. <!-- HERESDK-3591 -->
- Consolidated HTTP error codes into `badRequest` and `internalServerError` and output actual codes as error log. <!-- HERESDK-3415 -->
- Offline routing: Fixed `noRouteFound` issue that happened when a U-turn is required right after the starting point of the route. <!-- ROUTING-27498 -->
- Map style update: Improved readability of ferry lines and labels. <!-- CARTO-399 -->
- Map view: When using `MapFeatureModes.terrain3D` then some portions of the tiles may fail to load when a zoom operation is performed while tiles are still loading. <!-- HERESDK-3135 -->
- Navigation: Fixed incorrect route deviation detection caused by unsuccessful route-matching in certain cases in which the next route-matched location would be located on two or more spans ahead. <!-- HERESDK-2763 -->

#### Known Issues

- The _API Reference_ you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the _API Reference_ we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map view: `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- HERESDK-2102 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (ie. the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- HERESDK-1502 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.19.1.0

#### New Features

- Map style update: Implemented additional icons for grocery, clothing and shoe shopping POIs. <!-- CARTO-324 -->
- Map view: Added an option to specify an offset for map measure storage level mapping. Added class `MapMeasureDependentStorageLevels`. Added method `MapLayerBuilder.withMapMeasureDependentStorageLevels()` which provides a mapping between a `MapLayer` map measure to datasource storage level. <!-- HERESDK-3445 -->
- This version of the HERE SDK is delivered with map data v132 for `CatalogType.optimizedClientMap` catalog and v79 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-3427 -->
- Routing: Added `CarSpecifications` to specify vehicle dimensions for `CarOptions`, `EVCarOptions`, and `TaxiOptions`. <!-- HERESDK-3461 -->
- Map style update: Implemented Japan specific roadside station icon (michi-no-eki). <!-- CARTO-461 -->
- Map view: Added `MapFeatures.lowSpeedZones` and `MapFeatureModes.lowSpeedZonesAll` to show areas with reduced speed limits. Only available for Japan currently. For users of the _Explore Edition_, this feature will be available automatically with the next map update. For the _Navigate Edition_, this feature is already available. <!-- HERESDK-2485 -->
- Navigation: Added low speed zone warner. Currently the low speed zone warner is available only in Japan. Take a look at the `Navigation` example app for a usage example. <!-- HERESDK-2245 -->
- Network positioning: Improved the freshness of Wi-Fi model data and included internally next-generation positioning algorithms to improve the quality of network positioning. <!-- POSTI-117 -->

#### Resolved Issues

- Navigation: Fixed `VisualNavigator` position interpolation logic where the location indicator acted erratic in tracking mode when entering or leaving a cul-de-sac. <!-- HERESDK-3117 -->
- Offline routing: Fixed crash that occured while loading geometry for segments that exist in a routing layer group and does not exist in a rendering layer group. <!-- OLPSUP-31869 -->

#### Known Issues

- The _API Reference_ you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the _API Reference_ we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again _or_ after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map view: `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- HERESDK-2102 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (ie. the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- HERESDK-1502 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->
- Map view: When using `MapFeatureModes.terrain3D` then some portions of the tiles may fail to load when a zoom operation is performed while tiles are still loading. <!-- HERESDK-3135 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.19.0.0

#### New Features

- Navigation: Added `textUsageOption` to `ManeuverNotificationOptions`. Defines whether street name, route number and signpost direction should be used when generating a notification. <!-- HERESDK-2896 -->
- Navigation: Added a debug feature with the property `debugModeEnabled` to the `VisualNavigator`. When enabled, a small SVG overlay will be drawn over the map (in the middle left of the screen) containing information like map- and route-matched locations that can help with the investigation of navigation related issues. Note that this feature was already added with HERE SDK 4.18.5.0. <!-- HERESDK-2960 -->
- Map style update: Enabled display of outlines for water polygons and polylines. <!-- CARTO-341 -->
- Indoor map: Added enums `sdk.venue.routing.VenueTransportMode` and `sdk.venue.data.VenueTopology.TopologyDirectionality`. Added class `sdk.venue.data.VenueTopology.AccessCharacteristics` to let user know the mode and directionality of topology. Added `sdk.venue.data.VenueTopology.getAccessibility()` which returns a list of mode of transport allowed and direction allowed on a topology. Added `sdk.venue.control.Venue.setCustomStyle(List<VenueTopology>, VenueGeometryStyle)` to enable user to set a custom styling on a list of topologies. Added `sdk.venue.control.VenueMap.getTopology(GeoCoordinates)` which returns a `sdk.venue.data.VenueTopology` object on given `GeoCoordinate`. <!-- INDR-1011 -->
- Map style update: Added display of outlines for extruded buildings. <!-- CARTO-54 -->
- Map style update: Improved readability of map elements like city center and cartography labels by increasing size and applying stronger colors, also boundaries by styling brighter colors and darkening satellite imagery. <!-- CARTO-407 -->
- This version of the HERE SDK is delivered with map data v131 for `CatalogType.optimizedClientMap` catalog and v78 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-3337 -->
- Navigation: Added property `debugGpxFilePath` to the `VisualNavigator`. It accepts a string with the path of a GPX file that will be draw in the map. Note that this feature was already added with HERE SDK 4.18.5.0. <!-- HERESDK-2960 -->
- Routing: Added `textUsageOption` to `RouteTextOptions`. Defines whether street name, route number and signpost direction should be used when generating maneuver text. <!-- HERESDK-2896 -->
- Navigation: Added `RealisticViewWarning.RealisticViewRasterImage` which may be provided for certain countries such as Japan when the SVG variant is not available. The image is delivered as a PNG with a fixed size in portrait mode. <!-- HERESDK-3018 -->
- Map view: Added `MapScheme.logisticsHybridDay` and `MapScheme.logisticsHybridNight`, hybrid map schemes with focus on fleet management content. <!-- HERESDK-2032 -->
- Map view: `MapObjectDescriptor` moved from `mapview.mapobject` to `mapview` library. Removed beta label for: `MapViewBase.pick(MapSceneMapPickFilter?, Rectangle2D, MapViewBaseMapPickCallback)`, `HereMapController.pick(MapSceneMapPickFilter?, Rectangle2D, MapViewBaseMapPickCallback)`, `MapViewBaseMapPickCallback`, `MapSceneMapPickFilter`, `MapPickResult`, `MapObjectDescriptor`. <!-- HERESDK-2976 -->
- Map view: `MapMarker` now support the display of user supplied text along with an image. Added `MapMarkerTextStyle` and `MapMarkerTextStylePlacement` to support the encapsulation and configuration of the visual properties of the text of a `MapMarker`. Added the following APIs to `MapMarker`: `withImageAndText(GeoCoordinates coordinates, MapImage image, String text)`, `String text`, `MapMarkerTextStyle textStyle`. <!-- HERESDK-3069 -->
- The latest supported Flutter version was raised from 3.22.1 to 3.22.2. The Dart version was raised from 3.4.1 to 3.4.3. Other versions may also work, but are not guaranteed to be supported. Note that this update is recommended for all users that do not build with the minimum supported version. Flutter 3.22.2 fixes a blank map issue seen on some Android devices. The minimum supported Flutter and Dart versions remain unchanged. <!-- HERESDK-3402 -->
- Map view: It is now possible, to configure the 3D light settings in a `MapScene`. Added the following APIs: `MapScene.lights` to retrieve the MapSceneLights instance. * `MapSceneLightsCategory` enum defines the different categories of lights. `MapSceneLightsAttributeSettingError` enum to define attribute errors on light APIs. `MapSceneLightsDirection` class to specify a light direction. `MapSceneLightsAttributeSettingCallback` interface for handling errors on light APIs. `MapSceneLights.reset()` to reset the attributes of all lights to their default values. `MapSceneLights.setColor(MapSceneLightsCategory, ui.Color, MapSceneLightsAttributeSettingCallback?)`, `MapSceneLights.setIntensity(MapSceneLightsCategory, double, MapSceneLightsAttributeSettingCallback?)`, `MapSceneLights.setDirection(MapSceneLightsCategory, Direction, MapSceneLightsAttributeSettingCallback?)` to set the light attributes. `MapSceneLights.getColor(MapSceneLightsCategory)`, `MapSceneLights.getIntensity(MapSceneLightsCategory)`, `MapSceneLights.getDirection(MapSceneLightsCategory)` to retrieve the light attributes. Note that this is a beta release of this feature. <!-- HERESDK-2533 -->
- Indoor map: Added `VenueInfoListListener` listener to take appropriate action after venue info list load is completed. Added `VenueMap.addVenueInfoListListener(VenueInfoListListener)` to let a user add a `VenueInfoListListener` listener to a VenueMap. Added `VenueMap.removeVenueInfoListListener(VenueInfoListListener)` to let a user remove a `VenueInfoListListener` listener from a `VenueMap`. Added `VenueMap.getVenueInfoListAsync()` and `VenueMap.getVenueInfoListAsyncWithErrors()` to let a user load the list of venues available in a collection in async mode: This will prevent the main UI thread from blocking. <!-- INDR-1001 -->
- Map view: Added a new `text-outline-width` attribute to the `icon-text` style technique to allow the customization of the text outline width in pixels. Note that this is a beta release of this feature. <!-- HERESDK-3310 -->

#### API Changes - Breaking

- Map view: Removed the previously deprecated: `MapCameraAnimationFactory.createAnimationFromUpdate(MapCameraUpdate cameraUpdate, Duration duration, EasingFunction easingFunction)` `MapCameraKeyframeTrack.lookAtDistance(List<ScalarKeyframe> keyframes, EasingFunction easingFunction, KeyframeInterpolationMode interpolationMode)` `MapCameraKeyframeTrack.lookAtTarget(List<GeoCoordinatesKeyframe> keyframes, EasingFunction easingFunction, KeyframeInterpolationMode interpolationMode)` `MapCameraKeyframeTrack.lookAtOrientation(List<GeoOrientationKeyframe> keyframes, EasingFunction easingFunction, KeyframeInterpolationMode interpolationMode)` `MapCameraKeyframeTrack.principalPoint(List<Point2DKeyframe> keyframes, EasingFunction easingFunction, KeyframeInterpolationMode interpolationMode)` `MapCameraKeyframeTrack.normalizedPrincipalPoint(List<Anchor2DKeyframe> keyframes, EasingFunction easingFunction, KeyframeInterpolationMode interpolationMode)` `MapCameraKeyframeTrack.fieldOfView(List<ScalarKeyframe> keyframes, EasingFunction easingFunction, KeyframeInterpolationMode interpolationMode)` `MapItemKeyFrameTrack.moveTo(List<GeoCoordinatesKeyframe> keyframes, EasingFunction easingFunction, KeyframeInterpolationMode interpolationMode)` `MapItemKeyFrameTrack.polylineProgressWithEasing(List<ScalarKeyframe> keyframes, Easing easing, KeyframeInterpolationMode interpolationMode)` Use counterpart methods 'xxxWithEasing' and `Easing` parameter instead. Removed the previoulsy deprecated: `EasingFunction MapCameraKeyframeTrack.easingFunction` property. <!-- HERESDK-764 -->
- Map view: Removed the previously deprecated `HereMapOptions.withDefaults()` constructor. Use the unnamed constructor instead. <!-- HERESDK-783 -->
- Map view: Removed the previously deprecated class `PickPoiResult` and property `PickMapContentResult.pois`. Use `PickedPlace` and `PickMapContentResult.pickedPlaces` instead. <!-- HERESDK-3382 -->
- Routing: Removed the previously deprecated `instructionFormat` attribute from `RouteTextOptions`. <!-- HERESDK-106 -->
- Routing: Removed the previously deprecated `AvoidanceOptions.avoidAreas` property. Please use `AvoidanceOptions.avoidBoundingBoxAreas` instead. <!-- HERESDK-1867 -->
- Navigation: Removed the previously deprecated `StreetAttributes.controlledAccess`. Use instead `StreetAttributes.controlledAccessHighway`. <!-- HERESDK-1689 -->
- Routing: Removed the previously deprecated `TextFormat`. <!-- HERESDK-106 -->
- Map view: Removed class `MapContextProviderLanguageOptions` as it is an internal class that cannot be used and got exposed accidentally. <!-- HERESDK-3464 -->
- Map view: Renamed the beta API attribute `font-size` to `text-size` for the `icon-text` style technique. <!-- HERESDK-3457 -->

#### API Changes - Deprecations

- Map view: Deprecated: `MapViewBasePickMapItemsCallback`, `MapViewBasePickMapContentCallback`, `MapViewBase.pickMapItems(Point2D, Double, PickMapItemsCallback)` - please use `pick()` instead, `MapViewBase.pickMapContent(Rectangle2D, PickMapContentCallback)` - please use `pick()` instead, `HereMapController.pickMapItems(Point2D, Double, PickMapItemsCallback)` - please use `pick()` instead, `HereMapController.pickMapContent(Rectangle2D, PickMapContentCallback)` - please use `pick()` instead. <!-- HERESDK-2976 -->
- Navigation: Deprecated `ManeuverNotificationOptions.streetNameUsageOption`. It will be removed in HERE SDK 4.22.0. Please use `ManeuverNotificationOptions.textUsageOptions` instead. <!-- HERESDK-2896 -->
- Navigation: Deprecated `ManeuverNotificationOptions.signpostDirectionUsageoption`. It will be removed in HERE SDK 4.22.0. Please use `ManeuverNotificationOptions.textUsageOptions` instead. <!-- HERESDK-2896 -->
- Navigation: Deprecated `LocalizedTextUsageOption`. It will be removed in HERE SDK 4.22.0. Please use `TextUsageOptions` instead. <!-- HERESDK-2896 -->
- Navigation: Deprecated `ManeuverNotificationOptions.roadNumberUsageOption`. It will be removed in HERE SDK 4.22.0. Please use `ManeuverNotificationOptions.textUsageOptions` instead. <!-- HERESDK-2896 -->

#### Resolved Issues

- Map style update: Improved density configuration for administrative labels on the map. <!-- CARTO-414 -->
- Navigation: Due to an extrapolation issue, the `LocationIndicator` rendered by the `VisualNavigator` may show turns sometimes not accurately when driving in tracking mode. This happens only for a short time after it will be correctly automatically. <!-- HERESDK-2783 -->
- Offline maps: Clamped the `taskCount` value passed to `MapDownloader` and `MapUpdater` to the valid range from 1 to 64 tasks. <!-- HERESDK-2788 -->

#### Known Issues

- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- Map view: `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- HERESDK-2102 -->
- Offline maps: When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- HERESDK-2142 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- HERESDK-1502 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Map view: Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- HERESDK-2563 -->
- Routing: An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- HERESDK-2565 -->
- Map view: When using `MapFeatureModes.terrain3D` then some portions of the tiles may fail to load when a zoom operation is performed while tiles are still loading. <!-- HERESDK-3135 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.18.5.0

#### New Features

- Positioning: Added network usage reporting for `UsageStats.Feature.positioning`, for methods 'positioning' and 'serviceImprovement'. <!-- POSTI-3498 -->
- Map view: Added API to manage light settings in a `MapScene` with: `MapSceneLightType` enum to define a light type, `MapSceneLightAttributeSettingError` enum to define attribute errors on light APIs, `MapSceneLightDirection` object to specify a light direction, `MapSceneLightAttributeSettingCallback` interface for handling errors on light APIs, `MapScene.resetLightAttributesToDefaults()` to reset the attributes of all lights to their default values, `MapScene.setLightColor(MapSceneLightType, Color, MapSceneLightAttributeSettingCallback?)`, `MapScene.setLightIntensity(MapSceneLightType, double, MapSceneLightAttributeSettingCallback?)`, `MapScene.setLightDirection(MapSceneLightType, LightDirection, MapSceneLightAttributeSettingCallback?)` to set the light attributes, `MapScene.getLightColor(MapSceneLightType)`, `MapScene.getLightIntensity(MapSceneLightType)`, `MapScene.getLightDirection(MapSceneLightType)` to retrieve the light attributes. Note that this is a beta release of this feature. <!-- HERESDK-2533 -->
- The latest supported Flutter version was raised from 3.19.3 to 3.22.1. The Dart version was updated from 3.3.1 to 3.4.1. Other versions may also work, but are not guaranteed to be supported. The HERE SDK plugin is now built with the minimum supported Flutter version 3.13.9. <!-- HERESDK-2038 -->
- This version of the HERE SDK is delivered with map data v129 for `CatalogType.optimizedClientMap` catalog and v77 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-3184 -->

#### API Changes - Breaking

- As announced in the changelog for HERE SDK 4.18.4.0, we transitioned to a new backend for satellite-based map schemes (`satellite`, `hybridDay`, `hybridNight`, `liteHybridDay`, `liteHybridNight`): <!-- markdown-link-check-disable-line -->https://maps.hereapi.com/v3/base/mc/{z}/{x}/{y}/jpeg?style=satellite.day&size=512.<!-- markdown-link-check-enable --> The new RTS (Raster Tile Service) endpoint does not support credentials from legacy developer accounts. If you have not already done so, please [migrate your account](https://www.here.com/docs/bundle/platform-migration-guide/page/topics/faq.html). As fallback option set the `EngineBaseURL.RASTER_TILE_SERVICE` to the old endpoint. See our release announcement for HERE SDK 4.18.4.0 for details. <!-- HERESDK-3169 -->
- Offline maps: Removed deprecated `MapLoaderError.tooManyRequests`. Use `MapLoaderError.requestLimitReached` instead. <!-- HERESDK-3007 -->
- Removed the previously deprecated `RoutePrefetcher.prefetchAroundLocation()` function. Please use `RoutePrefetcher.prefetchAroundLocationWithRadius()` instead. <!-- HERESDK-3006 -->
- Map view: Updated the supported map measure value range for 'DashImageRepresentation' from [0-20] to [1-20]. <!-- HERESDK-2735 -->

#### Resolved Issues

- Navigation: Fixed missing maneuver when continuing straight on a road that changes its name. <!-- HERESDK-3149 -->
- `OfflineRoutingEngine`: Fixed missing original coordinates of the arrival place when calling `returnToRoute()`. <!-- HERESDK-2817 -->
- Navigation: Fixed missing Hiragana transliteration that was causing an issue when receiving `ManeuverNotificationListener` events. <!-- HERESDK-2836 -->
- Navigation: Fixed `VisualNavigator` position jumps in tracking mode, that occurred when the most probable path contains a loop and drivers deviate from it. <!-- HERESDK-3117 -->

#### Known Issues

- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Navigation: When a route contains ferry sections, false positive route deviations may be reported in these sections. <!-- HERESDK-1901 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Navigation: Position updates for ferry sections of pedestrian routes may be incoherent. <!-- HERESDK-1901 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- Map view: When using `MapFeatureModes.terrain3D` then some portions of the tiles may fail to load when a zoom operation is performed while tiles are still loading. <!-- HERESDK-3135 -->
- Navigation: Due to an extrapolation issue, the `LocationIndicator` rendered by the `VisualNavigator` may show turns sometimes not accurately when driving in tracking mode. This happens only for a short time after it will be correctly automatically. <!-- HERESDK-2783 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.18.4.0

#### New Features

- Search: Added TripAdvisor support via `SearchEngine.setCustomOption()`. Note that this option is only available for customer who own a HERE license for rich content access including TripAdvisor. <!-- HERESDK-3124 -->
- Map view: Added `MapContentType.point` enum value. Added `PointData`, `PointDataBuilder`, `PointDataAccessor`, `PointDataSource` and `PointDataSourceBuilder` for creating and managing custom geodetic point data sources. Note that this is a beta release of this feature. <!-- HERESDK-786 -->
- Added `EngineBaseURL.rasterTileService` enum value to set a custom base URL template for the raster tile service. The `EngineBaseURL` can be set via `SDKOptions`. This option can be used to switch back to our legacy Map Tile service starting with HERE SDK 4.18.5.0. Note that this option will do nothing until HERE SDK 4.18.5.0. For more details, see our changelog entry regarding the planned Map Tile backend switch. <!-- HERESDK-2381 -->
- Navigation: Added `Span.getCar/Scooter/Truck/WalkAttributes()` to get `AccessAttributes` for car, trucks, scooters and pedestrians. <!-- HERESDK-3030 -->
- Navigation: Added `roadSignSegment` to `RoadSignWarning` to provide a reference to the road sign location. <!-- HERESDK-2956 -->
- This version of the HERE SDK is delivered with map data v128 for `CatalogType.optimizedClientMap` catalog and v77 for `CatalogType.optimizedClientMapJapan` catalog. <!-- HERESDK-3055 -->
- Added `LayerConfiguration.implicitlyPrefetchedFeatures` to define what features are downloaded during online usage - for example, when panning the map view or during navigation (if available for your edition). Previously, the same list of features had to be enabled for offline use via `MapDownloader` (if available for your edition) and online use. See our _Optimization Guide_ for the list of features that are enabled, by default. Now it is possible to define a different list for offline use via `LayerConfiguration.enabledFeatures` versus online usage for map view via `implicitlyPrefetchedFeatures`. The features for the latter are implicitly prefetched. If an empty list is set, then implicit prefetching is disabled: Effectively, this means to enable the most minimal network consumption during online use, while for offline use downloaded regions are unaffected. Note that this is a beta release of this feature. <!-- IOTSDK-23833 -->

#### API Changes - Breaking

- **Upcoming major change:** With HERE SDK 4.18.5.0, we plan to transition to a new backend for satellite-based map schemes (`satellite`, `hybridDay`, `hybridNight`, `liteHybridDay`, `liteHybridNight`). These new satellite map schemes are provided through our new Platform Raster Tile Service v3, and it is only accessible when your application is managed through the HERE platform. If you have not already done so, please [migrate your account](https://www.here.com/docs/bundle/platform-migration-guide/page/topics/faq.html) from your HERE developer account to the new HERE platform portal. Your HERE Sales representative or the HERE Support Team is available to assist you. If your account has not been migrated by then, satellite map schemes will no longer be rendered starting with HERE SDK 4.18.5.0. Need more time for the account migration to the HERE platform? Don’t worry! We also provide an option to switch back to our legacy Map Tile / Satellite service: For this, the following option needs to be set before initializing the HERE SDK: `sdkOptions.customEngineBaseUrls = { EngineBaseURL.rasterTileService: 'https://1.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/satellite.day/{z}/{x}/{y}/512/jpg' };`. Note that this option will do nothing until HERE SDK 4.18.5.0. <!-- IOTSDK-23863 -->

#### Resolved Issues

- `OfflineRoutingEngine`: Fixed missing `RouteHandle` when importing an offline route with a `RouteHandle` and a transport mode. <!-- HERESDK-3044 -->
- Fixed wrong distance calculation of `NavigatorInterface.calculateRemainingDistanceInMeters()` that happened when the requested coordinate could be found earlier in the route's path - for example, when the route is making turns back to previous travelled paths. <!-- HERESDK-2929 -->
- Navigation: Fixed the usage of route calculations with unnecessary toll cost requests that happened when the `DynamicRoutingEngine` checks for remaining route sections with a better estimated time of arrival. <!-- HERESDK-2916 -->

#### Known Issues

- With Flutter 4.16 or newer, devices running Android 14 may freeze when being resumed from background and the app is showing a map view. Note that this is a known [Flutter issue](https://github.com/flutter/engine/pull/50792) which is not specific for the HERE SDK. We recommend to not build your apps with Flutter 4.16 or newer if you are targeting Android 14 devices. <!-- HERESDK-2749 -->
- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- Map view: When using `MapFeatureModes.terrain3D` then some portions of the tiles may fail to load when a zoom operation is performed while tiles are still loading. <!-- HERESDK-3135 -->
- Navigation: Due to an extrapolation issue, the `LocationIndicator` rendered by the `VisualNavigator` may show turns sometimes not accurately when driving in tracking mode. This happens only for a short time after it will be correctly automatically. <!-- HERESDK-2783 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.18.3.0

#### New Features

- Routing: Added `TollOptions` to specify how tolls should be calculated by specifying `co2Class`, `emissionType`, `transponders` and `vehicleCategory`. <!-- IOTSDK-23879 -->
- Map view: Added `VehicleRestriction`, `SpecificRestriction`, `RestrictionType`, `HazardousMaterialRestriction`, `TimeRestriction` and `TransportType` which allow specifying details of a vehicle restriction for the purpose of generating a restriction icon using `IconProvider`. Added `VehicleRestrictionIconProperties` to specify restriction icon properties. Added `IconProvider.createVehicleRestrictionIconWithIconProperties(VehicleRestrictionIconProperties, MapScheme, Size2D, IconCallback)` method to generate restriction icon images. <!-- IOTSDK-23863 -->
- Search: Added new place category ID constant `PlaceCategory.facilitiesSchool`. <!-- IOTSDK-24190 -->
- Map view: Added `MapViewBase.pick(MapSceneMapPickFilter?, Rectangle2D, MapViewBaseMapPickCallback)`, `HereMapController.pick(MapSceneMapPickFilter?, Rectangle2D, MapViewBaseMapPickCallback)`, `MapViewBaseMapPickCallback`, `MapSceneMapPickFilter`, `MapPickResult`, `MapObjectDescriptor`.	Note that this feature is released as beta. <!-- IOTSDK-23699 -->

#### API Changes - Breaking

- **Upcoming major change:** With HERE SDK 4.18.5.0, we plan to transition to a new backend for satellite-based map schemes (`satellite`, `hybridDay`, `hybridNight`, `liteHybridDay`, `liteHybridNight`). These new satellite map schemes are provided through our new Platform Raster Tile Service v3, and it is only accessible when your application is managed through the HERE platform. If you have not already done so, please [migrate your account](https://www.here.com/docs/bundle/platform-migration-guide/page/topics/faq.html) from your HERE developer account to the new HERE platform portal. Your HERE Sales representative or the HERE Support Team is available to assist you. If your account has not been migrated by then, satellite map schemes will no longer be rendered starting with HERE SDK 4.18.5.0. Need more time for the account migration to the HERE platform? Don’t worry! We also provide an option to switch back to our legacy Map Tile / Satellite service. This fallback option will be available with HERE SDK 4.18.4.0. More details will be shared in the upcoming changelogs. <!-- IOTSDK-23863 -->

#### Resolved Issues

- Routing: Fixed `RoutingEngine.returnToRoute(..)` method where the returned route lacked stopovers when the `lastTraveledSectionIndex` parameter was zero. <!-- IOTSDK-24164 -->
- `OfflineRoutingEngine`: Fixed `RouteHandle` generation when it is disabled by `RouteOptions.enableRouteHandle`. <!-- IOTSDK-24221 -->
- Navigation: Fixed wrong `Speedlimits` events for trucks that could happen when there are multiple matching CVR rules. <!-- IOTSDK-24049 -->
- Navigation: Fixed incorrect `LocalizedRoadNumber.routeType` when no `Route` is set in tracking mode. <!-- IOTSDK-24123 -->

#### Known Issues

- With Flutter 4.16 or newer, devices running Android 14 may freeze when being resumed from background and the app is showing a map view. Note that this is a known [Flutter issue](https://github.com/flutter/engine/pull/50792) which is not specific for the HERE SDK. We recommend to not build your apps with Flutter 4.16 or newer if you are targeting Android 14 devices. <!-- HERESDK-2749 -->
- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.18.2.0

#### New Features

- Routing: Added `displayLocation` to `Waypoint` and `RoutePlace` to specify the `GeoCoordiates` of a POI to indicate its physical location. <!-- IOTSDK-23461 -->
- Incremental map updates are now enabled for `CatalogType.optimizedClientMapJapan`. <!-- IOTSDK-19231 -->
- Map view: Added `MapContentType.polygon` enum value.
Added `PolygonData`, `PolygonDataBuilder`, `PolygonDataAccessor`, `PolygonDataSource` and `PolygonDataSourceBuilder` for creating and managing custom geodetic polygon data sources. Note that this feature is released as beta. <!-- IOTSDK-21033 -->
- Navigation: Added `RealisticViewVectorImage` and 'RealisticViewWarning.realisticViewVectorImage' as replacement for the deprecated `RealisticView` and `RealisticViewWarning.realisticView`. <!-- IOTSDK-24014 -->
- Map view: Added `GeoPolygon.withInnerBoundaries([GeoCoordinates] vertices, [[GeoCoordinates]] innerBoundaries)` to construct a `GeoPolygon` with inner boundaries (holes) and `GeoPolygon.innerBoundaries` member to store and access the inner boundaries of a `GeoPolygon`. <!-- IOTSDK-21033 -->
- Map style update: Added dedicated roadshield icon for Indonesia. <!-- CARTODSG-8 -->
- This version of the HERE SDK is delivered with map data v124 for `CatalogType.optimizedClientMap` catalog and v76 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-24008 -->
- Added a [privacy manifest file](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files) to the HERE SDK plugin to describe the data collected by the HERE SDK and the purposes for this data collection. From May 1, 2024, Apple will require such manifests in order to publish or update iOS apps on the App Store. <!-- IOTSDK-23128 -->

#### API Changes - Breaking

- Removed ‘IconProvider‘ from `mapviewIconProvider` library. Use ‘IconProvider‘ from `mapview` library instead. <!-- IOTSDK-24010 -->

#### API Changes - Deprecations

- Deprecated `TimeRule.asString`. It will be removed in v4.21.0. Please use `TimeRule.timeRuleString` instead. <!-- IOTSDK-23669 -->
- Navigation: Deprecated `RealisticView` and `RealisticViewWarning.realisticView`. This will be removed in v4.21.0. Please use `RealisticViewVectorImage` and `RealisticViewWarning.realisticViewVectorImage` instead. <!-- IOTSDK-24014 -->

#### Resolved Issues

- Map view: When vector tiles are still loading, and the map view is destroyed or paused an ANR may occur sometimes when the internet connection is slow and/or when a device is running out of memory. <!-- IOTSDK-23736 -->
- Navigation: Fixed confusing maneuvers that happened when passing side streets. <!-- IOTSDK-19528 -->
- Navigation: Fixed `DynamicCameraBehavior` automatic maneuver zoom where the zoom distance was not being updated when approaching a maneuver. <!-- IOTSDK-24026 -->
- `SegmentDataLoader`: Fixed localization information related to road numbers. <!-- IOTSDK-24140 -->
- `OfflineRoutingEngine`: Now the HERE SDK aggregates the alternative toll fares by all available payment methods. <!-- OLPSUP-28985 -->
- `SegmentDataLoader`: Fixed localization information related to street names. <!-- IOTSDK-23786 -->
- `OfflineRoutingEngine`: Fixed violated restrictions details. <!-- IOTSDK-23669 -->

#### Known Issues

- With Flutter 4.16 or newer, devices running Android 14 may freeze when being resumed from background and the app is showing a map view. Note that this is a known [Flutter issue](https://github.com/flutter/engine/pull/50792) which is not specific for the HERE SDK. We recommend to not build your apps with Flutter 4.16 or newer if you are targeting Android 14 devices. <!-- IOTSDK-23464 -->
- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.18.1.0

#### New Features

- Navigation: Added new types for road signs with `RoadSignType.twoStageLeft` and `RoadSignType.twoStageRight` that are notified through the `RoadSignWarningListener`. A two-stage-turn (also known as hook-turn or Copenhagen-Left) is a special maneuver commonly used by cyclists to safely make a left turn at an intersection [without crossing oncoming traffic](https://www.liveintaiwan101.com/blog/posts/how-does-the-two-stage-left-turn-work). <!-- IOTSDK-23891 -->
- Positioning: Added new types to `LocationIssueType` with `positionNotFound`, `positionWlanScanError`, `positionNoWlanMeasurements`, `positionCellScanError` and `positionNoCellMeasurements`. The new types provide more detailed information about potential positioning issues. <!-- POSTI-3417 -->
- This version of the HERE SDK is delivered with map data v122 for `CatalogType.optimizedClientMap` catalog and v76 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-23874 -->
- Navigation: Added `TollStopWarningOptions` class which contains `highwayWarningDistanceInMeters`, `ruralWarningDistanceInMeters` and `urbanWarningDistanceInMeters` options to configure the distances when the toll stop warner is triggered on the corresponding road types. <!-- IOTSDK-23991 -->

#### API Changes - Deprecations

- Navigation: Deprecated `TextNotificationType.speedCameraWarning`. Use `TextNotificationType.safetyCameraWarning` instead. <!-- IOTSDK-23974 -->

#### Resolved Issues

- The beta API 'MapFeatureModes.terrainHillshadingWith3d' looks now as expected when being used together with custom raster layers, `MapMarker`, `MapPolyline`, `MapPolygon`, `LocationIndicator`, `MapFeatures` (`landmarks`, `shadows`). <!-- IOTSDK-19468 -->
- Navigation: Axle group weight truck restrictions are no longer considered as general restriction and will be ignored. <!-- IOTSDK-24090 -->
- Routing: Fixed incorrect side of destination by exposing side of street information from routing response - if available and when `Waypoint.sideOfStreetHint` is provided when calculating a route. <!-- IOTSDK-16639 -->
- Navigation: Fixed too long processing in internal map matcher component caused by circular segment connections. <!-- IOTSDK-23996 -->
- Map view: Fixed lost camera limits when setting `MapCameraLimits.zoomRange`. <!-- IOTSDK-23393 -->
- Map view: Fixed vehicle restriction shown when restriction's profile matches min or max value of restriction, i.e. when vehicle height is 5 m then a height restriction of 5 m was shown. <!-- IOTSDK-23483 -->
- `OfflineRoutingEngine`: Fixed invalid argument error while calling `OfflineRoutingEngine.importRoute(..)` with `RefreshRouteOptions` initialized with `TransportMode`. <!-- IOTSDK-23836 -->

#### Known Issues

- With Flutter 4.16 or newer, devices running Android 14 may freeze when being resumed from background and the app is showing a map view. Note that this is a known [Flutter issue](https://github.com/flutter/engine/pull/50792) which is not specific for the HERE SDK. We recommend to not build your apps with Flutter 4.16 or newer if you are targeting Android 14 devices. <!-- IOTSDK-23464 -->
- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Map view: When vector tiles are still loading, and the map view is destroyed or paused an ANR may occur sometimes when the internet connection is slow and/or when a device is running out of memory. <!-- IOTSDK-23736 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.18.0.0

#### New Features

- This version of the HERE SDK is delivered with map data v120 for `CatalogType.optimizedClientMap` catalog and v75 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-23712 -->
- Updated the latest supported Flutter version from 3.16.5 to 3.19.3. The related Dart version has been updated from 3.2.3 to 3.3.1. Note that the minimum supported Flutter and Dart versions remain unmodified. <!-- IOTSDK-23478 -->
- `OfflineRoutingEngine`: Added `RouteHandle` support for offline routing with `offlineRoutingEngine.importRouteFromHandle(..)` that accepts a route handle to recreate the route. <!-- IOTSDK-18924 -->
- Search: Introduced new `W3WSearchEngine` which converts three word addresses to coordinates and vice versa through the respective search methods. Added `W3WSquare`, `W3WSearchError` and `W3WSearchCallback` to receive the results. <!-- IOTSDK-23742 -->
- Map view: Added `MapContext.freeResource()` to free resources used by map view objects. This feature is intended for use when system resource availability becomes low. For example, it allows to free memory when the application transitions to background. <!-- IOTSDK-23774 -->
- Map view: Enhanced data for picked vehicle restrictions: Added `restrictionCategory` and `countryCode` members to `PickMapContentResult.VehicleRestrictionResult`. This additional information can be used to generate vehicle restriction icons with the `IconProvider`. <!-- IOTSDK-23384 -->
- Map view: The 'MapFeatureModes.terrain3d' feature mode is now also supported in combination with our hybrid map schemes. Note that this is a beta release of this feature. <!-- IOTSDK-23427 -->
- Map view: Added `IconProvider.createVehicleRestrictionIcon()` to obtain a vehicle restriction icon from a `PickVehicleRestrictionsResult`. Note that this is a beta release of this feature. <!-- IOTSDK-23384 -->
- Removed beta status for `RoutingEngine.refreshRoute(..)`, `RoutingEngine.refreshRouteWithTraveledDistance(..)`, `RoutingEngine.importRouteFromHandle(..)`, `RoutingEngine.importCarRoute(..)`, `RoutingEngine.importScooterRouteWithStops(..)`, `RoutingEngine.importScooterRoute(..)`, `RoutingEngine.importTruckRoute(..)`, `RoutingEngine.importBusRoute(..)`, `RoutingEngine.importPrivateBusRoute(..)`, `RoutingEngine.importEVCarRoute(..)`, `RoutingEngine.importEVTruckRoute(..)`, `RoutingEngine.importCarRouteWithStops(..)`, `RoutingEngine.importTruckRouteWithStops(..)`, `RoutingEngine.importBusRouteWithStops(..)`, `RoutingEngine.importPrivateBusRouteWithStops(..)`, `RoutingEngine.importEVCarRouteWithStops(..)`, RoutingEngine.importEVTruckRouteWithStops(..)`. These APIs are now considered to be stable. <!-- IOTSDK-23855 -->
- EV routing: Removed beta notice for `EVChargingPool`, `EVChargingStation`, `EVChargingPoolDetails` and `EVSE`. These APIs are now considered to be stable. A charging pool for electric vehicles is an area equipped with one or more charging stations. A charging station defines a group of connectors for electrical vehicles that share a common charging connector type and max power level. <!-- IOTSDK-23680 -->
- Routing: Introduced `IsolineRoutingEngine` to support the existing routing isoline feature which was available through the `RoutingEngine` and that has been deprecated with this release. <!-- IOTSDK-23274 -->

#### API Changes - Breaking

- Map view: Removed previously deprecated getters and setters for visual properties of a `MapPolyline` as well as the related constructors. Use instead `MapPolylineSolidRepresentation` and `MapPolylineDashRepresentation` with `MapPolyline.setRepresentation(MapPolylineRepresentation)` and the constructor `MapPolyline(GeoPolyline, MapPolylineRepresentation)`. <!-- IOTSDK-20185 -->
- Map view: Renamed `MapFeatureModes.terrainHillshading` and `MapFeatureModes.terrainHillshadingWith3d` to `MapFeatureModes.terrainHillshade` and `MapFeatureModes.terrain3d` respectively. Note that the renamed modes are released as beta. <!-- IOTSDK-23417 -->
- Routing: Removed the previously deprecated `Span.polyline`. Use instead `Span.geometry`. <!-- IOTSDK-18874 -->
- Map view: Removed the previously deprecated `LocationIndicator` implementation of `MapViewLifecycleListener`. Use `LocationIndicator.enable` and `LocationIndicator.disable` to add or remove a `LocationIndicator` from a `MapView`. <!-- IOTSDK-18871 -->
- Navigation: Removed the previously deprecated `Milestone` constructor. Use instead the `Milestone` constructor that supports the `MilestoneType` type. <!-- IOTSDK-18553 -->
- As announced previously, with HERE SDK 4.18.0.0, we have raised the minimum supported iOS version from iOS 12.4 to **iOS 13.0**. <!-- IOTSDK-23139 -->
- Routing: Removed the previously deprecated `routingEngine.returnToRoute(...)` method overload which required to calculate the traveled fraction to be set as parameter. Use instead the `routingEngine.returnToRoute(...)` overload which directly consumes the `RouteDeviation` parameters to provide the same information. `routeDeviation.fractionTraveled` has been removed for the same reason. Use instead `routeDeviation.lastTraveledSectionIndex` and `routeDeviation.traveledDistanceOnLastSectionInMeters`. Note that the `RouteDeviation` event is only available for the _Navigate Edition_. <!-- IOTSDK-18420 -->

#### API Changes - Deprecations

- Search: Deprecated the `CategoryQuery_Area.withCorridor` constructor.  Use instead `CategoryQuery_Area.withCorridorAndCenter`. <!-- IOTSDK-23352 -->
- Deprecated `SearchError.polylineTooLong` as it can no longer occur: The HERE SDK now resolves too long polyline automatically under the hood. `SearchError.polylineTooLong` will be removed with HERE SDK 4.20.0. <!-- IOTSDK-23697 -->
- Navigation: Deprecated `TruckRestrictionWarning` constructor that does not set all fields, instead set fields explicitly. <!-- IOTSDK-23819 -->
- `RoutingEngine`: Deprecated method `calculateIsoline(..)`. The functionality has been moved to the new `IsolineRoutingEngine`. <!-- IOTSDK-23274 -->

#### Resolved Issues

- _Navigate Edition_ customers experienced unnecessary requests for satellite tiles that have been already cached. With HERE SDK 4.18.0.0 this has been fixed and new tiles are downloaded earliest after one day based on a LRU strategy. <!-- IOTSDK-23767 -->
- Offline navigation: Fixed missing route type information in `LocalizedRoadNumber` for offline maneuver. <!-- IOTSDK-23499 -->
- Navigation: Improved performance and memory consumption of data loading for warners based on listener availability for that warner. <!-- IOTSDK-22964 -->
- Navigation: Fixed a crash during map matching that affected selected devices. <!-- IOTSDK-23948 -->

#### Known Issues

- With Flutter 4.16 or newer, devices running Android 14 may freeze when being resumed from background and the app is showing a map view. Note that this is a known [Flutter issue](https://github.com/flutter/engine/pull/50792) which is not specific for the HERE SDK. We recommend to not build your apps with Flutter 4.16 or newer if you are targeting Android 14 devices. <!-- IOTSDK-23464 -->
- Map view: When vector tiles are still loading, and the map view is destroyed or paused an ANR may occur sometimes when the internet connection is slow and/or when a device is running out of memory. <!-- IOTSDK-23736 -->
- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- The beta API 'MapFeatureModes.terrainHillshadingWith3d' may not look as expected when being used together with custom raster layers, `MapMarker`, `MapPolyline`, `MapPolygon`, `LocationIndicator`, `MapFeatures` (`landmarks`, `shadows`). <!-- IOTSDK-19468 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.17.5.0

#### New Features

- Map view: Added 'MapScheme.logisticsNight', the dark equivalent to 'MapScheme.logisticsDay' with focus on fleet management content. <!-- IOTSDK-23075 -->
- Routing: Added `timeRule` field to `TollFare` to indicate applicable times for toll costs. <!-- IOTSDK-23607 -->
- Navigation: Added `MapMatchedLocation.isDrivingInTheWrongWay` to identify when the driver is driving against the permitted travel direction of the road. <!-- IOTSDK-20844 -->
- Positioning: Added new enum value to `LocationIssueType` for `sensorPositioningNotAvailable`. <!-- HDGNSS-5002 -->
- This version of the HERE SDK is delivered with map data v119 for `CatalogType.optimizedClientMap` catalog and v75 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-23563 -->
- Map style update: Added additional localized bank POIs. <!-- CARTODSG-656 -->
- Map view: Added `MapContentType.line` enum value. Added `DataAttributesBuilder` for building `DataAttributes` instances. Added `DataAttributeValue`, `DataAttributes` and `DataAttributesBuilder` for creating custom data attributes. Added `LineData`, `LineDataBuilder`, `LineDataAccessor`, `LineDataSource` and `LineDataSourceBuilder` for creating and managing custom geodetic line data sources. This feature allows to consume less memory for large data sets - instead of using `MapPolyline`. It allows also finer control over the style and layer stacking, for example, to show a line before map labels. See also our _style guide for custom map styles_ for more information - which is part of the Developer Guide. Note that this feature is a beta release of this feature. <!-- IOTSDK-21031 -->

#### API Changes - Breaking

- Map view: Removed the beta status for `MapScene.enableFeatures(..)`, `MapScene.disableFeatures(..)`, `MapScene.getSupportedFeatures()` and `MapScene.getActiveFeatures()`. The API is now considered to be stable. <!-- IOTSDK-23457 -->
- The `TruckRestrictionWarning` field `type` and the enum `TruckRestrictionWarningType` with the values `general`, `weight` and `dimension` were introduced with HERE SDK version 4.12.8 to indicate the truck restriction type, however, since then, additional fields were added to `TruckRestrictionWarning` (`trailerCount` with 4.14.0, `timeRule` with 4.14.4, and `truckRoadType`, `hazardousMaterials`, `tunnelCategory`, and `axleCount` with 4.16.3) that impacted the originally designed truck restriction type, meaning that, now, for example, a general truck restriction that is not further specified applies only when the other fields are `null`. Please note, that applications must check all `TruckRestrictionWarning` fields in order to announce/display the applicable truck restrictions. The `timeRule` field can be set alone or in combination with other restrictions when they are time-dependent. <!-- IOTSDK-14576 -->
- Upcoming breaking change - with **HERE SDK 4.18.0.0**, our next major release, we plan to raise the minimum supported iOS version from iOS 12.4 to **iOS 13.0**. <!-- IOTSDK-23139 -->

#### API Changes - Deprecations

- Navigation: Deprecated the redundant `TruckRestrictionWarning` field `type` and its enum `TruckRestrictionWarningType`. Instead, check all nullable fields of a `TruckRestrictionWarning` to see which types are given, such as `WeightRestriction` or `DimensionRestriction`. A general truck restriction is given when all fields are `null` and when the list for `HazardousMaterial` is empty. <!-- IOTSDK-23671 -->

#### Resolved Issues

- Navigation: Fixed crash that happened when issuing safety camera warnings from the `EventTextListener`. Note that the issue was introduced with HERE SDK 4.17.3.0. <!-- IOTSDK-23619 -->
- `OfflineRoutingEngine`: Fixed unexpected max gross weight restriction notice. <!-- OLPSUP-29518 -->
- Navigation: Roundabouts maneuvers do no longer trigger any spatial azimuth trajectory. <!-- IOTSDK-23604 -->
- `OfflineRoutingEngine`: Fixed signpost text. <!-- IOTSDK-13009 -->
- Navigation: Japanese notifications for depart maneuver text have been fixed. <!-- IOTSDK-23546 -->
- Map view: Fixed density independent pixel scaling for 'MapMarker3d'. <!-- IOTSDK-23191 -->

#### Known Issues

- With Flutter 4.16 or newer, devices running Android 14 may freeze when being resumed from background and the app is showing a map view. Note that this is a known [Flutter issue](https://github.com/flutter/engine/pull/50792) which is not specific for the HERE SDK. We recommend to not build your apps with Flutter 4.16 or newer if you are targeting Android 14 devices. <!-- IOTSDK-23464 -->
- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- The beta API 'MapFeatureModes.terrainHillshadingWith3d' may not look as expected when being used together with custom raster layers, `MapMarker`, `MapPolyline`, `MapPolygon`, `LocationIndicator`, `MapFeatures` (`landmarks`, `shadows`). <!-- IOTSDK-19468 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.17.4.0

#### New Features

- `GPXTrackWriter`: Now, information on elevation, pitch and milliseconds can be recorded into a GPX track via GPX track points as elevation, pitch and timestamp attributes. <!-- IOTSDK-23308 -->
- Navigation: Added `highwayWarningDistanceInMeters`, `ruralWarningDistanceInMeters` and `urbanWarningDistanceInMeters` options to `RealisticViewWarningOptions`. <!-- IOTSDK-23437 -->
- Navigation: Added `SafetyCameraWarningOptions` class to configure options for `SafetyCameraWarnings`. Added `safetyCameraWarningOptions` property to `NavigatorInterface`. <!-- IOTSDK-23356 -->
- This version of the HERE SDK is delivered with map data v117 for `CatalogType.optimizedClientMap` catalog and v74 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-23411 -->
- Added `pitchInDegrees` to `Location` class and `deadReckoning` to `LocationTechnology` enum. Note that these values are not set by the HERE SDK, but applications can now make use of such fields - for example, when special hardware is attached that is capable of providing such data. The new fields are also useful when recording GPX files with the HERE SDK - if available for your edition. <!-- IOTSDK-23242 -->
- Map style update: Added outline display for polygonal roads in Japan. <!-- CARTODSG-6 -->
- Map style update: Implemented dynamic label placement for embedded Carto POIs. Depending on the available space, labels can appear top, left or right around the POI icon to improve readability. <!-- CARTODSG-607 -->
- `RoutingEngine`: Added `RoutingConnectionSettings` option as overloaded constructor parameter to allow custom network connection settings, for example, to specify the retry logic when connecting the HERE routing backend. Note that this change was already introduced with HERE SDK 4.17.3.0. <!-- IOTSDK-23138 -->
- Navigation: Added `highwayWarningDistanceInMeters`, `ruralWarningDistanceInMeters` and `urbanWarningDistanceInMeters` options to `RoadSignWarningOptions`. <!-- IOTSDK-23351 -->

#### API Changes - Breaking

- Upcoming breaking change - with **HERE SDK 4.18.0.0**, our next major release, we plan to raise the minimum supported iOS version from iOS 12.4 to **iOS 13.0**. <!-- IOTSDK-23139 -->

#### Resolved Issues

- Navigation: Fixed incorrect keep right/left maneuver generation for rare situations with multiple lanes. <!-- IOTSDK-20173 -->
- Navigation: Fixed an issue for the voice maneuver text generation. Added a `<speak>` tag to comply with the SSML (Speech Synthesis Markup Language) specification. <!-- IOTSDK-23326 -->

#### Known Issues

- With Flutter 4.16 or newer, devices running Android 14 may freeze when being resumed from background and the app is showing a map view. Note that this is a known [Flutter issue](https://github.com/flutter/engine/pull/50792) which is not specific for the HERE SDK. We recommend to not build your apps with Flutter 4.16 or newer if you are targeting Android 14 devices. <!-- IOTSDK-23464 -->
- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- The beta API 'MapFeatureModes.terrainHillshadingWith3d' may not look as expected when being used together with custom raster layers, `MapMarker`, `MapPolyline`, `MapPolygon`, `LocationIndicator`, `MapFeatures` (`landmarks`, `shadows`). <!-- IOTSDK-19468 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.17.3.0

#### New Features

- Navigation: Added intersection name in Japanese maneuver notification in Japan. <!-- IOTSDK-20910 -->
- Navigation: Added new `RailwayCrossingWarning` that informs on upcoming railway crossings. <!-- IOTSDK-21126 -->
- Navigation: Added `EventTextListener` to expose extra information regarding maneuvers and speed camera warning text notifications. <!-- IOTSDK-20254 -->
- Search: Added `CategoryQuery_Area` constructor that takes `GeoCorridor` and `GeoCoordinates` as parameters. <!-- IOTSDK-23334 -->
- MapLoader: Added `downloadArea()` to `MapDownloader` for specified custom region downloading via `GeoPolygon`. <!-- IOTSDK-19540 -->
- This version of the HERE SDK is delivered with map data v115 for `CatalogType.optimizedClientMap` catalog and v74 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-23222 -->
- Search: Added a closed-alpha feature `SearchOptions.highDensityEncodingEnabled`.
  Enabling high density encoding allows input parameters of type `GeoCorridor` to be encoded with higher density of coordinates in `SearchEngine` requests. <!-- IOTSDK-23076 -->
- Introduced visual improvements for the roads in a hybrid scheme on a zoom-in level. Now transparent roads are displayed without round cap artifacts at the intersection of road segments. <!-- CARTODSG-715 -->

#### API Changes - Breaking

- Upcoming breaking change - with **HERE SDK 4.18.0.0**, our next major release, we plan to raise the minimum supported iOS version from iOS 12.4 to **iOS 13.0**. <!-- IOTSDK-23139 -->

#### API Changes - Deprecations

- `SpatialManeuverNotificationListener` will be removed in v4.20.0. Please use `EventTextListener` instead. <!-- IOTSDK-20254 -->
- `SpatialManeuverAzimuthListener` will be removed in v4.20.0. Please use `EventTextListener` instead. <!-- IOTSDK-20254 -->
- `ManeuverNotificationListener` will be removed in v4.20.0. Please use `EventTextListener` instead. <!-- IOTSDK-20254 -->

#### Resolved Issues

- `OfflineSearchEngine`: Added support for category name translations for `OfflineSearchEngine` results.
  Each assigned `PlaceCategory` to a `Place` now includes category names in the requested language.
  Defaults to local language if not set or available. <!-- IOTSDK-22521 -->
- Routing: Fixed missing notice details in truck road type violation section notice. <!-- IOTSDK-23249 -->
- Navigation: Fixed map-matcher logic regarding loading unnecessary ferry segments which prevents the user from receiving `NavigableLocation` with map-matched locations and other location related events like `RouteDeviation`. The issue could be observed when the input location was close (same tile) to very long ferry segments. <!-- IOTSDK-23092 -->

#### Known Issues

- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- Flutter apps may experience freezing on Android 14 devices when resumed from the background. <!-- IOTSDK-23464 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.17.2.0

#### New Features

- Map view: Added `DrawOrderType` to represent the type of a draw order. Added `mapPolyline.drawOrderType` property. For example, with `mapSceneAdditionOrderIndependent` you can specify that the draw order should not depend on the order of when an item is added. Instead, multiple map items of the same type with the same draw order can be drawn in an arbitrary order and map items with similar attributes like color can be grouped and drawn together all at once to improve the rendering performance. <!-- IOTSDK-23108 -->
- Routing: Added more route violation codes with `SectionNoticeCode.violatedAvoidDifficultTurns`, `SectionNoticeCode.potentialCarpool`, `SectionNoticeCode.potentialTurnRestriction`, `SectionNoticeCode.potentialVehicleRestriction`, `SectionNoticeCode.potentialZoneRestriction`, `SectionNoticeCode.violatedChagingStationOpeningHours` and `SectionNoticeCode.tollsDataTemporarilyUnavailable`. <!-- IOTSDK-42 -->
- Added `MapFeatureModes.terrainHillshadingWith3d` to show shaded 3D terrain on the map. This mode is not supported for the following map schemes: `hybridDay`, `hybridNight` and `satellite`. Note that this is a beta release of this feature. <!-- IOTSDK-20520 -->
- Navigation: Added new `RailwayCrossingWarning` that informs on upcoming railway crossings. <!-- IOTSDK-21126 -->
- `OfflineRoutingEngine`: Fixed a parsing issue for `SectionNotice` for weight per axle groups. <!-- IOTSDK-22982 -->
- Added `PlaceFilter_EV.minPowerInKilowatts` that enables retrieving EV charging stations with the given minimum charging power. Note that this is released as closed-alpha for selected customers. By default, this feature results in a `SearchError.forbidden` when your credentials are not enabled. <!-- IOTSDK-22954 -->
- Routing: Added `ViolatedRestriction.Details.timeRule` to inform on the time intervals during which restrictions are enforced. <!-- IOTSDK-22117 -->
- This version of the HERE SDK is delivered with map data v113 for `CatalogType.optimizedClientMap` catalog and v72 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-23042 -->
- Map view: The previously released APIs for picking vehicle restrictions with `PickMapContentResult.VehicleRestrictionResult` and `PickMapContentResult.vehicleRestrictions` and the related filtering features via `MapContentSettings.filterVehicleRestrictions()` and `MapContentSettings.resetVehicleRestrictionFilter()` are now considered to be stable and the beta status has been removed. <!-- IOTSDK-18996 -->

#### API Changes - Breaking

- `VisualNavigator`: Extrapolation is now enabled, by default. You can change this via the `extrapolation` property. Extrapolation enables the use of predicted locations that follow the geometry of the route (or road) ahead to achieve a more accurate navigation experience. <!-- IOTSDK-23086 -->
- Map view: Changed the allowed range for the camera's field of view (FoV) for `MapCameraKeyframeTrack.fieldOfView()`, `MapCameraKeyframeTrack.fieldOfViewWithEasing()` and `MapCameraUpdateFactory.setVerticalFieldOfView()` - the value for the FoV will be clamped to the range [1deg, 150deg]. <!-- IOTSDK-20796 -->
- Upcoming breaking change - with **HERE SDK 4.18.0.0**, our next major release, we plan to raise the minimum supported iOS version from iOS 12.4 to **iOS 13.0**. <!-- IOTSDK-23139 -->

#### Resolved Issues

- `OfflineRoutingEngine`: Fixed an issue with duplicated `SectionNotice` items. <!-- IOTSDK-22117 -->
- `OfflineRoutingEngine`: Fixed an issue for avoidance of certain truck road types. <!-- IOTSDK-19937 -->
- Navigation: Fixed an issue with incorrect locations for `BorderCrossingWarning` events. <!-- IOTSDK-23048 -->
- Navigation: Improved maneuver notifications for Hungarian with directional phrases for major road names with proper declension. <!-- IOTSDK-23153 -->

#### Known Issues

- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- The beta API 'MapFeatureModes.terrainHillshadingWith3d' may not look as expected when being used together with custom raster layers, `MapMarker`, `MapPolyline`, `MapPolygon`, `LocationIndicator`, `MapFeatures` (`landmarks`, `shadows`). <!-- IOTSDK-22644 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.17.1.0

#### New Features

- `OfflineSearchEngine`: Added `StructuredQuery` as input for `OfflineSearchEngine.search(..)` and `OfflineSearchEngine.suggest(..)`. This feature allows to search for `Place` results for a given `ResultType` such as `street` or `district`. On top, `AddressElements` can be specified to limit the results to a specific `city` and other elements along with a search `query` and  other parameters. A possible use case can be to limit suggestions to certain types, for example, to accept only `street` results in "Los Angeles" and reject other results like "Pizza Palace" when a user starts to type "Pi ...". Note that this is a beta release of this feature. <!-- IOTSDK-22520 -->
- `MapImageOverlay` and related APIs are considered to be stable. Removed the beta status. <!-- IOTSDK-18994 -->
- The HERE SDK is now built with Xcode 14.2 instead of Xcode 13.2.1. <!-- IOTSDK-20679 -->
- Raised the minimum supported Flutter version from 3.7.12 to 3.13.9. Raised the minimum supported Dart version from 2.19.6 to 3.1.5. Raised the latest supported Flutter version from 3.10.6 to 3.16.5. Raised the latest supported Dart version from 3.0.6 to 3.2.3. Other versions may also work, but are not guaranteed to be supported. <!-- IOTSDK-18952 -->
- Added `PickMapContentResult.pickedPlaces` containing a list of `PickedPlace` results. A `PickedPlace` can be use more efficiently to search for a `Place` when an embedded map marker is picked from the map. Take a look at the _carto_poi_picking_app_ example for a possible usage scenario. <!-- IOTSDK-19054 -->
- Search: Added `Address.stateCode` that contains a state code for the address. <!-- IOTSDK-22871 -->
- Search: Added `PickedPlace.offlineSearchId` that holds a place ID. Note that the parameter is meant to be consumed by the HERE SDK internally when passing a `PickedPlace` as argument to a search engine. <!-- IOTSDK-19054 -->
- `MapDownloader`: With HERE SDK 4.17.1.0 we improved the performance when installing new map data into the cache and the persisted storage, especially, when external SD cards (Android only) are used. <!-- IOTSDK-22832 -->
- This version of the HERE SDK is delivered with map data v112 for `CatalogType.optimizedClientMap` catalog and v72 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-22891 -->
- Map style update: Added new embedded Carto POIs for the following categories: _Golf Shop_, _EV Dealership - New Vehicles_, _EV Dealership - Used Vehicles_, _EV Repair_ and _Urgent Care Center_. <!-- CARTODSG-667 -->

#### API Changes - Breaking

- Map style update: Generic truck restriction icons are no longer displayed for streets that are open for delivery but closed for trucks. Only generic truck restrictions are affected by this change. The behavior for all other specific restrictions (weight, height, length, hazardous, ...) has not changed. <!-- IOTSDK-21978 -->
- Map style update: Increased the density for city labels. City labels are now shown 1 or 2 zoom levels earlier. <!-- CARTODSG-706 -->
- Upcoming breaking change - with **HERE SDK 4.18.0.0**, our next major release, we plan to raise the minimum supported iOS version from iOS 12.4 to **iOS 13.0**. <!-- IOTSDK-23139 -->

#### API Changes - Deprecations

- Deprecated `PickMapContentResult.PoiResult` and `PickMapContentResult.pois`. Use `PickedPlace` and `PickMapContentResult.pickedPlaces` instead. <!-- IOTSDK-19054 -->

#### Resolved Issues

- `DynamicRoutingEngine`: Fixed a potential issue that may cause an ANR when stopping the engine. <!-- IOTSDK-20960 -->
- Fixed an issue for the map schemes `roadNetworkDay` and `roadNetworkNight` where `MapMarker` items are not rendered as expected. <!-- IOTSDK-22629 -->
- Maneuver notifications: The distance phrase for Finnish voice messages has been revised to become more instructive. <!-- OLPSUP-25015 -->
- Navigation: Fixed incorrect general `TruckRestrictionWarning` for certain roads. <!-- IOTSDK-22826 -->
- `OfflineRoutingEngine`: Improved certain issues with the error reporting logic. <!-- IOTSDK-22829 -->
- `OfflineRoutingEngine`: Fixed missing `ViolatedRestriction.Details` when `maxPayloadCapacityInKilograms` is violated. <!-- IOTSDK-22990 -->
- Navigation: Fixed an issue with incorrect `RouteDeviation` events. <!-- IOTSDK-20918 -->
- `OfflineRoutingEngine`: Fixed missing spans with `SectionNotices` that may occur when a `Section` contains a violation for `violatedZoneRestriction`. <!-- IOTSDK-22887 -->

#### Known Issues

- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.17.0.0

#### New Features

- Routing: Added property `avoidPolygonAreas` to `AvoidanceOptions` to enable avoiding polygon-shaped areas during route calculation. <!-- IOTSDK-19958 -->
- Added `GeoBox.intersection(GeoBox)` and `static GeoBox.intersection(List<GeoBox>)` to detect an intersection of two or more geo boxes - also known as collision check. <!-- IOTSDK-20559 -->
- `TrafficEngine`: Added `queryForFlow()` methods for querying traffic flow data within a bounding box, a circle, or a corridor. Via `TrafficFlowQueryOptions` you can specify the min/max jam factor. The callback provides a list of `TrafficFlow` objects that contain details on the traffic flow. The data may differ from the traffic flow feature shown on the map view. Note that this is a beta release of this feature. <!-- IOTSDK-20554 -->
- Indoor maps: Added `VenueService.loadTopologies()`. This informs the `VenueService` that topology features must be downloaded with venue map. Added function `Venue.setTopologyVisible()` and `Venue.getTopologyVisible()`. These functions are used to toggle topology visibility. Added `VenueLevel.getTopologies()`. It provides a list of topologies associated with given level. Added class `VenueTopology`. It has all the properties associated with given topology object. <!-- INDOOR-19023 -->
- `MapView`: `MapView`: Added `Easing` class representing an easing function to be used with animations. Added `MapCameraAnimationFactory.createAnimationFromUpdateWithEasing(MapCameraUpdate, Duration, Easing)`. Added `MapCameraKeyframeTrack.lookAtDistanceWithEasing(List<ScalarKeyframe>, Easing, KeyframeInterpolationMode)`. Added `MapCameraKeyframeTrack.lookAtTargetWithEasing( List<GeoCoordinatesKeyframe>, Easing, KeyframeInterpolationMode)`. Added `MapCameraKeyframeTrack.lookAtOrientationWithEasing(List<GeoOrientationKeyframe>, Easing, KeyframeInterpolationMode)`. Added `MapCameraKeyframeTrack.principalPointWithEasing(List<Point2DKeyframe>, Easing, KeyframeInterpolationMode)`. Added `MapCameraKeyframeTrack.normalizedPrincipalPointWithEasing(List<Anchor2DKeyframe>, Easing, KeyframeInterpolationMode)`.Added `MapCameraKeyframeTrack.positionWithEasing(List<GeoCoordinatesKeyframe>, Easing, KeyframeInterpolationMode)`. Added `MapCameraKeyframeTrack.orientationWithEasing(List<GeoOrientationKeyframe>, Easing, KeyframeInterpolationMode)`. Added `MapCameraKeyframeTrack.fieldOfViewWithEasing(List<ScalarKeyframe>, Easing, KeyframeInterpolationMode)`. Added `MapItemKeyFrameTrack.moveToWithEasing(List<GeoCoordinatesKeyframe>, Easing, KeyframeInterpolationMode)`. Added `MapItemKeyFrameTrack.polylineProgressWithEasing(List<ScalarKeyframe>, Easing, KeyframeInterpolationMode)`. <!-- IOTSDK-19638 -->
- `MapView`: Added two new `MapScheme` layers: `roadNetworkDay` and `roadNetworkNight` which highlight roads without showing other content such as labels or buildings. It is designed for usage as an additional zoomed-in mini-maps display to help drivers to orientate during navigation and to focus on the maneuver arrows which can be highlighted on top of these new map schemes. <!-- IOTSDK-19842 -->
- Custom catalogs: Added `ExternalMapDataSource.configureSdkEngineWithAutoRemoteConnection(..)` and `ExternalMapDataSource.configureSdkEngineWithFixedRemoteConnection(..)` to connect a separate process, which serves map content. Select the appropriate API depending on the desired strategy to resolve the catalog configuration. Use `ExternalMapDataSource.start(..)` and `ExternalMapDataSource.stop(..)` to control the lifetime of the server, that allows other processes to connect and consume map content. <!-- IOTSDK-20474 -->
- Navigation: Added a new warner to receive `DangerZoneWarning` events that inform on danger zones. A danger zone refers to areas where there is an increased risk of traffic incidents. These zones are designated to alert drivers to potential hazards and encourage safer driving behaviors. The HERE SDK warns when approaching the danger zone, as well as when entering and leaving such a zone. A danger zone may or may not have one or more speed cameras in it. The exact location of such speed cameras is not provided. Note that danger zones are only available for selected countries, such as France. <!-- IOTSDK-20181 -->
- Custom raster layer: Added a `Style` class to update visual properties of a raster layer at runtime - such as transparency. Added `JsonStyleFactory` to create a `Style` from JSON sources. Added `MapLayerBuilder.withStyle(Style)` method to provide a custom style when creating a `MapLayer`. Added `MapLayer.setStyle(Style)` method to update a custom layer style. Note: This is a beta release of this feature, so there could be a few bugs and unexpected behaviors. Related APIs may change for new releases without a deprecation process. <!-- IOTSDK-20190 -->
- This version of the HERE SDK is delivered with map data v109 for `CatalogType.optimizedClientMap` catalog and v72 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-20725 -->
- Custom backends: Added enum `EngineBaseURL.trafficVectorTileService` to provide a custom traffic vector tile service URL. This impacts the traffic flow feature shown on the `MapView`. <!-- IOTSDK-19023 -->

#### API Changes - Breaking

- Removed deprecated `HereMapOptions` constructors `HereMapOptions(MapProjection)`, `HereMapOptions.fromColor(Color)`, `HereMapOptions.fromProjectionAndColor(MapProjection, Color)`. Instead, use the `HereMapOptions.withDefaults` constructor and change the desired properties on the resulting `HereMapOptions` object. <!-- IOTSDK-17543 -->
- Routing: Removed the previously deprecated `Span.routeNumber`. Use instead `Span.roadNumbers`. <!-- IOTSDK-20564 -->
- For Android, the HERE SDK is now using `compileSdkVersion` and `targetSdkVersion` 34 instead of 33. Apps should update the version in the app's `build.gradle` file. <!-- IOTSDK-19810 -->
- Custom raster tiles: Removed the previously deprecated `templateUrl` from `RasterDataSourceProviderConfiguration` along with the corresponding constructors. Use instead `urlProvider` and the corresponding constructors which were previously beta APIs and are now modified to use the non-optional `urlProvider` as first parameter. `TileUrlProviderFactory.fromXyzUrlTemplate()` can be used to generate a URL provider callback for an xyz URL template. `TileUrlProviderCallback` and `TileUrlProviderFactory` are no longer beta APIs and are now considered to be stable. <!-- IOTSDK-18988 -->

#### API Changes - Deprecations

- Deprecated `HereMapOptions.withDefaults()` constructor, use the unnamed constructor instead. <!-- IOTSDK-20734 -->
- Routing: Deprecated `AvoidanceOptions.avoidAreas`. Use `AvoidanceOptions.avoidBoundingBoxAreas` instead. <!-- IOTSDK-19958 -->
- Deprecated `MapCameraAnimationFactory.createAnimationFromUpdate(MapCameraUpdate, Duration, EasingFunction)`. Use `MapCameraAnimationFactory.createAnimationFromUpdateWithEasing(MapCameraUpdate, Duration, Easing)` instead. Deprecated `MapCameraKeyframeTrack.easingFunction` property. Deprecated `MapCameraKeyframeTrack.lookAtDistance(List<ScalarKeyframe>, EasingFunction, KeyframeInterpolationMode)`. Use `MapCameraKeyframeTrack.lookAtDistanceWithEasing(List<ScalarKeyframe>, Easing, KeyframeInterpolationMode)` instead. Deprecated `MapCameraKeyframeTrack.lookAtTarget(List<GeoCoordinatesKeyframe>, EasingFunction, KeyframeInterpolationMode)` Use `MapCameraKeyframeTrack.lookAtTargetWithEasing(List<GeoCoordinatesKeyframe>, Easing, KeyframeInterpolationMode)` instead. Deprecated `MapCameraKeyframeTrack.lookAtOrientation(List<GeoOrientationKeyframe>, EasingFunction, KeyframeInterpolationMode)`. Use `MapCameraKeyframeTrack.lookAtOrientationWithEasing(List<GeoOrientationKeyframe>, Easing, KeyframeInterpolationMode)` instead. Deprecated `MapCameraKeyframeTrack.principalPoint(List<Point2DKeyframe>, EasingFunction, KeyframeInterpolationMode)`. Use `MapCameraKeyframeTrack.principalPointWithEasing(List<Point2DKeyframe>, Easing, KeyframeInterpolationMode)` instead. Deprecated `MapCameraKeyframeTrack.normalizedPrincipalPoint(List<Anchor2DKeyframe>, EasingFunction, KeyframeInterpolationMode)`. Use `MapCameraKeyframeTrack.normalizedPrincipalPointWithEasing(List<Anchor2DKeyframe>, Easing, KeyframeInterpolationMode)` instead. Deprecated `MapCameraKeyframeTrack.position(List<GeoCoordinatesKeyframe>, EasingFunction, KeyframeInterpolationMode)`. Use `MapCameraKeyframeTrack.positionWithEasing(List<GeoCoordinatesKeyframe>, Easing, KeyframeInterpolationMode)` instead. Deprecated `MapCameraKeyframeTrack.orientation(List<GeoOrientationKeyframe>, EasingFunction, KeyframeInterpolationMode)`. Use `MapCameraKeyframeTrack.orientationWithEasing(List<GeoOrientationKeyframe>, Easing, KeyframeInterpolationMode)` instead. Deprecated `MapCameraKeyframeTrack.fieldOfView(List<ScalarKeyframe>, EasingFunction, KeyframeInterpolationMode)`. Use `MapCameraKeyframeTrack.fieldOfViewWithEasing(List<ScalarKeyframe>, Easing, KeyframeInterpolationMode)` instead. Deprecated `MapItemKeyFrameTrack.moveTo(List<GeoCoordinatesKeyframe>, EasingFunction, KeyframeInterpolationMode)`. Use `MapItemKeyFrameTrack.moveToWithEasing(List<GeoCoordinatesKeyframe>, Easing, KeyframeInterpolationMode)` instead. Deprecated `MapItemKeyFrameTrack.polylineProgress(List<ScalarKeyframe>, EasingFunction, KeyframeInterpolationMode)`. Use `MapItemKeyFrameTrack.polylineProgressWithEasing(List<ScalarKeyframe>, Easing, KeyframeInterpolationMode)` instead. <!-- IOTSDK-19638 -->
- Deprecated `RouteTextOptions.instructionFormat` as it is not supported. <!-- IOTSDK-4468 -->

#### Resolved Issues

- Routing: Fixed missing `Maneuver` items that occurred sometimes for specific locations with highway splits. <!-- IOTSDK-19906 -->
- `VisualNavigator`: Fixed crash for the `VisualNavigator` that occurred due to race conditions emerging from the Flutter threading model on Android devices. <!-- IOTSDK-20261 -->
- Navigation: Highway transition notifications without an exit name do not include highway exit phrases anymore. For Japanese, highway transition notifications do not include any exit phrases. <!-- IOTSDK-19057 -->
- Routing: Fixed too long shield text for road shields in Japan when English language is used. <!-- OLPSUP-27378 -->

#### Known Issues

- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.16.4.0

#### New Features

- Routing: Added `builtUpArea` and `controlledAccessHighway` to `StreetAttributes` enum. <!-- IOTSDK-20220 -->
- This version of the HERE SDK is delivered with map data v106 for `CatalogType.optimizedClientMap` catalog and v72 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-19804 -->
- Map style update: Added a new coach icon and improved the existing tram icon. <!-- CARTODSG-682 -->
- Navigation: Added a new warner to listen for `BorderCrossingWarning` events. It notifies when approaching country border crossings and states border crossings. <!-- IOTSDK-7056 -->
- `OfflineSearchEngine`: Added support for `Details.foodTypes` to show food types assigned to a place. <!-- IOTSDK-19553 -->
- Routing: Added `trafficOptimizationMode` to `RouteOptions` to completely disable traffic optimization. Furthermore, the newly introduced `TrafficOptimizationMode` will replace the deprecated `RouteOptions.enableTrafficOptimization` flag. <!-- IOTSDK-17972 -->
- Map style update: Improved toll tunnel styling in Japan for the day, night and logistics map schemes. <!-- CARTODSG-673 -->
- Navigation: Added signpost direction information to voice maneuver notifications. This information is now synchronized among maneuvers to enhance the voice guidance experience. <!-- IOTSDK-20189 -->
- Search: Added `POIPaymentDetails`, `POIPaymentMethod` and `Details.payment` to show the available payment options at a POI. This is a beta feature and thus subject to change. <!-- IOTSDK-19892 -->
- Map style update: Improved state and county capital label priority. <!-- CARTODSG-675 -->
- Navigation: Enhanced `TruckRestrictionWarning`: Added new field `TruckRestrictionWarning.axleCount` to warn about truck restrictions with a range of axles. <!-- IOTSDK-20182 -->

#### API Changes - Breaking

- Removed closed-alpha APIs `sdk.search.EVPaymentMethod` and `sdk.search.PlaceFilter.EV.paymentMethods`. <!-- IOTSDK-20465 -->

#### API Changes - Deprecations

- Deprecated `RouteOptions.enableTrafficOptimization`. Use `RouteOptions.trafficOptimizationMode` instead. <!-- IOTSDK-17972 -->
- Deprecated `controlledAccess` enum value in `StreetAttributes`. Use instead `controlledAccessHighway`. <!-- IOTSDK-20220 -->

#### Resolved Issues

- `ViolatedRestriction.maxWeightPerAxleGroupInKilograms` works only as expected for the online `RoutingEngine`. The `OfflineRoutingEngine` may not work as expected. <!-- IOTSDK-19780 -->

#### Known Issues

- The API Reference you can find on [here.com/docs](https://www.here.com/docs/category/here-sdk) is currently not formatted as expected. Please try to use instead the API Reference we ship as part of the downloadable _release package_ you can find [here](https://platform.here.com/portal/sdk). <!-- TECHDOCS-3586 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.16.3.0

#### New Features

- Positioning: Added info level logging to the `LocationEngine` and related services to help analysing potential positioning issues. To disable this logging, set the logging level to `warning` or higher. <!-- POSTI-3127 -->
- Routing: Added `minChargetAtFirstChargingStationInKilowattHours` to `BatterySpecifications`. It indicates the minimum charge in kWh when arriving at the first charging station. <!-- IOTSDK-19369 -->
- Navigation: Added `TruckWarningRestriction.hazardousMaterials` field to indicate hazardous materials for truck restrictions. <!-- IOTSDK-19775 -->
- Updated the latest supported Flutter version from 3.10.5 to 3.10.6. The latest supported Dart version has been updated from 3.0.5 to 3.0.6. Note that the minimum supported versions for Flutter and Dart did not change. <!-- IOTSDK-18951 -->
- Added `shadows` constant to `MapFeatures` as well as `shadowsAll` constant to `MapFeatureModes` to enable/disable shadows for 3D buildings. Added enum `ShadowQuality`. Added `HereMapController.shadowQuality` property to set and get shadow quality. Note that this is a beta release of this feature. <!-- IOTSDK-19109 -->
- Navigation: Added `WeightRestrictionType.payloadCapacity` to support payload weight capacity types for `TruckRestrictionWarning` notifications. <!-- IOTSDK-19775 -->
- Navigation: Added optional field `TruckRestrictionWarning.truckRoadType` to indicate the road type for a restriction. <!-- IOTSDK-19774 -->
- `OfflineRoutingEngine`: Added support of private bus routes. Added `RoutingInterface.calculateRoute(..)` and  `BusSpecifications` to support offline routing. <!-- IOTSDK-19828 -->
- Map style update: Added mountain peak elevation visualization. <!-- CARTODSG-20 -->
- Navigation: Added `TruckWarningRestriction.tunnelCategory` to indicate the tunnel category of a truck restriction. <!-- IOTSDK-19775 -->
- This version of the HERE SDK is delivered with map data v103 for `CatalogType.optimizedClientMap` catalog and v72 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-19434 -->
- Routing: Added `maxWeightPerAxleGroupInKilograms` to `ViolatedRestriction`. Indicates where the max permitted weight per axle group during the trip in kilograms is exceeded. <!-- IOTSDK-19780 -->
- Routing: Added support for private bus routing. Private buses are vehicles that are operated by a private transport company and that do not have access to bus-only lanes reserved for public transit. Use `BusSpecifications` to determine the properties of a private bus. Added `CalculationOptionsType.privateBus`. Added `CalculationOptions.privateBusOptions`. Added `PrivateBusOptions` struct. Added `RoutingInterface.calculateRoute(..)` method for private bus transport mode. Added `RoutingEngine.importRoute(..)` method for private bus routing. Added `RefreshRouteOptions` constructor for private bus routing. <!-- IOTSDK-19575 -->

#### Resolved Issues

- Navigation: Fixed missing `RouteDeviation` notification in Japan. <!-- IOTSDK-19825 -->
- Navigation: Fixed a position shown by `VisualNavigator` when the application goes back to the foreground and does not send GPS updates. <!-- IOTSDK-19796 -->
- Navigation: Fixed discrepancy between the location indicator and the route progress visualization when using the `VisualNavigator`. <!-- IOTSDK-16730 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `ViolatedRestriction.maxWeightPerAxleGroupInKilograms` works only as expected for the online `RoutingEngine`. The `OfflineRoutingEngine` may not work as expected. <!-- IOTSDK-19780 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->  

### Version 4.16.2.0

#### New Features

- Added new overloads to import bicycle, scooter and pedestrian routes to the `RoutingEngine`. There are two overloads - one without `RouteStop` and one with a `RouteStop` parameter. <!-- IOTSDK-19694 -->
- Added `ViolatedRestriction.Details.routingZoneReference` to provide more details of a restricted routing zone that has been violated. It will be set when `AvoidanceOptions.zoneCategories` is not empty. <!-- IOTSDK-19405 -->
- Added `Details.foodTypes` to show the available food types of a `Place` such as a restaurant while searching for a `Place`. <!-- IOTSDK-19551 -->
- Added `visualNavigator.maneuverArrowWidthFactor` property to get and set the width factor of maneuver arrow for scaling. <!-- IOTSDK-19000 -->
- Added a green and white road shield icon to indicate a Trans-Canada highway on the `MapView`. <!-- CARTODSG-118 -->
- Added two new language codes for `esAr` (Argentinian Spanish) and `nlBe` (Flemish) to `LanguageCode`. <!-- IOTSDK-6227 -->
- Added `ViolatedRestriction.Details.maxPayloadCapacityInKilograms` to provide details of the maximum permitted payload capacity that has been violated. <!-- IOTSDK-19601 -->
- Added `BusOptions.BusSpecifications` to specify the properties of a bus for route calculation, such as weight or vehicle dimensions. <!-- IOTSDK-19366 -->
- Added an option to improve voice guidance with directional information. Added `directionInformationUsageForActionNotificationOption` with `DirectionInformationUsageOption` to `ManeuverNotificationOptions`. This new option configures whether or not to include direction information (road name, road number, or signpost direction). By default, the option is disabled (default example: "Now turn left to join the motorway."). Example with road information: "Now turn left to join the I-83 South.". Example with road information and signpost direction: "Now turn left to join the I-83 South towards Baltimore.". <!-- IOTSDK-19741 -->

#### Resolved Issues

- Fixed crash that happens when a route calculated with the `TransitRoutingEngine` is set to a `Navigator` or `VisualNavigator` instance. Note that public transport routes are still not supported with turn-by-turn navigation. <!-- IOTSDK-19526 -->
- Fixed a crash when the `InterpolationListener` is set and the `VisualNavigator` instance is destroyed. <!-- IOTSDK-19661 -->
- Fixed missing maneuver generation when turning while navigation. <!-- IOTSDK-19256 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away. The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.16.1.0

#### New Features

- Added `SDKNativeEngine.passThroughFeature` property to allow traffic services to access online data although the `offlineMode` is globally activated via `SDKOptions` or the shared instance of `SDKNativeEngine`. <!-- IOTSDK-18442 -->
- `MapView`: The APIs for `MapPolylineRepresentation` and `MapPoyline.setRepresentation(MapPolyineRepresentation representation)` are now production-ready. Removed the beta status. <!-- IOTSDK-18505 -->
- Routing: Added property `id` to `TrafficIncidentOnRoute`. <!-- IOTSDK-19406 -->
- Added `MapPolylineSolidRepresentation` and `MapPolylineDashRepresentation` to encapsulate the visual properties of a `MapPolyline`. <!-- IOTSDK-18505 -->
- Navigation: The property `visualNavigator.extrapolationEnabled` now enables/disables extrapolation of locations also for the tracking mode of the `VisualNavigator`. Previously, only the route mode was supported. <!-- IOTSDK-18714 -->
- This version of the HERE SDK is delivered with map data v101 for `CatalogType.optimizedClientMap` catalog and v72 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-19434 -->
- Routing: Added `payloadCapacityInKilograms` to `TruckSpecifications` to specify the allowed payload capacity, including trailers. The provided value must be >= 0. By default, it is set to `null`, which means that the value will be ignored for route calculation with the `RoutingEngine` or the `OfflineRoutingEngine` (if available for your edition). <!-- IOTSDK-19368 -->
- `MapView`: The `MapMeasureDependentRenderSize` API is now production-ready: Removed the beta status. The API represents a render size - described as map-measure dependent values. <!-- IOTSDK-18505 -->
- `SearchEngine`: Added `PlaceFoodType`, `CategoryQuery.includeFoodTypes` and `CategoryQuery.excludeFoodTypes` to support food type filtering. <!-- IOTSDK-14081 -->
- Deprecated getters and setter for visual properties of a `MapPolyline` as well as the related constructors. Use `MapPolylineSolidRepresentation` and `MapPolylineDashRepresentation` with `MapPolyline.setRepresentation(MapPolylineRepresentation)` and the constructor `MapPolyline(GeoPolyline, MapPolylineRepresentation)` instead. List of all deprecated methods/properties: `MapPolyline​(GeoPolyline geometry, double widthInPixels, Color color)`, `MapPolyline.withOutlineWidthInPixelsAndOutlineColor​(GeoPolyline geometry, double widthInPixels, Color color, double outlineWidthInPixels, Color outlineColor)`, `lineWidth`, `lineColor`, `lineCap`, `measureDependentLineWidth`, `outlineWidth`, `outlineColor`, `measureDependentOutlineWidth`, `dashPattern`, `dashFillColor`. <!-- IOTSDK-18505 -->
- Map style update: Improved visualization of truck restrictions icons related to the amount of axles, weight per axle group, weight per axle number and axle group restriction. <!-- CARTODSG-490 -->

#### API Changes - Breaking

- Removed deprecated log levels: `LogLevel.logLevelTrace` and `LogLevel.logLevelDebug`. Removed `SDKNativeEngine.setLogAppender(LogAppender)` method, use the `LogControl` API instead. <!-- IOTSDK-16982 -->
- `RoadTexts`: Removed the previously deprecated `numbers`, `towards` members and constructors with arguments. Use the `numbersWithDirection` field instead. <!-- IOTSDK-18062 -->

#### API Changes - Deprecations

- Deprecated `prefetchAroundLocation(GeoCoordinates currentLocation)`, use `void prefetchAroundLocationWithRadius(GeoCoordinates currentLocation, double? radius)` instead. <!-- IOTSDK-13314 -->

#### Resolved Issues

- Navigation: The roundabout turn angle estimation was extended. Instead of considering only route links, now side links of intersections are also taken into account. <!-- IOTSDK-17845 -->
- Map style update: Reverted the font used for text rendering of Carto POIs from bold to regular. This issue was introduced accidentally with HERE SDK 4.14.5.0. <!-- IOTSDK-18808 -->
- The method `MapContentSettings.setTrafficRefreshPeriod(Duration value)` now correctly updates the refresh frequency for upcoming requests. <!-- IOTSDK-19480 -->
- Positioning: The `LocationStatusListener` now accurately reflects changes of the location services status of a device and provides timely updates to its registered listeners. <!-- IOTSDK-19065 -->
- Navigation: Road number information in Japan for maneuver texts and maneuver notifications is now provided as a combination of road name and road number (for example, "西湘バイパス ( 国道1号 )") - if both fields are in the same language. <!-- IOTSDK-19058 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- Navigation: The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.16.0.0

#### New Features

- Added `MapContentSettings.setTrafficRefreshPeriod(Duration value)` method to adjust the traffic refresh period for the traffic flow and incidents `MapFeatures` and `MapContentSettings.resetTrafficRefreshPeriod()` to reset the applied traffic refresh period. <!-- IOTSDK-18111 -->
- Added `MapMeasureDependentRenderSize` to represent a render size, described as map-measure dependent values. Note that this is a beta release of this feature. <!-- IOTSDK-18504 -->
- Map data: Added `SegmentDataLoader` and related APIs to load attributes of a map segment. With `getSegmentsAroundCoordinates​(GeoCoordinates coordinates, double radiusInMeters)` you can access OCM map data to load a list of `OCMSegmentId` IDs. With these IDs you can synchronously load a `SegmentData` object containing information on `SegmentSpanData` that contains, for example, the `PhysicalAttributes` of a road, `SegmentSpeedLimit` information and more data from the OCM map. The API works offline on cached or persisted map data. <!-- IOTSDK-18787 -->
- Navigation: Added `NavigatorInterface.setCustomOption(key, value)` to specify undocumented key/value pairs for experimental features. Unsupported options are silently ignored. <!-- OLPSUP-24503 -->
- This version of the HERE SDK is delivered with map data v99 for `CatalogType.optimizedClientMap` catalog and v72 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-19244 -->
- Map style update: Improved showing traffic icons for road closures, when a road is closed - independent of the actual incident type. <!-- CARTODSG-532 -->
- Custom maps: Added enum `EngineBaseURL.trafficData` to provide a custom traffic backend URL. <!-- IOTSDK-19023 -->
- Added `GeoBox.envelope(GeoBox)` and `static GeoBox.envelopeGeoBoxes(List<GeoBox>)` encompass two or more geo boxes into one box. <!-- IOTSDK-19385 -->
- Added `CertificateSettings` class to specify parameters to set-up a Mutual Transport Layer Security (mTLS) connection on Android devices. Note that this change was already introduced with HERE SDK 4.15.4.0. <!-- IOTSDK-18549 -->
- Navigation: Added `CurrentSituationLaneAssistanceViewListener` to receive lane-based information on the access, type and direction of the lanes of the current road a user is driving on. Note that this is supported for tracking mode without following a route and for turn-by-turn navigation. <!-- IOTSDK-19059 -->
- Offline maps: Added support for incremental map updates. Instead of downloading an entire region, only the parts that have changed will be installed. This results in a faster update process and less downloaded data. Note that this improvement is in effect since HERE SDK 4.15.3.0. <!-- IOTSDK-19380 -->

#### API Changes - Breaking

- Removed deprecated function `CatalogVersionHint.latest()`. Use instead `CatalogVersionHint.latest(bool)`. <!-- IOTSDK-17205 -->
- Renamed the beta API `MapFeatureModes.hillshading` to `MapFeatureModes.terrainHillshading`. <!-- IOTSDK-17010 -->
- Removed deprecated log levels: `LogLevel.logLevelTrace` and `LogLevel.logLevelDebug`. Removed `SDKNativeEngine.setLogAppender(LogAppender)` method, use the `LogControl` API instead. <!-- IOTSDK-16982 -->
- Changed beta API `MapPolyline.DashImageRepresentation` to be immutable. Use `MapMeasureDependentRenderSize` type as size input parameter instead of a map of `(double, double)`. <!-- IOTSDK-18504 -->
- Removed deprecated method `MapViewBase.setWatermarkPlacement(WatermarkPlacement placement, int bottomMargin)`. <!-- IOTSDK-18987 -->

#### API Changes - Deprecations

- Removed deprecated Maneuver.ferry. This maneuver is not supported. <!-- IOTSDK-16021 -->
- Removed the deprecated option `routeOptions.enableEnterHighwayManeuverAction()`. The feature is now enabled, by default. <!-- IOTSDK-18061 -->

#### Resolved Issues

- Navigation: Improved loading of map tiles when an occasional connection loss occurs. <!-- IOTSDK-15647 -->
- Navigation: For `TruckRestrictionWarning` events that are time-dependent the `TimeRule` information is sometimes not correct. <!-- IOTSDK-19312 -->
- `MapView`: When panning to a new area and no data is in the cache or in the persisted storage, then the download of new map tiles may take a bit longer for map versions newer than 97. <!-- IOTSDK-19263 -->
- Navigation: Fixed an issue with lane assistance when a lane divider between lanes allows to change the lanes too early. <!-- IOTSDK-19221 -->
- Fixed speed limits for trucks on highway sections near an urban area. <!-- IOTSDK-19062 -->
- `MapLoader`: Switching political views is now possible without loosing already downloaded `Region` data. <!-- IOTSDK-19018 -->

#### Known Issues

- The new method `MapContentSettings.setTrafficRefreshPeriod(Duration value)` might have no effect, as the specified period could potentially be overridden internally over time. <!-- IOTSDK-19480 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- Navigation: The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in a `SectionNotice` warning when no road sign is indicating such a restriction. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.15.5.0

#### New Features

- Navigation: Added `visualNavigator.defaultRouteManeuverArrowMeasureDependentWidths()` to retrieve a dictionary that exposes the default values that are used for the widths of a route polyline and maneuver arrows. The dictionary pairs the widths with the corresponding zoom level. Note that this change is part of this release, although it was already announced for 4.15.4.0. <!-- IOTSDK-18844 -->
- Search: Added `EVChargingPool.cpoId` and `EVChargingPool.evseInfo` as _closed-alpha_. The fields contain info on the _CPO_ ID (Charge Point Operator ID) and the _Electric Vehicle Supply Equipment_ ID (EVSE ID). This is useful for drivers of electric vehicles to determine the charging infrastructure at a charging point. Note: The new fields are only set for participants of the closed-alpha group who got access from HERE to use this feature. <!-- IOTSDK-18993 -->
- This version of the HERE SDK is delivered with map data v97 for `CatalogType.optimizedClientMap` catalog and v72 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-18815 -->
- Added `MapCameraUpdate.lookToMatchGeoPointToViewPointWithOrientationMapMeasure(..)` and  `MapCameraUpdate.lookToMatchGeoPointToViewPoint(..)` that match the given `GeoCoordinates` to a given `viewPoint` in order to position the map camera. This does not change the principal point. Note that this is a beta release of this feature. <!-- IOTSDK-18772 -->
- Map style update: Improved the density of city labels. For this, the visibility range of certain city labels has been adjusted. <!-- CARTODSG-629 -->
- `MapView`: Added `MapCameraUpdateFactory.compositeUpdate(List<MapCameraUpdate>)` to support the creation of a composite `MapCameraUpdate` instance that allows to execute all given updates sequentially in the order they were provided in the list. <!-- IOTSDK-17968 -->
- Search: Added `PlaceFilter.ev.paymentMethods` and `EVPaymentMethod` as `closed-alpha`. This allows to filter search results based on the available payment methods at a charging station for electric vehicles. Currently, it is not possible to verify the payment methods for the resulting `Place`. Note: The new filter is only available for participants of the closed-alpha group who got access from HERE to use this feature. If your credentials are not enabled, a [SearchError.forbidden] will be propagated. <!-- IOTSDK-19042 -->
- Navigation: Added `visualNavigator.setExtrapolationEnabled()` to enable/disable extrapolation of the current location during turn-by-turn navigation. By default, it is disabled. Enable it to fix issues with a lagging `LocationIndicator`. <!-- IOTSDK-18040 -->
- Truck routing: Added `TruckRoadTypes` enum that specifies the Swedish types `BK1`, `BK2`, `BK3`, `BK4` and the Mexican types `A2`, `A4`, `B2`, `B4`, `C`, `D`, `ET2`, `ET4`. This is useful for truck-specific road networks that define complex restrictions. The listed types correlate to detailed LAT vehicle specifications which are usually known to truck drivers. For example, truck drivers in Sweden have to know the BK class of their truck to know on which roads they are allowed to drive. Set a `avoidedTruckRoadTypes` list via `TruckOptions` or `EVTruckOptions`. If these options are violated, find a warning in the `SectionNotice` of a `Route`: Added `violatedAvoidTruckRoadType` to `SectionNoticeCode` and `forbiddenTruckRoadTypes` to `ViolatedRestriction.Details`. <!-- IOTSDK-19027 -->
- Map style update: Added bathymetry ocean visualization for the `normalDay` and `normalNight` map schemes. <!-- CARTODSG-542 -->

#### Resolved Issues

- `OfflineSearchEngine`: Setting a filter for search results with `TextQuery.placeFilter.fuelTypes` and `TextQuery.placeFilter.truckFuelTypes` is now supported also for the `OfflineSearchEngine`. <!-- IOTSDK-18334 -->
- Navigation: Fixed an issue with natural guidance for TTS. Now it is ensured that the "count information" is based on the current car location. <!-- IOTSDK-19078 -->
- Routing: Fixed cases where a wrong `ManeuverAction` is generated for forks on highways. <!-- OLPSUP-24250 -->
- Navigation: When the option `filterOutInactiveTimeDependentWarnings` is enabled, inactive time-dependent `SchoolZoneWarning` events are now correctly filtered for all time zones. Now, the local time of a segment is used when applying the provided `TimeRule` object: When the HERE SDK constructs a new `TimeRule`, the time zone offset in seconds and the _Daylight Savings Time_ (DST) specification as a string in ISO 14825 format is required to be set. For this, the newly added parameters `timeZoneOffsetInSeconds` and `dstSpec` are used by the HERE SDK. <!-- IOTSDK-19128 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- `MapView`: When panning to a new area and no data is in the cache or in the persisted storage, then the download of new map tiles may take a bit longer for map versions newer than 97. <!-- IOTSDK-19263 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- Navigation: The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Navigation: For `TruckRestrictionWarning` events that are time-dependent the `TimeRule` information is sometimes not correct. <!-- IOTSDK-19312 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.15.4.0

#### New Features

- `SearchEngine`: Added `PlaceFilter.ev.supplierNames` and `PlaceFilter.ev.connectorTypeIDs` as closed-alpha: Participants of the closed-alpha group can get access from HERE to use this feature. If your credentials are not enabled, a [SearchError.FORBIDDEN] will be propagated. <!-- IOTSDK-18519 -->
- Map style update: Country borders are now visually improved - increasing the line width with a more saturated color. State borders will now change from a solid to a dashed line based on the current zoom level. <!-- CARTODSG-520 -->
- Navigation: Added `visualNavigator.defaultRouteManeuverArrowMeasureDependentWidths()` to retrieve a dictionary that exposes the default values that are used for the widths of a route polyline and maneuver arrows. The dictionary pairs the widths with the corresponding zoom level. <!-- IOTSDK-18844 -->
- Custom map styles: Added `mapScene.reloadScene()` to ensure that an entire scene is reloaded again without using any cached data. This can be useful, when local changes are done on a JSON style file and the same file should be loaded again. This method skips internal optimization checks and enforces a reload of the scene. <!-- IOTSDK-19108 -->
- Added `DirectedOCMSegmentId` class which contains information of a OCM map segment. Note that this class is at the moment only used internally. However, it will be possible to make use of this class in a future release of the HERE SDK to access arbitrary map data. <!-- IOTSDK-13204 -->
- A `Route` object contains now a list of `RouteRailwayCrossing` elements which indicate the `GeoCoordinates`, a `RouteOffset` and the `RouteRailwayCrossingType` of a railway for a train or a tram line that is crossing the route. Note that this change was already introduced with HERE SDK 4.15.3.0 and it is only available when using the `RoutingEngine`. <!-- IOTSDK-18632 -->
- Map style update: Added Carto POIs for the place category "Business Facility". <!-- CARTODSG-604 -->
- Pick Carto POIs: You can now use the `SearchEngine` or the `OfflineSearchEngine` (not available for all editions) to retrieve a `Place` object containing more details: use the `PickMapContentResult` as data to create a `PickedPlace` object that can be used to search for the `Place`. Added `PickedPlace` that is accepted by the new methods `SearchEngine.searchPickedPlace(..)` and `OfflineSearchEngine.searchPickedPlace(..)` (not available for all editions). <!-- IOTSDK-18731 -->
- `RoutingEngine`: Added an overload of the `importRoute(..)` method to specify a list of `RouteStop` elements. When importing a route just from a list of coordinates, the information on stopover waypoints is usually lost. Use the `RouteStop` class to specify such stops. It allows to specify a `locationIndex` and a `stopDuration`. This will influence the overall ETA - and during navigation the `RouteStop` will be treated as a stopover waypoint so that it will be reported as a `Milestone` when passing-by (note that navigation is only supported for the `Navigate Edition`). <!-- IOTSDK-18910 -->
- Map style update: The `MapScheme.LITE_NIGHT` was improved with dark street colors. Other map elements were styled accordingly to fit the new design. <!-- CARTODSG-618 -->
- This version of the HERE SDK is delivered with map data v95 for `CatalogType.optimizedClientMap` catalog and v71 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-18626 -->
- `NetworkSettings`: Added client `CertificateSettings` to specify parameters to set-up connections that allow to authenticate during the initial connection of an SSL/TLS handshake via Mutual Transport Layer Security (mTLS). This feature is only supported for Android devices. Note that this is a beta release of this feature. <!-- IOTSDK-18549 -->

#### API Changes - Breaking

- `RoutingEngine`: Removed unsupported transport modes for `importRoute(..)` overloads for _bicycles_, _pedestrians_ and _scooters_ when importing routes from a list of `Location` objects. In addition, removed support for `importRoute(..)` overloads that use `RefreshRouteOptions` constructed from `BicycleOptions`, `PedestrianOptions`, or `ScooterOptions`. <!-- IOTSDK-18911 -->

#### Resolved Issues

- Navigation: The size of an `Engine` is now validated. Allowed values are in the range [1, 65535] or `null`. <!-- IOTSDK-18824 -->
- Navigation: Maneuver notifications in Hindi that contain the text "join the highway" for a second maneuver have been fixed by using the complete 'से मिले' verb. <!-- IOTSDK-18054 -->
- Navigation: The "slight turn" maneuver notification voice phrases in Japanese have been revised. <!-- IOTSDK-18463 -->
- `OfflineRoutingEngine`: Fixed incorrect information in `LocalizedRoadNumber` of a `Span`. <!-- IOTSDK-17822 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- Navigation: When the option `filterOutInactiveTimeDependentWarnings` is enabled, then inactive time-dependent `SchoolZoneWarning` events are not always filtered as expected for some time zones. <!-- IOTSDK-19128 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- Navigation: The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.15.3.0

#### New Features

- Navigation: Added a warner for school zones. Subscribing to it is done using `SchoolZoneWarningListener`. Options are controlled via `setSchoolZoneWarningOptions`. Take a look at the _Navigation_ section in the Developer Guide or the Navigation example app for more details. <!-- IOTSDK-18244 -->
- Added `sdk.core.NetworkEndpoint` class to specify a DNS server and extended `sdk.core.engine.NetworkSettings` with a new `domainNameSystemServers` field to allow setting a list of `NetworkEndpoint` servers to use for HTTP requests. The settings can be set when initializating the HERE SDK to specify alternative endpoints. Check the API Reference for more details. Note that this is an advanced feature that can be ignored by most users. <!-- IOTSDK-18883 -->
- Added debug symbols for Android, which can be found in the release package of the HERE SDK: The ZIP archive is located in Flutter plugin in the folder `here_sdk/android/libs` next to the AAR. A customer may use this with Google Play (or any other crash analytics service) to retrieve symbolicated crash logs. Take a look at the _Key Concepts_ section in the Developer Guide for more details. <!-- IOTSDK-14310 -->
- `MapLoader`: Added `PolygonPrefetcher` API to prefetch map data area using `prefetch(GeoPolygon, PrefetchStatusListener)` method and estimate its size using `estimateMapDataSize(GeoPolygon, MapDataSizeListener)` method. Added `MapDataSize` class to store map data size values. <!-- IOTSDK-18412 -->
- Navigation: Added convenience function to calculate the distance between the current location of the user on the route and a ahead location on the route - for example, to display the distance to certain spots of interest ahead: The newly added method `navigator.calculateRemainingDistanceInMeters​(GeoCoordinates coordinates)` provides the distance to the given coordinates if they are on the route ahead. If the coordinates are already behind or not on the route at all, `null` is returned. <!-- IOTSDK-18296 -->

#### API Changes - Breaking

- Indoor maps: Deleted `VenueMap.venues`. User won't be able to get list of already loaded maps. Deleted `VenueDrawing.id`. Use instead `VenueDrawing.identifier`. Deleted `VenueDrawing.getGeometryById(int geometryId)`. Use instead `VenueDrawing.getGeometryByIdentifier(String geometryId)`. Deleted `VenueGeometry.id`. Use instead `VenueGeometry.identifier`. Deleted `VenueLevel.id`. Use instead `VenueLevel.identifier`. Deleted `VenueLevel.getGeometryById(int geometryId)`. Use instead `VenueLevel.getGeometryByIdentifier(String geometryId)`. Deleted `VenueService.startLoading(List<int> venueIds)`. User would now be able to load only one map at a time. Deleted `VenueService.start(String token)`. Use instead `VenueEngine.start(AuthenticationCallback? callback)` or `VenueEngine.startWithToken(String token)`. Deleted `VenueService.startAsync(String token)`. Use instead `VenueEngine.start(AuthenticationCallback? callback)` or `VenueEngine.startWithToken(String token)`. <!-- INDOOR-18744 -->
- Removed the previously deprecated `performMapUpdate(..)` and `checkMapUpdate(..)` API of `MapUpdater` class. Use instead `updateCatalog(..)` and `retrieveCatalogIndo(..)` of `MapUpdater`. Removed the previously deprecated `CheckMapUpdateCallback`. Removed the previously deprecated enum `MapUpdateAvailability`. <!-- IOTSDK-18490 -->

#### API Changes - Deprecations

- Map view: Using a `LocationIndicator` as a `MapViewLifecycleListener` has been deprecated. Instead, `locationIndicator.enable(..)` and `locationIndicator.disable()` can be used to add/remove a `LocationIndicator` to/from a `MapViewBase` such as a `HereMapController`. <!-- IOTSDK-17259 -->
- Routing: Deprecated 'Span.polyline'. Use 'Span.geometry' instead. <!-- IOTSDK-16557 -->

#### Resolved Issues

- Navigation: The `repeatLastManeuverNotification()` method may not always work as expected. For example, after a route deviation has been detected, calling this method will not result in a retriggered notification. <!-- IOTSDK-18392 -->
- `OfflineRoutingEngine`: Provided now correct location for map-matched coordinates of depature and arrival `RoutePlace` of `Section` for a `Route`. <!-- IOTSDK-18805 -->
- During tunnel extrapolation `navigableLocationListener.onNavigableLocationUpdated(..)` was called with `navigableLocation.originalLocation` with coordinates (0, 0). This was fixed and now `navigableLocation.originalLocation` contains latest location passed to `navigator.onLocationUpdated(..)`. <!-- IOTSDK-18630 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- Navigation: The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.15.2.0

#### New Features

- Custom raster layers: Added a `TileUrlProviderCallback` that can be set to get notified when a new tile is requested from the specified tile data source. Added the convenience function  `TileUrlProviderFactory.fromXyzUrlTemplate()` that can be set as `urlProvider` if the new callback feature is not needed. Take a look at the Developer Guide for a usage example. Note that this is a beta release of this feature. <!-- IOTSDK-17398 -->
- This version of the HERE SDK is delivered with map data v92 for `CatalogType.optimizedClientMap` catalog and v68 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-18516 -->
- `RoutingEngine`: Improved the routing algorithm for trucks. Now, roads with a `FunctionalRoadClass` of 3 or 4 are penalized more than before. As a result, smaller roads are a bit more often avoided. Overall, this will result in routes that are better suited for trucks. <!-- PBJIRA-3430 -->
- Scooter routing: Added new field `ScooterOptions.engineSizeInCubicCentimeters` used as a routing option when calculating a scooter route. The `RouteOptions.occupantsNumber` can now be used also as routing options for calculating scooter routes. <!-- IOTSDK-18060 -->
- Navigation: Added support for customizable route and maneuver arrow width - for example, to adapt the width based on zoom level to show traffic flow lines and the route together. Added `visualNavigator.measureDependentWidth` property to set and get the measure for different zoom levels. <!-- IOTSDK-18568 -->
- Map style update: Added public transit Carto POIs specific for each country. <!-- CARTODSG-273 -->
- Navigation: It is now possible to get notified when a pass-through waypoint has been reached. Added new field `Milestone.type` that can be of type `MilestoneType.stopover` or `MilestoneType.passthrough`. Added possibility to enable/disable pass-through waypoint processing via `navigator.setPasstroughWaypointEnabled()`. By default, it is disabled. Use the `MilestoneStatusListener` to get notfied. The notification logic behaves like for stopovers. However, for a pass-through waypoint there is no guarantee that it will lie on the route. In that case, no notification will occur. <!-- IOTSDK-11447 -->
- Search: Added `CategoryQuery.placeFilter`, `TextQuery.placeFilter` and `PlaceFilter` that is used to specify place filtering options. <!-- IOTSDK-18489 -->

#### API Changes - Breaking

- Search: Removed `CategoryQuery.fuelTypes`, `CategoryQuery.truckFuelTypes`, `CategoryQuery.truckClass`. Use instead `CategoryQuery.placeFilter`. <!-- IOTSDK-18489 -->
- Search: Removed `TextQuery.fuelTypes`, `TextQuery.truckFuelTypes`, `TextQuery.truckClass`. Use instead `TextQuery.placeFilter`. <!-- IOTSDK-18486 -->
- Custom raster layers: Deprecated the `Provider` constructors for `RasterDataSourceProviderConfiguration` in favor of newly added constructors that consume the new 	`urlProvider` parameter to set the newly added `TileUrlProviderCallback`. Deprecated also the field that holds the `templateUrl` member. Use the newly introduced `urlProvider` instead. <!-- IOTSDK-17398 -->
- The behavior of `HereMapOptions.initialBackgroundColor` has changed: The color is applied as `HereMap` background color only between rendering the first frame without a scene config and _before_ rendering the first frame after loading a scene config. To have this color displayed as backgound of an initializing `HereMap`, platform specific means must be used like enveloping the `HereMap` in a container with a background color. Note that this change has been already introduced with HERE SDK 4.14.5.0. <!-- IOTSDK-18457 -->

#### API Changes - Deprecations

- Deprecated `Milestone` constructor. Please use the newly added constructor with 'MilestoneType' parameter instead. <!-- IOTSDK-11447 -->

#### Resolved Issues

- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- Fixed an issue with initialization of the HERE SDK that was introduced with HERE SDK 4.15.1.0 that could lead to a crash on Android devices when the APK was built with Flutter 3.10.x. <!-- IOTSDK-18753 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- Network statistics available via `UsageStats` currently do not include network calls when HERE positioning is used. Also, when HD-GNSS is enabled, these extra network calls are not included for now. Note that this has no impact on the features itself and they are still fully functional. <!-- IOTSDK-18691 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Navigation: The `repeatLastManeuverNotification()` method may not always work as expected. For example, after a route deviation has been detected, calling this method will not resul in a retriggered notification. <!-- IOTSDK-18392 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- Navigation: The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.15.1.0

#### New Features

- Added `routingEngine.returnToRoute(...)` overload which accepts now the parameters as provided by the `RouteDeviation` event. Added `RouteDeviation.lastTraveledSectionIndex` and `RouteDeviation.traveledDistanceOnLastSectionInMeters` members, which contain information about the last known section index and the progress on that section. Extended `RouteDeviation` constructor to accept both values. <!-- IOTSDK-18245 -->
- `RoutePrefetcher`: Added `MaploaderError.notEnoughSpace` to indicate when there is not enough space available in the mutable cache. <!-- IOTSDK-17602 -->
- Improved readability of logs: Now, all HERE SDK log messages are prefixed with "hsdk-" to make it easier to identify which messages are coming from the HERE SDK. <!-- IOTSDK-17323 -->
- Navigation: It is now possible to disable _tunnel extrapolation_ to control whether location updates are simulated due to a weak GPS signal. By default, tunnel extrapolation is enabled. Added property `enableTunnelExtrapolation` to `Navigator` and `VisualNavigator`. <!-- IOTSDK-17802 -->
- Map style update: Improved polygone outline styling for environmental and congestion zones. <!-- CARTODSG-548 -->
- Navigation: The visibility of maneuver arrows can now be set via the property `visualNavigator.maneuverArrowsVisible​`. <!-- IOTSDK-18018 -->
- Offline maps: Added `MapLoaderError.brokenUpdate` to indicate an unrecoverable error that may happen internally during the construction of the required pending update parameters. Operations such as catalog updates or region downloads will always fail after this error occurred. The healing procedure is to clean the persisted maps via `MapDownloader.clearPersistentMapStorage(SDKCacheCallback)`. <!-- IOTSDK-17765 -->
- This version of the HERE SDK is delivered with map data v90 for `CatalogType.optimizedClientMap` catalog and v67 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-17764 -->
- Map style update: Restricted access roads are now styled according to the properties of a road segment. The HERE Style Editor exposes the following values: `Private`, `Service Road`, or `Public Access = no`. <!-- CARTODSG-474 -->

#### API Changes - Breaking

- The shared instance of the `SDKNativeEngine` isn't created automatically on startup and instead it must be created explicitly as shown in the accompanying example apps. <!-- IOTSDK-13832 -->
- Feature configurations and other properties can be no longer set via `AndroidManifest.xml` file on Android or via `plist` file on iOS. The `OptionReader` class has been removed. <!-- IOTSDK-13832 -->
- By default, `SDKOptions.cachePath` and `SDKOptions.persistentMapStoragePath` are now empty - even after the HERE SDK was initialized. Setting a new string, will overwrite the internally used default paths. On Android the internally used path is: `Context.getCacheDir().getPath()`. On iOS the internally used path is: `{Application_Home}/Library/Caches`. Note that relative and absolute paths can be set. A relative path will use the internally used default path as parent. <!-- IOTSDK-13832 -->

#### API Changes - Deprecations

- Deprecated the `routingEngine.returnToRoute(...)` method overload which required to calculate the traveled fraction to be set as parameter. Use instead the newly added `routingEngine.returnToRoute(...)` overload which directly consumes the newly added `RouteDeviation` parameters to provide the same information. <!-- IOTSDK-18245 -->

#### Resolved Issues

- Navigation: Setting `ManeuverNotificationTimingOptions` works as expected for trucks on highways: In fact, notification thresholds are always speed limit dependent - even when custom values are set. For example, if the current speed limit is less than 100 km/h on highways, then the notification thresholds for rural roads will be used instead. Note that this applies to all transport modes. For the more details please refer to the updated API Reference. <!-- IOTSDK-17780 -->
- Fixed incomplete Hindi maneuver notifications related to `ENTER_HIGHWAY_FROM_LEFT` and `ENTER_HIGHWAY_FROM_RIGHT` maneuver actions. The second maneuver phrase was updated to say the complete phrase of 'मोटर-वे से मि'. <!-- IOTSDK-18054 -->
- The `OfflineSearchEngine` now supports filtering search results by `CategoryQuery.truckFuelTypes` via `PlaceFilter` to be on par with the `SearchEngine`. <!-- IOTSDK-18229 -->
- Fixed Malayalam maneuver notifications: Corrected the word order of the distance phrase. The post-position of 'ന് ശേഷം' can now be found right after the distance value and unit. <!-- IOTSDK-16140 -->
- The `OfflineSearchEngine` now supports filtering search results by `CategoryQuery.fuelTypes` via `PlaceFilter` to be on par with the `SearchEngine`. <!-- IOTSDK-18169 -->
- Fixed Italian maneuver notifications: The distance phrase of '1 chilometro' generated by the voice package is now presented as 'un chilometro' to improve its interpretation by text-to-speech engines. <!-- IOTSDK-18339 -->
- `SpeedBasedCameraBehavior`: When setting an invalid profile containing `SpeedBasedCameraBehavior.ProfileValue` elements no longer a crash will occur. Now, invalid profile values will be silently ignored. Make sure to set `fromMetersPerSecond` and `toMetersPerSecond` with ascending intervals. For example, when setting [a, b] and [c, d], then make sure that c > a and c <= b and d > b. <!-- IOTSDK-18433 -->
- Fixed incorrect map-matched locations that may be calculated during tunnel extrapolation. <!-- IOTSDK-17979 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map view is moved by performing a touch gesture. This results in an application freeze. More details can be found [here](https://github.com/flutter/flutter/issues/58987). <!-- IOTSDK-6759 -->
- Navigation: The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.15.0.0

#### New Features

- `MapView`: It is now possible to show traffic flow and a route side-by-side at any zoom level. The line width for `MapArrow` and `MapPolyline` can now be specified per zoom level. Added `MapPolyline.measureDependentLineWidth`, `MapPolyline.measureDependentOutlineWidth` and `MapArrow.measureDependentTailWidth` properties to set and get the line and outline width of a `MapPolyline` and the tail width of a `MapArrow` depending on camera zoom level. Note that this is a beta release of this feature. <!-- IOTSDK-13048 -->
- Added `roadExitLabels` constant to `MapFeatures` as well as `roadExitLabelsNumbersOnly` and `roadExitLabelsAll` constants to `MapFeatureModes` to enable/disable rendering of road exit labels on the map. <!-- IOTSDK-17484 -->
- Added `isOffRoad` method to the `RoutePlace` that indicates if a route place is off-road or not. <!-- IOTSDK-17445 -->
- This version of the HERE SDK is delivered with map data v88 for `CatalogType.optimizedClientMap` catalog and v67 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-17763 -->
- Added `MapScheme.logisticsDay`, a day version map scheme with focus on fleet management content. <!-- IOTSDK-16237 -->
- Added support for dashed polylines: Added class `MapPolylineRepresentation` that is a base class for classes defining visual appearance of MapPolyline. Added class `MapPolylineDashImageRepresentation` used to render `MapPolyline` as a series of images placed along a polyline. Added factory method `factory MapPolyline.withRepresentation(GeoPolyline geometry, MapPolylineRepresentation representation)` that allows to create a polyline that is using a `MapPolylineRepresentation` for defining the visual appearance of a line. Added `MapPolyline.setRepresentation(MapPolylineRepresentation representation)` to change the visual appearance of a polyline. <!-- IOTSDK-17427 -->
- Added `UsageStats` class that gathers statistics of the HERE SDK network usage to count all uploaded and downloaded data. Use `SDKNativeEngine.getSdkUsageStats()` and `SDKNativeEngine.enableUsageStats()` to retrieve the network statistics. Added `SDKNativeEngine.clearPersistentUsageStats()` and `SDKNativeEngine.clearUsageStatsCache()` to clear statistics. Note that this is a beta release of this feature. <!-- IOTSDK-16164, IOTSDK-16327 -->
- `OfflineSearchEngine`: Improved support for our index mechanism to find places in installed `Region` data - even if they are far away from the provided search center. Now it is possible to track the progress of the asynchronous operation. When indexing is disabled, the behavior or the mentioned APIs below remains as before. When indexing is enabled, it will affect all operations that modify persistent storage content. Added `setIndexOptions` API in `OfflineSearchEngine` to control and track indexing over persistent map. Added `OfflineSearchIndex.Options` to provide indexing option to `setIndexOptions` API, which can enable or disable indexing using `OfflineSearchIndex.Options.enabled` flag. Added `OfflineSearchIndexListener` interface, which is to be provided in `setIndexOptions` API to track index building process. Added `OfflineSearchIndex.Operation` enum to indicate index creation or removal mode through `OfflineSearchIndexListener.onStarted` API. Added `OfflineSearchIndex.Error` enum to indicate any error during `setIndexOptions` or at the time of index completion through `OfflineSearchIndexListener.onComplete` API. When indexing is enabled, `MapDownloader.downloadRegions`, `MapDownloader.deleteRegions`, `MapDownloader.clearPersistentMapStorage`, `MapDownloader.repairPersistentMap`, `MapUpdater.performMapUpdate`, `MapUpdater.performFeatureUpdate`, `MapUpdater.updateCatalog` will ensure that the index is created, deleted or updated to contain entries from regions
that are installed in persistent storage. Note that this is a beta release of this feature. <!-- IOTSDK-17978 -->
- Pass-through waypoints can now be retrieved from a `Route`: Added class `PassThroughWaypoint` `and Section.passthroughWaypoints` property. <!-- IOTSDK-17886 -->
- Added new feature configurations to `LayerConfiguration` to support the download of the new `adas` and `eHorizon` (Electronic Horizon) map layers. Both layers are currently not relevant for users of the `Navigate Edition` and can be ignored for now. <!-- COLUMBUS-1082 -->
- Off-road guidance: Added a dashed line between the map-matched and the original destination to the `VisualNavigator` to help guide users to off-road destinations. The line visibility can be switch on/off via `setOffRoadDestinationVisible` method in the `VisualNavigator` class. <!-- IOTSDK-17441 -->
- Improved visual map styles: City center labels for small villages (hamlets) are now already visible starting from zoom level 13 - instead of 14. <!-- CARTODSG-551 -->
- Navigation: Added a warner for environmental zones. Subscribing to it is done using `EnvironmentalZoneWarningListener`. Take a look at the Developer Guide for a usage example. <!-- IOTSDK-12404 -->
- Added support for off-road guidance after reaching the last map-matched destination: Added `OffRoadDestinationReachedListener` class and `offRoadDestinationReachedListener` property to the `NavigatorInterface` to inform the user when an off-road destination has been reached. Added `OffRoadProgress` struct, `OffRoadProgressListener` class, and `setOffRoadProgressListener`/`getOffRoadProgressListener` methods to the `NavigatorInterface`. This can be used to inform the user about off-road progress with the remaining distance to the original destination and the bearing of the destination compared to the user's current position. Take a look at the Developer Guide for a usage example. <!-- IOTSDK-17445 -->
- Routing: Added `offsetStart` and `offsetEnd` properties to `SegmentReference` class. <!-- IOTSDK-18045 -->
- `MapDownloader`: Extended `CatalogUpdateInfo` by adding fields for  `networkSizeInBytes`, which shows how much data will be downloaded to update a map and `diskSizeInBytes`, which shows how much free space is needed on the disk to perform a map update. Note that `diskSizeInBytes` depends on the selected `MapUpdateVersionCommitPolicy`, due to map data being removed from a device according to the said policy. <!-- IOTSDK-17190 -->

#### API Changes - Breaking

- Removed `SDKOptions.enableIndexing` flag. Use instead `OfflineSearchEngine.setIndexOptions()`. Note that the `OfflineSearchEngine` is not available for all editions. <!-- IOTSDK-17978 -->
- `MapCamera`: The altitude value (if set) of the _lookAt_ target `GeoCoordinates` is ignored. Any subsequent camera updates and animations will consider the target coordinates as being located on the ground. Impacted methods (including overloads): `MapCameraAnimationFactory.flyTo()`, `MapCamera.lookAt()` and `MapCameraUpdateFactory.lookAt()`. <!-- IOTSDK-14988 -->
- Removed Dart constructor for `TransitSectionDetails`. Please use other available contructors instead. <!-- IOTSDK-18048 -->
- Removed deprecated constructors for `CellularPositioningOptions`, `SatellitePositioningOptions`, `WifiPositioningOptions`, `NotificationOptions`, `SensorOptions`. Please use other available contructors. <!-- IOTSDK-15537 -->
- Removed deprecated constructor for `AuthenticationData`. Please use other available contructors. <!-- IOTSDK-15537 -->
- Removed deprecated constructor for `Region`. Please use other available contructors. <!-- IOTSDK-15537 -->
- Removed deprecated `TextQuery.includeChains` and `TextQuery.includeChains`. Please use `CategoryQuery.includeChains` and `CategoryQuery.excludeChains` instead. <!-- IOTSDK-15537 -->
- Raised the minimum supported Flutter version from 3.3.10 to 3.7.12. Raised the minimum supported Dart version from 2.18.6 to 2.19.6. Raised the latest supported Flutter version from 3.7.7 to 3.10.5. Raised the latest supported Dart version from 2.19.4 to 3.0.5. Other versions may also work, but are not guaranteed to be supported. <!-- IOTSDK-17522 -->
- Removed the previously deprecated `AssumedTrackingTransportMode` property. Please use `TrackingTransportProfile` property instead. <!-- IOTSDK-18050 -->
- Removed Dart constructor for struct `Attribution`, `TransitWaypoint` and `DynamicRoutingEngine`. Please use other available contructors instead. Note that the `DynamicRoutingEngine` is not available for all editions. <!-- IOTSDK-18048 -->
- Removed depracated `RoadFeatures.difficultTurns` and `SectionNoticeCode.violatedAvoidDifficultTurns` enums. Use other available options instead such as `uTurns`. <!-- IOTSDK-13833 -->
- Removed deprecated `MapSceneLayers`. `MapScene.setLayerVisibility` can no longer be used to enable/disable map features. Please use `MapScene.enableFeatures` and `MapScene.disableFeatures` instead. <!-- IOTSDK-13835 -->
- Removed the previously deprecated `MapCameraKeyframeTrack.focalLength()` method. Use `MapCameraKeyframeTrack.fieldOfView() instead`.
Removed the previously deprecated `MapCameraKeyframeTrack.setFocalLength()` method. Use `MapCameraKeyframeTrack.setVerticalFieldOfView() instead`. <!-- IOTSDK-18269 -->
- Removed deprecated constructors in `GPXDocument`, `LocationSimulatorOptions`, `RoadAttributes`, `SectionProgress`, `ManeuverProgress`, `SpeedLimit`, `SpeedLimitOffset`. Please use other available contructors. <!-- IOTSDK-15537 -->
- Removed deprecated `MapFeatureMode.trafficFlowRegionSpecific`. Please use `MapFeatureModes.trafficFlowJapanWithoutFreeFlow` instead. <!-- IOTSDK-14409 -->
- Removed deprecated constructors in `AvoidanceOptions`, `CarOptions`, `EVCarOptions`, `EVConsumptionModel`, `EVTruckOptions`, `FarePrice`, `PedestrianOptions`, `PostAction`, `PreAction`, `RouteTextOptions`, `ScooterOptions`, `TransitRouteOptions`, `TransitStop`, `TruckOptions`. Please use other available contructors. <!-- IOTSDK-15537 -->
- Removed the previously deprecated `TruckSpecifications.type`. Please use `TruckSpecifications.trucktype` instead. <!-- IOTSDK-17507 -->
- Removed deprecated constructors in `GeoPlace` and `SearchOptions`. Please use other available contructors. <!-- IOTSDK-15537 -->

#### Resolved Issues

- `OfflineRoutingEngine`: Offline route calculation may take too long or result in detours when the route crosses a country border in Baltic countries. <!-- OLPSUP-23628 -->
- Navigation: Fixed an issue with incorrect `SpeedLimits` when the route was calculated with the `OfflineRouteEngine`. <!-- IOTSDK-17002 -->
- Fixed skipped location and route progress updates for `VisualNavigator` after pausing navigation. Now the updates will be processed. <!-- IOTSDK-17826 -->
- `OfflineSearchEngine`: Setting `SearchOptions.maxItems` to a value outside the allowed range of [1, 100] will no longer cause a crash. <!-- IOTSDK-17881 -->
- Fixed wrong `TruckRestrictions.distanceType.reached` event that happened when an access violation starts from an unexpected offset of a road segment. <!-- IOTSDK-17099 -->
- Fixed missing support for `place.boundingBox` when serializing a `Place` via `Place.serializeCompact()`. <!-- IOTSDK-18326 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- Navigation: Setting `ManeuverNotificationTimingOptions` may not work as expected for trucks on highways. <!-- IOTSDK-17780 -->
- `SpeedBasedCameraBehavior`: When setting a profile containing `SpeedBasedCameraBehavior.ProfileValue` elements a crash may occur. To workaround this, make sure to set `fromMetersPerSecond` and `toMetersPerSecond` with ascending intervals. For example, when setting [a, b] and [c, d], then make sure that c > a and c <= b and d > b. <!-- IOTSDK-18433 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.14.5.0

#### New Features

- Added support for road shield icons. With `iconProvider.createRoadShieldIcon(...)` you can now asynchronously create a `Image` that depicts a road number such as "A7" or "US-101" - as it already appears on the map view. Added `IconProvider.IconCallback` to receive the resulting image or an error. The icon is generated offline from `RoadShieldIconProperties` that require parameters such as `RouteType` and `LocalizedRoadNumber`. These parameters can be retrieved from the `Span` of a `Route` object. Added `span.getShieldText(..)` to get the `shieldText` for use with `RoadShieldIconProperties`. Added `span.getRoadNumbers()` to get a list of `LocalizedRoadNumber` items with additional information such as `RouteType` (level 1 to 6, indicating whether a road is a major road or not) and `CardinalDirection` (such as in "101 West"). Note: This is a beta release of this feature. <!-- IOTSDK-17270 -->
- `TruckRestrictionsWarningOptions` allow now to configure the notification thresholds by setting distances in meters for highways, rural and urban roads. <!-- IOTSDK-17194 -->
- Updated map styles: Improved the visual styling of tunnels. <!-- CARTODSG-119 -->
- Custom map catalogs: Added error code `updateBlockedAsAnotherPending` for multi-catalog configurations to prevent an update of another catalog when one catalog is already in a `pendingUpdate` state. Added enum of same name to `CatalogUpdateState`. <!-- IOTSDK-17073 -->
- Feature configurations are now expressed in code. Exposed `LayerConfiguration` to specify the list of features to enable. As before, by disabling map features that are not essential for the application it is possible to optimize the size of the map to download. Note that with next release it will be no longer possible to define feature configurations via `AndroidManifest` or `Plist`. <!-- IOTSDK-15098 -->
- Added `WeightPerAxleGroup` to `TruckSpecifications`. Allows specification of axle weights in a more fine-grained way than `weightPerAxleInKilograms`. <!-- IOTSDK-16022 -->
- Added `TollStop.distanceType` and `TollStop.distanceToTollStopInMeters` to indicate when a toll station is ahead or has been passed. <!-- IOTSDK-17853 -->

#### API Changes - Breaking

- With next release it will be no longer possible to define feature configurations via `AndroidManifest` or `Plist`. Use the new `LayerConfiguration` instead.

#### Resolved Issues

- Fixed IPv6 support. Added `networkInterface` field to `ProxySetting` to improve compatibility on Android. <!-- IOTSDK-17819 -->
- The `VisualNavigator` now makes use of the new method `mapPolyline.mapContentCategoriesToBlock()` to hide vehicle restriction icons that cross the path of a route. <!-- IOTSDK-17804 -->
- The traffic flow shown on the map view is no longer hidden by a `Route` rendered with the `VisualNavigator`: The width of its `MapPolyline` depends now on the zoom level so that traffic flow and route can be shown together. <!-- IOTSDK-15438 -->
- `VisualNavigator`: Fixed cases where the map camera was lagging behind the `LocationIndicator` during fast moves or at high zoom levels. <!-- IOTSDK-17677 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- Navigation: Setting `ManeuverNotificationTimingOptions` may not work as expected for trucks on highways. <!-- IOTSDK-17780 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- `OfflineSearchEngine`: Setting `SearchOptions.maxItems` to a value outside the allowed range of [1, 100] will cause a crash. For this release, make sure to set a value within the range to avoid this problem. <!-- IOTSDK-17881 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `OfflineRoutingEngine`: Offline route calculation may take too long or result in detours when the route crosses a country border in Baltic countries. Sometimes, no route can be found. Other countries may be also affected. As a workaround, it is recommended to restart the application after a map update has been performed. <!-- OLPSUP-23628 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.14.4.0

#### New Features

- This version of the HERE SDK is delivered with map data v85 for `CatalogType.optimizedClientMap` catalog and v67 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-17642 -->
- Navigation: Added `repeatLastManeuverNotification()` to `Navigator` and `VisualNavigator`. This method repeats the last maneuver notification. The current location of the user is taken into account. For example, this can be useful, when a user would like the hear the last maneuver again. <!-- IOTSDK-17442 -->
- `MapView`: It is now possible to hide icons from the `MapFeatures.vehicleRestrictions` layer when they cross the path of a `MapPolyline`: Added an API for a map polyline to block vehicle restriction icons. Added `MapPolyline.mapContentCategoriesToBlock: [MapContentCategory]` property. Added `MapContentCategory` enum. <!-- IOTSDK-17282 -->
- `TruckRestrictionWarning`: Added an option to filter out time-dependent restrictions based on the device time via `TruckRestrictionsWarningOptions.filterOutInactiveTimeDependentRestrictions`. It can be set via `Navigator` or `VisualNavigator`. By default, no filtering applies. Added `TimeRule` to `TruckRestrictionWarning` which indicates a time period of one or more intervals for which a truck restriction applies. The default notification thresholds based on road type and distance can be changed via the newly added `TruckRestrictionsWarningOptions`. <!-- IOTSDK-17183 -->
- Navigation: Added `TollStopWarningListener` to provide information on upcoming toll stops including lane and payment information. Take a look at the `Navigation` example app for a usage example: Find it on [GitHub](https://github.com/heremaps/here-sdk-examples). <!-- IOTSDK-17618 -->

#### Resolved Issues

- Navigation: For highways in Australia and New Zealand, the street name is now set with a higher precedence than the road number. As a result, the name of a highway is now included in the maneuver and maneuver notification text. <!-- IOTSDK-17533 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- Navigation: Setting `ManeuverNotificationTimingOptions` may not work as expected for trucks on highways. <!-- IOTSDK-17780 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- `OfflineSearchEngine`: Setting `SearchOptions.maxItems` to a value outside the allowed range of [1, 100] will cause a crash. For this release, make sure to set a value within the range to avoid this problem. <!-- IOTSDK-17881 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: The `speedLimit.speedLimitLimitInMetersPerSecond` information reported for trucks in tracking mode may be inaccurate - even when setting the correct transport mode via `trackingTransportProfile`. In tracking mode, currently, the value contains the speed limit as seen on the sign post (which is usually intended for cars) - or the known legal maximum car speed limit for the current type of street. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `OfflineRoutingEngine`: Offline route calculation may take too long or result in detours when the route crosses a country border in Baltic countries. Sometimes, no route can be found. Other countries may be also affected. As a workaround, it is recommended to restart the application after a map update has been performed. <!-- OLPSUP-23628 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.14.3.0

#### New Features

- Improved log messages. Now more information is printed when a fatal error occurs on the native side via JNI / Java. <!-- IOTSDK-17534 -->
- Added 'MapScheme.liteDay', 'MapScheme.liteNight', 'MapScheme.liteHybridDay', 'MapScheme.liteHybridNight' schemes, which are the simplified versions of the respective normal map schemes. These simplified scheme variants serve well as background for more complex content such as public transit lines. <!-- IOTSDK-17336 -->
- `MapView`: Added option to choose surface or texture view on Android devices. Added `MapRenderMode` enum and `HereMapOptions.renderMode` property, which allows choosing between `SurfaceView` and `TextureView` for map rendering. By default, `SurfaceView` is used, which offers best performance, but can suffer from various graphical glitches in some scenarios, particularly on Android 12 and 13. For applications with complex and dynamic UI and/or with multiple `MapView` instances, using `MapRenderMode.TEXTURE` fixes these graphical glitches. Use the newly introduced `HereMapOptions` to specify the `renderMode`. <!-- IOTSDK-17105 -->
- `MapView`: Improved map styles to render overlapping roads based on their z-level attribute. <!-- CARTODSG-94 -->
- This version of the HERE SDK is delivered with map data v82 for `CatalogType.optimizedClientMap` catalog and v67 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-17455 -->
- `MapView`: Added `HereMapOptions.withDefaults` named constructor which initializes `HereMapOptions` with default values. <!-- IOTSDK-17105 -->
- Added `RoutePrefetcher.prefetchGeoCorridor()` to prefetch tile data for an entire `GeoCorridor`. This new API performs an asynchronous operation to download data for all enabled feature configurations along the route corridor. The progress of the prefetching operation is reported through the `PrefetchStatusListener.onProgress()` interface. Once the operation is completed, the result is communicated via `PrefetchStatusListener.onComplete()`. Note that this is a beta release. <!-- IOTSDK-17350 -->
- Realistic views: Added a free-to-use font package. Find the `SignpostFonts.zip` package in your release package. The TTF fonts and accompanying license files can be found inside the ZIP file. These fonts are required to render `RealisticView` SVG content during turn-by-turn navigation. A usage example can be seen in the chapter on _realistic views_ in our Developer Guide. <!-- IOTSDK-16960 -->

#### API Changes - Deprecations

- Deprecated default `HereMapOptions` constructor and named constructors `HereMapOptions.fromColor` and `HereMapOptions.fromProjectionAndColor`. Instead, use `HereMapOptions.withDefaults` named constructor and change desired properties on the resulting `HereMapOptions` object. <!-- IOTSDK-17542 -->

#### Resolved Issues

- Navigation: For `realisticView.signpostSvgImageContent` there are no longer issues with font overflows for most countries. A font package is now included. Only two packages for THA and ARA are still missing (see known issues). <!-- IOTSDK-15272 -->
- Navigation: Fixed an issue for too slow `SpeedLimit` information during guidance caused by a CVR misinterpretation. <!-- IOTSDK-15766 -->
- Navigation: Fixed a visual issue with sharp turns. Now the animation (and the location indicator) follows the route precisely. <!-- IOTSDK-15995 -->
- It is no longer necessary to load the `optimizedClientMapJapan` map catalog after the `optimizedClientMap` catalog. The order no longer matters. <!-- IOTSDK-17182 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: The `SignpostFonts.zip` package which is included in the release package is missing two TTF font families: `DejaVuSans.ttf` contains _Thai (THA)_ fonts and supports Thailand. And `THSarabunPSK-Bold.ttf`, which contains _Arabic (ARA)_ fonts and supports Israel, Kuwait, Bahrain, Egypt, Morocco, Oman, Qatar, Saudi Arabia, United Arab Emirates. For the affected countries, there can be issues with font overflows (that is the text of a signpost shield might appear too big) when rendering `realisticView.signpostSvgImageContent`. <!-- IOTSDK-17570 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: `SpeedLimit` information reported for trucks in tracking mode may be inaccurate - even when setting the transport mode as tracking `TransportProfile`. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `OfflineRoutingEngine`: Offline route calculation may take too long or result in detours when the route crosses a country border in Baltic countries. Sometimes, no route can be found. Other countries may be also affected. As a workaround, it is recommended to restart the application after a map update has been performed. <!-- OLPSUP-23628 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.14.2.0

#### New Features

- `MapView`: Added more mountain range labels for all preconfigured `MapScheme` styles. <!-- CARTODSG-526 -->
- `MapView`: Enhanced pick support for Carto POIs. Pick results of type `PickMapContentResult.PoiResult` make now use of a new internal OCM annotation layer that allows to pick POIs that have not been pickable before. Note that the `offlineSearchId` field is always empty for such pick results. <!-- IOTSDK-14711 -->
- Indoor Maps: In order to make it easier to search for `VENUES` when viewing the map at high zoom levels, we now display the venue structure as a patch: This patch enables the venue to be visible even when the map is zoomed out. Note that this happens automatically and does not require any changes on app-side. <!-- INDOOR-18466 -->
- `MapView`: Enabled visualization of exit number displays for access restricted streets for all preconfigured `MapScheme` styles. <!-- CARTODSG-276 -->
- `MapView`: Improved the visualization and the hierarchy of city labels for the preconfigured map styles. <!-- CARTODSG-524 -->
- This version of the HERE SDK is delivered with map data v80 for `CatalogType.optimizedClientMap` catalog and v67 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-17302 -->

#### Resolved Issues

- Navigation: The visual representation of the lanes to take at a complex junction is now highlighted as expected for `realisticView.junctionViewSvgImageContent`: The lanes to take are shown in blue color instead of green. <!-- IOTSDK-17240 -->
- Navigation: Fixed an issue with `SpeedLimits` notifications related to `SpeedLimitListener`. <!-- IOTSDK-14714 -->
- Navigation: Aligned the font family names contained in the SVG for `RealisticView` signposts. The font assets are planned to be provided with the next release. Until then, font overflow issues may still happen. <!-- IOTSDK-15272 -->
- Navigation: Fixed irrelevant `continueOn` maneuver notifications for FRC4 or FRC5 roads. <!-- IOTSDK-14808 -->
- Navigation: Fixed diacritics for the word `then` in the voice package for Arabic to improve the pronunciation by TTS engines. <!-- IOTSDK-16763 -->
- Natural Guidance: Internally, the HERE SDK avoids now access to map data when processing location updates and preloads map data based on predictions using an optimized most-probable-path algorithm. <!-- IOTSDK-17180 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- When setting the `optimizedClientMapJapan` map catalog, then the `optimizedClientMap` catalog has to be set (or loaded) first - or unexpected behavior and visual defects may occur. <!-- IOTSDK-17182 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: For `realisticView.signpostSvgImageContent` there can be issues with font overflows (that is the text of a signpost shield might appear too big). <!-- IOTSDK-15272 -->
- Navigation: `SpeedLimit` information reported for trucks in tracking mode may be inaccurate - even when setting the transport mode as tracking `TransportProfile`. <!-- IOTSDK-17385 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `OfflineRoutingEngine`: Offline route calculation may take too long or result in detours when the route crosses a country border in Baltic countries. Sometimes, no route can be found. Other countries may be also affected. As a workaround, it is recommended to restart the application after a map update has been performed. <!-- OLPSUP-23628 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.14.1.0

#### New Features

- `RoadTexts`: Added support for transliteration for offline usage. <!-- IOTSDK-16281 -->
- `OfflineRoutingEngine`: `AvoidanceOptions.zoneCategories` is now supported to avoid environmental zones. <!-- IOTSDK-17147 -->
- Positioning: Added new value `locationServicesDisabled` to `LocationEngineStatus`, which informs that location services are disabled in the system settings of a device. <!-- IOTSDK-16442 -->
- This version of the HERE SDK is delivered with map data v79 for `CatalogType.optimizedClientMap` catalog and v67 for `CatalogType.optimizedClientMapJapan` catalog. <!-- IOTSDK-17135 -->
- Custom catalogs: Added `AuthenticationMode` in `SDKOptions`. This feature is useful when `customEngineBaseUrls` are used to self-host backend services. Use 	`AuthenticationMode.withToken(String accessToken)` to set a custom bearer token as string. If `AuthenticationMode.withExternal()` is called, the authentication must be done fully by the client. With `AuthenticationMode.withKeySecret​(String accessKeyId, String accessKeySecret)` you bring back the default behavior, where for each online request a bearer token is set in the header of a request - consisting of the provided credentials. Usually, this is done by the HERE SDK internally. Note: This is a beta release of this feature. <!-- IOTSDK-15681 -->
- `MapView`: Improved map design by adding public transit _access_ icons as embedded Carto POIs based on the General Transit Feed Specification ([GTFS](https://gtfs.org)). Entrances to transit stations are indicated with a small entrance symbol. These icons are clustered, based on the zoom level, together with the transit station icons we added in our last release. Note that this map feature requires OCM version 79 or higher. <!-- CARTODSG-173 -->
- `MapUpdater`: Added `CatalogUpdateState` to `CatalogUpdateInfo` which contains more information on the current update state. <!-- IOTSDK-17072 -->

#### API Changes - Breaking

- Removed deprecated geo fields and constructors of `sdk.search.TextQuery` and `sdk.search.CategoryQuery`. Use newly added constructors taking `sdk.search.TextQuery.Area` and `sdk.search.CategoryQuery.Area` instead. <!-- IOTSDK-14246 -->
- Removed deprecated `CategoryQuery.withExcludeCategories`. Please set `excludeCategories` directly using `categoryQueryObject.excludeCategories`. <!-- IOTSDK-14246 -->

#### Resolved Issues

- Navigation: Fixed missed `passed` event for `TruckRestrictionWarning` for overlapping restrictions. <!-- IOTSDK-17120 -->
- `DynamicRoutingEngine`: Fixed a crash when calling `DynamicRoutingEngine.stop()` at an unexpected time. <!-- IOTSDK-17310 -->
- `MapView`: Improved visualization and names for traffic styles. <!-- CARTODSG-516 -->
- Offline search: Fixed indexing support for multiple catalogs when `SDKOptions.enableIndexing` flag is set. <!-- IOTSDK-17116 -->
- `DynamicRoutingEngine`: Fixed a bug when `onBetterRouteFound(..)` is called with 0 difference for ETA and distance. <!-- IOTSDK-16243 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- When setting the `optimizedClientMapJapan` map catalog, then the `optimizedClientMap` catalog has to be set (or loaded) first - or unexpected behavior and visual defects may occur. <!-- IOTSDK-17182 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: For `realisticView.signpostSvgImageContent` there can be issues with font overflows (that is the text of a signpost shield might appear too big). <!-- IOTSDK-15272 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Navigation: The visual representation of the lanes to take at a complex junction is not highlighted as expected for `realisticView.junctionViewSvgImageContent`: The lanes to take are shown correctly, but they are shown in green color instead of blue. <!-- IOTSDK-17240 -->
- `OfflineRoutingEngine`: Offline route calculation may take too long or result in detours when the route crosses a country border in Baltic countries. Sometimes, no route can be found. Other countries may be also affected. As a workaround, it is recommended to restart the application after a map update has been performed. <!-- OLPSUP-23628 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.14.0.0

#### New Features

- `OfflineRoutingEngine`: Enabled support for taxi routes. <!-- IOTSDK-14540 -->
- `OfflineRoutingEngine`: `RoadFeatures.uTurns` are now supported for cars, taxis and buses and can be avoided. <!-- IOTSDK-14540 -->
- `MapView`: Improved the map design for deserts with a polygon display. Note that this is only available for OCM based maps. <!-- CARTODSG-96 -->
- `MapView`: Improved the map design with an updated style for unpaved roads. The fill and outline color and the labels of unpaved roads are now styled with a brownish tint. <!-- CARTODSG-475 -->
- `RoutingEngine`: `RoadFeatures.uTurns` are now supported for cars, taxis and buses and can be avoided. <!-- IOTSDK-14541 -->
- `MapPolygon`: Added `outlineColor` and `outlineWidth` properties to enable polygon outlines. <!-- IOTSDK-16922 -->
- Map data: Added a convenience method to see the default `CatalogConfiguration`. By calling `CatalogConfiguration.getDefault(CatalogType)` you can retrieve the HRN string and the map version. This can be useful, when you want to enable extended map data for Japan. Note that `CatalogType.optimizedClientMapJapan` is an extended map type that requires the `CatalogType.optimizedClientMap` catalog as a base map. If Japan is not set, then the area in Japan is showing limited details on the map view. Get in touch with the HERE team to get access to the enriched Japan map data. Take a look at the Developer Guide for a usage example. <!-- IOTSDK-16544 -->
- `OfflineSearchEngine`: Added `SDKOptions.enableIndexing` flag that enables an index mechanism to find places in installed `Region` data - even if they are far away from the provided search center. This matches the behavior of the online `SearchEngine`. When set to false, the behavior or the mentioned APIs remains as before. Defaults to false. If set to true, this flag affects all operations that modify persistent storage content: `mapDownloader.downloadRegions()`, `mapDownloader.deleteRegions()`, `mapDownloader.clearPersistentMapStorage()`, `mapDownloader.repairPersistentMap()`, `mapDownloader.performMapUpdate()`, `mapDownloader.performFeatureUpdate()`, `mapDownloader.updateCatalog()`. These methods will ensure that the index is created, deleted or updated to contain entries from `Region` data that are installed in the persistent storage. Creating an index takes time and this will make all operations that download or update offline maps longer, but usually not more than a few seconds up to a couple of minutes (depending on the amount of installed offline maps data). The stored index also increases the space occupied by offline maps by around 5%. The performance and space impact will be improved for future releases of the HERE SDK. Note that this is a beta release of this feature. <!-- IOTSDK-16932 -->
- `MapView`: Improved the map design by adding public transit embedded Carto POIs based on the General Transit Feed Specification ([GTFS](https://gtfs.org)). The icons are automatically clustered based on the zoom level. Note that this map feature requires OCM version 78 or higher. <!-- CARTODSG-67 -->
- Raised the minimum supported Flutter version from 3.3.2 to Flutter 3.3.10. The latest supported Flutter version was raised from 3.3.10 to Flutter 3.7.7. Accordingly, the minimum supported Dart version was raised from 2.18 to Dart 2.18.6. The latest supported Dart version was raised from 2.18.6 to Dart 2.19.4. Other versions may also work, but are not guaranteed to work. <!-- IOTSDK-16709 -->
- This version of the HERE SDK is delivered with map data v75 for the `optimizedClientMap` catalog and v67 for the `optimizedClientMapJapan` catalog. <!-- IOTSDK-16894 -->

#### API Changes - Breaking

- Navigation: Removed the previously deprecated `routing.TruckSpecifications`. Use instead `transport.TruckSpecifications`. <!-- IOTSDK-16930 -->
- Removed deprecated method `HereMapController.pickMapFeatures` and class `PickMapFeaturesResult`. Use `HereMapController.pickMapContent` and `PickMapContentResult` instead. <!-- IOTSDK-12995 -->
- Routing: Removed deprecated `Section.trafficSpeeds` property. Use instead the `Span.trafficSpeed` property. Removed deprecated `TrafficSpeed.offset`. Use instead the `Span.sectionPolylineOffset` property. <!-- IOTSDK-16921 -->
- Positioning: Removed the previously deprecated 'LocationEngineStatus.notLicensed'. Feature availability is notified with 'LocationStatusListener.onFeaturesNotAvailable()'. Removed the previously deprecated 'LocationEngineStatus.notCompatible'. Status is notified with 'LocationIssueListener'. <!-- HDGNSS-4155 -->
- Removed the previously deprecated `mapView.setWatermarkPosition()` method. Use instead `mapView.setWatermarkLocation()`. <!-- IOTSDK-13061 -->
- Search: Removed deprecated `accomodation`, `accomodationHotelMotel` and `accomodationLodging` constants from `PlaceCategory`. `accommodation`, `accommodationHotelMotel` and `accommodationLodging` should be used instead. <!-- IOTSDK-13680 -->
- Removed deprecated methods `MapCamera.lookAt(GeoCoordinates, double)` and `MapCamera.lookAt(GeoCoordinates, GeoOrientationUpdate, double)`. Use `MapCamera.lookAt(GeoCoordinates, MapMeasure)` and `MapCamera.lookAt(GeoCoordinates, GeoOrientationUpdate, MapMeasure)` instead. <!-- IOTSDK-11527 -->

#### Resolved Issues

- Navigation: A slash appearing on direction information (street name, road number, or signpost direction) is interpreted as `trên` in Vietnamese voice package. <!-- IOTSDK-16641 -->
- Navigation: Fixed a crash that occurred when the `DynamicRoutingEngine` was not able to compute a better route. <!-- IOTSDK-17015 -->
- Navigation: Fixed an issue with `trailerCount` in `TruckRestrictionWarning`, if one is available. <!-- IOTSDK-16994 -->
- When `MapFeatures.vehicleRestrictions` is activated, the map view will no longer show an icon for truck speed limits - also the related purple line is no longer shown. <!-- IOTSDK-16389 -->
- Navigation: The current location can now be restored in order to fix issues with sending notifications. <!-- IOTSDK-15378 -->
- Outlines for `MapPolyline` lines no longer show a minimal gap at certain zoom levels. <!-- HARP-15072 -->
- `RoutingEngine`: Fixed a `RoutingError` that happens for the Slovenian language definition when calling `importRoute()`. <!-- IOTSDK-16997 -->
- `RealisticViewWarning`: A `PASSED` notification is no longer sent if an `AHEAD` notification was not sent beforehand. <!-- IOTSDK-16573 -->
- Natural guidance: Signpost direction information included in a voice maneuver notification is now obtained from the `localizedText` attribute in `Signpost` instead of the deprecated `towards` field in `RoadTexts`. <!-- IOTSDK-16996 -->

#### Known Issues

- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- When setting the `optimizedClientMapJapan` map catalog, then the `optimizedClientMap` catalog has to be set (or loaded) first - or unexpected behavior and visual defects may occur. <!-- IOTSDK-17182 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: For `realisticView.signpostSvgImageContent` there can be issues with font overflows (that is the text of a signpost shield might appear too big). <!-- IOTSDK-15272 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Navigation: The visual representation of the lanes to take at a complex junction is not highlighted as expected for `realisticView.junctionViewSvgImageContent`: The lanes to take are shown correctly, but they are shown in green color instead of blue. <!-- IOTSDK-15272 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.13.5.0

#### New Features

- Routing: Added `Span.countryCode` property to obtain a country code per span. <!-- IOTSDK-16458 -->
- Added `LocationIndicator.opacity` property to set and get the opacity of a location indicator. <!-- IOTSDK-15656 -->
- Enhanced information on route restrictions: Added `violatedRestrictions: List<ViolatedRestriction>` property to class `SectionNotice`. `ViolatedRestriction.Details` contains, for example, height restrictions or forbidden `TruckType` values. This feature works online, but is also supported for use with the `OfflineRoutingEngine` - if supported by your HERE SDK edition. Note: This is a beta release of this feature. <!-- IOTSDK-16357 -->
- Added `LogControl` to filter HERE SDK log messages. This allows to disable HERE SDK related console logs or to set a custom `LogAppender` to receive only selected log messages from the HERE SDK. <!-- IOTSDK-14868 -->
- Routing: Enhanced `RoadTexts` accessible from a `Maneuver`. `RoadTexts` contains now a list of `LocalizedRoadNumbers` and a `numbersWithDirection` field to contain road numbers with direction. The latter replaces the deprecated `numbers` field. <!-- IOTSDK-13008 -->
- Added `MapFeature.terrain` and `MapFeatureModes.hillshading` as a beta feature to show shaded terrain on the map. Not supported for hybrid and satellite schemes. This feature is disabled by default. Added the value "terrain" that can be specified in the _AndroidManifest_/_Plist_ for the "com.here.sdk.feature_configuration"/"FeatureConfiguration" key to include terrain data when downloading a `Region`. <!-- IOTSDK-16177 -->
- This version of the HERE SDK is delivered with map version 73 and map version 67 for the extended Japan map. <!-- IOTSDK-16560 -->
- Raised maximum supported Flutter version from 3.3.9 to 3.3.10. Raised corresponding latest supported Dart version from 2.18.5 to 2.18.6. Newer versions may also work, but are not guaranteed to work. The minimum supported Flutter / Dart versions remain unchanged. <!-- IOTSDK-15831 -->
- Navigation: Added new camera behavior class called `SpeedBasedCameraBehavior` to be used in the `VisualNavigator`. It provides automatic camera zoom and tilt based on the user's current speed. Although it can be used on active guidance, it is best suited for tracking mode. It is possible to customize which zoom or tilt value should be used for any given speed range. Furthermore, a smooth animation is now performed when switching between camera behaviors or when starting turn-by-turn navigation. <!-- IOTSDK-16156 -->
- `ConsentEngine`: Added support for Serbian (Latin) and Vietnamese localizations to the data consent dialog. <!-- POSTI-2837 -->
- Added read-only property `signpost` to get signpost information. `SignpostLabel.direction` will replace `RoadTexts.towards` for getting information about directions. <!-- IOTSDK-13004 -->
- Routing: Added `turnAngleInDegrees` (-180 to 180) and `roundaboutAngleInDegrees` (-360 to 360) to `Maneuver` class to indicate information on the turn angle for all turn related actions. If not applicable for the maneuver, the value will be `null`. `roundaboutAngleInDegrees` indicates the amount of the roundabout that needs to be traversed - it is positive in right-driving countries and negative in left-driving countries. <!-- IOTSDK-16644 -->

#### API Changes - Breaking

- The `RealisticView` object inside the `RealisticViewWarning` event is now optional. When `distanceType` is `ahead`, the `RealisticView` will contain the SVG images for junction view and signpost. When `distanceType` is `passed`, the `RealisticView` object will be `null`. <!-- IOTSDK-16941 -->

#### API Changes - Deprecations

- The `numbers` field in `RoadTexts` has been deprecated and will be removed with HERE SDK version 4.16.0. Use the newly introduced `numbersWithDirection` field instead. <!-- IOTSDK-13008 -->
- Deprecated `setLogAppender()` in `SDKNativeEngine`. Use the newly introduced `LogControl` API instead. Deprecated `Debug` and `Trace` log levels as such messages are not relevant. <!-- IOTSDK-14868 -->

#### Resolved Issues

- Navigation: Fixed an issue with voice maneuver notifications for Arabic. Selected diacritics have been added to enhance the pronunciation. <!-- IOTSDK-16668 -->
- Navigation: Fixed an issue with voice maneuver notifications for Malayalam. An unexpected phrase occurred in the middle of a maneuver sentence. <!-- IOTSDK-16668 -->
- Navigation: Fixed wrong side for road signs. `roadsign` notifications and natural guidance maneuver instructions texts have been updated to indicate only the signs relevant for the current side of the road. <!-- IOTSDK-16203 -->
- Navigation: Fixed an issue with voice maneuver notifications for Slovak. An unexpected 'a potom' phrase occurred in the middle of a maneuver sentence. <!-- IOTSDK-16668 -->
- Routing: Fixed an issue with wrong roundabout maneuver actions after return to route. <!-- IOTSDK-16554 -->
- `ManeuverAction.enterHighwayFromLeft` and `ManeuverAction.enterHighwayFromRight` are now properly generated when `RouteOptions.enableEnterHighwayManeuverAction` is set. <!-- IOTSDK-15292 -->
- Navigation: Fixed missing `TruckRestrictionWarning` events when the user starts navigation on a long segment and the restriction is in the next segment. <!-- IOTSDK-16786 -->
- Fixed `RoutingError.couldNotMatchOrigin` and `RoutingError.couldNotMatchDestination` from `OfflineRoutingEngine` when waypoints cannot be matched to the road network to align with the behavior of the online `RoutingEngine`. <!-- IOTSDK-14522 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: The visual representation of the lanes to take at a complex junction is not highlighted as expected for `realisticView.junctionViewSvgImageContent`. Instead, all lanes are currently highlighted. On top, there can be issues with font overflows (that is the text of a signpost shield might appear too big). <!-- IOTSDK-15272 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.13.4.0

#### New Features

- Added `MapMarker.visibilityRanges : [MapMeasureRange]` property. <!-- IOTSDK-16118 -->
- `MapMarker3D` objects can now be picked from the map view: Added `PickMapItemsResult.markers3d` read-only property that holds the list of picked `MapMarker3D` instances. <!-- IOTSDK-14570 -->
- Added zoom `visibilityRanges` property to `MapPolyline`. <!-- IOTSDK-5058 -->
- Added `SDKNativeEngine.proxySettings` property to get/set the `ProxySettings` that will be used by the HERE SDK for all network requests. By setting a proxy server, you can specify, for example, the IP address and port number of your proxy. By default, no proxy is set. Note: This is a beta release of this feature. <!-- IOTSDK-15417 -->
- This version of the HERE SDK is delivered with map data v71 for the main (ROW) map catalog and v67 for the extended Japan catalog. <!-- IOTSDK-16329 -->
- Added support for natural guidance: `ManeuverNotification` texts for TTS now include significant objects (such as traffic lights or stop signs) along a route to make maneuvers better understandable. Example: "At the next _traffic light_ turn left onto Wall street". By default, this feature is disabled. To enable it, add at least one `NaturalGuidanceType` such as `trafficLight` to `ManeuverNotificationOptions` via the list of `includedNaturalGuidanceTypes`. <!-- IOTSDK-3513 -->
- Added `offlineMode` to `SDKOptions` to initialize the HERE SDK in offline mode. This complements the existing global offline switch via the shared instance of the `SDKNativeEngine` to switch at runtime. <!-- IOTSDK-15993 -->
- Added `ignoreCachedData` option to `CatalogVersionHint.latest(ignoreCachedData)`, which allows to auto-update to the latest map version when the map data cache already contains data and no `Regions` are installed. Use this hint when initializing the HERE SDK. See the `Maps` section in our `Developer Guide` for more details. <!-- IOTSDK-16257 -->
- Added `MapMarker3D.visibilityRanges : [MapMeasureRange]` property. <!-- IOTSDK-7787 -->

#### API Changes - Deprecations

- Deprecated `CatalogVersionHint.latest()`. Use `CatalogVersionHint.latest(Boolean)` instead. <!-- IOTSDK-16257 -->

#### Resolved Issues

- Navigation: Warner options are now stored and set again after switching from/to tracking mode/routing mode. <!-- IOTSDK-16312 -->
- Added voice maneuver notification text for the very first maneuver. <!-- IOTSDK-13741 -->
- Navigation: For very long routes, the eat-up route progress visualization is sometimes not in sync with the `LocationIndicator`. <!-- IOTSDK-15682 -->
- `MapView`: Fixed handling of `MapFeatures` when an invalid `MapFeatureModes` value has been set. Now features with an invalid mode are silently ignored. <!-- IOTSDK-13916 -->
- Maneuver notifications (TTS): Changed "HWY" road number abbreviation to "highway". <!-- IOTSDK-16353 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: The visual representation of the lanes to take at a complex junction is not highlighted as expected for `realisticView.junctionViewSvgImageContent`. Instead, all lanes are currently highlighted. On top, there can be issues with font overflows (that is the text of a signpost shield might appear too big). <!-- IOTSDK-15272 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.13.3.0

#### New Features

- Offline Maps: Added error codes `pendingUpdate` and `parallelRequest` to cover failed updates and parallel requests cases. <!-- IOTSDK-15765 -->
- Debug symbols are now included in the `heresdk.xcframework` for iOS: look for the dSYM files that are added for each device architecture. For iOS apps that are deployed to App Store or via [TestFlight](https://developer.apple.com/testflight/) you can find in Apple's _Connect Portal_ the crash reports: Instead of downloading the crash report click on _Open in Xcode_ and you should see the symbolicated stack trace using the dSYM files. This should also work with [Firebase Crashlytics](https://firebase.google.com/products/crashlytics) and related solutions. Keep in mind, that the `heresdk.xcframework` is a _fat binary_ and that its file size is optimized by Xcode at deployment time. More details you can find in the _Key Concepts_ guide. <!-- IOTSDK-16139 -->
- Added opacity factor which specifies the translucency of a `MapMarker3D`. The factor is applied to the alpha channel of the resulting texture of the marker: Added `opacity` and `renderInternalsEnabled` properties. The `renderInternalsEnabled` flag indicates whether to render the internal geometry of a 3D map marker occluded by its front facing polygons. <!-- IOTSDK-15655 -->
- Added property to control the visibility of a `MapPolygon` dependent on a given zoom range: Added `MapPolygon.visibilityRanges: [MapMeasureRange]` property. <!-- IOTSDK-5783 -->
- Added property to control the visibility of a `MapMarker3D` dependent on a given zoom range: Added `MapMarker3D.visibilityRanges: [MapMeasureRange]` property. <!-- IOTSDK-7787 -->
- This version of the HERE SDK is shipped with map data version 69 (OCM). <!-- IOTSDK-16148 -->

#### API Changes - Breaking

- [Bitcode optimization](https://developer.apple.com/documentation/xcode-release-notes/xcode-14-release-notes) for iOS has been deprecated by Apple. Consequently, as of now the HERE SDK no longer supports bitcode optimization and apps can no longer be built with bitcode. For older projects it may be required to explicitly disable bitcode - especially, when you build your app for release and you see in the logs that `-embed-bitcode` is executed. In that case, add `ENABLE_BITCODE = NO;` to your `ios/Podfile`. You can see an example for this in our _example apps_. <!-- IOTSDK-16139 -->

#### Resolved Issues

- Polylines are now pickable independent of alpha color values: `MapViewBase.pickMapItems()` now can pick `MapPolyline` items with `fillColor.alpha = 0`. <!-- IOTSDK-15665 -->
- `MapScene.Layers.trafficFlow` and `MapScene.Layers.trafficIncidents` are now visible on the map. This was a license issue which affected all _Navigate_ and _Explore Edition_ users. <!-- PRCAT-33 -->
- Navigation: Fixed missing truck restrictions warnings when there were overlapping restrictions ahead. <!-- IOTSDK-14589 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: For very long routes, the eat-up route progress visualization is sometimes not in sync with the `LocationIndicator`. <!-- IOTSDK-15682 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: The visual representation of the lanes to take at a complex junction is not highlighted as expected for `realisticView.junctionViewSvgImageContent`. Instead, all lanes are currently highlighted. On top, there can be issues with font overflows (that is the text of a signpost shield might appear too big). <!-- IOTSDK-15272 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.13.2.0

#### New Features

- Positioning: Enhanced enum 'LocationIssueType' with new types. <!-- HDGNSS-3941 -->
- Route calculation: Added more error codes to `RoutingError` to provide more detailed failure reasons. <!-- IOTSDK-15932 -->
- Added customization options for route eat-up (that is route progress) and maneuver arrows: Added class `VisualNavigatorColors` and made it a property of `VisualNavigator`, also added struct `RouteProgressColors`. `RouteProgressColors` contains `ahead`, `outlineAhead` as route colors and `behind`, `outlineBehind` as traveled route colors. `VisualNavigatorColors` has a member `maneuverArrowColor`. `VisualNavigatorColors` has the following methods: `visualNavigatorColor.setRouteProgressColors(SectionTransportMode sectionTransportMode, RouteProgressColors routeProgressColors)` allows to set `RouteProgressColors` per `SectionTransportMode`. `VisualNavigatorColor.getRouteProgressColors(SectionTransportMode sectionTransportMode)` returns `RouteProgressColors` for a provided `SectionTransportMode`.
`VisualNavigatorColors.dayColors()` returns the default day `VisualNavigatorColors` colors.
`VisualNavigatorColors.nightColors()` returns the default night `VisualNavigatorColors` colors. Take a look at the Navigation example app for a possible usage example. <!-- IOTSDK-15626 -->
- The HERE watermark can now be freely positioned on the map view: Added `HereMapController.setWatermarkLocation(Anchor2D anchor, Point2D offset)` and added the read-only property `watermarkSize` to `HereMapController` class. <!-- IOTSDK-15334 -->
- Added 'RouteProgress.spanIndex' which represents the span index within a route section. <!-- COLUMBUS-1029 -->
- Applied several map style improvements (no API changes involved): Updated the road shield icon for Turkey & Jamaica. Adjusted the visibility of public transport POIs and subway and tram lines in Japan. Improved visibility of intersections and traffic lights in Japan. Added dedicated traffic incident marker for type 'lane-restriction'. Visualized land parcels in Victoria, Australia (applies only to _Navigate Edition_). Added map data attribute 'National Importance' for priority and visibility settings of POIs (applies only to _Explore Edition_). Note that these changes have been already applied for HERE SDK 4.13.1.0. <!-- CARTODSG-91 -->
- Detailed map for Japan: Improved the visibility of labels by reducing duplicated labels for POIs and landuse labels. <!-- CARTODSG-414 -->
- Added `hasShower` attribute in `TruckAmenities` struct and changed `showerCount` attribute to optional. <!-- IOTSDK-15936 -->

#### API Changes - Breaking

- Navigation: The beta APIs for `SignpostWarningListener` and `JunctionViewWarningListener` have been replaced by a new unified `RealisticViewWarningListener` to receive SVG string data for signpost shields and complex junction views in 3D. The `RealisticViewWarning` event now always contains SVG data for both, signposts and junction views. The `realisticView.signpostSvgImageContent` is meant to be overlayed on top of the `realisticView.junctionViewSvgImageContent`. The signpost view looks like a shield that appears along a road. Take a look at the _Navigation example app_ for a usage example of the new API. Note that the HERE SDK only delivers the SVG as string, so you need to use a third-party library to render the SVG content. The data for junction views was optimized to occupy only around 2 MB, while the signpost data occupies only a few KB. However, it is still recommended to use the available _feature-configurations_ to preload the data in advance, see our _Optimization Guide_. Note that lane highlighting (that is which lane to take at the complex junction) is not yet implemented and that there can be issues with font overflows (that is the text of a shield might appear too big). Keep in mind, that the SVG assets are meant to be shown fullscreen on a secondary display. <!-- IOTSDK-15568 -->

#### API Changes - Deprecations

- Deprecated `HereMapController.setWatermarkPlacement(WatermarkPlacement placement, int bottomMargin)`. Use the new APIs instead. <!-- IOTSDK-15334 -->
- Deprecated `FERRY` from `ManeuverAction` enum. It was never used. <!-- IOTSDK-15885 -->

#### Resolved Issues

- Fixed missing truck restriction warnings that may happen when a user deviates from the route and enters a restricted area. <!-- IOTSDK-16091 -->
- `ManeuverNotifications`: Some word inflections and phrases in the voice package for Arabic have been revised to enhance the pronunciation of the voice notification. <!-- IOTSDK-15797 -->
- Map view: `pickMapItems()` now also picks `MapPolygons` with `fillColor.alpha = 0`. <!-- IOTSDK-15664 -->
- The previously missing maneuver text for the `depart` maneuver action is now generated. <!-- IOTSDK-15734 -->
- When requesting toll cost for offline routing, then the axle count is used in a wrong way. As a workaround for implementation testing, but not production-safe: Double the axle count. <!-- IOTSDK-15075 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` and `MapScene.Layers.trafficIncidents` are no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- PRCAT-33 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Navigation: For very long routes, the eat-up route progress visualization is sometimes not in sync with the `LocationIndicator`. <!-- IOTSDK-15682 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: The visual representation of the lanes to take at a complex junction is not highlighted as expected for `realisticView.junctionViewSvgImageContent`. Instead, all lanes are currently highlighted. On top, there can be issues with font overflows (that is the text of a signpost shield might appear too big). <!-- IOTSDK-15272 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.13.1.0

#### New Features

- Added read-only property `isRendering` to `VisualNavigator`. It indicates whether the `VisualNavigator` is currently rendering or not. <!-- IOTSDK-11607 -->
- Added `MapMarkerCluster.opacity` property to set and get the opacity of the cluster image. <!-- IOTSDK-15662 -->
- Added optional `billingTag` field to `SDKOptions` to track your HERE platform usage across the various HERE services your application may contact. For more information on the billing tag, see our [cost management guide](https://developer.here.com/documentation/cost-management/dev_guide/topics/tutorials-billing-tags.html). The tag needs to follow the format as described in the guide or it will be ignored. The parameter defaults to `null`, which also means that the tag is ignored for all requests. Note: The billing tag is optional, but when set, it can help you to understand how often your app uses certain services, for example, the number of hits to our HERE backend routing services. For more details on tracking such details, please consult the _cost management guide_ or get in touch with the HERE billing team. <!-- IOTSDK-15294 -->
- Added `businessAndServicesEvChargingStation` enum value to `PlaceCategory` to allow searching for EV charging stations via a `CategoryQuery`. <!-- IOTSDK-14059 -->
- Added new persistent map status `PersistentMapStatus.storageClosed` to indicate that the map storage is already closed due to disposal of the `SDKNativeEngine`. Added a new persistent map repair error `PersistentMapRepairError.operationAfterDispose` to indicate that the repair is invoked on a disposed `SDKNativeEngine`. <!-- IOTSDK-14340 -->

#### API Changes - Breaking

- [Dart FFI](https://pub.dev/packages/ffi) 2.0.1 is now supported, which means that other third-party plugins also need to be updated to use FFI 2.0.1 or newer, or they can't be used together with the HERE SDK. <!-- IOTSDK-15810 -->
- Removed deprecated `MapUpdater.fromSdkEngine`. Use instead `MapUpdater.fromSdkEngineAsync`. <!-- IOTSDK-12896 -->
- Removed deprecated `MapDownloader.fromSdkEngine`. Use instead `MapDownloader.fromSdkEngineAsync`. <!-- IOTSDK-12896 -->

#### Resolved Issues

- Calling `sdkNativeEngine.dispose()` now always shuts down ongoing `MapDownloader` requests. <!-- IOTSDK-14607 -->
- Fixed a bug in `OfflineRoutingEngine` for toll cost calculation that could happen when the axle count was specified for trucks. <!-- IOTSDK-15075 -->
- Fixed incorrect `TruckRestrictionWarning` distance ahead when the current location of the vehicle is close to the end of a route segment. <!-- IOTSDK-14846 -->
- In rare cases, on some newer devices running Android 12 or higher, fast changes of the device orientation can lead to render problems: This is a known Flutter issue tracked [here](https://github.com/flutter/flutter/issues/89558). For now, this issue has to be solved on app side. <!-- IOTSDK-13350 -->
- Fixed empty `maneuver.getText()` for `leftRoundaboutExit[1..12]` and `rightRoundaboutExit[1..12]` maneuver action. The maneuver text is now always generated. <!-- IOTSDK-15734 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` and `MapScene.Layers.trafficIncidents` are no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- PRCAT-33 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- When requesting toll cost for offline routing, then the axle count is used in a wrong way. As a workaround for implementation testing, but not production-safe: Double the axle count. <!-- IOTSDK-15075 -->
- Navigation: For very long routes, the eat-up route progress visualization is sometimes not in sync with the `LocationIndicator`. <!-- IOTSDK-15682 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: `Signpost` SVG Strings contain an additional padding so that the SVG can be blended on top of a `JunctionView` asset. However, due to the padding it is currently not easily possible to show a trimmed `Signpost` asset without padding. Furthermore, the size of `JunctionView` assets is too large for mobile use - unless the data is preloaded as part of offline maps data. On top, other issues may appear when trying to render the SVG String as bitmap. <!-- IOTSDK-15272 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.13.0.0

#### New Features

- `LocationSimulator`: Added methods `pause()` and `resume()` to pause and resume sending notifications to location event subscribers. <!-- IOTSDK-13037 -->
- Adding support for transparent `MapMarker` items: Added `MapMarker.opacity` property to set and get opacity of the map markers. <!-- IOTSDK-7163 -->
- Added methods `MapScene.addMapImageOverlay(MapImageOverlay)` and `MapScene.removeMapImageOverlay(MapImageOverlay)`. <!-- IOTSDK-15206 -->
- You can now overwrite the base speeds on a `Route` per segment. After route calculation, you can use the segment reference IDs to set new values per route span and then calculate a new route with the updated values: Added collection of `MaxSpeedOnSegment` instances to all motor-vehicle based route calculation options (`BusOptions`, `CarOptions`, `EVCarOptions`, `EVTruckOptions`, `ScooterOptions`, `TaxiOptions`, and `TruckOptions`) to set restrictions for segments which affects route calculation and the ETA. For the `SegmentReference` parameter, beside the `segmentId`, the `travelDirection` can be optionally set, other values are ignored. Note that this feature is not available for offline use. <!-- IOTSDK-15006 -->
- Added global offline switch to make the HERE SDK radio-silent. This offline mode prevents the HERE SDK from initiating any online connection. `sdkNativeEngine.isOfflineMode()` method added to enable/disable this functionality. Note that this setting is not persisted. This is a beta release of this feature. <!-- IOTSDK-14980 -->
- In additon to Flutter 3.3.2 and Dart 2.18.1 now also Flutter 3.3.9 along with Dart 2.18.5 is supported. Newer versions may also work, but are not guaranteed to work. <!-- IOTSDK-15468 -->
- `OfflineRoutingEngine`: Added `RouteOptions.enableTolls` to enable toll cost calculation for offline routing. This is a beta release of this feature. <!-- IOTSDK-15075 -->
- Added `MapCamera.cancelAnimation(MapCameraAnimation)`. <!-- IOTSDK-12942 -->
- Added return type to `setManeuverNotificationTimingOption()` to indicate if the `ManeuverNotificationTimingOptions` parameter contains an invalid value. <!-- IOTSDK-13076 -->
- Add `segmentHint` and `onRoadThreshold` properties to `Waypoint` class to improve waypoint matching. <!-- IOTSDK-15005 -->
- This version of the HERE SDK is delivered with map data version 60. <!-- IOTSDK-15393 -->
- Added `MapViewBase.isValid` to check the validity of the corresponding `MapView` instance. This will return `false`, when the instance is in an invalid state because it was, for example, destroyed. <!-- IOTSDK-14588 -->
- Added `TransitSectionDetails` constructor that takes 1 parameter. <!-- IOTSDK-12062 -->
- Added class `MapImageOverlay` that allows to show icons on top of the map view that do not move, scale or tilt together with the map. You can use this to show, for example, informative icons on a map view or a map surface view for in-car use. <!-- IOTSDK-15206 -->

#### API Changes - Breaking

- Removed previously deprecated enum `sdk.routing.TunnelCategory`. Please use `sdk.transport.TunnelCategory` instead. Removed previously deprecated `sdk.routing.TruckOptions.tunnelCategory`. Please use `sdk.routing.TruckOptions.linkTunnelCategory`instead.
Removed previously deprecated `sdk.routing.EVTruckOptions.tunnelCategory`. Please use `sdk.routing.EVTruckOptions.linkTunnelCategory`instead. <!-- IOTSDK-12410 -->
- Removed the previously deprecated `SectionProgress.trafficDelayInSeconds`. Use instead `SectionProgress.trafficDelay`. <!-- IOTSDK-15504 -->
- Removed deprecated `Location.timestamp_since_boot_in_milliseconds`. Use `Location.timestamp_since_boot` instead. <!-- IOTSDK-15504 -->
- Remove deprecated 'sdk.routing.Route.polyline'. Use 'sdk.routing.Route.geometry()' instead. Remove deprecated 'sdk.routing.Section.polyline'. Use 'sdk.routing.Section.geometry()' instead. <!-- IOTSDK-15505 -->
- Removed deprecated enum entries of `MapError`: `duplicateLayer`, `invalidDataSource`, `invalidContent`, `unknownLayer`, `unknown`. <!-- IOTSDK-12535 -->
- Removed deprecated `Region` constructors. Use the constructor with region id instead. <!-- IOTSDK-12062 -->
- Removed deprecated `ManeuverProgress` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `SectionProgress` constructor that takes all parameters. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Removed deprecated `GeoPlace` constructors. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Removed deprecated `Attribution` constructor that takes all parameters. Use the unnamed constructor instead. Removed deprecated `TransitStop` constructor that takes all parameters. Use the unnamed constructor instead. <!-- IOTSDK-12062 -->
- Removed the previously deprecated `FarePrice.validityPeriodInSeconds`. Use instead `FarePrice.validityPeriod`. <!-- IOTSDK-15504 -->
- Removed deprecated `AuthenticationData.expiry_time_in_seconds`. Use `AuthenticationData.expiry_time` instead. <!-- IOTSDK-15504 -->
- Removed deprecated `AvoidanceOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `CarOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `EVCarOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `EVConsumptionModel` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `FarePrice` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `PedestrianOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `PostAction` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `PreAction` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `RouteTextOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `ScooterOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `TransitRouteOptions` constructor that takes all parameters. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Removed previously deprecated `LocationSimulatorOptions.notificationIntervalInMilliseconds`. Use instead `LocationSimulatorOptions.notificationInterval`. <!-- IOTSDK-15504 -->
- Removed the previously deprecated `PostAction.durationInSeconds`. Use instead `PostAction.duration`. <!-- IOTSDK-15504 -->
- Removed the previously deprecated `SectionProgress.remainingDurationInSeconds`. Use instead `SectionProgress.remainingDuration`. <!-- IOTSDK-15504 -->
- Removed previously deprecated `sdk.routing.TruckType` enum. Please use `sdk.transport.TruckType` enum instead. Removed previously deprecated variable `TruckSpecifications.type`. Please use `TruckSpecifications.truckType` instead. <!-- IOTSDK-12485 -->
- Removed deprecated `AuthenticationData` constructor that takes all parameters. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Removed the previously deprecated `Section.trafficDelayInSeconds`. Use instead `Section.trafficDelay`. <!-- IOTSDK-15504 -->
- Removed the previously deprecated `Maneuver.durationInSeconds`. Use instead `Maneuver.duration`. <!-- IOTSDK-15504 -->
- Removed deprecated `LocationSimulator` constructor that takes all parameters. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Removed the previously deprecated `Span.durationInSeconds`. Use instead `Span.duration`. <!-- IOTSDK-15504 -->
- Removed Section.departureTime and Section.arrivalTime properties. Use `Section.departureLocationTime` and `Section.arrivalLocationTime` instead. <!-- IOTSDK-13091 -->
- Removed previously deprecated enum `sdk.routing.HazardousGood`. Please use `sdk.transport.HazardousMaterial`instead. Removed previously deprecated variable `sdk.routing.TruckOptions.hazardousGoods`. Please use `sdk.routing.TruckOptions.hazardousMaterials`instead.
Removed previously deprecated variable `sdk.routing.EVTruckOptions.hazardousGoods`. Please use `sdk.routing.EVTruckOptions.hazardousMaterials`instead. <!-- IOTSDK-12411 -->
- Removed the previously deprecated `Route.durationInSeconds`. Use instead `Route.duration`. <!-- IOTSDK-15504 -->
- Removed deprecated `TruckOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated`EVTruckOptions` constructor that takes all parameters. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Removed deprecated `MapCameraObserver` interface, `MapCamera.addObserver(MapCameraObserver)` and `MapCamera.removeObserver(MapCameraObserver)` methods. Use `MapCamera.addListener(MapCameraListener)` and `MapCamera.removeListener(MapCameraListener)` instead. <!-- IOTSDK-12941 -->
- Removed previously deprecated `sdk.routing.TransportMode` enum. Use `sdk.transport.TransportMode` enum instead. Removed previously deprecated variable `Route.transportMode`. Use `Route.requestedTransportMode` instead. Removed previously deprecated variable `NavigatorInterface.trackingTransportMode`. Use `NavigatorInterface.trackingTransportProfile` instead. <!-- IOTSDK-12412 -->
- Removed deprecated `MapCamera.flyTo()` methods and related `MapCamera.FlyToOptions`. Use one of the `MapCameraAnimationFactory.flyTo()` methods to create a fly-to camera animation and `MapCamera.startAnimation(MapCameraAnimation)` to initiate it. <!-- IOTSDK-12944 -->
- Removed `MapCameraUpdateFactory.setPrincipalPointOffset(Point2D)` method. Use `MapCameraUpdateFactory.normalizedPrincipalPoint` instead. <!-- IOTSDK-12534 -->
- Removed previously deprecated `DynamicRoutingEngineOptions` default constructor and `DynamicRoutingEngineOptions.pollIntervalInMinutes` and DynamicRoutingEngineOptions.minTimeDifferenceInSeconds. Please use the available alternatives insted. <!-- IOTSDK-11995 -->
- Removed the previously deprecated `BatterySpecifications.chargingSetupDurationInSeconds`. Use instead `BatterySpecifications.chargingDetupDuration`. <!-- IOTSDK-15504 -->
- Removed the previously deprecated `Section.durationInSeconds`. Use instead `Section.duration`. <!-- IOTSDK-15504 -->
- Removed the previously deprecated `Route.trafficDelayInSeconds`. Use instead `Route.trafficDelay`. <!-- IOTSDK-15504 -->
- Removed deprecated `Address` constructor that takes all parameters. Use the default constructor instead. <!-- IOTSDK-12013 -->
- Removed the previously deprecated `GPXOptions` constructor with parameters. Use instead the default constructor and set the options by fields. <!-- IOTSDK-12061 -->
- Removed the previously deprecated `SearchOptions` constructor. Use `SearchOptions.withDefaults` instead. <!-- IOTSDK-12040 -->
- Removed deprecated methods `MapCameraLimits.setMinTilt` and `MapCameraLimits.setMinTilt`, use `MapCameraLimits.tiltRange` instead. Removed deprecated methods `MapCameraLimits.setMinZoomLevel` and `MapCameraLimits.setMaxZoomLevel`, use `MapCameraLimits.zoomRange` instead. Removed enum 'MapCameraLimits.ErrorCode' and exception `MapCameraLimitsException.MapCameraLimitsException` which have become obsolete. <!-- IOTSDK-12943 -->
- Removed deprecated `TransitWaypoint` constructor that takes 2 parameters. Use the unnamed constructor that takes 1 parameter instead. <!-- IOTSDK-12062 -->
- Removed the previously deprecated `TransitStop.durationInSeconds`. Use instead `TransitStop.duration`. <!-- IOTSDK-15504 -->
- Removed deprecated `TransitSectionDetails` constructor that takes 6 parameters. Use the unnamed constructor instead. <!-- IOTSDK-12062 -->
- Removed the previously deprecated `ManeuverProgress.remainingDurationInSeconds`. Use instead `ManeuverProgress.remainingDuration`. <!-- IOTSDK-15504 -->
- Removed deprecated `MapCamera.cancelAnimation()` method. Use `MapCamera.cancelAnimations()` instead. <!-- IOTSDK-12942 -->
- Removed the previously deprecated `Waypoint.durationInSeconds`. Use instead `Waypoint.duration`. <!-- IOTSDK-15504 -->
- Removed deprecated and unsupported method `RasterDataSource.changeConfigurationWithConfigPath()`. <!-- IOTSDK-12535 -->
- Removed the previously deprecated constructor of `CameraSettings`. Use instead the default constructor or `CameraBehaviour`. <!-- IOTSDK-11983 -->
- Removed deprecated `RoadAttributes` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `SpeedLimit` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `SpeedLimitOffset` constructor that takes all parameters. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Removed the previously deprecated `PreAction.durationInSeconds`. Use instead `PreAction.duration`. <!-- IOTSDK-15504 -->
- Removed deprecated `CellularPositioningOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `SatellitePositioningOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `WifiPositioningOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `NotificationOptions` constructor that takes all parameters. Use the default constructor instead. Removed deprecated `SensorOptions` constructor that takes all parameters. Use the default constructor instead. <!-- IOTSDK-12062 -->

#### API Changes - Deprecations

- Deprecated `VenueMap.venues`. Only the last two open venues remain in memory,
others are dropped. Therefore, no replacement is offered. <!-- INDOOR-17145 -->
- Deprecated `TransitWaypoint.withDefaults` constructor. Use the unnamed constructor instead. <!-- IOTSDK-12062 -->
- Deprecated `AvoidanceOptions.withDefaults` constructor. Use the default constructor instead. Deprecated `CarOptions.withDefaults` constructor. Use the default constructor instead. Deprecated `EVCarOptions.withDefaults` constructor. Use the default constructor instead. Deprecated `EVConsumptionModel.withDefaults` constructor. Use the default constructor instead. Deprecated `FarePrice.withDefaults` constructor. Use the default constructor instead. Deprecated `PedestrianOptions.withDefaults` constructor. Use the default constructor instead. Deprecated `PostAction.withDefaults` constructor. Use the default constructor instead. Deprecated `PreAction.withDefaults` constructor. Use the default constructor instead. Deprecated `RouteTextOptions.withDefaults` constructor. Use the default constructor instead. Deprecated `ScooterOptions.withDefaults` constructor. Use the default constructor instead. Deprecated `TransitRouteOptions.withDefaults` constructor. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Deprecated `RoadAttributes.withDefaults` constructor. Use the default constructor instead. Deprecated `SpeedLimit.withDefaults` constructor. Use the default constructor instead. Deprecated `SpeedLimitOffset.withDefaults` constructor. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Deprecated `LocationSimulator.withDefaults` constructor. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Deprecated `Attribution.withDefaults` constructor. Use the unnamed constructor instead.
Deprecated `TransitStop.withDefaults` constructor. Use the unnamed constructor instead. <!-- IOTSDK-12062 -->
- Deprecated `AuthenticationData.withDefaults` constructor. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Deprecated `VenueService.startLoading()`. No replacemenet is offered. <!-- INDOOR-17145 -->
- Deprecated `TruckOptions.withDefaults` constructor. Use the default constructor instead.
Deprecated `EVTruckOptions.withDefaults` constructor. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Deprecated methods to manipulate the focal length of the 'MapCamera'. Methods 'setFocalLength()' of class 'sdk.mapview.MapCameraUpdateFactory' and 'focalLength()' of class 'sdk.mapview.MapCameraKeyframeTrack'. Modify the field of view to achieve a similar visual change. <!-- IOTSDK-15220 -->
- Deprecated `Region.withAllDefaults` constructor. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Deprecated `GPXOptions.witDefaults()`. Use the unnamed constructor instead. <!-- IOTSDK-12061 -->
- Deprecated `ManeuverProgress.withDefaults` constructor. Use the default constructor instead. Deprecated `SectionProgress.withDefaults` constructor. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Deprecated `TransitSectionDetails.withDefaults` constructor. Use the unnamed constructor instead. <!-- IOTSDK-12062 -->
- Deprecated `GeoPlace.withDefaults` constructor. Use the default constructor instead. <!-- IOTSDK-12062 -->
- Deprecated `CellularPositioningOptions.withDefaults` constructor. Use the default constructor instead. Deprecated `SatellitePositioningOptions.withDefaults` constructor. Use the default constructor instead. Deprecated `WifiPositioningOptions.withDefaults` constructor. Use the default constructor instead.
Deprecated `NotificationOptions.withDefaults` constructor. Use the default constructor instead. Deprecated `SensorOptions.withDefaults` constructor. Use the default constructor instead. <!-- IOTSDK-12062 -->

#### Resolved Issues

- Unified maneuver list: `Maneuver` objects that are retrieved from `Navigator` or `VisualNavigator` are now identical to the ones retrieved from `Route.Section`. On top, the `maneuver.text` property is now guaranteed to be non-empty. The property is now also non-empty when using the `OfflineRoutingEngine`. The content of the `text` property has been aligned and, for example, the text no longer contains distance information. <!-- IOTSDK-8446 -->
- In rare cases, on some newer devices running Android 12 or higher, fast changes of the device orientation can lead to render problems. This is a known Flutter issue tracked [here](https://github.com/flutter/flutter/issues/89558). <!-- IOTSDK-13350 -->
- When all types of gesture actions are disabled using the `Gestures.disableDefaultAction(GestureType)` method the start of a gesture will no longer cancel ongoing camera animations. <!-- IOTSDK-14924 -->
- Disposing the `SDKNativeEngine` may not shut down ongoing `MapDownloader` requests. <!-- IOTSDK-14607 -->
- `READ_PHONE_STATE` permission is no longer needed on Android. <!-- POSTI-2495 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- The global offline switch `sdkNativeEngine.isOfflineMode()` does not load map tiles after enabling the online mode again or after restoring a lost network connection. As a workaround the map view has to be panned & zoomed a bit to activate the online mode again. <!-- OAM-1797 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` and `MapScene.Layers.trafficIncidents` are no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- PRCAT-33 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- When requesting toll cost for offline routing, then the axle count is used in a wrong way. As a workaround for implementation testing, but not production-safe: Double the axle count. <!-- IOTSDK-15075 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: `Signpost` SVG Strings contain an additional padding so that the SVG can be blended on top of a `JunctionView` asset. However, due to the padding it is currently not easily possible to show a trimmed `Signpost` asset without padding. Furthermore, the size of `JunctionView` assets is too large for mobile use - unless the data is preloaded as part of offline maps data. On top, other issues may appear when trying to render the SVG String as bitmap. <!-- IOTSDK-15272 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.11.0

#### New Features

- `GPXTrack`: Added `gpxTrack.getLocations()` to get all stored track points converted to a `Location` object. <!-- IOTSDK-14298 -->
- `LocationIndicator`: Added visual halo support to indicate the accuracy of the GPS signal. The default 3D assets have been updated. By default, the halo is not visualized. In this case the accuracy indicator has a fixed and zoom level independent size. For values smaller than 20 meters the halo is hidden. Enable the halo by setting the boolean property `LocationIndicator.isAccuracyVisualized`.
If enabled, `location.horizontalAccuracyInMeters` defines the size of the halo around the location indicator - after calling `locationIndicator.updateLocation(location)`. <!-- IOTSDK-9118 -->
- Exposed detailed information along a `Route` to know upcoming speed limits, street attributes, names, traffic and much more. For this, added `Span.sectionPolylineOffset`, `Span.dynamicSpeedInfo`, `Span.streetAttributes`, `Span.carAttributes`, `Span.truckAttributes`, `Span.scooterAttributes`, `Span.walkAttributes`, `Span.durationInSeconds`, `Span.streetNames`, `Span.routeNumbers`, `Span.speedLimitInMetersPerSecond`, `Span.consumptionInKilowattHours`, `Span.functionalRoadClass`, `Span.duration`, `Span.baseDuration`. A span defines the smallest part of a route segment and its curvature is exposed as a list of `GeoCoordinates`. <!-- IOTSDK-15007 -->
- This version of the HERE SDK is delivered with map data version 59. <!-- IOTSDK-15239 -->
- `MapUpdater`: It is now possible to define if `Region` updates including subregions are applied one-by-one (`MapUpdateVersionCommitPolicy.onFirstRegion`) or once the updates for all installed regions have been downloaded completely (`MapUpdateVersionCommitPolicy.onComplete`). This influences the required size of the storage during an update. By default, `MapUpdateVersionCommitPolicy.onComplete` is used. Set the policy via the new property `mapUpdater.versionCommitPolicy`. <!-- IOTSDK-13349 -->
- Added a way to filter the content shown for the `MapFeatures.trafficIncidents` layer on the map view: Added `MapContentSettings.filterTrafficIncidents(List<TrafficIncidentType> trafficIncidents)` method to filter the displayed traffic incidents and `MapContentSettings.resetTrafficIncidentFilter()` method to reset the applied traffic incident filter. <!-- IOTSDK-14742 -->

#### API Changes - Breaking

- Android: The HERE SDK is now using `compileSdkVersion` and `targetSdkVersion` 33 instead of 31. Apps should update the version in the app's `build.gradle` file. <!-- IOTSDK-14564 -->

#### API Changes - Deprecations

- Positioning: Deprecated 'LocationEngineStatus.notLicensed'. Check the feature availability instead via 'LocationStatusListener.onFeaturesNotAvailable()'. Deprecated 'LocationEngineStatus.notCompatible'. Use instead the status notification via 'LocationIssueListener'. <!-- HDGNSS-3798 -->

#### Resolved Issues

- Camera settings are now applied immediately after changing 'visualNavigator.cameraMode', 'fixedCameraBehavior.cameraDistanceInMeters', 'fixedCameraBehavior.cameraTiltInDegrees' or 'fixedCameraBehavior.cameraBearingInDegrees'. <!-- IOTSDK-15254 -->
- Navigation: For very long routes, the eat-up route progress visualization is sometimes not in sync with the `LocationIndicator`. <!-- IOTSDK-3873 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` and `MapScene.Layers.trafficIncidents` are no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- PRCAT-33 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- Disposing the `SDKNativeEngine` may not shut down ongoing `MapDownloader` requests. As a workaround, shut down pending requests yourself before disposing the HERE SDK. <!-- IOTSDK-14607 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: `Signpost` SVG Strings contain an additional padding so that the SVG can be blended on top of a `JunctionView` asset. However, due to the padding it is currently not easily possible to show a trimmed `Signpost` asset without padding. Furthermore, the size of `JunctionView` assets is too large for mobile use - unless the data is preloaded as part of offline maps data. <!-- IOTSDK-15272 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- In rare cases, on some newer devices running Android 12 or higher, fast changes of the device orientation can lead to render problems. This is a known Flutter issue tracked [here](https://github.com/flutter/flutter/issues/89558). <!-- IOTSDK-13350 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.10.0

#### New Features

- `RoutePrefetcher`: Added `prefetchCorridorLengthMeters` property to optionally configure the length of a corridor to prefetch. <!-- IOTSDK-12833 -->
- Positioning: Added new 'LocationIssueListener' to notify when a new a location issue has occurred. Added new enum 'LocationIssueType' to indicate the type of found issue. <!-- HDGNSS-3380 -->
- Navigation: Added `intersectionNames` property to `Maneuver` class to provide `LocalizedTexts` of a junction. These attributes are only provided when a maneuver is retrieved from `Navigator` or `VisualNavigator` during turn-by-turn navigation. Routes calculated with `OfflineRoutingEngine` are not supported. <!-- IOTSDK-10165 -->
- This version of the HERE SDK is delivered with map data version 57. <!-- IOTSDK-15091 -->
- Navigation: Route eat-up functionality is now enabled, by default: Added route progress visualization in `VisualNavigator` controlled by `routeProgressVisible` property. When enabled, the travelled part of the polyline and its outline will be rendered with gray colors. <!-- IOTSDK-3873 -->
- GPX: Added `addTrack()` method to `GPXDocument` to allow multiple tracks storage. <!-- IOTSDK-13791 -->
- Navigation: Added support for _signposts_ and _junction view_ images in SVG Standard 1.1 format. Use `visualNavigator.signpostWarningListener` and `visualNavigator.junctionViewWarningListener` to receive SVG assets as a String at complex junctions. Use `SignpostWarningOptions` and `JunctionViewWarningOptions` to specify, for example, the desired aspect ratio. Currently, signposts contain a padding, so that the asset can be optionally matched as overlay on a corresponding junction view asset. While signposts images are usually around 30 KB, junction views can occupy around 15 MB. Note that if the data was not loaded in time, the String will be empty. Therefore, it is recommended to preload the assets via feature configurations: Use "JUNCTION_VIEW_3X4", "JUNCTION_VIEW_16X9" to preload junction views and "JUNCTION_SIGN_3X4", "JUNCTION_SIGN_16X9" for signposts. To preload the data, the feature configuration has to bet set and then a `Region` has to be downloaded and installed. When driving in such a region, the assets are available for online and offline use. For future releases, we will reduce the level of realism to shrink the size of junction views. Currently, a lot of separate details like trees are used to compose a 3D image. By default, there is no native support for Strings in SVG Standard 1.1 format, so a third-party solution has to be used to render the SVGs. Note that this is a beta release of this feature and thus, there can be bugs and unexpected behavior and the feature is likely to change for upcoming releases without a deprecation process. <!-- IOTSDK-13639 -->

#### Resolved Issues

- Navigation: Fixed missing `ahead` event for `TruckRestrictionWarning` when the restriction does not start at the beginning of a segment. <!-- IOTSDK-14960 -->
- Navigation: Fixed missing `passed` event for `TruckRestrictionWarning` when consecutive, but not adjacent, segments contain the same truck restriction. <!-- IOTSDK-15008 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` and `MapScene.Layers.trafficIncidents` are no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- PRCAT-33 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Turn-by-turn navigation does not start when an offline maps update or download is happening in parallel. <!-- IOTSDK-1 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- Disposing the `SDKNativeEngine` may not shut down ongoing `MapDownloader` requests. As a workaround, shut down pending requests yourself before disposing the HERE SDK. <!-- IOTSDK-14607 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- Navigation: `Signpost` SVG Strings contain an additional padding so that the SVG can be blended on top of a `JunctionView` asset. However, due to the padding it is currently not easily possible to show a trimmed `Signpost` asset without padding. Furthermore, the size of `JunctionView` assets is too large for mobile use - unless the data is preloaded as part of offline maps data. <!-- IOTSDK-15272 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- In rare cases, on some newer devices running Android 12 or higher, fast changes of the device orientation can lead to render problems. This is a known Flutter issue tracked [here](https://github.com/flutter/flutter/issues/89558). <!-- IOTSDK-13350 -->
- Navigation: For very long routes, the eat-up route progress visualization is sometimes not in sync with the `LocationIndicator`. <!-- IOTSDK-3873 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.9.0

#### New Features

- Added bulk operation support for `MapPolylines`: Multiple lines can now be added / removed with `addMapPolylines(List<MapPolyline> mapPolylines)` and `removeMapPolylines(List<MapPolyline> mapPolylines)`. <!-- IOTSDK-12666 -->
- When using custom catalogs, then the new property 'CatalogConfiguration.cacheExpirationPeriod' allows to define for how long the catalog data is retained in the map cache before it is removed. If not set, the cache will be deleted on a Least Recently Used (LRU) basis. <!-- IOTSDK-13505 -->
- Navigation: Added _spatial audio trajectories_ to handle notification maneuvers that are happening shortly after each other. These trajectories are not affected by 'initialAzimuthInDegrees' or 'sweepAzimuthInDegrees' when calling 'startPanning()': Instead, a special case of panning trajectory will be triggered to better support such cases: For this, the audio cue is spatialized considering the action of both maneuvers - for example, the audio cue 'Now turn right and then turn left' will be spatialized as following: (1) 'Now turn right' will be heard as coming from the right. (2) 'and then turn left' will be heard as coming from the left. Note that the estimation for playing both audio cues may not be always fully accurate resulting in a slight mismatch between the audio source and the audio cue message. <!-- IOTSDK-10809 -->
- `SDKOptions.customEngineBaseUrls`: Added support for configurable URLs with the new enum value `EngineBaseURL.authentication` that can be used to specify custom URLs for authentication instead of the default URLs. Example URL (do not add endpoints): <!-- markdown-link-check-disable --> "https://account.api.yourcompany.com". <!-- markdown-link-check-enable --> <!-- IOTSDK-14819 -->
- Added the following feature configurations: "RENDERING": A basic set of rendering features such as Carto POIs. "TRAFFIC": Map data that provides traffic broadcast functionality using RDS-TMC format. It should be used when there is no internet connection, so that the routing module can utilize traffic data coming over the radio channel to create routes with the `OfflineRoutingEngine`. "EV": Offline map data for EV charging stations.  "TRUCK_SERVICE_ATTRIBUTES": Enables truck related attributes to be returned by `OfflineSearchEngine`.  "FUEL_STATION_ATTRIBUTES": Enables fuel attributes to be returned by `OfflineSearchEngine`. "OFFLINE_BUS_ROUTING": Map data that is used to calculate bus routes. When not set, the `OfflineRoutingEngine` may not be able to calculate routes with `BusOptions`. Note that the "RENDERING" layer is a base layer that cannot be disabled. See _optimization guide_ for more details. <!-- IOTSDK-14710 -->
- `MapFeatures.vehicleRestrictions`: The shown icons can now be picked from the map to get more details. Pick them from the map view with `pickMapContent()`. `pickMapContentResult.vehicleRestrictions` provides `PickMapContentResult.VehicleRestrictionResult`. See _carto_poi_picking_app_ example app for a possible usage scenario. Note that this is a beta release of this feature. <!-- IOTSDK-12288 -->
- Added `VehicleProfile` class to define the properties of a vehicle. In the future, this profile is planned to be used for routing. Right now, the profile is only relevant for users of the _Navigate Edition_. <!-- IOTSDK-14327 -->
- `SDKOptions.customEngineBaseUrls`: Added support for configurable endpoints with the new enum value `EngineBaseURL.DS_PROXY` that can be used to specify custom endpoints to set a _DS Proxy_ instead of the default endpoints. Example URL (with added endpoints): <!-- markdown-link-check-disable --> "https://data.api.platform.yourcompany.com/direct/v1/test". <!-- markdown-link-check-enable --> <!-- IOTSDK-14821 -->
- `MapMarker` clusters: The beta status for `MapMarkerCluster.ImageStyle`, `MapMarkerCluster.CounterStyle` and the related `MapMarkerCluster` constructor has been removed: The feature has become stable. <!-- IOTSDK-14241 -->
- Added new feature configurations to specify the default layer configuration. Added "JUNCTION_VIEW_3X4", "JUNCTION_VIEW_16X9", "JUNCTION_SIGN_3X4", "JUNCTION_SIGN_3X5", "JUNCTION_SIGN_4X3", "JUNCTION_SIGN_5X3", "JUNCTION_SIGN_16X9". These layers are disabled, by default. They contain data for the upcoming feature to support SVG image data for junction views and signpost views during navigation. Note that the image ratio is appended to the layer name. See **optimization guide** for more details. <!-- IOTSDK-14710 -->
- Added `sdkEngineAlreadyDisposed` to `InstantiationErrorCode` enum to indicate that `SDKNativeEngine.dispose()` was already called. <!-- IOTSDK-14910 -->

#### API Changes - Breaking

- `MapPolyline`: Removed the beta feature `AlphaBlendType` enum and the related property. <!-- HARP-19646 -->
- The default language in `ManeuverNotificationOptions` was changed from British to American English. <!-- IOTSDK-14900 -->

#### API Changes - Deprecations

- Navigation: Deprecated `Navigator.assumedTrackingTransportMode`. Use instead the newly introduced `Navigator.trackingTransportProfile` to set the newly introduced `VehicleProfile` for tracking mode. With this, speed limits will match the provided profile and effectively, truck speed limits can now be received as expected. <!-- IOTSDK-14327 -->
- `MapUpdater`: Deprecated `performMapUpdate()` and `checkMapUpdate()`. Use the newly introduced `updateCatalog()` and `retrieveCatalogsUpdateInfo()` instead. Both methods are released as beta. Internally, each downloadable `Region` is part of a catalog and regions cannot be updated individually, instead only the catalog or the cache can be updated as a whole. <!-- IOTSDK-15016 -->
- `MapCamera`: When setting `GeoCoordinates` for any camera operation such as `lookAt()` or `flyTo()`, then the `altitude` value will be ignored starting with release of HERE SDK 4.15.0 - for now, the value has been deprecated. <!-- HARP-19636 -->

#### Resolved Issues

- Navigation: Fixed high CPU/battery consumption when `VisualNavigator` is used. <!-- IOTSDK-15078 -->
- Navigation: In tracking mode, without following a `route`, the `TransportMode` is no longer ignored. Call the newly introduced `navigator.trackingTransportProfile` and set a `VehicleProfile` with e.g. `TRUCK` transport mode. By default, `CAR` is assumed. <!-- IOTSDK-14289 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` and `MapScene.Layers.trafficIncidents` are no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- PRCAT-33 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Turn-by-turn navigation does not start when an offline maps update or download is happening in parallel. <!-- IOTSDK-1 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- Disposing the `SDKNativeEngine` may not shut down ongoing `MapDownloader` requests. As a workaround, shut down pending requests yourself before disposing the HERE SDK. <!-- IOTSDK-14607 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- In rare cases, on some newer devices running Android 12 or higher, fast changes of the device orientation can lead to render problems. This is a known Flutter issue tracked [here](https://github.com/flutter/flutter/issues/89558). <!-- IOTSDK-13350 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->
- The classes `MapSurfaceHost.kt`, `MapViewHost.kt` and `MapViewHost.swift` are only meant for experimental use until further notice.<!-- IOTSDK-13528 -->

### Version 4.12.8.0

#### New Features

- The `HereMap` on Android now allows to use the _Hybrid Composition_ mode. By default, the _Virtual Display_ mode is still used. We expect, that in the future, the _Hybrid Composition_ mode will become the default mode. In order to use the _Hybrid Composition_ mode for native views, set the new optional constructor parameter `mode` when creating a `HereMap` like this: `HereMap(mode: NativeViewMode.hybridComposition, ...)`. The _Hybrid Composition_ mode is recommended for devices running Android 12 or higher. Note that it can cause performance impacts on lower Android versions. More information about _Hybrid Composition_ and _Virtual Display_ modes can be found [here](https://docs.flutter.dev/development/platform-integration/android/platform-views). <!-- IOTSDK-13350 -->
- Indoor Maps: Overloaded `venueEngine.startWithToken(String token)` to accept a custom  authentication token to start the `VenueEngine` for customers who can generate a project scope token. <!-- INDOOR-16112 -->
- Added `MapLoaderError.catalogConfigurationError`: This error may occur when a `CatalogConfiguration` is misconfigured and cannot be used for any operation with `MapDownloader` or `MapUpdater`. <!-- IOTSDK-14356 -->
- `VisualNavigator`: By default, the route polyline is now rendered with colored sections to highlight different transport modes (if any) - as listed in `SectionTransportMode`. <!-- IOTSDK-14760 -->
- Added animation support for `MapPolyline` instances. Now, they can be moved and the progress can be animated (for example, to animate a route-eat-up progress) - added static `MapPolylineAnimation` class to represent an animation that can be applied to a `MapPolyline` object. Added `startAnimation(MapPolylineAnimation animation, AnimationListener listener)` to `MapPolyline` to start an animation. Added `cancelAnimation(MapPolylineAnimation animation)` to `MapPolyline` to cancel an animation. Added `MapItemKeyFrameTrack polylineProgress(List<ScalarKeyframe> keyframes, EasingFunction easingFunction, KeyframeInterpolationMode interpolationMode)` to create a keyframe track for the progress property of a 'MapPolyline'. <!-- HARP-19604 -->
- `TruckRestrictionWarning`: Added `DistanceType.reached` to notify when a truck restriction has been reached. The event is followed by `passed`, when the restriction has been passed. If the restriction has no length, then `reached` is skipped and only a `passed` event is sent. Note that the `ahead` event is always sent first. Added now also support for `WeightRestrictionType.weightPerAxle`. If no restriction is set, then a general truck restriction applies: Added `TruckRestrictionWarningType.general`, for convenience. The _Navigation_ example app and the Developer Guide show a possible implementation. Note that the above features are released as beta. <!-- IOTSDK-14822 -->

#### API Changes - Breaking

- The minimum supported Xcode version was raised from Xcode 12.4 to Xcode 13.2.1. The minimum supported Mac OS version was raised from Catalina to Big Sur. Lower versions may still work, but are no longer guaranteed to work. Note that the minimum supported iOS version stays on 12.4. Effectively, this change was already introduced with HERE SDK 4.12.7.0. <!-- IOTSDK-14513 -->
- `TruckRestrictionWarning`: Changed the distance threshold when the `AHEAD` notification is sent.  In cities, the event is sent 500 m ahead (instead of 1000 m ahead). On rural roads, the event is sent 750 m ahead (instead of 1500 m ahead). And on highways, the event is sent 1500 m ahead (instead of 2000 m ahead). <!-- IOTSDK-14822 -->

#### Resolved Issues

- `TruckRestrictionWarning`: Warnings that are not on a `Route` path are now filtered out. Note that if a a driver deviates from a route, the warnings are still delivered. <!-- IOTSDK-14768 -->
- `OfflineRoutingEngine`: Fixed missing `SectionNotice` items for routes that have been calculated with `returnToRoute()`. <!-- IOTSDK-14603 -->
- `OfflineRoutingEngine`: The sequence of roundabout-related `ManeuverAction` instructions is now behaving like the (online) `RoutingEngine` - the sequence is now `left/rightRoundAboutEnter` followed by `left/rightRoundAboutEnterExit[1-12]`. <!-- IOTSDK-14485 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` and `MapScene.Layers.trafficIncidents` are no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- PRCAT-33 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Turn-by-turn navigation does not start when an offline maps update or download is happening in parallel. <!-- IOTSDK-1 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- Disposing the `SDKNativeEngine` may not shut down ongoing `MapDownloader` requests. As a workaround, shut down pending requests yourself before disposing the HERE SDK. <!-- IOTSDK-14607 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- Navigation: In tracking mode, without following a `route`, the `TransportMode` is ignored and falls back to `car`. Setting `navigator.assumedTransportMode` has no effect. And, for example, when receiving `SpeedLimit` events, they are only valid for cars. <!-- IOTSDK-14289 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- In rare cases, on some newer devices running Android 12 or higher, fast changes of the device orientation can lead to render problems. This is a known Flutter issue tracked [here](https://github.com/flutter/flutter/issues/89558). <!-- IOTSDK-13350 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.7.0

#### New Features

- Flutter 3.3.2 is now fully supported. Note that an upgrade to this version is _required_ in order to use this release of the HERE SDK. The HERE SDK will support only this Flutter version until further notice. Higher versions may also work, but are not guaranteed to work. Flutter 2.10.5 is no longer supported. Along with Flutter 3.3.2, also the supported Dart version was increased from 2.16.2 to 2.18.1. The HERE SDK plugin for iOS is now compiled with Xcode 13.2.1. <!-- IOTSDK-13525 -->
- `SearchEngine`: Added `connectorTypeId` to `EVChargingStation`. More information on the IDs and the corresponding type can be found [here](https://developer.here.com/documentation/charging-stations/dev_guide/topics/resource-type-connector-types.html). <!-- IOTSDK-14529 -->
- Added `HereMapController.secondaryLanguage` property to set and get a secondary map language to support places that can show dual labels. If the text for primary and secondary language is the same, then only the primary language will be shown. If a requested language is not supported, then the local language is used. For example, some cities in India show a dual label with Latin (English) & Hindi text - at the same time. <!-- HARP-19524 -->
- Added support for custom map data: Added `CatalogConfiguration`, which can be used to access default catalogs on the HERE platform, as well as custom catalogs such as for self-hosted or BYOD (bring your own data) use cases. Added `DesiredCatalog`, which provides an interface to identify a catalog on the HERE platform. A developer can specify the HERE Resource Name (HRN) for the catalog along with a `CatalogVersionHint` for the desired version. A custom `CatalogConfiguration` needs to be specified via `SDKOptions` before initializing the HERE SDK. Note: This is a beta release of this feature, so there could be a few bugs and unexpected behaviors. Related APIs may change for new releases without a deprecation process. <!-- IOTSDK-14186 -->
- Added `MapPolyline.progressOutlineColor` property to style the outline of the progress part of a polyline. <!-- HARP-18454 -->
- This version of the HERE SDK is delivered with map data version 54. <!-- IOTSDK-14428 -->
- Added support for auto-zoom during guidance: Added the new classes `CameraBehavior`, `FixedCameraBehavior` and `DynamicCameraBehavior`, and the new property `VisualNavigator.cameraBehavior`. Set `VisualNavigator.cameraBehavior` an instance of `DynamicCameraBehavior` to enable dynamic camera behavior (i.e. zooming in and out from maneuvers) duration navigation. Set `VisualNavigator.cameraBehavior` an instance of `FixedCameraBehavior` to track the location marker from a fixed distance, tilt and, optionally, bearing. Set `VisualNavigator.cameraBehavior` to `null` do disable any camera behavior. Furthermore, use `CameraBehavior.normalizedPrincipalPoint` to change the principal point used duration navigation. The default normalized principal point used by the `VisualNavigator` can be retrieved from an defaulted constructed instance of `FixedCameraBehavior`. <!-- IOTSDK-13702 -->
- The newly introduced `SDKNativeEngine.makeSharedInstance()` feature we have released with HERE SDK 4.12.1.0 is now fully workable. As a result, it is now possible to switch to the new way to _manually_ initialize the HERE SDK to avoid auto-initialization - as described in the Developer Guide. All accompanying example apps show the new initialization approach. <!-- IOTSDK-14635 -->
- TTS: Side of destination information is now supported for voice `ManeuverNotification` events. <!-- IOTSDK-9989 -->
- Indoor Maps: Added `venueinfoList` which returns a list of venues. The list is accessible from a `VenueMap` and it contains `VenueInfo` elements containing a venue identifier, a venue ID and a venue name. <!-- INDOOR-16113 -->

#### API Changes - Breaking

- `VisualNavigator` now uses the same colors as the HERE WeGo app for routes. Also, the bicycle route color has been aligned. <!-- IOTSDK-14642 -->

#### API Changes - Deprecations

- Deprecated `CameraMode`, `CameraSettings`, `VisualNavigator.cameraMode` and `VisualNavigator.cameraSettings`. They will be removed in version 4.15.0. Use `CameraBehavior` and `VisualNavigator.cameraBehavior` instead. <!-- IOTSDK-13702 -->

#### Resolved Issues

- `MapPolyline` instances no longer interprete an alpha color setting of 0.0 as fully opaque. <!-- IOTSDK-14645 -->
- Navigation: Fixed missing `passed` notification when `ahead` notification is sent in tracking mode and then a route set to the navigator. <!-- IOTSDK-14576 -->
- Improved the `VisualNavigator` to not redraw on the map view when the provided `Location` update is not changing. <!-- IOTSDK-13218 -->

#### Known Issues

- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` and `MapScene.Layers.trafficIncidents` are no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- PRCAT-33 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Turn-by-turn navigation does not start when an offline maps update or download is happening in parallel. <!-- IOTSDK-14141 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- Disposing the `SDKNativeEngine` may not shut down ongoing `MapDownloader` requests. As a workaround, shut down pending requests yourself before disposing the HERE SDK. <!-- IOTSDK-14607 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- Navigation: In tracking mode, without following a `route`, the `TransportMode` is ignored and falls back to `car`. Setting `navigator.assumedTransportMode` has no effect. And, for example, when receiving `SpeedLimit` events, they are only valid for cars. <!-- IOTSDK-14289 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.6.0

#### New Features

- Navigation: Added maneuver instructions for Catalan. <!-- IOTSDK-14446 -->
- Added `AlphaBlendType` enum and the property `MapPolyline.alphaBlendType: AlphaBlendType`. The `AlphaBlendType` specifies how translucent `MapPolyline` instances are rendered on top of each other. The default type is `OVERWRITE`. Note that this is a beta release of this feature. <!-- HARP-19498 -->
- Search: Added `CategoryQuery.fuelTypes` and `TextQuery.fuelTypes`, which can be used to filter `FuelStation` results based on available fuel types. Added also `TextQuery.truckFuelTypes` and `CategoryQuery.truckFuelTypes`, which can be used to filter `FuelStation` results based on available truck fuel types. <!-- IOTSDK-14287 -->
- Added `MapPolyline.progress` and `MapPolyline.progressColor` properties to style two parts of a polyline with different colors. <!-- HARP-18454 -->
- Added `CategoryQuery.truckClass` and `TextQuery.truckClass`, which can be used to filter `FuelStation` results with the minimum supported `TruckClass`. This filter is only available for use with the `SearchEngine`. The `OfflineSearchEngine` (not available for all editions) ignores this filter. <!-- IOTSDK-14287 -->
- Expose new feature `OFFLINE_BUS_ROUTING` in the `sdk.core.engine.LayerConfiguration` that adds support to `OfflineRountingEngine` to calculate routes with `BusOptions`. Attention: Without this feature, bus routes cannot be calculated offline. <!-- IOTSDK-14352 -->
- Indoor Maps: Setting a HRN value has been made optional. If a HRN is not provided, then the default collection will be selected automatically. The default collection implies the collection which has all published indoor venue maps for a realm. Note that a user can still change a HRN via `VenueService.setHrn(String hrn)`. <!-- INDOOR-16668 -->
- Added `RoutePlace.sideOfDestination` to identify the side of a street where the destination waypoint resides. <!-- IOTSDK-9989 -->
- Map style update: Optimized the map view representation for `MapScheme.hybridDay` and `MapScheme.hybridNight`: The day and night schemes have been unified and the readability has been improved. <!-- HARP-19471 -->

#### API Changes - Deprecations

- Deprecated `MapFeatureModes.trafficFlowRegionSpecific`, it will be removed in version 4.15.0. Use the newly introduced `MapFeatureModes.trafficFlowJapanWithoutFreeFlow` instead, if you are using the rich map for Japan. This is the adapted mode for Japan based on  `trafficFlowWithoutFreeFlow` to exclude green lines for no traffic. <!-- IOTSDK-14172 -->

#### Resolved Issues

- Navigation: Fixed a crash that may occur when receiving `SpeedLimit` events. <!-- IOTSDK-14562 -->
- `RoutingEngine`: The `importRoute()` feature via a list of `Locations` can be used now as expected. <!-- BAMSUPP-2008 -->
- Offline Maps: `MapDownloader` now accurately reflects the size of `Region` downloads based on the current "feature_configuration". <!-- IOTSDK-13781 -->
- When using the `RoadSignWarningListener`, then setting or getting `RoadSignWarningOptions` is now functional. <!-- IOTSDK-14344 -->
- `MapPolyline` instances no longer ignore alpha color settings. <!-- IOTSDK-5364 -->
- Navigation: If the voice package language is set to `ja-JP`, the voice notification will include direction information (street name, route name, signpost information) in Hiragana form to avoid wrong interpretation of Kanji characters by the internal TTS engine. <!-- IOTSDK-14023 -->
- Navigation: Improved TTS maneuver notifications for Italian and Spanish. <!-- IOTSDK-12722 -->

#### Known Issues

- Sometimes, a crash may happen for turn-by-turn navigation, when a segment with a _ferry_ set as `TransportMode` is ahead. <!-- OLPSUP-19585 -->
- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- Since HERE SDK 4.12.1.0, the newly introduced `SDKNativeEngine.makeSharedInstance()` feature is not workable yet. As a result, it is not possible yet to switch to the new way to manually initialize the HERE SDK to avoid auto-initialization - as described in the Developer Guide. All example apps still show the old initialization. <!-- IOTSDK-14635 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` and `MapScene.Layers.trafficIncidents` are no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- PRCAT-33 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Turn-by-turn navigation does not start when an offline maps update or download is happening in parallel. <!-- IOTSDK-14141 -->
- Currently, Flutter 3.x is _not yet_ supported due to a [known issue with platform views](https://github.com/flutter/flutter/issues/103630). For an upcoming release, we are planning to integrate Flutter 3.3.2 that contains a possible fix for this problem. Once the HERE SDK supports Flutter 3.3.2, an upgrade to this version is required in order to use this version of the HERE SDK. Note that the HERE SDK will then only support one Flutter version until further notice. The currently supported minimum and latest Flutter version will be no longer compatible. <!-- IOTSDK-13525 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- Disposing the `SDKNativeEngine` may not shut down ongoing `MapDownloader` requests. As a workaround, shut down pending requests yourself before disposing the HERE SDK. <!-- IOTSDK-14607 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- `MapPolyline` instances interprete an alpha color setting of 0.0 as fully opaque. As a workaround, set an alpha value of 0.01 to make the polyline translucent. Non-zero alpha values work as expected. <!-- IOTSDK-14645 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- Navigation: In tracking mode, without following a `route`, the `TransportMode` is ignored and falls back to `car`. Setting `navigator.assumedTransportMode` has no effect. And, for example, when receiving `SpeedLimit` events, they are only valid for cars. <!-- IOTSDK-14289 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.5.0

#### New Features

- Added `MapFeatures.environmentalZones` and `MapFeatureModes.environmentalZonesAll`. <!-- IOTSDK-13902 -->
- Added `MapFeatures.congestionZones` and `MapFeatureModes.congestionZonesAll`. <!-- IOTSDK-14302 -->
- All map view features now have a named default mode. Constants for those were added to `MapFeatureModes`: `buildingFootprintsAll`, `extrudedBuildingsAll`, `environmentalZonesAll`, `trafficIncidentsAll`, `safetyCamerasAll` (only available for the _Navigate Edition_). <!-- IOTSDK-14172 -->
- Added a `CameraSettings` property to control the principal point position during visual navigation. <!-- PBJIRA-2715 -->
- `SearchEngine`: Added the property `Details.fuelStation` that contains fuel station attributes. Added struct `sdk.search.FuelStation`,`sdk.search.FuelAdditive`, `sdk.search.GenericFuel`, `sdk.search.TruckFuel`. Currently it is supported only for online search. It can be enabled by adding `show=fuel` as custom option. This is a beta feature and thus subject to change. <!-- IOTSDK-13264 -->
- Optimized the map view representation for extruded buildings and building footprints across zoom levels. <!-- HARP-8049 -->

#### API Changes - Deprecations

- Indoor Maps: Deprecated all functions in `venues` which used a feature ID as integer. It is recommended to use functions which accept a feature ID as string. For example, instead of `getID()`, use `getIdentifier()` and instead of `getGeometryById(int id)`, use `getGeometryById(String id)`. <!-- INDOOR-16669 -->

#### Resolved Issues

- Lane assistance is now supported also for the `bus` transport mode. <!-- IOTSDK-14014 -->

#### Known Issues

- Sometimes, a crash may happen for turn-by-turn navigation, when a segment with a _ferry_ set as `TransportMode` is ahead. <!-- OLPSUP-19585 -->
- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- When using the `RoadSignWarningListener`, then setting or getting `RoadSignWarningOptions` is non-functional for now. Setting these options has no effect. <!-- IOTSDK-14344 -->
- Since HERE SDK 4.12.1.0, the newly introduced `SDKNativeEngine.makeSharedInstance()` feature is not workable yet. As a result, it is not possible yet to switch to the new way to manually initialize the HERE SDK to avoid auto-initialization - as described in the Developer Guide. All example apps still show the old initialization. <!-- IOTSDK-13921 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` is no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- IOTSDK-1 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Turn-by-turn navigation does not start until an offline maps update or download is happening in parallel. <!-- IOTSDK-14141 -->
- Currently, Flutter 3.x is _not yet_ supported due to a [known issue with platform views](https://github.com/flutter/flutter/issues/103630). For an upcoming release, we are planning to integrate Flutter 3.3.2 that contains a possible fix for this problem. Once the HERE SDK supports Flutter 3.3.2, an upgrade to this version is required in order to use this version of the HERE SDK. Note that the HERE SDK will then only support one Flutter version until further notice. The currently supported minimum and latest Flutter version will be no longer compatible. <!-- IOTSDK-13525 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Navigation: In tracking mode, without following a `route`, the `TransportMode` is ignored and falls back to `car`. Setting `navigator.assumedTransportMode` has no effect. And, for example, when receiving `SpeedLimit` events, they are only valid for cars. <!-- IOTSDK-14289 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The `importRoute()` feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- BAMSUPP-2008 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.4.0

#### New Features

- Indoor maps: Added overloaded versions for `selectVenueAsyncWithErrors(int venueId, VenueLoadErrorCallback callback)` and `addVenueAsyncWithErrors(int venueId, VenueLoadErrorCallback callback)` to propagate errors occuring during loading of venues. Errors occuring during venue load can be captured with the callback. Please refer to the example app for a usage example. <!-- INDOOR-16448 -->
- Indoor maps: Added `getIdentifier()` for `Structure`, `Level`, `Geometry` and `Entity` which returns the ID for these features as a string. Also added related overloaded functions like `getGeometryByIdentifier(String geometryId)`. <!-- INDOOR-16390 -->
- Navigation: Along a road you can find many shields. Now you can get notified on all these shields while driving: Added a warner for road signs on the route with `RoadSignWarningListener`. The resulting `RoadSignWarning` event contains detailed information on the shield, including `RoadSignType` and `RoadSignCategory`. By default, the event will be fired with the same distance threshold as for other warners: On highways, the event is fired 2000 meters ahead, on rural roads 1500 meters ahead and in cities 1000 meters ahead. With `RoadSignWarningOptions` you can set a filter. Note that for now, setting `RoadSignWarningOptions` has no effect due to a known issue - see below. <!-- IOTSDK-13173 -->
- Added `enterHighwayFromLeft` and `enterHighwayFromRight` values to `ManeuverAction` enum. They indicate the maneuver action for a driver to perfom on entering a highway either from the left or right side. These enum values are only generated when setting the `enableEnterHighwayManeuverAction` flag in `RouteOptions` to true. By default, the flag is set to false. With HERE SDK 4.14.0 we plan to set it to true, by default. <!-- IOTSDK-13199 -->
- Added `AreaType` enum which represents the type of an area such as country, state or district. Added property `Place.areaType` which gets the area type for the respective `Place`. <!-- IOTSDK-7592 -->
- Navigation: It is now possible to unsubscribe from continuously prefetching map data by calling `routePrefetcher.stopPrefetchAroundRoute()`. <!-- IOTSDK-13549 -->
- Added `EVChargingStation.hasFixedCable` field to know if a charging station for electric vehicles supports fixed cables. <!-- IOTSDK-14196 -->

#### Resolved Issues

- Increased size limit from 10000 to 50000 for `routingEngine.importRoute()` when setting a list of `Location` points. <!-- IOTSDK-14102 -->
- `RoutingEngine`: Improved the time to calculate `Route` results for very large routes. <!-- IOTSDK-13756 -->
- `MapDownloader`: It is now possible to delete a `Region` when another download was interrupted. <!-- IOTSDK-13440 -->
- Fixed high number of mountain peak labels on the map of USA to improve the performance and map readability. For this, the `MapUpdater` needs to be used to update to map version 48 or higher. <!-- IOTSDK-13855 -->
- The sequence of roundabout-related `ManeuverAction` values is now `left/rightRoundaboutEnter` followed by `left/rightRoundaboutEnterExit[1-12]`. It was previously `left/rightRoundaboutEnterExit[1-12]` followed by `left/rightTurn`. <!-- IOTSDK-13662 -->
- `RoutingEngine`: Fixed missing toll information for bus or taxi online routes. <!-- IOTSDK-12676 -->

#### Known Issues

- Sometimes, a crash may happen for turn-by-turn navigation, when a segment with a _ferry_ set as `TransportMode` is ahead. <!-- OLPSUP-19585 -->
- Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- When using the `RoadSignWarningListener`, then setting or getting `RoadSignWarningOptions` is non-functional for now. Setting these options has no effect. <!-- IOTSDK-14344 -->
- Since HERE SDK 4.12.1.0, the newly introduced `SDKNativeEngine.makeSharedInstance()` feature is not workable yet. As a result, it is not possible yet to switch to the new way to manually initialize the HERE SDK to avoid auto-initialization - as described in the Developer Guide. All example apps still show the old initialization. <!-- IOTSDK-13921 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` is no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- IOTSDK-1 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Turn-by-turn navigation does not start until an offline maps update or download is happening in parallel. <!-- IOTSDK-14141 -->
- Currently, Flutter 3.0 is not yet supported due to a [known issue with platform views](https://github.com/flutter/flutter/issues/103630). We are planning to integrate a possible [fix](https://github.com/flutter/engine/pull/33599) for the Flutter engine. Once the HERE SDK supports Flutter 3.x an upgrade to Flutter 3.x is required. The currently supported minimum and latest Flutter version will be no longer compatible. <!-- IOTSDK-13525 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Navigation: In tracking mode, without following a `route`, the `TransportMode` is ignored and falls back to `car`. Setting `navigator.assumedTransportMode` has no effect. And, for example, when receiving `SpeedLimit` events, they are only valid for cars. <!-- IOTSDK-14289 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The `importRoute()` feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- BAMSUPP-2008 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.3.0

#### New Features

- Introduced a new `MapMarkerCluster.CounterStyle` that indicates the number of contained `MapMarker` items in a cluster. The style allows various options to customize how this will be rendered on top of a cluster image. A new `MapMarkerCluster()` constructer has been added to set the style. In addition, an `Anchor2D` can be used to position the counter and the cluster image. An usage example can be found in the `map_items_app` example. Note that this is a beta release of this feature. <!-- IOTSDK-10207 -->
- The latest supported Flutter version was raised from 2.10.2. to 2.10.5. The latest supported Dart version was raised from 2.16.1. to 2.16.2. - note that Flutter 3.x is not yet supported and cannot be used. The minimum supported Flutter and Dart versions have not been changed. <!-- IOTSDK-14057 -->
- `OfflineSearchEngine`: The newly introduced `TruckAmenities` feature is enabled by default for all offline search requests. This is a beta release of this feature. <!-- IOTSDK-13263 -->
- Added `CategoryQuery.includeChains` and `CategoryQuery.excludeChains` that support search filtering by [chains](https://developer.here.com/documentation/geocoding-search-api/dev_guide/topics-places/places-chain-system-full.html). <!-- IOTSDK-14080 -->
- Labels for indoor maps can now be modified with `venueService.setLabelTextPreference()` that defines what content is shown for text labels on an indoor map. <!-- INDOOR-16308 -->
- The properties for `EVChargingPoolDetails` and `EVChargingStation` have been extended. Such information is available when using the online `SearchEngine` and the `OfflineSearchEngine` (for users of the _Navigate Edition_). <!-- IOTSDK-13786 -->
- `SearchEngine`: Added `TruckAmenities` to the `Details` of a `Place` to inform on amenities such as truck wash or the number of available showers. Currently, this is supported only for online search. For now, this can be enabled by calling `searchEngine.setCustomOption()` with "show" as `name` and "truck" as `value`. This is a beta release of this feature. <!-- IOTSDK-13263 -->
- This version of the HERE SDK is delivered with map data version 49. <!-- IOTSDK-14092 -->
- Traffic broadcast: Added `TMCServiceInterface.onTMCEntered()` to resolve blocking calls when `TrafficBroadcast.onTMCDataUpdated()` is called. <!-- IOTSDK-13177 -->

#### API Changes - Breaking

- Search for EV charging stations: Moved and renamed `Place.Details.EVChargingStationAttributes` to `Place.Details.EVChargingPool.EVChargingPoolDetails`. <!-- IOTSDK-13786 -->
- `MapFeatureModes.trafficFlowRegionSpecific` is only rendered for credentials that enable detailed map data for Japan. By default, use `MapFeatureModes.trafficFlowWithFreeFlow` instead. <!-- IOTSDK-13903 -->
- Removed the previously deprecated `MilestoneReachedListener`. Use instead the `MilestoneStatusListener`. <!-- IOTSDK-13948 -->

#### API Changes - Deprecations

- Deprecated `TextQuery.includeChains` and `TextQuery.excludeChains`. Please use `CategoryQuery.includeChains` and `CategoryQuery.excludeChains` instead. <!-- IOTSDK-14080 -->

#### Resolved Issues

- `OfflineRoutingEngine`: Fixed missing walk sections for offline bicycle routing. <!-- IOTSDK-14042 -->
- Navigation: Fixed an issue with `Route` data that was not considered correctly by some listeners for events such as `SafetyCameraWarning` or `TruckRestrictionWarning`. <!-- IOTSDK-13205 -->
- Fixed `JunctionViewLaneAssistance` events that sometime were triggered too early when approaching a complex junction. <!-- IOTSDK-13982 -->
- It is now possible to update the map cache to a newer map version - independently of offline maps. By calling `mapUpdater.performMapUpdate()` the map cache will be updated to a newer version (if available) - even if never any `Region` was installed. If offline maps are available, then they will be updated together with the map cache, like before. If offline maps are installed later after the cache has been updated, the same map version will be used. It is not possible to use different versions for the map cache and offline maps. Note that with HERE SDK 4.12.2.0 or earlier, it was not possible to update the map cache alone when no offline maps data was installed beforehand. <!-- IOTSDK-12041 -->

#### Known Issues

- Sometimes, a crash may happen for turn-by-turn navigation, when a segment with a _ferry_ set as `TransportMode` is ahead. <!-- OLPSUP-19585 -->
- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` is no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- IOTSDK-1 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Turn-by-turn navigation does not start until an offline maps update or download is happening in parallel. <!-- IOTSDK-14141 -->
- Currently, Flutter 3.0 is not yet supported due to a [known issue with platform views](https://github.com/flutter/flutter/issues/103630). We are planning to integrate a possible [fix](https://github.com/flutter/engine/pull/33599) for the Flutter engine. Once the HERE SDK supports Flutter 3.x an upgrade to Flutter 3.x is required. The currently supported minimum and latest Flutter version will be no longer compatible. <!-- IOTSDK-13525 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- `MapDownloader`: It is not possible to delete a `Region` when another download was interrupted. Workaround: The app needs to be restarted. <!-- IOTSDK-13440 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Indoor maps: Due to a HERE platform issue with credentials handling, indoor maps cannot be rendered together with the default map schemes. For now, only the indoor map can be seen, while the background with the map view stays gray. This issue only appears when you attempt to use indoor maps. <!-- OLPSUP-18243 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- The newly introduced `TruckAmenities` feature is not highlighted as a beta API in the API Reference. <!-- IOTSDK-14199 -->
- An unexpected large number of mountain peak labels is present on the map of USA, which reduces map readability and to a smaller extent performance. <!-- IOTSDK-13855 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- PBJIRA-2012 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.2.0

#### New Features

- Search `Details` now contain `EVChargingStationAttributes` - if applicable for a `Place`. <!-- IOTSDK-13786 -->
- Added a `TrafficDataProvider` interface that allows to integrate radio station signals providing traffic broadcasts. A `TrafficBroadcast` is expecting the [RDS-TMC](https://en.wikipedia.org/wiki/Traffic_message_channel) format and it can be used when there is no internet connection, so that the `OfflineRoutingEngine` can utilize traffic data coming over the radio channel. The `activate()` method needs to be called to receive traffic data events. This class continuously reacts to new locations provided from a location source and acts as a `LocationListener`. The location must be updated regardless of calling `activate()`. In order to adopt the interface special hardware is required. Talk to your HERE representative for more details. This is released as a beta feature. <!-- IOTSDK-13177 -->

#### API Changes - Breaking

- Added support for `RoutePrefetcher` to `VisualNavigator`. Previously, the feature was only available for the `Navigator`. Replaced `Navigator` with `NavigatorInterface` in `RoutePrefetcher`. <!-- IOTSDK-13663 -->
- Removed `connectorTypeId` from the search type `EVChargingStation`. The API is still in beta state. <!-- IOTSDK-13786 -->

#### Resolved Issues

- Fixed: Using `JunctionViewLaneAssistance` can slow down the time until guidance starts when no suitable map data is available in the cache. <!-- IOTSDK-13749 -->
- `OfflineSearchEngine`: Corrected the allowed range of `SearchOptions.maxItems` to [1, 100]. When not set, results will be limited to 20, by default (previously it was 5). This applies also to auto suggestion results. <!-- IOTSDK-13617 -->
- `SearchEngine`: Corrected the allowed range of `SearchOptions.maxItems` to [1, 100]. When not set, results will be limited to 20, by default. This applies also to auto suggestion results. <!-- IOTSDK-13617 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` is no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- IOTSDK-1 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Currently, Flutter 3.0 is not yet supported due to a [known issue with platform views](https://github.com/flutter/flutter/issues/103630). We are awaiting a possible [fix](https://github.com/flutter/engine/pull/33599) for the Flutter engine. <!-- IOTSDK-13525 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- `MapDownloader`: It is not possible to delete a `Region` when another download was interrupted. Workaround: The app needs to be restarted. <!-- IOTSDK-13440 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- An unexpected large number of mountain peak labels is present on the map of USA, which reduces map readability and to a smaller extent performance. <!-- IOTSDK-13855 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- PBJIRA-2012 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.1.0

#### New Features

- EV routing: Added `PostAction.chargingDetails` to get `ChargingActionDetails`, which supports additional parameters for EV charging such as `arrivalChargeInKilowattHours` and `targetChargeInKilowattHours`. The latter indicates the kWh level to which a vehicle's battery should be charged at a stop. <!-- IOTSDK-13551 -->
- Added support for our new web-based unified [HERE Style Editor](https://platform.here.com/style-editor/) that is available on the HERE platform. With the HERE Style Editor you can create highly [customizable map styles](https://developer.here.com/documentation/flutter-sdk-navigate/dev_guide/topics/custom-map-styles.html#create-and-load-custom-map-styles). Note that custom map styles that have been made with the legacy desktop editor need to be migrated to the new HERE Style Editor format. [Get in touch](https://www.here.com/contact) with your HERE representative to convert your existing styles. The HERE Style Editor is available via self-serve on the HERE platform. <!-- IOTSDK-1000 -->
- Replaced `MapScene.Layers` with a more flexible solution: All map layers can now be enabled or disabled as `MapFeatures` specifying one ore more `MapFeatureModes`. Pass a map of key / value pairs to the new `MapScene` method `void enableFeatures(Map<String, String> features)`. Hide a layer via `void disableFeatures(List<String> features)`. Query supported map features via `Map<String, List<String>> getSupportedFeatures()` and check currently active map features with `Map<String, String> getActiveFeatures()`. Note that this is a beta release of this feature. <!-- IOTSDK-13580 -->
- Guidance: Added `EXIT_ROUNDABOUT` as first maneuver when starting in a roundabout. <!-- IOTSDK-9393 -->
- This version of the HERE SDK is delivered with map data version 47. <!-- IOTSDK-13788 -->
- Added a simplified way to initialize the HERE SDK manually. Using the default automatic initialization is still possible, but has been deprecated. Added `SDKNativeEngine.makeSharedInstance()` to safely initialize a shared instance of the  `SDKNativeEngine`. Calling this method also gracefully destroys any previous instance (if any). In order to deactivate auto-init, it is also required to remove credentials from `AndroidManifest` or `plist` and to set them instead via `SDKOptions`. As a result, the HERE SDK SDK will not be created automatically at startup. <!-- IOTSDK-12047 -->
- Search: Added `TextQuery.includeChains` and `TextQuery.excludeChains` that support search filtering by adding a list of `PlaceChain` items. More information on chain IDs that correlate to specific places such as shops or stores can be found [here](https://developer.here.com/documentation/geocoding-search-api/dev_guide/topics-places/places-chain-system-full.html). <!-- IOTSDK-13719 -->
- Added map layer options for truck related vehicle restrictions. Added class `MapContentSettings` to Navigate variant, with the following methods:
`void filterVehicleRestrictions(TruckSpecifications truckSpecifications, List<HazardousMaterial> hazardousMaterials, TunnelCategory tunnelCategory)`
`void resetVehicleRestrictionFilter()`
which controls filtering of displayed vehicle restrictions on the map when the `MapScene.Layers.VEHICLE_RESTRICTIONS` layer is visible. Note that this is a beta release of this feature. <!-- IOTSDK-12860 -->

#### API Changes - Breaking

- Removed the previously deprecated `DynamicRoutingEngineListener`. User instead `DynamicRoutingListener`. <!-- IOTSDK-13762 -->

#### API Changes - Deprecations

- In rare cases an application using the HERE SDK may crash due to a `Storage.LevelDB` error or the initialization of the HERE SDK may fail with a `failedToLockCacheFolder` error. Added the class 'LockingProcess' and related functionality to prevent such crashes. <!-- IOTSDK-12047 -->
- Deprecated all constants defined in `MapScene.Layers`. Instead of using those constants with `MapScene.setLayerVisibility()`, use the newly introduced `MapScene.enableFeatures()` and `MapScene.disableFeatures()` with the constants from `MapFeatures` and `MapFeatureModes`. Note that unlike layer visibility state, a map feature state is reset on `loadScene()`. <!-- IOTSDK-13668 -->
- Online `RoutingEngine`: Deprecated `RoadFeatures.DIFFICULT_TURNS`. Use instead `RoadFeatures.U_TURNS`. <!-- IOTSDK-12531 -->

#### Resolved Issues

- The response time to calculate routes with the `RoutingEngine` has been heavily improved. <!-- IOTSDK-13756 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` is no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- IOTSDK-1 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Currently, Flutter 3.0 is not yet supported due to a [known issue with platform views](https://github.com/flutter/flutter/issues/103630). We are awaiting a possible [fix](https://github.com/flutter/engine/pull/33599) for the Flutter engine. <!-- IOTSDK-13525 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- `MapDownloader`: It is not possible to delete a `Region` when another download was interrupted. Workaround: The app needs to be restarted. <!-- IOTSDK-13440 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- Using `JunctionViewLaneAssistance` can slow down the time until guidance starts when no suitable map data is available in the cache. <!-- IOTSDK-13749 -->
- An unexpected large number of mountain peak labels is present on the map of USA, which reduces map readability and to a smaller extent performance. <!-- IOTSDK-13855 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- PBJIRA-2012 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.12.0.0

#### New Features

- We have launched a web-based [HERE Style Editor](https://platform.here.com/style-editor/) to create custom map styles. The editor will be available for use with the upcoming release of **HERE SDK 4.12.1.0**. <!-- IOTSDK-1000 -->
- This version of the HERE SDK is delivered with map data version 45. <!-- IOTSDK-13621 -->

#### API Changes - Breaking

- Removed previously deprecated `MapScene.setLayerState(String layerName, MapSceneLayerState newState)`. Use `MapScene.setLayerVisibility(...)` instead. Removed previously deprecated enum `MapSceneLayerState`, use `VisibilityState` instead. <!-- IOTSDK-11528 -->
- Removed the previously deprecated `MapCamera.animateToAreaWithGeoOrientationAndViewRectangle(GeoBox target, GeoOrientationUpdate orientation, Rectangle2D viewRectangle, int durationInMs)` method. Use one of the other available methods instead. <!-- IOTSDK-11326 -->
- The style for `MapScheme.normalNight` has been updated to improve readability: Increased brightness, saturation and contrast and reduced the number of different color tones. <!-- HARP-16820 -->
- A new web-based unified [HERE Style Editor](https://platform.here.com/style-editor/) was made available on the HERE platform. The editor will be available for use with the upcoming release of **HERE SDK 4.12.1.0**. It is compatible with the [Maps API for JavaScript (JSAPI)](https://developer.here.com/develop/javascript-api) and the HERE SDK. Custom map styles that have been made with the legacy desktop editor need to be migrated to the new HERE Style Editor format. [Get in touch](https://www.here.com/contact) with your HERE representative to discuss potential style updates until then. HERE SDK 4.12.0.0 is the last release that supports the old desktop format. <!-- IOTSDK-1000 -->
- Instantiation of `VenueEngine` requires now to catch a `InstantiationErrorException`. <!-- INDOOR-16124 -->
- Monthly active users (MAU) are no longer counted when the HERE SDK is initialized. Instead, only usage counts, for example, when a `MapView` is shown, or when any engine like `SearchEngine`, `RoutingEngine` or any other engine - including `MapDownloader`, `RoutePrefetcher`, `Navigator` and `VisualNavigator` (for users of the _Navigate Edition_) - is _instantiated_. If credentials are changed at runtime, then usage is counted again. <!-- IOTSDK-12843 -->

#### API Changes - Deprecations

- Deprecated `Accomodation`, `AccomodationHotelMotel` and `AccomodationLodging` constants in `PlaceCategory`. Use the newly added `Accommodation`, `AccommodationHotelMotel` and `AccommodationLodging` constants instead. <!-- IOTSDK-13360 -->
- The `MapLoaderError.tooManyRequests` error code has been renamed and deprecated. Use instead the newly introduced `MapLoaderError.requestLimitReached` error code. <!-- IOTSDK-8497 -->

#### Resolved Issues

- Fixed backwards movement of `LocationIndicator` for `VisualNavigator` when spans with zero length were present in a `Route`. <!-- IOTSDK-13533 -->
- Fixed redundant U-turn maneuvers that can happen sometimes for _bicycle_ routes that have been created with the `OfflineRoutingEngine`. <!-- IOTSDK-13653 -->
- Calling `SpatialManeuverAudioCuePanning.startPanning(null)` does now work correctly. It is no longer necessary to call the method with `CustomPanningData(null, null, null)` as parameter as workaround. <!-- IOTSDK-13565 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` is no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- IOTSDK-1 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Currently, Flutter 3.0 is not yet supported due to a [known issue with platform views](https://github.com/flutter/flutter/issues/103630). We are awaiting a possible [fix](https://github.com/flutter/engine/pull/33599) for the Flutter engine. <!-- IOTSDK-13525 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- `MapDownloader`: It is not possible to delete a `Region` when another download was interrupted. Workaround: The app needs to be restarted. <!-- IOTSDK-13440 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- PBJIRA-2012 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.11.4.0

#### New Features

- Positioning: Added `LocationTechnology` to indicate the technology or the provider of a location update that was received with the `LocationEngine`. Added optional `locationTechnology` field to `Location` class. Added optional `gnssTime` to `Location` class to provide another time format at which a location was determined. <!-- HDGNSS-3251 -->
- This version of the HERE SDK is delivered with map data version 44. <!-- IOTSDK-13213 -->
- Navigation: Enhanced the `MapMatchedLocation` class with `segmentReference`, `segmentOffset` and `confidence` - which ranges between 0 (poor accuracy) and 1 (best accuracy). Added `localId` and `tilePartition_id` to `SegmentReference`. `SegmentReference` is released as a beta feature to support upcoming features. <!-- COLUMBUS-138 -->
- A `Route` contains now indexes for traffic incidents: Added `getTrafficIncidentIndexes()` to `Span`. The indexes are related to the traffic incidents in the parent `Section`. This helps to find the exact positions of traffic incidents on a route. <!-- IOTSDK-13098 -->
- EV routing: Added `availableConnectorCount` to `EVChargingStation`. It represents the number of available physical connectors at a charging station. <!-- IOTSDK-13446 -->
- Added support for spatial audio maneuver notifications during navigation that allow to adjust the stereo panorama of the text-to-speech in real-time. This happens based on the maneuver location in relation to a driver sitting in a vehicle. Added `SpatialManeuverNotificationListener` and `SpatialManeuverAzimuthListener`. The first listener triggers notifications when spatial maneuvers are available. Meanwhile, the second one delivers `SpatialTrajectoryData`: It contains the next azimuth angle to be used and it indicates wether the spatial audio trajectory has finished or not. Added `SpatialManeuver` data, which contains the required data to spatialize the audio cues and `SpatialManeuverAudioCuePanning` to create the designed spatial audio maneuvers. It takes `CustomPanningData` as argument to `startPanning()` - this allows not only to update the `estimatedAudioCueDuration` of the `SpatialManeuver` but also to customize its `initialAzimuthInDegrees` and `sweepAzimuthInDegrees` properties. <!-- IOTSDK-12334 -->
- Added `setGeoCoordinates()` and `getGeoCoordinates()` to `Metadata`. <!-- APIGEN-1520 -->

#### API Changes - Breaking

- Aligned the return value of `PickTrafficIncidentResult.originalId` to return a `String` instead of an integer. <!-- IOTSDK-13383 -->
- Indoor Maps: It is now required to set a HRN value in order to use the `VenueService`. Added the `setHrn()` method to `VenueService` to set the HRN value for a platform catalog to fetch only the data for which an app is authorized. Internally, the HERE SDK renders indoor map data now in a new indoor map data format (MOM) which requires the HRN value. The visual representation of indoor map data is almost the same as before - except that the styling of selected indoor map features has been updated. <!-- INDOOR-5478 -->
- Positioning: It is no longer necessary to add the previously required Android permission `ACTIVITY_RECOGNITION`. The permission can be removed - if it is not used otherwise by an application. <!-- POSTI-2363 -->
- Removed the `IndoorRoutingEngine` as indoor routing is no longer supported for venues. <!-- INDOOR-5478 -->
- The zoom level behavior of the `MapCamera` has been aligned: Internally, the HERE SDK calculates now a zoom level with a pixel scale as reference instead of ppi. As a result, when a zoom level is set, the `MapView` is zoomed in a bit less than previously. Note that this affects only the zoom level and not the camera's distance setting to earth. In addition, the maximum zoom level has been increased from 22 to 23. <!-- IOTSDK-13117 -->

#### Resolved Issues

- Fixed an issue with maneuver notification updates during navigation. <!-- IOTSDK-11132 -->
- Navigation: Fixed handling of truck speed limits on limited access roads for some countries. <!-- IOTSDK-13599 -->
- `offlineRoutingEngine.returnToRoute()` now properly updates the departure and arrival times of the resulting `Route`. <!-- IOTSDK-13138 -->
- Fixed `offlineRoutingEngine.returnToRoute()` when it returns to a section after the first one. <!-- IOTSDK-12976 -->
- A `Route` created with the `RoutingEngine` differentiates now between sections for stops and sections created due to a transport mode change: The `waypointIndex` of the first departure place and the last arrival place are now set according to the waypoints indexes. <!-- IOTSDK-13187 -->
- GPX coordinates are now explicitly converted to degrees in a `GPXDocument` before writing to a file. <!-- IOTSDK-13484 -->
- Fixed crash in `VisualNavigator`: Each incoming maneuver refers now to its polyline as derived from its own section. Previously, all the maneuvers referred to the current section polyline. <!-- IOTSDK-13292 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- When using the new keyboard animations introduced with Flutter 2.10.2 the map view might blink in pink during the animation on iOS devices. <!-- IOTSDK-13141 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- By default, `MapScene.Layers.trafficFlow` is no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected. <!-- IOTSDK-1 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Currently, Flutter 3.0 is not yet supported due to a [known issue with platform views](https://github.com/flutter/flutter/issues/103630). We are awaiting a possible [fix](https://github.com/flutter/engine/pull/33599) for the Flutter engine. <!-- IOTSDK-13525 -->
- `MapViewPin` instances do not disappear after tilting and panning the map far away: The pins still show up above the horizon. <!-- IOTSDK-7051 -->
- `MapDownloader`: It is not possible to delete a `Region` when another download was interrupted. Workaround: The app needs to be restarted. <!-- IOTSDK-13440 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Calling `SpatialManeuverAudioCuePanning.startPanning(null)` does not work correctly. Instead, call the method with `CustomPanningData(null, null, null)` as parameter. <!-- IOTSDK-13565 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- PBJIRA-2012 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.11.3.0

#### New Features

- `ManeuverViewLaneAssistance` is now guaranteed to support left-hand and right-hand driving countries. No API change involved. <!-- IOTSDK-12586 -->
- Added class `PickTrafficIncidentResult` containing all data of a picked traffic incident. Added `PickMapContentResult.trafficIncidents` property for retrieving picked traffic incidents. <!-- IOTSDK-12427 -->
- This version of the HERE SDK is delivered with map data version 41. <!-- IOTSDK-13213 -->
- Added `MapCamera.lookAt(GeoCoordinates, MapMeasure)` and `MapCamera.lookAt(GeoCoordinates, GeoOrientationUpdate, MapMeasure)`. <!-- IOTSDK-10913 -->
- Added `sdk.transport.TruckSpecifications` as replacement for the deprecated `sdk.routing.TruckSpecifications`. <!-- HARP-18336 -->

#### API Changes - Breaking

- By default, the `RoutePrefetcher` prefetched map data around a location with a radius of 10 km. This was reduced to 2 km. <!-- IOTSDK-13277 -->

#### API Changes - Deprecations

- Deprecated `sdk.routing.TruckSpecifications` class. Use 'sdk.transport.TruckSpecifications' instead. <!-- HARP-18336 -->
- Deprecated `MapCamera.lookAt(GeoCoordinates, double)` and `MapCamera.lookAt(GeoCoordinates, GeoOrientationUpdate, double)`. Use instead the newly added `lookAt()` methods to set a `MapMeasure`, which allows now to specify if distance, scale or zoom level should be changed. <!-- IOTSDK-10913 -->
- Added `EVTruckOptions.truck_specifications` as replacement for the deprecated `EVTruckOptions.specifications`. <!-- HARP-18336 -->
- Added `TruckOptions.truck_specifications` as replacement for deprecated `TruckOptions.specifications`. <!-- HARP-18336 -->
- Deprecated `TruckOptions.specifications`. Use `TruckOptions.truck_specifications`instead. <!-- HARP-18336 -->
- Deprecated `EVTruckOptions.specifications`. Use `EVTruckOptions.truck_specifications`instead. <!-- HARP-18336 -->

#### Resolved Issues

- Fixed: `SafetyCameraWarning` notifications are repeated too often. The notifications for the safety cameras ahead are now given only once. <!-- IOTSDK-13162 -->
- Fixed a random crash for `RoutePrefetcher` that happend after route deviation. <!-- IOTSDK-13248 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- When using the new keyboard animations introduced with Flutter 2.10.2 the map view might blink in pink during the animation on iOS devices. <!-- IOTSDK-13141 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- Sometimes, turn-by-turn maneuver instructions on a highway result in "left fork" or right fork" instructions instead of just "continue on highway". <!-- IOTSDK-13212 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- PBJIRA-2012 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->
- By default, `MapScene.Layers.trafficFlow` is no longer visible on the map. This is a license issue which affects all _Navigate_ and _Explore Edition_ users. Please [contact us](https://www.here.com/contact) and ask for a HERE SDK license update to get traffic flow data. Your credentials will then be enabled to get access. Explore users can go directly to [developer.here.com](https://developer.here.com/) (instead of the HERE platform self-serve portal) as only the self-serve portal is affected.

### Version 4.11.2.0

#### New Features

- Extended feature configurations: 3D landmarks can now be enabled or disabled as feature. Added the value "LANDMARKS_3D" that can be specified in the _AndroidManifest_/_Plist_ for the "com.here.sdk.feature_configuration"/"FeatureConfiguration" key. <!-- IOTSDK-12446 -->
- Added offline support for 3D landmarks. When the `MapScene.Layers.landmarks` is set to be visible, landmarks will be also visible offline when enough map data was loaded into the cache - or when the corresponding `Region` was downloaded. <!-- IOTSDK-12446 -->
- `OfflineRoutingEngine`: Added support for `Waypoint.sideOfStreetHint`. <!-- IOTSDK-9463 -->
- Added `RoutePrefetcher.prefetchAroundLocation()` which prefetches map data within a circle of radius 10 km of around a location. It is recommended to call this method once before starting navigation for a smooth user experience. <!-- IOTSDK-12424 -->
- Added method `setCustomOptions()` to `RoutingEngine` which allows adding custom options to each routing query. Use this feature at your own risk to experiment with [Routing API v8 backend features](https://developer.here.com/documentation/routing-api/dev_guide/index.html) that are not yet supported by the HERE SDK. <!-- IOTSDK-13168 -->

#### API Changes - Breaking

- Moved class `com.here.sdk.routing.RoutePrefetcher` to `com.here.sdk.prefetcher.RoutePrefetcher`. <!-- IOTSDK-13022 -->
- Offline maps: Before downloading or deleting a `Region`, it is required to call `getDownloadableRegions()` - only if a map update was performed beforehand. As a recommendation: Once `MapUpdater` has completed an update process, call `getDownloadableRegions()` to internally update the list of available `Region` data. <!-- IOTSDK-13265 -->

#### API Changes - Deprecations

- `SearchEngine`: Deprecated existing constructors of `TextQuery` and `CategoryQuery`.
Use newly added constructors taking `TextQuery.Area` and `CategoryQuery.Area` instead. <!-- IOTSDK-13013 -->
- Deprecated `Section.departureTime` and `Section.arrivalTime` properties. Use `Section.departureLocationTime` and `Section.arrivalLocationTime` properties instead. Added `LocationTime` class which provides the local time, UTC time and the UTC offset, including DST time variations. <!-- IOTSDK-12926 -->
- Deprecated `MapViewBase.pickMapFeatures(Rectangle2D, MapViewBase.PickMapFeaturesCallback)`, `HereMapController.pickMapFeatures(Rectangle2D, MapViewBase.PickMapFeaturesCallback)`, `MapViewBase.PickMapFeaturesCallback`, `PickMapFeaturesResult`. Use instead the newly introduced `MapViewBase.pickMapContent(Rectangle2D, MapViewBase.PickMapContentCallback)`, `MapView.pickMapContent(Rectangle2D, MapViewBase.PickMapContentCallback)`, `MapViewBase.PickMapContentCallback`, `PickMapContentResult`. <!-- IOTSDK-12981 -->

#### Resolved Issues

- Fixed failing traffic incident queries for `TrafficEngine`. <!-- IOTSDK-13245 -->
- Fixed incorrectly reported `SpeedLimit` notifications for trucks that happened in some situations. <!-- IOTSDK-13143 -->
- `OfflineRoutingEngine`: Fixed unnecessary detours that happened when waypoints are close to junctions. <!-- ROUTING-22537 -->
- `ManeuverNotificationOptions.enableHighwayExit` is now considered when notifications are received by `ManeuverNotificationListener`. <!-- IOTSDK-13052 -->
- Bus routes may not be fully accurate and the `TransportMode` of such routes is incorrectly changed to `car`. Fixed value returned by the `getSectionTransportMode()` method of a `Section` for bus routes. <!-- IOTSDK-13104 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- When using the new keyboard animations introduced with Flutter 2.10.2 the map view might blink in pink during the animation on iOS devices. <!-- IOTSDK-13141 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- Sometimes, turn-by-turn maneuver instructions on a highway result in "left fork" or right fork" instructions instead of just "continue on highway". <!-- IOTSDK-13212 -->
- When a feature configuration is applied, then the `MapDownloader` does not accurately show the updated size of a `Region`. This does not affect the actual size on disk. <!-- IOTSDK-11975 -->
- `SafetyCameraWarning` notifications are repeated too often. <!-- IOTSDK-13162 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- PBJIRA-2012 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.11.1.0

#### New Features

- Added `MapImage.withImageDataImageFormatWidthAndHeight(Uint8List imageData, ImageFormat imageFormat, int width, int height)` to set a custom size. It will also accept PNG image data. <!-- IOTSDK-13016 -->
- Search: Added `Suggestion.id` that holds an auto suggest item ID. <!-- IOTSDK-13014 -->
- Added a method to `MapView` to set a HERE watermark margin with `hereMapController.setWatermarkPlacement(WatermarkPlacement placement, int bottomMargin)`. <!-- IOTSDK-12703 -->

#### API Changes - Breaking

- Removed the previously deprecated constructor `Location.withAllFields` and the field `Location.timestamp`. Use the default constructor instead and set the values afterwards. <!-- IOTSDK-12988 -->

#### API Changes - Deprecations

- Deprecated the method `HereMapController.setWatermarkPosition(WatermarkPlacement placement, int bottomCenterMargin)`. Use the related `setWatermarkPlacement()` method instead. <!-- IOTSDK-12703 -->

#### Resolved Issues

- Dark background issue fixed for `MapView` when using a `webMercator` projection. <!-- IOTSDK-12971 -->
- Fixed: Finding traffic on a route via `trafficEngine.queryForIncidents` fails unexpectedly for `GeoCorridor` objects that are much shorter than 500 km. <!-- IOTSDK-12801 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- When using the new keyboard animations introduced with Flutter 2.10.2 the map view might blink during the animation on iOS devices. <!-- IOTSDK-13141 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- Bus routes may not be fully accurate and the `TransportMode` of such routes is incorrectly changed to `car`. <!-- IOTSDK-13104 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- IOTSDK-12285 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.11.0.0

#### New Features

- Added support for offline Bus route calculation via `OfflineRoutingEngine` and turn-by-turn navigation via `Navigator` / `VisualNavigator`. <!-- IOTSDK-12697 -->
- Added low-level 3D support to programmatically add custom 3D objects on the map. Added `MeshBuilder`, `TriangleMeshBuilder` and `QuadMeshBuilder` to construct different kinds of meshes from points in 3D space via `Point3D`. The resulting `Mesh` container can be used with a texture graphic to create `MapMarker3D` objects. <!-- IOTSDK-11386 -->
- `MapMarker3D` objects can now be scaled using a `RenderSize.Unit` in `meters`, `pixels` and
`densityIndependentPixels`. <!-- IOTSDK-9672 -->
- Added `CategoryQuery.excludeCategories` to add a list of `PlaceCategory` items that should be excluded from a category search for places. These categories can be set with `CategoryQuery.withExcludeCategories`. <!-- IOTSDK-12939 -->
- Added enhanced animation support for `MapMarker` objects via the new `MapMarkerAnimation` class. Such animations are based on a `MapItemKeyFrameTrack` that stores keyframes for interpolation of a map item property. It can be constructed by calling `MapItemKeyFrameTrack.moveTo(List<GeoCoordinatesKeyframe> keyframes, EasingFunction easingFunction, KeyframeInterpolationMode interpolationMode)`. The animation can be started or cancelled via `mapMarker.startAnimation(mapMarkerAnimation)/cancelAnimation(mapMarkerAnimation)`. <!-- IOTSDK-10493 -->
- Added support for online Bus route calculation via `RoutingEngine`. Added `TransportMode.bus` and `BusOptions`. <!-- IOTSDK-12696 -->
- Added `RoutePrefetcher` to improve the navigation experience. By calling its `prefetchAroundRouteOnIntervals()` method it downloads map data in advance that may be needed during a trip. The data will be loaded automatically to the map cache and it will be used when the device is temporary offline - unless the device is fully operating offline using _offline maps_. <!-- IOTSDK-11484 -->
- Added fade animations for `MapMarker` by setting `fadeDuration: TimeInterval`. The marker will automatically fade-in when being added to the `MapView` and fade-out when being removed. By default, this feature is disabled and the `fadeDuration` property defaults to 0. <!-- IOTSDK-4861 -->
- Added explicit support for flat `MapMarker3D` objects. Added a convenience constructor for `MapMarker3D` with a `MapImage` parameter to create a flat map marker. Use `RenderSize.Unit` with `densityIndependentPixels` to create flat marker with a fixed size - independent of zoom level. <!-- IOTSDK-3964 -->
- Added support for the [traveling salesman](https://en.wikipedia.org/wiki/traveling_salesman_problem) use case. Multiple stopover `Waypoint` items along a `Route` can now be ordered automatically by setting `RouteOptions.optimizeWaypointsOrder`. If set to `true`, the `OfflineRoutingEngine` will try to optimize the waypoints order to reach the destination faster or to make the route shorter. The feature is not yet supported for the online `RoutingEngine`. Note that this is a beta release of this feature. <!-- IOTSDK-12582 -->
- Added support to record a navigation session for later use with the new `GPXTrackWriter` - for example, to test new app features or to replay and analyse unexpected behavior. Add the `GPXTrackWriter` as a listener to `LocationEngineBase` via `addLocationListener()` for GPX track recording. Use the `GPXDocument` to load the GPX track from file or from a recorded track. Only track data is used from the GPX format. Any unknown elements in the file are ignored. Any known element with an invalid value returns an error. Elevation values are ignored. Use `GPXDocument.save()` to save loaded tracks to a file pointed by name: It returns `true` if succeeded and `false` otherwise. <!-- IOTSDK-12887 -->
- Added enhanced camera animations with `MapCameraAnimationFactory.flyTo(GeoCoordinatesUpdate, double, Duration)`, `MapCameraAnimationFactory.flyTo(GeoCoordinatesUpdate, GeoOrientationUpdate, double, Duration)`, `MapCameraAnimationFactory.flyTo(GeoCoordinatesUpdate, MapMeasure, double, Duration)`, `MapCameraAnimationFactory.flyTo(GeoCoordinatesUpdate, GeoOrientationUpdate, MapMeasure, double, Duration)`. <!-- HARP-18311 -->
- Added offline support for `RouteOptions.arrivalTime`. This field will be ignored if `RouteOptions.enableTrafficOptimization` is set to `false`. Cannot be set along with `RouteOptions.departureTime`. <!-- IOTSDK-12623 -->

#### API Changes - Breaking

- Removed the previously deprecated `InstantiationErrorCode.failedToLockPersistentMapStorageFolder`. Nothing to use instead: The persistent storage directory is no longer locked. <!-- IOTSDK-10993 -->
- Removed the previously deprecated `SectionNoticeCode.violatedPedestrianOption` symbol. Nothing to use instead as this is no longer supported. <!-- IOTSDK-10978 -->

#### API Changes - Deprecations

- Deprecated `MapCamera.FlyToOptions`` and all `MapCamera.flyTo` APIs. Use `MapCameraAnimationFactory.flyTo` APIs instead. <!-- HARP-18311 -->
- Deprecated `Section.trafficSpeeds` property. Use instead `Span.trafficSpeed` property. <!-- IOTSDK-10258 -->

#### Resolved Issues

- The `TrafficEngine` can handle now `GeoCorridor` objects without a radius. When the radius via `halfWidthInMeters` is unset, a default value of 30 meters is used. <!-- IOTSDK-12800 -->
- A `GPXDocument` no longer ignores the timezone in the GPX _track point time_ of the imported GPX file. It reads now correctly the track point timezone as UTC. <!-- IOTSDK-12957 -->
- Fixed an issue for TTS maneuver notifications where abbreviated names have been incorrectly translated in German when using the `ManeuverNotificationListener`. <!-- IOTSDK-12925 -->
- The `returnToRoute()` feature of the `RoutingEngine` now routes back to the first untravelled waypoint and the `routeFractionTraveled` parameter is no longer ignored. <!-- IOTSDK-11493 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- Finding traffic on a route via `trafficEngine.queryForIncidents` fails unexpectedly for `GeoCorridor` objects that are much shorter than 500 km. <!-- IOTSDK-12801 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- IOTSDK-12285 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- OLPSUP-18080 -->

### Version 4.10.5.0

#### New Features

- Added `MapMeasureRange` class to hold a `MapMeasure` range, `MapCameraLimits.zoomRange: MapMeasureRange` property. <!-- HARP-18314 -->
- Added `SdkContext.release()` method. It is recommended to call this method once, when the application shuts down. <!-- IOTSDK-12481 -->
- Added support for custom backends with the new `EngineBaseURL` enum and the `customEngineBaseUrls` field in `SDKOptions`. <!-- IOTSDK-12409 -->
- Added `MapCameraLimits.tiltRange(AngleRange)` property. <!-- HARP-18331 -->
- Added support for `Pedestrian` routes and transport mode in `OfflineRoutingEngine` and for navigation. <!-- IOTSDK-12637 -->
- Japan is now available as a separate offline maps `Region` download via `MapDownloader`. With enabled credentials, high-quality Japan map data can be downloaded. By default, only low-quality basic map data is available for download. Talk to your HERE representative to enable high-quality Japan map data. Note that this feature is already available since v4.10.4.0. <!-- IOTSDK-12307 -->
- Route alternatives are now fully supported for electric vehicles. EV route alternatives are enabled when `routeOptions.alternatives` is in the range [1, 6]. Note that this feature is already available since v4.10.4.0. <!-- IOTSDK-12400 -->
- Added `MapCameraLimits.setBearingRangeAtZoom(MapMeasure, AngleRange)`, `MapCameraLimits.clearBearingRanges`, `MapCameraLimits.setTiltRangeAtZoom(MapMeasure, AngleRange)` and `MapCameraLimits.clearTiltRanges`. <!-- HARP-18274 -->
- Added `MapCamera.cancelAnimations` methods. <!-- HARP-18331 -->
- Added `MapCameraListener` interface, `MapCamera.addListener(MapCameraListener)`, `MapCamera.removeListener(MapCameraListener)` and `MapCamera.removeListeners` methods. <!-- HARP-18331 -->

#### API Changes - Deprecations

- Deprecated `LocationSimulatorOptions.notificationIntervalInMilliseconds`. Use `LocationSimulatorOptions.notificationInterval` instead. <!-- IOTSDK-12317 -->
- Deprecated `Location.timestampSinceBootInMilliseconds`. Use `Location.timestampSinceBoot` instead. <!-- IOTSDK-12317 -->
- Deprecated `MapCameraLimits.setMinTilt(double)` and `MapCameraLimits.setMaxTilt(double)`. Use `MapCameraLimits.tiltRange` property instead. <!-- HARP-18331 -->
- Deprecated `MapCamera.cancelAnimation` method. Use `MapCamera.cancelAnimations` instead. <!-- HARP-18331 -->
- Deprecated `MapCameraLimits.setMinZoomLevel(double)`, `MapCameraLimits.setMaxZoomLevel(double)`, `MapCameraLimits.ErrorCode`, `MapCameraLimits.MapCameraLimitsException`. Use `MapCameraLimits.zoomRange: MapMeasureRange` property instead. <!-- HARP-18314 -->
- Deprecated `MapCameraObserver` interface, `MapCamera.addObserver(MapCameraObserver)` and `MapCamera.removeObserver(MapCameraObserver)` methods. Use `MapCamera.addListener(MapCameraListener)` and `MapCamera.removeListener(MapCameraListener)` instead. <!-- HARP-18331 -->
- Deprecated `DynamicRoutingEngine.pollIntervalInMinutes`. Use `DynamicRoutingEngine.pollInterval` instead. <!-- IOTSDK-12316 -->

#### Resolved Issues

- Fixed incorrect handling of `RouteOptions.occupantsNumber` while requesting a route. <!-- IOTSDK-12592 -->
- Routing: Fixed incorrect offset calculation for departure/arrival time that happens when converting to UTC time. <!-- IOTSDK-12799 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- Finding traffic on a route via `trafficEngine.queryForIncidents` fails unexpectedly for `GeoCorridor` objects that are much shorter than 500 km. <!-- IOTSDK-12801 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- IOTSDK-12285 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- IOTSDK-11931 -->

### Version 4.10.4.0

#### New Features

- Added `sdk.transport.TruckType` enum. It is meant to replace the deprecated `sdk.routing.TruckType`. <!-- IOTSDK-11015 -->
- Added `TruckOptions.hazardous_materials`. It is meant to replace the deprecated `TruckOptions.hazardous_goods`. <!-- IOTSDK-11015 -->
- Added `RouteOptions.occupantsNumber` support when using the `OfflineRoutingEngine`. <!-- IOTSDK-12378 -->
- Added `sdk.transport.HazardousMaterial` enum. It is meant to replace the deprecated `sdk.routing.HazardousGood`. <!-- IOTSDK-11015 -->
- Added `EVTruckOptions.hazardous_materials`. It is meant to replace the deprecated `EVTruckOptions.hazardous_goods`. <!-- IOTSDK-11015 -->
- Added `ManeuverNotificationTimingOptions` in `Navigator` to configure maneuver notification timings. This allows to customize the default distance and time thresholds that are used for TTS voice guidance. <!-- IOTSDK-12168 -->
- Traffic incident queries can now be canceled by calling the `cancel()` method of the `TaskHandle` object returned by the `TrafficEngine`. <!-- IOTSDK-12489 -->
- Added `routing.TruckSpecifications.truck_type`. It is meant to replace the deprecated `routing.TruckSpecifications.type`. <!-- IOTSDK-11015 -->

#### API Changes - Breaking

- The minimum supported Flutter version was raised from 2.5.3 to 2.8.0. The latest supported Flutter version is 2.10.2. The minimum supported Dart version was raised from 2.14.4 to 2.15.0. The latest supported Dart version is 2.16.1. Newer Flutter and Dart versions may also work, but are not guaranteed to work. <!-- IOTSDK-12603 -->

#### API Changes - Deprecations

- Deprecated `routing.TruckSpecifications.type`. Use `routing.TruckSpecifications.truck_type` instead. <!-- IOTSDK-11015 -->
- Deprecated `sdk.routing.HazardousGood` enum. Use 'sdk.transport.HazardousMaterial' instead. <!-- IOTSDK-11015 -->
- Deprecated `EVTruckOptions.hazardous_goods`. Use `EVTruckOptions.hazardous_materials` instead. <!-- IOTSDK-11015 -->
- Deprecated `routing.TruckType` enum. Use `routing.TruckType` instead. <!-- IOTSDK-11015 -->
- Deprecated `TruckOptions.hazardous_goods` enum. Use 'TruckOptions.hazardous_materials' instead. <!-- IOTSDK-11015 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- `MapDownloader`: The `sizeOnDiskInBytes` property of `Region` and `InstalledRegion` slightly differs. <!-- IOTSDK-12688 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- IOTSDK-12285 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- IOTSDK-11931 -->

### Version 4.10.3.0

#### New Features

- Added `sdk.transport.TunnelCategory`. It is meant to replace deprecated `sdk.routing.TunnelCategory`. <!-- IOTSDK-11015 -->
- Added altitude handling for offline routing. <!-- IOTSDK-12425 -->
- Added property `isDepthCheckEnabled` to `MapMarker3D` class. This improves rendering for complex 3D objects such as a torus. <!-- IOTSDK-12413 -->
- Added support for `UNKNOWN` value from `TrafficIncidentImpact` and `TrafficIncidentType` enums to enable filtering for traffic incidents. This value indicates that all types/impacts are requested from the backend and filtering will be applied thereafter by the HERE SDK. <!-- IOTSDK-12329 -->
- Added `EVTruckOptions.link_tunnel_category`. It is meant to replace deprecated `EVTruckOptions.tunnel_category`. <!-- IOTSDK-11015 -->
- Added `TruckOptions.link_tunnel_category`. It is meant to replace deprecated `TruckOptions.tunnel_category`. <!-- IOTSDK-11015 -->
- Added `MapCameraUpdateFactory.setNormalizedPrincipalPoint(Anchor2D)` method to animate camera's principal point using normalized screen coordinates. <!-- HARP-18064 -->
- Added `Anchor2DKeyframe` class to be used in animation of normalized principal point. Added `MapCameraKeyframeTrack.normalizedPrincipalPoint(List<Anchor2DKeyframe>, EasingFunction, KeyframeInterpolationMode)` that creates keyframe track for animating normalized principal point. Added `MapCameraKeyframeTrack.getAnchor2DKeyframes()` method. Added `MapCameraUpdateFactory.setNormalizedPrincipalPoint(Anchor2D)` method. <!-- HARP-18064 -->
- Visibility of embedded default Carto POIs on the map has been improved. <!-- HARP-17932 -->
- Added colors related to landuse area polygons in the night scheme have been updated. <!-- HARP-17798 -->
- Added `MapIdleListener` to `MapView` library to detect whether the map is idle or busy. Added `addMapIdleListener(MapIdleListener)` to start receiving idle state notifications and `removeMapIdleListener(MapIdleListener)` to stop receiving idle state notifications. It can be added for a `HereMap` instance, which you can get from a `MapView` instance. <!-- IOTSDK-11221 -->
- Added constructors to 'RasterDataSource'. <!-- HARP-17952 -->
- Added `initialBackgroundColor` to `MapViewOptions` and constructor to set initial background color. Initial background color will be shown until the first map scene has been loaded. <!-- IOTSDK-8377 -->
- Updated colors related to street network elements for the night scheme. <!-- HARP-17797 -->

#### API Changes - Deprecations

- Deprecated unsupported method `RasterDataSource.changeConfigurationWithConfigPath()`. Use the another constructor instead. <!-- HARP-18139 -->
- Deprecated `BatterySpecifications.changingSetupDurationInSeconds`. Use `BatterySpecifications.changingSetupDuration` instead. <!-- IOTSDK-10084 -->
- Deprecated `TruckOptions.tunnel_category` enum. Use 'TruckOptions.link_tunnel_category' instead. <!-- IOTSDK-11015 -->
- Deprecated `Maneuver.durationInSeconds`. Use `Maneuver.duration` instead.
    - Deprecated `Section.durationInSeconds`. Use `Section.duration` instead.
    - Deprecated `Section.trafficDelayInSeconds`. Use `Section.trafficDelay` instead. <!-- IOTSDK-10084 -->
- Search: Deprecated `GeoPlace(title, externalIDs, type, categories, address, location, business, web)` and `GeoPlace.allFields(title, externalIDs, type, categories, address, location, business, web, internalid, internalmyPlace)` constructors. Use `GeoPlace.withDefaults()` instead. <!-- IOTSDK-12266 -->
- Deprecated `SpeedLimit(speedLimitInMetersPerSecond, advisorySpeedLimitInMetersPerSecond, snowSpeedLimitInMetersPerSecond, rainSpeedLimitInMetersPerSecond, fogSpeedLimitInMetersPerSecond, optimal_weatherSpeedLimitInMetersPerSecond, school_zoneSpeedLimitInMetersPerSecond, time_dependentSpeedLimitInMetersPerSecond)` constructor. Please use the default constructor instead. <!-- IOTSDK-12267 -->
- Deprecated `SectionProgress.remainingDurationInSeconds`. Use `SectionProgress.remainingDuration` instead.
   - Deprecated `SectionProgress.trafficDelayInSeconds`. Use `SectionProgress.trafficDelay` instead.
   - Deprecated `SectionProgress` constructor with parameters. Use `SectionProgress.withDefaults()` instead.
    - Deprecated `ManeuverProgress.remainingDurationInSeconds`. Use `ManeuverProgress.remainingDuration` instead.
   - Deprecated `ManeuverProgress` constructor with parameters. Use `ManeuverProgress.withDefaults()` instead. <!-- IOTSDK-10084 -->
- Deprecated `Waypoint.durationInSeconds`. Use `Waypoint.duration` instead. <!-- IOTSDK-10084 -->
- Deprecated `RoadAttributes(isDirtRoad, isTunnel, isBridge, isRamp, isControlledAccess, isPrivate, isNoThrough, isTollway, isDividedRoad, isRightDrivingSide, isRoundabout)` constructor. Please use the default constructor instead. <!-- IOTSDK-12267 -->
- Deprecated `DynamicRoutingEngineOptions.minTimeDifferenceInSeconds`. Use `DynamicRoutingEngineOptions.minTimeDifference` instead. <!-- IOTSDK-10084 -->
- Deprecated `sdk.routing.TunnelCategory` enum. Use 'sdk.transport.TunnelCategory' instead. <!-- IOTSDK-11015 -->
- Navigation: Deprecated `SpeedLimitOffset(lowSpeedOffsetInMetersPerSecond, highSpeedOffsetInMetersPerSecond, highSpeedBoundaryInMetersPerSecond)` constructor. Please use the default constructor instead. <!-- IOTSDK-12267 -->
- Deprecated `Route.durationInSeconds`. Use `Route.duration` instead.
    - Deprecated `Route.trafficDelayInSeconds`. Use `Route.trafficDelay` instead. <!-- IOTSDK-10084 -->
- Deprecated `MapCameraUpdateFactory.setPrincipalPointOffset(Point2D)` method. Use `MapCameraUpdateFactory.setNormalizedPrincipalPoint(Anchor2D)` instead. <!-- HARP-18064 -->
- Deprecated `EVTruckOptions.tunnel_category`. Use `EVTruckOptions.link_tunnel_category` instead. <!-- IOTSDK-11015 -->
- Deprecated `PostAction.durationInSeconds`. Use `PostAction.duration` instead.
    - Deprecated `PostAction` constructor. Use `PostAction.withDefaults()` instead.
    - Deprecated `PreAction.durationInSeconds`. Use `PreAction.duration` instead.
    - Deprecated `PreAction` constructor with parameters. Use `PreAction.duration` instead. <!-- IOTSDK-10084 -->
- Deprecated `TransitStop.durationInSeconds`. Use `TransitStop.duration` instead. Deprecated `TransitStop(departure, durationInSeconds)` constructor. Use `TransitDeparture.withDefaults(departure)` instead. <!-- IOTSDK-10084 -->
- Deprecated `links` in `sdk.routing.Section`. Use `spans` instead. <!-- IOTSDK-12048 -->

#### Resolved Issues

- Fixed: Sometimes the `VisualNavigator` informs too late on `RouteProgress` after guidance start. <!-- IOTSDK-12499 -->
- Truck guidance no longer ignores truck specific legal speed limits (CVR). Limits are provided as part of the `SpeedLimit` event when transport mode `truck` is set. Use map version 32 or newer. <!-- IOTSDK-12565 -->
- Adding custom raster layers no longer hides the HERE logo. <!-- IOTSDK-12202 -->
- Removed copying geometry when there is only one section. <!-- IOTSDK-12459 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- IOTSDK-12285 -->
- `sdk.Navigator.getManeuverNotificationTimingOptions` and `sdk.Navigator.setManeuverNotificationTimingOptions` accept `sdk.routing.TransportMode` as argument, it will be changed to `sdk.transport.TransportMode` in the next minor release. <!-- IOTSDK-12168 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- IOTSDK-11931 -->

### Version 4.10.2.0

#### New Features

- Find traffic along a route: Added class `TrafficIncidentOnRoute` and read-only property `Section.trafficIncidents`. It represents traffic incidents on the route that are relevant for the section. <!-- IOTSDK-12198 -->
- The `RoutingEngine` is now able to provide routes that contain altitude values along the route. <!-- IOTSDK-8226 -->
- Added support for project scopes: With the new `AndroidManifest` meta-data option to specify a `com.here.sdk.access_scope` an app can set the HRN value as defined by your project ID. On iOS devices, use the `plist` key option to specify a `Scope`. Each app belongs to at least one or multiple projects. A possible use case can be to define a _debugScope_. See `SDKOptions` and the [IAM Guide](https://developer.here.com/documentation/identity-access-management/dev_guide/topics/manage-projects.html#create-a-project) for more details. <!-- IOTSDK-12107 -->
- Added `isTruckLight` flag to `TruckSpecifications`. It indicates that the truck can be classified as a car and that it is therefore excluded from legal restrictions (such as truck speed limits) for normal trucks when calculating the route. Note that specifications such as the physical dimensions, cargo, and others, are still taken into account. <!-- IOTSDK-12199 -->
- Feature configurations can now be updated at the next application update. Added `performFeatureUpdate` method to `MapUpdater` class. Call this method once a feature configuration has been updated in `AndroidManifest` or `plist` file. As a result, the cached map data will be deleted and subsequently updated. Also, the downloaded regions will be updated to reflect the changes. Note that it is the developer's responsibility to decide when to perform the update. The HERE SDK does not decide or notify when such an update can be made. Calling `performFeatureUpdate` is only necessary once, after an application has been updated. Use feature configurations to limit the map data that is downloaded when panning and zooming the map view - or when downloading offline regions. <!-- IOTSDK-11403 -->

#### API Changes

- Dropped support for Flutter 2.2.x. Flutter 2.5.0 and Dart 2.14.0 _or newer_ are now required - as already announced for the last release. <!-- IOTSDK-12352 -->
- Deprecated `sdk.routing.EVConsumptionModel(ascentConsumptionInWattHoursPerMeter, descentRecoveryInWattHoursPerMeter, freeFlowSpeedTable, trafficSpeedTable, auxiliaryConsumptionInWattHoursPerSecond)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12269 -->
- Deprecated `sdk.location.NotificationOptions(desiredIntervalMilliseconds, smallestIntervalMilliseconds)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12268 -->
- Deprecated `sdk.routing.TransitRouteOptions(departureTime, arrivalTime, alternatives, changes, modeFilter, modes, pedestrianSpeedInMetersPerSecond, pedestrianMaxDistanceInMeters, textOptions)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12269 -->
- Deprecated `sdk.location.CellularPositioningOptions(enabled)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12268 -->
- Deprecated `Section.polyline`, use `Section.geometry` instead. <!-- IOTSDK-7391 -->
- Deprecated `sdk.routing.AvoidanceOptions(roadFeatures, countries, avoidAreas, zoneCategories, segments)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12269 -->
- Deprecated `sdk.routing.IndoorRouteOptions(routeOptions, transportMode, indoorAvoidanceOptions, outdoorAvoidanceOptions, walkSpeedInMetersPerSecond)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12270 -->
- Deprecated `FarePrice.validityPeriodInSeconds`. Use `FarePrice.validityPeriod` instead. Deprecated `FarePrice` constructor. Use `FarePrice.withDefaults()` instead. <!-- IOTSDK-10084 -->
- Deprecated `AuthenticationData.expiryTimeInSeconds`. Use `AuthenticationData.expiryTime` instead. Deprecated `AuthenticationData` constructor. Use `AuthenticationData.withDefaults()` instead. <!-- IOTSDK-10084 -->
- Deprecated `Route.polyline`, use `Route.geometry` instead. <!-- IOTSDK-7391 -->
- Deprecated `sdk.location.SensorOptions(enabled)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12268 -->
- Deprecated `sdk.routing.PedestrianOptions(routeOptions, textOptions, avoidanceOptions, walkSpeedInMetersPerSecond)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12269 -->
- Deprecated `sdk.routing.IndoorAvoidanceOptions(indoorFeatures)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12270 -->
- Deprecated `sdk.location.WifiPositioningOptions(enabled)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12268 -->
- Deprecated `sdk.routing.TransitSectionDetails(transport, intermediateStops, agency, attributions, fares, incidents)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12269 -->
- Deprecated `sdk.routing.RouteTextOptions(language, instructionFormat, unitSystem)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12269 -->
- Deprecated `sdk.routing.FarePrice(type, estimated, currency, validityPeriodInSeconds, minimum, maximum)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12269 -->
- Deprecated `sdk.routing.ScooterOptions(routeOptions, textOptions, avoidanceOptions, allowHighway)` constructor. Use one of the other constructors instead. <!-- IOTSDK-12269 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- Sometimes the `VisualNavigator` informs too late on `RouteProgress` after guidance start. <!-- IOTSDK-12499 -->
- Truck guidance ignores truck specific speed limits (CVR). Currently, only the speed limits as they are valid for cars are provided as part of the `SpeedLimit` event. <!-- IOTSDK-12451 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5267 -->
- Transparency for `MapPolylines` is not supported. <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- IOTSDK-12285 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- IOTSDK-11931 -->

### Version 4.10.1.0

#### New Features

- Routing: Route calculations can now be canceled via the returned `TaskHandle` when calling `calculateRoute()` or related methods on engines such as the `RoutingEngine`. <!-- IOTSDK-9898 -->
- BYOD: Extended `GeoPlace` to hold more information: Added `ExternalID`, `LocationDetails`, `WebDetails`, `BusinessDetails`. <!-- IOTSDK-11379 -->
- Added `matchSideOfStreet` property to `Waypoint` class. It specifies how the location set by `sideOfStreetHint` should be handled when reaching a destination. <!-- IOTSDK-12104 -->
- Added value `SUB_METER_NAVIGATION` to `LocationAccuracy` enum. It causes HERE positioning to use high accuracy GNSS. Added values `NOT_LICENSED` and `NOT_COMPATIBLE` to `LocationEngineStatus` enum. They indicate additional error states related to HD GNSS. Added value `HD_GNSS_POSITIONING` to `LocationFeature` enum: It adds new supported feature to Positioning. Added value `hdEnabled` to `SatellitePositioningOptions` struct: If true, HD GNSS positioning is enabled. <!-- HDGNSS-2873 -->
- Added global `ParameterConfiguration` that holds default values for HERE SDK features. For now, this allows to specify a `walkingSpeedInMetersPerSecond` to define a default pedestrian movement. Added `TransitRouteOptions.fromDefaultParameterConfiguration()` and `PedestrianOptions.fromDefaultParameterConfiguration()` that allow to create `TransitRouteOptions` and `PedestrianOptions` that will use the values set via `ParameterConfiguration`. The created options can then be used as usual for route calculation. Note that this is a beta feature. <!-- IOTSDK-11021 -->
- Navigation: Added `SpeedLimit.optimalWeatherSpeedLimitInMetersPerSecond` property. <!-- IOTSDK-11941 -->
- Added a new `TrafficEngine` that allows querying for current traffic incidents. Check the _Traffic_ example app to see how it works. The `TrafficEngine` supports querying for traffic incidents in a bounding box, a circle, or a corridor. Querying for the exact traffic incident by ID. Traffic incidents can contain an incident type, an incident impact, an incident location (currently, a polyline with length), incident codes, an active time range, localized by the queried language description and summary, relevant vehicle restrictions, and more. It supports representations of traffic incident vehicle restrictions as a set of restricted vehicle properties of some vehicle category and filtering queried incidents by an incident type, an incident impact and an active time range. <!-- IOTSDK-10974 -->
- Added `RouteOptions.occupantsNumber`: An option reflecting the number of occupants in a vehicle. Supported for `car` and `truck` transport modes. When it is higher than 1 it affects a vehicles ability to use HOV/carpool lanes. Defaults to 1. <!-- IOTSDK-8702 -->
- Raised minimum supported Flutter version from 2.2.3 to 2.5.3. The latest Flutter version that is guaranteed to work is 2.8.1 - other versions may also work, but are not guaranteed to work. <!-- IOTSDK-12227 -->
- Added support for truck speed limits and CVR (Commercial Vehicle Regulated) speed limits for `SpeedLimitListener` and `SpeedWarningListener`. Governmental regulations can specify an upper speed limit for certain vehicle types, such as trucks. If a local road sign indicates a speed limit of 130 km/h, then this can be overruled: In Germany, for example, the maximum allowed speed for trucks is 100 km/h. When navigation or tracking is started then the `SpeedLimitListener` and `SpeedWarningListener` will use the set `TransportMode` to notify on truck or car speed limits. As a result, a truck driver will receive on German highways never a speed limit notification that is higher than 100 km/h. Note that this feature is only available for map data >= 32 - as indicated by `MapUpdater.getCurrentMapVersion()`. <!-- IOTSDK-11941 -->
- Navigation: Added support for smooth location interpolation. This feature is already effective when using the `VisualNavigator`. Now it is also possible to get the calculated interpolated locations directly from the newly added `InterpolatedLocationListener` from a `VisualNavigator` instance. This allows for more customization options, for example, to smoothly animate map objects or new map view instances that show a different perspective than the main map view display. <!-- IOTSDK-12025 -->

#### API Changes

- Changed type of `RefreshRouteOptions` constructor parameter from `sdk.routing.TransportMode` to `sdk.transport.TransportMode`. <!-- IOTSDK-11015 -->
- Removed the previously deprecated `release()` method from all classes as it was doing nothing. <!-- IOTSDK-10059 -->
- Removed the previously deprecated `Maneuver.polyline`. Use instead `Section.polyline` together with `Maneuver.sectionIndex` and `Maneuver.offset`. <!-- IOTSDK-10446 -->
- Routing: Deprecated `EVConsumptionModel(ascentConsumptionInWattHoursPerMeter, descentRecoveryInWattHoursPerMeter, freeFlowSpeedTable, trafficSpeedTable, auxiliaryConsumptionInWattHoursPerSecond)` constructor. Use the default constructor instead. <!-- IOTSDK-12269 -->
- Search: Deprecated `SearchOptions` constructor that takes all parameters. Please use the default constructor instead. <!-- IOTSDK-10988 -->
- Deprecated `Size2D.withDefaults()` constructor. Use one of the available constructors instead. <!-- IOTSDK-12259 -->
- Deprecated `SatellitePositioningOptions` constructor. Use `SatellitePositioningOptions.withDefaults()` instead. <!-- IOTSDK-10988 -->
- Search: Deprecated `Address.withValues()` constructor that takes all parameters. Please use the default constructor instead. <!-- IOTSDK-10988 -->
- Navigation: Deprecated `LocationSimulatorOptions` constructor that takes all parameters. Please use the default constructor instead. <!-- IOTSDK-10988 -->
- Deprecated `Point2D.withDefaults()` constructor. Use one of the available constructors instead. <!-- IOTSDK-12259 -->
- Routing: Deprecated `TransitRouteOptions(departureTime, arrivalTime, alternatives, changes, modeFilter, modes, pedestrianSpeedInMetersPerSecond, pedestrianMaxDistanceInMeters, textOptions)` constructor. Use the default constructor instead. <!-- IOTSDK-12269 -->
- Deprecated `NavigatorInterface.trackingTransportMode`. Use the newly introduced `NavigatorInterface.assumedTrackingTransportMode` instead. <!-- IOTSDK-11015 -->
- Deprecated `EVCarOptions` constructor. Use `EVCarOptions.withDefaults()` instead. <!-- IOTSDK-10988 -->
- Deprecated `Route.transportMode`. Use the newly introduced `Route.requestedTransportMode` instead. <!-- IOTSDK-11015 -->
- Routing: Deprecated `AvoidanceOptions(roadFeatures, countries, avoidAreas, zoneCategories, segments)` constructor. Use the default constructor instead. <!-- IOTSDK-12269 -->
- Navigation: Deprecated `GPXOptions` constructor that takes speed in meters per second. Please use the default constructor instead. <!-- IOTSDK-10988 -->
- Navigation: Deprecated `DynamicRoutingEngineOptions` constructor that takes parameters. Please use the newly added default constructor `DynamicRoutingEngineOptions.withAllDefaults()` instead. <!-- IOTSDK-10988 -->
- Deprecated `CarOptions` constructor. Use `CarOptions.withDefaults()` instead. <!-- IOTSDK-10988 -->
- Routing: Deprecated a route's `Link`. Use `Span` instead. <!-- IOTSDK-12048 -->
- MapDownloader: Deprecated `Region` constructor and `Region.withDefaults()`. Use `Region.withAllDefaults()` instead. <!-- IOTSDK-12264 -->
- Routing: Deprecated `PedestrianOptions(routeOptions, textOptions, avoidanceOptions, walkSpeedInMetersPerSecond)` constructor. Use the default constructor instead. <!-- IOTSDK-12269 -->
- Routing: Deprecated `TransitWaypoint` constructor that takes all parameters. Please use the default constructor instead. <!-- IOTSDK-10988 -->
- Routing: Deprecated `TransitSectionDetails(transport, intermediateStops, agency, attributions, fares, incidents)` constructor. Use the default constructor instead. <!-- IOTSDK-12269 -->
- Deprecated `TruckOptions` constructor. Use `TruckOptions.withDefaults()` instead. <!-- IOTSDK-10988 -->
- Routing: Deprecated `RouteTextOptions(language, instructionFormat, unitSystem)` constructor. Use the default constructor instead. <!-- IOTSDK-12269 -->
- Deprecated `EVTruckOptions` constructor. Use `EVTruckOptions.withDefaults()` instead. <!-- IOTSDK-10988 -->
- Deprecated `sdk.routing.TransportMode` enum. Use the newly introduced 'sdk.transport.TransportMode' instead. <!-- IOTSDK-11015 -->
- Routing: Deprecated `FarePrice(type, estimated, currency, validityPeriodInSeconds, minimum, maximum)` constructor. Use the default constructor instead. <!-- IOTSDK-12269 -->
- Routing: Deprecated `ScooterOptions(routeOptions, textOptions, avoidanceOptions, allowHighway)` constructor. Use the default constructor instead. <!-- IOTSDK-12269 -->
- Navigation: Deprecated the `CameraSettings` constructor that takes `cameraDistanceInMeters`, `cameraTiltInDegrees`, `cameraBearingInDegrees`. Please use the default constructor instead. <!-- IOTSDK-10988 -->

#### Resolved Issues

- Navigation: Fixed an issue with truck vehicle restriction notifications. <!-- IOTSDK-11502 -->
- Fixed: The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 --> <!-- HARP-8095 -->
- Fixed: Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 --> <!-- IOTSDK-7197 -->
- Fixed: Navigation: Maneuver voice notifications are sometimes triggered too early. <!-- IOTSDK-10787 --> <!-- IOTSDK-10787 -->
- Fixed: When `cachePath` and `persistentMapStoragePath` are changed via `SDKOptions`, then it may not change the default path. <!-- IOTSDK-11974 --> <!-- IOTSDK-11974 -->
- Fixed `ManeuverNotifications` for pedestrians: The timing when to trigger voice notifications is now adapted for pedestrians based on the set transport mode. <!-- IOTSDK-10645 -->
- Fixed: Truck routes that are imported via `importRoute()` may be result in a `RoutingError.NO_ROUTE_FOUND` error as certain truck restrictions may be violated along the road. This is incorrect and instead the resulting route should contain the violated restrictions as part of the route's `SectionNotice`. <!-- IOTSDK-11864 --> <!-- IOTSDK-11864 -->
- Fixed `VisualNavigator` that was showing two location indicators when a custom location indicator was set. <!-- IOTSDK-11605 -->

#### Known Issues

- Navigation: Outlines for `MapPolyline` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 --> <!-- HARP-15072 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 --> <!-- IOTSDK-7368 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 --> <!-- IOTSDK-7051 -->
- `MapPolyline` instances ignore alpha color settings and will appear fully opaque. <!-- IOTSDK-5267 --> <!-- IOTSDK-5267 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 --> <!-- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 --> <!-- IOTSDK-6759 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 --> <!-- IOTSDK-8521 -->
- `RoutingEngine`: The route import feature via a list of `Locations` cannot be used yet commercially and requires custom access credentials. Please contact your sales representative to get access. <!-- IOTSDK-12285 --> <!-- IOTSDK-12285 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- IOTSDK-11931 --> <!-- IOTSDK-11931 -->

### Version 4.10.0.0

#### New Features

- Navigation: Added `MilestoneStatusListener` that informs if a milestone has been reached or missed. For this, check the newly introduced `MilestoneStatus`.
- `MapView`: Added support for Mercator projection when a `MapView` is created programmatically. Added `HereMapOptions` and `MapProjection` that allow to specify the map projection. Enhanced constructor of `HereMap` with optional `options` parameter of type `HereMapOptions`. Examples:
 - `HereMap(..., options: HereMapOptions(MapProjection.globe),)`
 - `HereMap(..., options: HereMapOptions(MapProjection.webMercator),)` <!-- IOTSDK-8924 -->
- Added `MapContext` class and added `getMapContext()` method to `HereMapController`. A `MapContext` is needed when custom data sources for map tiles should be created, such as the new `RasterDataSource` to support custom raster layers on a `MapView`. <!-- IOTSDK-11464 -->
- `MapView`: Added support custom raster layers that can be shown as tile overlay on top of the map. Note: This is a beta release of this feature, so there could be a few bugs and unexpected behaviors. Related APIs may change for new releases without a deprecation process. The following classes have been added to support custom raster layers:
 - Added `RasterDataSource` which represents the source of raster tile data to
display. It also allows changing its configuration.
 - Added `RasterDataSourceConfiguration` which is used to specify a configuration
for the data source, including URL, tiling scheme, storage levels and caching
parameters.
 - Added `TilingScheme` enum which specifies how the tile data has to be interpreted.
 - Added `RasterDataSourceListener` interface which can be used to receive
notifications from the `RasterDataSource`.
 - Added `MapLayer` class which represents a renderable map overlay and controls
its visibility.
 - Added `MapLayerBuilder` which is used to create `MapLayer` objects.
 - Added `MapLayerPriority` which specifies the order of drawing a map layer.
 - Added `MapLayerVisibilityRange` which specifies at which zoom levels the map
layer will become visible.
 - Added `MapContentType` which specifies the type of data shown by the `MapLayer`. <!-- IOTSDK-12029 -->
- Added support for feature configurations that allow to specify how much map data should be loaded when panning the `MapView` or when downloading a new `Region` for offline usage. For example, if a feature like turn-by-turn navigation is never used in an application, it can be removed. As a result, when panning the `MapView` less data will be downloaded into the cache. In addition, when downloading a new `Region`, its size will be smaller. By default, all features are enabled. However, if a "FeatureConfiguration" is present in the `AndroidManifest` and/or `PList` file, then only the listed features will be _enabled_, all others will be _disabled_. If you want to disable only one feature, then all other features need to be present, or they will be also disabled. For example, the following enables only _navigation_ and _truck_ features and disables all others on Android devices: `<meta-data android:name="com.here.sdk.feature_configuration" android:value="NAVIGATION, TRUCK" />` and on iOS devices: `<key>FeatureConfiguration</key><array><string>NAVIGATION</string><string>TRUCK</string></array>`. As of now, these features can be specified:
  1. "DETAIL_RENDERING": Additional rendering details like buildings. Only used for the `MapView`.
  2. "NAVIGATION": Map data that is used for map matching during navigation. When not set, navigation may not work properly when being used offline.
  3. "OFFLINE_SEARCH": Map data that is used to search. When not set, the `OfflineSearchEngine` may not work properly when being used offline.
  4. "OFFLINE_ROUTING": Map data that is used to calculate routes. When not set, the `OfflineRoutingEngine` may not work properly when being used offline.
  5. "TRUCK": Map data that is used to calculate truck routes. When not set, the `OfflineRoutingEngine` may not work properly when being used offline to calculate truck routes. It is also used for map matching during truck navigation. When not set, truck navigation may not work properly when being used offline. <!-- IOTSDK-10554 -->
- The HERE SDK is now compatible with [Dart FFI](https://pub.dev/packages/ffi) package versions `>=1.0.0 <=1.1.2` - instead of just supporting FFI 1.0. <!-- IOTSDK-11438 -->
- `MapView`: Added support for textured 3D landmarks. Enable 3D landmarks with the new `MapScene.Layers.LANDMARKS` constant like so: `_hereMapController.mapScene.setLayerVisibility(MapSceneLayers.landmarks, VisibilityState.visible)`. Note that landmarks are only supported for newer map data >= 25, see `mapUpdater.getCurrentMapVersion()`. To ensure that 3D landmarks are visible, a map update may be required. Once a `Region` was updated, the map cache will be aligned automatically. Note that landmarks are released as beta. <!-- IOTSDK-3711 -->
- Added `HereMapControllerCore` class. Added `hereMapControllerCore` property to `HereMapController`. `HereMapControllerCore` is used to initialize a `MapLayer` that can be used with a `MapLayerBuilder` to support custom raster layers. <!-- IOTSDK-11464 -->
- Import routes: Added `RouteHandle​(String handle)` constructor that allows to create a `RouteHandle` from a given string handle. Such a string can be provided from other backend sources such as HERE REST APIs and it is valid for a couple of hours. The string encodes a calculated route and it can be used to import this route via the newly added method `importRouteFromHandle(RouteHandle routeHandle, RefreshRouteOptions refreshRouteOptions,
CalculateRouteCallback callback)` of the `RoutingEngine` for further use with the HERE SDK. Note: This is a beta release of this feature. <!-- IOTSDK-10242 -->
- Search: Added a default constructor for `Address`. <!-- IOTSDK-10988 -->
- Added support for BYOD (bring your own data) at runtime when searching for places. It's now possible to inject custom data for places that can be found with the `OfflineSearchEngine`. Such personal places can be found by regular queries. The results are ranked as other places coming directly from HERE. A new `GeoPlace` class was introduced that can contain custom place data. Multiple `GeoPlace` instances can be filled into a new data source called `MyPlaces`. This data source can be attached to the `OfflineSearchEngine` with its new `attach()` method. The added `OnTaskCompleted` event and `TaskOutcome` class are used to communicate the result of this asynchronous operation. <!-- IOTSDK-11379 -->
- Added HERE positioning support for Android 12. If an application targets Android SDK version 31 or higher, users need to grant the device's "precise" location. When being prompted, it is not enough to select the "approximate" precision. Therefore, `ACCESS_COARSE_LOCATION` and `ACCESS_FINE_LOCATION` permissions need to be present in a manifest file. HERE positioning needs the fine location permission in order to use GNSS and to make cellular and WiFi scans. <!-- POSTI-1954 -->
- `OfflineRoutingEngine`: `Maneuver.getExitSignTexts()` is now supported when calculating routes offline. <!-- IOTSDK-8252 -->
- Voice guidance: The `ManeuverNotificationOptions` have been extended with additional options and a `ManeuverNotificationType` to filter when voice texts are given:
  - `enableDestinationReachedNotification`: A flag that indicates whether notifications for destination/stopover reached maneuvers should be generated.
  - `enableDoubleNotification`: A flag that indicates whether double maneuver notification should be generated.
  - `enableHighwayExit`: A flag that indicates whether highway exit information should be used when generating notifications.
  - `enablePhoneme`: A flag that indicates whether phoneme for direction information should be used when generating notifications.
  - `enableRoundaboutNotification`: A flag that indicates whether notifications for roundabout-related maneuvers should be generated.
  - `includedNotificationTypes`: List of `ManeuverNotificationType` for which notifications should be generated.
  - `roadNumberUsageOption`: An option whether road numbers should be used when generating notifications.
  - `signpostDirectionUsageOption`: An option whether signpost directions should be used when generating notifications.
  - `streetNameUsageOption`: An option whether street names should be used when generating notifications. <!-- IOTSDK-11880 -->

#### API Changes

- The lane assistance API is now stable and the beta status has been removed.
- Deprecated `MilestoneReachedListener`, please use the newly introduced `MilestoneStatusListener` instead. <!-- IOTSDK-10375 -->
- Removed the previously deprecated classes `MapCamera.Orientation`, `MapCamera.OrientationUpdate`, `MapCamera.State.targetOrientation` and all methods using them. Use instead the new methods that use the new classes `GeoOrientation`, `GeoOrientationUpdate` and `MapCamera.State.orientationAtTarget`. For example, instead of the removed method `MapCamera.lookAtPointWithOrientationAndDistance(GeoCoordinates target, OrientationUpdate orientation, Double distanceInMeters)` use now `MapCamera.lookAtPointWithGeoOrientationAndDistance(GeoCoordinates target, GeoOrientationUpdate orientation, Double distanceInMeters)`. <!-- IOTSDK-10619 -->
- Removed the previously deprecated `GeoCorridor.radiusInMeters` property. Use the new property `GeoCorridor.halfWidthInMeters` instead. <!-- IOTSDK-10069 -->
- Removed the previously deprecated `FarePrice.unit` property. Use instead the `FarePrice.validityPeriodInSeconds` property. <!-- IOTSDK-10004 -->
- Removed the previously deprecated method `MapCamera.animateToAreaWithGeoOrientationAndViewRectangle(GeoBox target, GeoOrientationUpdate orientation, Rectangle2D viewRectangle, int durationInMs)`. Use one of the other available methods instead. <!-- IOTSDK-11325 -->
- Removed the previously deprecated `Agency.icon` property. This feature is no longer supported. <!-- IOTSDK-9980 -->
- Removed the previously deprecated map schemes: "preview.normal.day.json", "preview.normal.night.json", "preview.hybrid.day.json", "preview.hybrid.night.json". Use corresponding standard schemes instead: `MapScheme.normalDay`, `MapScheme.normalNight`, `MapScheme.hybridDay`, `MapScheme.hybridNight`. <!-- IOTSDK-9944 -->
- Removed the previously deprecated `LaneAssistanceListener`. Use instead `ManeuverViewLaneAssistanceListener`. <!-- IOTSDK-9874 -->
- Deprecated the method `MapScene.setLayerState(String layerName, MapSceneLayerState newState)`. Use the new method `MapScene.setLayerVisibility(String layerName, VisibilityState visibility)` instead. Deprecated the enum `MapSceneLayerState`. Use the enum `VisibilityState` instead. <!-- IOTSDK-11526 -->

#### Resolved Issues

- Voice guidance: Fixed errors for Hindi and Korean voice packages, which were causing missing notifications for some cases. <!-- IOTSDK-11579 -->
- Fixed: During navigation, sometimes _turn now_ maneuver notifications are provided too early. <!-- IOTSDK-11644 -->
- Fixed `LocationIndicator` position on the screen when the `MapView` is tilted. <!-- IOTSDK-10552 -->
- Routing: It is now possible to set a stop duration for each waypoint so that a better overal ETA can be given. Added 'durationInSeconds' property to `Waypoint`. It defaults to 0. Note that it will be ignored for pass-through waypoints. <!-- IOTSDK-9800 -->
- Fixed: `MapViewLifecycleListener.onAttach()` is now called once `MapView` has been fully initialized. <!-- IOTSDK-11619 -->
- `LocationSimulatorOptions.notificationIntervalInMilliseconds`: Fixed issues with too short notification intervals. Values less than 1 ms are clamped to 1 ms to guarantee normal location updates during guidance simulation. <!-- IOTSDK-5431 -->
- Fixed: HERE Positioning / `LocationEngine` does not work yet with Android 12. <!-- IOTSDK-11809 -->
- Fixed: During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. A new `MilestoneStatusListener` has been added that informs if a milestone has been reached or missed. <!-- IOTSDK-7167 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Navigation: Maneuver voice notifications are sometimes triggered too early. <!-- IOTSDK-10787 -->
- Outlines for `MapPolyine` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- Truck routes that are imported via `importRoute()` may be result in a `RoutingError.NoRouteFound` error as certain truck restrictions may be violated along the road. This is incorrect and instead the resulting route should contain the violated restrictions as part of the route's `SectionNotice`. <!-- IOTSDK-11864 -->
- Offline maps: When the same `Region` is downloaded multiple times, then multiple attempts to download the data are being made instead of answering with an error that a download for this `Region` is already in progress. <!-- IOTSDK-11931 -->
- When `cachePath` and `persistentMapStoragePath` are changed via `SDKOptions`, then it may not change the default path. <!-- IOTSDK-11974 -->

### Version 4.9.4.0

#### New Features

- Routing: Introduced `Departure` and `Arrival` time for each `Section` of a `Route`. <!-- IOTSDK-10749 -->
- Routing: Added support for bicycles. Now it is possible to create bicycle routes online with the `RoutingEngine` using `BicycleOptions`. Added also `TransportMode.bicycle`. <!-- IOTSDK-11555 -->
- Increased the supported maximum Flutter version from 2.5.2 to 2.5.3. The maximum supported Dart version was updated from 2.14.3 to 2.14.4. Newer versions may also work, but are not guaranteed to work. <!-- IOTSDK-11793 -->
- Routing: Added optional field `nameHint` to `Waypoint`. For cases when there are multiple places at the same geographic coordinate, this hint can help the `RoutingEngine` to find the expected place. For example, "North" can be set to differentiate between interstates "I66 North" and "I66 South". <!-- IOTSDK-8696 -->
- Routing: It's now possible to set `TaxiOptions.allowDriveThroughTaxiRoads`. It allows to calculate routes that make use of roads and lanes that are reserved for taxis. <!-- IOTSDK-11771 -->
- Bicycle routes are now also supported for turn-by-turn navigation and tracking. <!-- IOTSDK-11555 -->

#### Resolved Issues

- Fixed: In rare cases, the map view can show a gray screen right after start-up and the application may appear not responding (ANR). <!-- IOTSDK-10531 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. In rare cases, this can lead to missed milestone reached events. <!-- IOTSDK-7167 -->
- Navigation: Maneuver voice notifications are sometimes triggered too early. <!-- IOTSDK-10787 -->
- Outlines for `MapPolyine` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- Navigation: Sometimes _turn now_ maneuver notifications are provided too early. <!-- IOTSDK-11644 -->
- HERE Positioning / `LocationEngine` does not work yet with Android 12. Support is planned with HERE SDK 4.10. <!-- IOTSDK-11809 -->
- Truck routes that are imported via `importRoute()` may be result in a `RoutingError.NoRouteFound` error as certain truck restrictions may be violated along the road. This is incorrect and instead the resulting route should contain the violated restrictions as part of the route's `SectionNotice`. <!-- IOTSDK-11864 -->

### Version 4.9.3.0

#### New Features

- `OfflineRoutingEngine`: Added support for notice spans - as already known from the online `RoutingEngine`. <!-- IOTSDK-9936 -->
- Added new map layer with `MapScene.Layers.safetyCameras` to show safety camera icons on the map. <!-- IOTSDK-11387 -->
- The visibility of embedded Carto POIs on the map can now be controlled with the new static method `MapScene.setPoiVisibility(List<String> categoryIds, VisibilityState visibility)` to set a `VisibilityState` for a list of POI categories. <!-- IOTSDK-8671 -->

#### API Changes

- Renamed the class `PickMapFeaturesResultPickPoiResult` to `PickPoiResult`. <!-- IOTSDK-11596 -->

#### Resolved Issues

- `OfflineRoutingEngine`: For truck routes now a `SectionNotice` with violated restrictions is provided instead of a route calculation resulting in a `RoutingError`. <!-- IOTSDK-11592 -->
- Navigation: Improved tunnel extrapolation during tracking mode. <!-- IOTSDK-11224 -->
- Fixed: Picking map features such as embedded POIs and map items via `mapView.pickMapItems` and `mapView.pickMapFeatures` is currently not possible at the same time. <!-- IOTSDK-11622 -->
- Fixed `enterHigway` maneuver action which was incorrectly reported as _turn left / right_ instead of _left / right fork_. <!-- IOTSDK-11628 -->
- Fixed: Changing `SpeedLimit` values are now detected correctly during a trip. <!-- IOTSDK-11539 -->
- Fixed: Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- Fixed: The traffic layers `MapScene.Layers.TRAFFIC_FLOW` and `MapScene.Layers.TRAFFIC_INCIDENTS` may not be instantly visible when starting an app for the first time. <!-- IOTSDK-11335 -->
- Fixed: Setting the map layer `VEHICLE_RESTRICTIONS` is currently ignored and the layer is not visible. <!-- OLPSUP-16401 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- In rare cases, the map view can show a gray screen right after start-up and the application may appear not responding (ANR). <!-- IOTSDK-10531 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. In rare cases, this can lead to missed milestone reached events. <!-- IOTSDK-7167 -->
- Navigation: Maneuver voice notifications are sometimes triggered too early. <!-- IOTSDK-10787 -->
- Outlines for `MapPolyine` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- Navigation: Sometimes _turn now_ maneuver notifications are provided too early. <!-- IOTSDK-11644 -->
- HERE Positioning / `LocationEngine` does not work yet with Android 12. Support is planned with HERE SDK 4.10. <!-- IOTSDK-11809 -->

### Version 4.9.2.0

#### Highlights

- Removed the _beta status_ for the HERE SDK for Flutter. Please note, that due to the rapid development of Dart and Flutter also our HERE SDK APIs may change for new releases without prior notice or a deprecation process. We expect that this will happen only for rare exceptional cases - if at all. From now on, for the majority of cases the HERE SDK for Flutter will follow a deprecation process and upcoming breaking changes will be communicated via Release Notes and in the API Reference documentation.
- Added iOS simulator support for M1 machines with a new _ios-arm64_x86_64-simulator_ framework that is included now in the XCFramework along with the _ios-arm64_ framework. Now it is possible to start simulators without any workaround on M1 machines. Note that bitcode optimization is only enabled for _ios-arm64_.

#### New Features

- Added `LocationIndicator.updateLocation(Location location, MapCameraUpdate cameraUpdate)` to update the location of the indicator and the target coordinates of the `MapView` at the same time - for example, when tracking the user's location. <!-- IOTSDK-11282 -->
- Offline Routing: Enabled a property for `RouteOptions` that allows to set an upper limit of the driving speed of a vehicle: `speedCapInMetersPerSecond` is available for car and truck transport modes. It can affect route path and ETA. Note that this property was already available for online routing. <!-- IOTSDK-9530 -->
- Added a feature to observe when a `MapCamera` animation or `flyTo()`-call has been completed: Added `AnimationListener` interface, 'AnimationState' enumeration, `MapCamera.startAnimationWithListener` method, `MapCamera.flyToWithOptionsAndGeoOrientationAndListener` and `MapCamera.fflyToWithOptionsAndGeoOrientationAndDistanceAndListener` methods. <!-- IOTSDK-11207 -->
- Added a feature to pick embedded Carto POIs. By default, embedded POIs are visible on the map and they can be picked now via `mapView.pickMapFeatures()` to get a `PickMapFeaturesResult` that contains a `PoiResult`. Check the Developer Guide for a usage example. <!-- IOTSDK-3882 -->
- Added a convenience feature to tie a `LocationIndicator` directly to the `MapView`'s life cycle'. For example, be calling the new `enable()` method, the `LocationIndicator` is visible on the map. This has the same affect as when calling `mapView.addLifecycleDelegate(locationIndicator)`. Added factory method `LocationIndicator.withMapView(MapViewBase mapView)`, added methods `LocationIndicator.enable(MapViewBase mapView)`, `LocationIndicator.disable()`. <!-- IOTSDK-10205 -->
- `MapMarkerCluster` items can now be picked - and when picking other map items, clustered markers are _no longer_ returned via `pickMapItemsResult.getMarkers()`. Instead, call the new `pickMapItemsResult.getClusteredMarkers()` method. See the `MapItems` example app and the Developer Guide for a usage example. <!-- IOTSDK-10206 -->

#### Resolved Issues

- `VisualNavigator`: Fixed out of sync maneuver arrows after a route recalculation. <!-- IOTSDK-11409 -->
- Fixed: Depending on your configuration when running on Xcode simulator, you may need to modify the `post_install` task in the generated Podfile. Now, arm64 M1 support is already integrated by default. <!-- IOTSDK-8491 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- In rare cases, the map view can show a gray screen right after start-up and the application may appear not responding (ANR). <!-- IOTSDK-10531 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. In rare cases, this can lead to missed milestone reached events. <!-- IOTSDK-7167 -->
- Navigation: Maneuver voice notifications are sometimes triggered too early. <!-- IOTSDK-10787 -->
- The traffic layers `MapScene.Layers.TrafficFlow` and `MapScene.Layers.TrafficIncidents` may not be instantly visible when starting an app for the first time. <!-- IOTSDK-11335 -->
- Outlines for `MapPolyine` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- Setting the map layer `VEHICLE_RESTRICTIONS` is currently ignored and the layer is not visible. <!-- OLPSUP-16401 -->
- Picking map features such as embedded POIs and map items via `mapView.pickMapItems` and `mapView.pickMapFeatures` is currently not possible at the same time. <!-- IOTSDK-11622 -->

### Version 4.9.1.0

#### Highlights

- The minimum supported Flutter version was raised from 2.0.6 to 2.2.3. Flutter 2.5.2 (and therefore Dart 2.14.3) is now officially supported.

#### New Features

- Offline routing: Added `PreActions` and `PostActions` handling related to a time needed to board/disembark a ferry. <!-- IOTSDK-9406 -->
- Added `removeMapMarkers()` method to `MapScene` class. It removes multiple map markers in a batch call. <!-- IOTSDK-5669 -->

#### API Changes

- Removed deprecated tag for `persistentMapStorageFolderAccessDenied`. `persistentMapStorageFolderAccessDenied` is not deprecated anymore. <!-- IOTSDK-9753 -->
- Deprecated `MapCamera.animateToAreaWithGeoOrientationAndViewRectangle(GeoBox target, GeoOrientationUpdate orientation, Rectangle2D viewRectangle, int durationInMs)`. Use one of the other available methods instead. <!-- IOTSDK-10924 -->
- Deprecated `MapCameraFlyToOptions.durationInMs`, use `MapCameraFlyToOptions.duration` instead. <!-- IOTSDK-10922 -->

#### Resolved Issues

- Fixed: Route imports no longer fail when `Location.time` is set. <!-- IOTSDK-11353 -->
- Navigation: Fixed location jumps after leaving tunnels. <!-- IOTSDK-10860 -->
- ReturnToRoute: Fixed rerouting during navigation. It considers now the original `RouteOptions`. <!-- IOTSDK-11384 -->
- Offline routing: Fixed missing country code value for `Maneuver` class. <!-- IOTSDK-11240 -->
- Fixed: `VisualNavigator` now restores/removes map items when attaching or detaching a mapview. <!-- IOTSDK-11409 -->
- Fixed navigation issues when obsolete GPS locations where being queued and processed after new locations were already available. <!-- IOTSDK-11104 -->
- Fixed: Navigation now prefers the optional `Location.time` when set. <!-- IOTSDK-11330 -->
- Fixed: `VisualNavigator` now updates `MapView` based on events sent by `MapViewLifecycleListener`. This prevents that tracking is stopped after coming back to foreground. <!-- IOTSDK-10955 -->
- Fixed a short pink screen, that can appear before the first display of a `MapView`. <!-- HARP-16927 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- In rare cases, the map view can show a gray screen right after start-up and the application may appear not responding (ANR). <!-- IOTSDK-10531 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. In rare cases, this can lead to missed milestone reached events. <!-- IOTSDK-7167 -->
- Navigation: Maneuver voice notifications are sometimes triggered too early. <!-- IOTSDK-10787 -->
- `MapMarkerCluster` groups are not directly pickable yet. As a workaround, overlapping markers can be identified by setting a unique `Metadata` key to the contained `MapMarker` items of a cluster. See the _MapItems_ app for an example. <!-- IOTSDK-10206 -->
- The traffic layers `MapScene.Layers.TrafficFlow` and `MapScene.Layers.TrafficIncidents` may not be instantly visible when starting an app for the first time. <!-- IOTSDK-11335 -->
- Outlines for `MapPolyine` lines can show a minimal gap at certain zoom levels. As a workaround use a round `LineCap` style. <!-- HARP-15072 -->
- Setting the map layer `VEHICLE_RESTRICTIONS` is currently ignored and the layer is not visible. <!-- OLPSUP-16401 -->
- Depending on your configuration when running on Xcode simulator, you may need to modify the `post_install` task in the generated Podfile: <!-- IOTSDK-8491 -->

```dart
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
          config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64' if `uname -m` == "x86_64\n"
        end

  end
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.4'
        end
    end
    project.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.4'
    end
end
```

### Version 4.9.0.0

#### New Features

- Added new animation features to `MapCamera` with `startAnimation(MapCameraAnimation)`, `EasingFunction` and `KeyframeInterpolationMode`. Added related classes `GeoCoordinatesKeyframe`, `GeoOrientationKeyframe`, `Point2DKeyframe`, `ScalarKeyframe`, `MapCameraAnimation`, `MapCameraAnimationFactory` and `MapCameraKeyframeTrack`. <!-- IOTSDK-10983 -->
- Routes can now be imported: Added `routingEngine.importRoute()` to import a route from a list of `GeoCoordinates` and `RouteOptions`. <!-- IOTSDK-10954 -->
- Added support for map marker clustering with the new classes `MapMarkerCluster` and `MapMarkerCluster.ImageStyle`. A marker cluster can be added/removed with `MapScene.addMapMarkerCluster()/MapScene.emoveMapMarkerCluster`. See the _MapItems_ example app for a usage example. <!-- IOTSDK-9109 -->
- Search: Added support for offline `Suggestion` results. Check the _SearchHybrid_ example app for a usage example. <!-- IOTSDK-10822 -->
- Added optional field `time` to `Location` class to specify the time when the location data was set. <!-- IOTSDK-10954 -->
- Batch support for `MapMarker`: Added method to add multiple `MapMarker` items at once. With `mapScene.addMapMarkers()` a list of `MapMarker` items can be added to a `MapScene` with a single batch call. <!-- IOTSDK-9884 -->
- Search: Added `PlaceType.intersection` to indicate an intersection of at least two streets. Note: This is a beta feature. <!-- IOTSDK-9900 -->

#### API Changes

- Removed the previously deprecated factory method in `Location` class. Use one of the other available constructors instead. <!-- IOTSDK-10954 -->
- Removed the previously deprecated `MapRepresentable` interface and `addMapRepresentable` and `removeMapRepresentable` methods from `HereMapController`. Use the `MapViewLifecycleListener` instead. <!-- IOTSDK-9302 -->
- Removed the previously deprecated `NavigableLocation.streetName` and `NavigableLocation.speedLimitInMetersPerSecond` properties. Use the `RoadTextsListener` and `SpeedLimit` instead. <!-- IOTSDK-10101 -->
- Map schemes: Removed the previously deprecated scene configuration files: "legacy.grey.day.json", "legacy.grey.night.json", "legacy.hybrid.day.json", "legacy.hybrid.night.json", "legacy.normal.day.json", "legacy.normal.night.json". Use the related `MapSchemes` instead. <!-- IOTSDK-9941 -->
- Removed the previously deprecated `Notice` class, `NoticeCode` enum and `Section.notices` property. Use `SectionNoticeCode`, `SectionNotice` class and `Section.getSectionNotices()` method instead. <!-- IOTSDK-10102 -->
- Search: Removed the following fields from `Address` class that have been previously deprecated: `stateName`, `countyName`, `streetName`, `additionalData`. Please use `state`, `county` and `street` instead. The field `additionalData` was already unused. <!-- IOTSDK-8376 -->
- Removed the previously deprecated `MapLoaderError.duplicateCatalog`. Now `MapLoaderError.internalError` is returned in case of a duplicated catalog. <!-- IOTSDK-8588 -->
- Search: Removed the perviously deprecated `optionsNotAvailable` value from the `SearchError` enum. It was replaced by the `SearchError.invalidParameter` value. <!-- IOTSDK-9403 -->
- Removed the previously deprecated  `greyDay` and `greyNight` from `MapScheme` enum. Use the _normal_ map scheme variants instead. <!-- IOTSDK-9940 -->
- Removed the previously deprecated `LocationUpdateListener` class. `LocationListener` should be used instead. <!-- POSTI-1159 -->
- Deprecated field `timestamp` in `Location` class, please use the newly introduced `time` field instead. <!-- IOTSDK-10954 -->

#### Resolved Issues

- Improved guidance user experience: Now incoming locations are discarded if the processing of previous location updates has not yet been completed. <!-- IOTSDK-10796 -->
- Fixed: Sometimes, physical road dividers are not considered for offline routing. <!-- IOTSDK-9187 -->
- Navigation: Fixed flickering of `LocationIndicator`. <!-- IOTSDK-7579 -->
- Fixed: Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Fixed: Leaving an app via back press on Android devices can lead to a freeze when the app is restarted. This can happen when the `LocationEngine` could not be properly stopped or the `VisualNavigator` is still rendering. <!-- IOTSDK-10214 -->
- Fixed: `MapUpdater`: After initial download of a region a newer version is already available for download. <!-- IOTSDK-10417	 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- In rare cases, the map view can show a gray screen right after start-up and the application may appear not responding (ANR). <!-- IOTSDK-10531 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. In rare cases, this can lead to missed milestone reached events. <!-- IOTSDK-7167 -->
- Navigation: Maneuver voice notifications are sometimes triggered too early. <!-- IOTSDK-10787 -->
- `MapMarkerCluster` groups are not directly pickable yet. As a workaround, overlapping markers can be identified by setting a unique `Metadata` key to the contained `MapMarker` items of a cluster. See the _MapItems_ app for an example. <!-- IOTSDK-10206 -->
- The traffic layers `MapScene.Layers.TrafficFlow` and `MapScene.Layers.TrafficIncidents` may not be instantly visible when starting an app for the first time. <!-- IOTSDK-11335 -->
- Flutter 2.5 is not officially supported yet. To run apps on simulator, modify the `post_install` task in the generated Podfile: <!-- IOTSDK-8491 -->

```dart
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
          config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64' if `uname -m` == "x86_64\n"
        end

  end
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.4'
        end
    end
    project.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.4'
    end
end
```

### Version 4.8.4.0

#### New Features

- Navigation: Added `distanceType` to `SafetyCameraWarning` and `TruckRestrictionWarning`. It tells if the event is ahead or was just passed by. <!-- IOTSDK-10695 -->
- Routing: Added `getDurationInSeconds` method to the `Maneuver` class to get the estimated duration of a maneuver. <!-- IOTSDK-10997 -->
- Added new factory method for [DMS](https://gisgeography.com/decimal-degrees-dd-minutes-seconds-dms/) and decimal `GeoCoordinates` to convert one into the other with `GeoCoordinates.fromString()`. <!-- IOTSDK-10260 -->
- Search: Added `ResponseDetails` as result type that provides the `requestId` of a search request and a `correlationId` to identify multiple, related queries. <!-- IOTSDK-10420 -->
- Routing: Added a static `fromString` method to `SegmentReference` to generate instances of this class from a well-formatted String. Usually, `SegmentReference` instances are only accessible from the `Span` of a `Route`'s `Segment`. <!-- IOTSDK-10805 -->

#### API Changes

- Routing: For the new toll cost API, now the newly added `RouteOptions.enableTolls` flag must be set to get toll costs. It is set to `false` by default. When this flag is enabled, toll data is requested for toll applicable transport modes. <!-- IOTSDK-11004 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- Leaving an app via back press on Android devices can lead to a freeze when the app is restarted. This can happen when the `LocationEngine` could not be properly stopped or the `VisualNavigator` is still rendering. <!-- IOTSDK-10214 -->
- `MapUpdater`: After initial download of a region a newer version is already available for download. <!-- IOTSDK-10417	 -->
- In rare cases, the map view can show a gray screen right after start-up and the application may appear not responding (ANR). <!-- IOTSDK-10606, IOTSDK-10531 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. In rare cases, this can lead to missed milestone reached events. <!-- IOTSDK-7167 -->
- Navigation: Maneuver voice notifications are sometimes triggered too early. <!-- IOTSDK-10787 -->

### Version 4.8.3.0

#### Highlights

- The latest stable Flutter version that works with the HERE SDK was updated from 2.2.2 to 2.2.3. Newer versions _may_ also work, but are not guaranteed to work.

#### New Features

- Public transit routes: Added support for new `pedestrian` sections to provide better information on in-station walks, for example, when walking from a place of type `accessPoint` type to a place of type `station`. <!-- IOTSDK-10927 -->
- Routing: Added `RouteOptions.enableTrafficOptimization` property which is true by default, and when set to false, it doesn't consider traffic information and ignores `RouteOptions.departureTime`. <!-- IOTSDK-9976 -->
- Routing: It's now possible to avoid individual segments on a `Route`. With the newly added `segments` field in `AvoidanceOptions` users can specify the parts of a route they would like to avoid after a recalculation. The segments can be identified via `Route -> Section -> Span -> SegmentReference`.
  - Added `SegmentReference` class that represents a reference to a segment id with a travel direction.
  - Added `getSegmentReference` method to the `Span` class.
  - Added `TravelDirection` enum that indicates the travel direction along a segment.
- Offline routing: When using `OfflineRoutingEngine.returnToRoute()` the new route contain now the initial `RouteHandle`.
- Added enhanced APIs to control the `MapCamera` with the new classes `MapCameraUpdate`, `MapCameraUpdateFactory` and `MapMeasure`. Added the `applyUpdate` method to `MapCamera` that accepts a `MapCameraUpdate` as parameter.
- Routing: Added `violatedAvoidSeasonalClosure`, `violatedAvoidTollTransponder`, `seasonalClosure`, `tollTransponder`, `tollsDataUnavailable` and `chargingStopNotNeeded` symbols to the `SectionNoticeCode` enum.
- Navigation: Voice guidance now supports four additional regional languages in India: Bengali, Kannada, Malayalam, and Telugu.

#### API Changes

- Transit routes no longer provide fare information and the `TransitSectionDetails.fares` list is always empty. <!-- IOTSDK-10950 -->
- Routing: Deprecated `SectionNoticeCode.violatedPedestrianOption` symbol. It will be removed in v4.11.0 as it is no longer supported.
- Deprecated `persistentMapStorageFolderAccessDenied` and `failedToLockPersistentMapStorageFolder` values from the `InstantiationErrorCode` enum. The persistent storage directory is no longer locked.

#### Resolved Issues

- Fixed: Missing language support for `no-NB` and `pt-BR` for distant maneuver notifications. <!-- IOTSDK-10466 -->
- Fixed: It is not possible to set both `RouteOptions.departureTime` and `RouteOptions.arrivalTime` at the same time. Plus, `RouteOptions.arrivalTime` is ignored when `RouteOptions.enableTrafficOptimization` is set to false. <!-- IOTSDK-9760 -->
- Voice navigation: For Russian maneuver notifications, the abbreviations and declensions handling has been fixed.

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- Leaving an app via back press on Android devices can lead to a freeze when the app is restarted. This can happen when the `LocationEngine` could not be properly stopped or the `VisualNavigator` is still rendering. <!-- IOTSDK-10214 -->
- `MapUpdater`: After initial download of a region a newer version is already available for download. <!-- IOTSDK-10417	 -->
- In rare cases, the map view can show a gray screen right after start-up and the application may appear not responding (ANR). <!-- IOTSDK-10606, IOTSDK-10531 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. In rare cases, this can lead to missed milestone reached events. <!-- IOTSDK-7167 -->
- Navigation: Maneuver voice notifications are sometimes triggered too early. <!-- IOTSDK-10787 -->

### Version 4.8.2.0

#### New Features

- Improved search for electric vehicle charging stations: Added classes `EVChargingPool` and `EVChargingStation`. A charging pool for electric vehicles is an area equipped with one or more charging stations. A charging station defines a group of connectors for electrical vehicles that share a common charging connector type and max power level. Note: This is a beta feature. <!-- IOTSDK-10800 -->
- Navigation: Improved `TruckRestrictionWarning` and `SafetyCameraWarning` events. With the new `WarningType` you can now get notified if the location of the truck restriction or the safety camera lies ahead or if it was just passed by. <!-- IOTSDK-10695 -->
- Improved search for electric vehicle charging stations: Added property `Details.evChargingPool` that represents the details of the charging pool for electric vehicles. Note: This is a beta feature. <!-- IOTSDK-10810 -->
- Routing: Added information on toll costs with a new `PaymentMethod` enum, `TollFare` & `Toll` structs and `Section.tolls` property. Note: This is a beta feature. <!-- IOTSDK-10617 -->

#### API Changes

<!-- - Users of the exclusive _Skytree Edition_ no longer need to load the Japan map scheme for a `MapScene` via `loadScene("japan.ocm.day.json", loadSceneCallback)`. This special map scheme covers the entire world and it is now automatically enabled for users of the _Skytree Edition_ based on the set credentials. IOTSDK-8672 -->
- Deprecated `DynamicRoutingListener` which is replaced by the newly introduced `DynamicRoutingEngineListener`. The listener is now set with the new `DynamicRoutingEngine.start(route, listener)` method which can throw a `StartException` if no `RouteHandle` was requested for the route. Route calculation errors are propagated via the newly added `DynamicRoutingListener.onRoutingError()`. Check the _navigation_app_ app for a usage example. <!-- IOTSDK-10733 -->

#### Resolved Issues

- `ReturnToRoute`: Fixed rare cases that could lead to a crash or invalid maneuvers when the feature was used offline. <!-- IOTSDSK-10305 -->
- Corrected the Hindi translation for "yards". <!-- IOTSDK-6557 -->
- Navigation: Corrected the Greek translation of the "turn sharp" maneuver notification. <!-- IOTSDK-10112 -->
- `ReturnToRoute` during navigation: Fixed possible negative values for maneuver lengths and removed maneuvers with no geometry for cases when `returnToRoute` was called multiple times. As a benefit, now a longer part of the original route can be preserved. <!-- IOTSDK-10009 -->
- Fixed: In rare cases, `Storage.LevelDB` related crashes can occur when starting the app. <!-- IOTSDK-10512 -->
- Fixed: Voice navigation: The voice announcements for multiple speed cameras that are very close to each other are delivered for both cameras at the same time, so that the first event may be skipped. <!-- IOTSDK-10566 -->
- Fixed: Navigation: When using `JunctionViewLaneAssistance` for very long routes then a significant delay can occur before navigation is actually started. Currently, this happens because the entire route is traversed beforehand. <!--IOTSDK-10660 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- Leaving an app via back press on Android devices can lead to a freeze when the app is restarted. This can happen when the `LocationEngine` could not be properly stopped or the `VisualNavigator` is still rendering. <!-- IOTSDK-10214 -->
- `MapUpdater`: After initial download of a region a newer version is already available for download. <!-- IOTSDK-10417	 -->
- In rare cases, the map view can show a gray screen right after start-up and the application may appear not responding (ANR). <!-- IOTSDK-10606, IOTSDK-10531 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. In rare cases, this can lead to missed milestone reached events. <!-- IOTSDK-7167 -->
- Navigation: Maneuver voice notifications are sometimes triggered too early. <!-- IOTSDK-10787 -->

### Version 4.8.1.0

#### New Features

- Offline Maps: Extended the `MapDownloader` to check for broken maps with `getInitialPersistentMapStatus()`. Added also `repairPersistentMap()`, so that broken maps can be repaired asynchronously. Check the Developer Guide or the _OfflineMaps_ example app for a usage example.
- Routing: Added `NoRouteHandle` enum value to `RoutingError` to indicate that the route did not contain the required `RouteHandle`, which is needed, for example, to refresh a route.
- Search: Added new `name` property to `PlaceCategory` that provides a level 3 description.

#### API Changes

- Renamed `GeoCorridor.make()` to `GeoCorridor()`.
- Renamed `Navigator.make()` to `Navigator()`.
- Renamed `VenueEngine.make()` to `VenueEngine()`.

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- Leaving an app via back press on Android devices can lead to a freeze when the app is restarted. This can happen when the `LocationEngine` could not be properly stopped or the `VisualNavigator` is still rendering. <!-- IOTSDK-10214 -->
- `MapUpdater`: After initial download of a region a newer version is already available for download. <!-- IOTSDK-10417	 -->
- In rare cases, `Storage.LevelDB` related crashes can occur when starting the app. <!-- IOTSDK-10512 -->
- In rare cases, the map view can show a gray screen right after start-up and the application may appear not responding (ANR). <!-- IOTSDK-10606, IOTSDK-10531 -->
- Voice navigation: The voice announcements for multiple speed cameras that are very close to each other are delivered for both cameras at the same time, so that the first event may be skipped. <!-- IOTSDK-10566 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. In rare cases, this can lead to missed milestone reached events. <!-- IOTSDK-7167 -->
- Navigation: When using `JunctionViewLaneAssistance` for very long routes then a significant delay can occur before navigation is actually started. Currently, this happens because the entire route is traversed beforehand. <!--IOTSDK-10660 -->

### Version 4.8.0.0

#### Highlights

- The minimum supported Flutter and Dart version was raised to _Flutter 2.0_ and _Dart 2.12_.
- FFI 1.0 is now supported, which means that other third-party plugins also need to be updated to use FFI 1.0, or they can't be used together with the HERE SDK.
- Support for [null safety](https://dart.dev/null-safety#sidenav-2-4) was added. Null safety can be [optionally](https://dart.dev/null-safety/unsound-null-safety) disabled.
- It's no longer necessary to call `release()` to dispose an object. The method has been deprecated and it will be removed in the future. When still calling it, it will do nothing.
- A new _reference application_ for the HERE SDK for Flutter (_Navigate Edition_) was published on [GitHub](https://github.com/heremaps/here-sdk-ref-app-flutter). It shows how a complex and release-ready project targeting iOS and Android devices may look like. You can use it as a source of inspiration for your own HERE SDK based projects - in parts or as a whole. Many parts of the app overlap with the _Explore Edition_ - however, guidance requires the _Navigate Edition_. At the moment, only HERE SDK 4.7 is supported.

#### New Features

- Truck navigation: Added a listener for `TruckRestrictionWarning` to the `Navigator` and `VisualNavigator`, which is called at a specific distance while navigating along a route in order to warn about a truck restrictions ahead. It can contain multiple truck restrictions. For now, the following restrictions are possible: `WeightRestriction` and `DimensionRestriction`. Check the _Navigation_ example app for an usage example.
- Lane assistance: Added a `JunctionViewLaneAssistance` listener to `Navigator` and `VisualNavigator` that informs on the possible lanes and complex junctions.

#### API Changes

- Deprecated `MapCameraOrientation` - replaced with `GeoOrientation`
- Deprecated `MapCameraOrientationUpdate`  - replaced with `GeoOrientationUpdate`
- Deprecated `MapCameraState.targetOrientation` - replaced with `MapCameraState.orientationAtTarget`
- Deprecated `MapCamera.flyToWithOptionsAndOrientation(GeoCoordinates target, MapCameraOrientationUpdate orientation, MapCameraFlyToOptions animationOptions) → void` - replaced with `MapCamera.flyToWithOptionsAndGeoOrientation(GeoCoordinates target, GeoOrientationUpdate orientation, MapCameraFlyToOptions animationOptions) → void`
- Deprecated `MapCamera.flyToWithOptionsAndOrientationAndDistance(GeoCoordinates target, MapCameraOrientationUpdate orientation, double distanceInMeters, MapCameraFlyToOptions animationOptions) → void` - replaced with `MapCamera.flyToWithOptionsAndGeoOrientationAndDistance(GeoCoordinates target, GeoOrientationUpdate orientation, double distanceInMeters, MapCameraFlyToOptions animationOptions) → void`
- Deprecated `MapCamera.lookAtAreaWithOrientation(GeoBox target, MapCameraOrientationUpdate orientation) → void` - replaced with `MapCamera.lookAtAreaWithGeoOrientation(GeoBox target, GeoOrientationUpdate orientation) → void`
- Deprecated `MapCamera.lookAtAreaWithOrientationAndViewRectangle(GeoBox target, MapCameraOrientationUpdate orientation, Rectangle2D viewRectangle) → void` - replaced with `MapCamera.lookAtAreaWithGeoOrientationAndViewRectangle(GeoBox target, GeoOrientationUpdate orientation, Rectangle2D viewRectangle) → void`
- Deprecated `MapCamera.lookAtPointWithOrientationAndDistance(GeoCoordinates target, MapCameraOrientationUpdate orientation, double distanceInMeters) → void` - replaced with `MapCamera.lookAtPointWithGeoOrientationAndDistance(GeoCoordinates target, GeoOrientationUpdate orientation, double distanceInMeters) → void`
- Deprecated `MapCamera.orbitBy(MapCameraOrientationUpdate delta, Point2D origin) → void` - replaced with `MapCamera.orbitByWithGeoOrientation(GeoOrientationUpdate delta, Point2D origin) → void`
- Deprecated `MapCamera.setTargetOrientation(MapCameraOrientationUpdate orientation) → void` - replaced with `MapCamera.setOrientationAtTarget(GeoOrientationUpdate orientation) → void`
- Removed the previously deprecated `updateGeometry()` methid from `MapPolyline` and `MapPolygon`.
- Search: Removed previously deprecated fields in `Contact`: `emailAddresses`, `landlinePhoneNumbers`, `mobilePhoneNumbers`, `websiteAddresses`.
- Routing: Removed the previously deprecated `Arrival` and `Departure` classes.
- Changed the `DynamicRoutingEngine` constructor from `DynamicRoutingEngine.make()` to `DynamicRoutingEngine()`.
- Changed the `DynamicRoutingEngine` event from `etaDifferenceInMinutes` to `etaDifferenceInSeconds`.

#### Resolved Issues

- Navigation: Fixed a problem where intense CPU usage and memory consumption was observed for some routes when an application was listening for `SpeedLimits`.

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- Leaving an app via back press on Android devices can lead to a freeze when the app is restarted. This can happen when the `LocationEngine` could not be properly stopped or the `VisualNavigator` is still rendering. <!-- IOTSDK-10214 -->
- `MapUpdater`: After initial download of a region a newer version is already available for download. <!-- IOTSDK-10417	 -->
- In rare cases, `Storage.LevelDB` related crashes can occur when starting the app. <!-- IOTSDK-10512 -->
- In rare cases, the map view can show a gray screen right after start-up and the application may appear not responding (ANR). <!-- IOTSDK-10606, IOTSDK-10531 -->
- Voice navigation: The voice announcements for multiple speed cameras that are very close to each other are delivered for both cameras at the same time, so that the first event may be skipped. <!-- IOTSDK-10566 -->

### Version 4.7.7.0

#### Highlights

- Preview: Flutter version and FFI version have been raised. Support for null safety was introduced. It's no longer necessary to call release(). The HERE SDK _reference application_ was introduced on GitHub. See the details for all these changes in the highlights for the 4.8.0.0 release above.

#### New Features

- Search: Added `politicalView` member to `Place` class. The optional value can be checked if it is matching the one that was set beforehand via `SDKOptions`.
- `MapUpdater`: The current map version of a downloadable region is now exposed. This can be useful for debugging potential map data issues.
- Added a new `DynamicRoutingEngine` that allows to periodically request traffic-optimized routes. This can be useful to notify users on better routes while staying in a route planner or during a guidance context when the traffic situation has changed.

#### API Changes

- The map styles for `NORMAL_DAY`, `NORMAL_NIGHT`, `HYBRID_DAY` and `HYBRID_NIGHT` have been updated to the ones that have been made available as `preview` beforehand. The new map styles feature a clean and neutral base map and a street network with improved gray scales that allow a better hierarchy of elements that can be added on top.
- `MapView`: "Simplified Chinese", "Traditional Taiwan" and "Traditional Hong Kong" language labels are now supported.
- Removed the "fromLambda" constructor from all related Dart classes, for example `Gestures`, `MapDownloader`, `SearchEngine` and so on. Instead of creating a gesture listener like this: `tapListener = TapListener.fromLambdas(lambda_onTap: (Point2D p) { ... });` the code can be simplified now to: `tapListener = TapListener((Point2D p) { ... });`.
- Routing: Updated the API for the _returnToRoute_ and _refreshRoute_ features for `RoutingEngine` and `OfflineRoutingEngine`:
  - Changed the parameter order of `RoutingInterface.returnToRoute()`: The `startingPoint` parameter is now the second parameter, not the third parameter. The feature is still in beta.
  - Added a `startingPoint` parameter to the `RoutingEngine.refreshRoute()` method. In return, deleted `RefreshRouteOptions.updateStartingPoint()`. The feature is still in beta.
  - Deleted the ReturnToRouteEngine. Use the newly introduced `RoutingInterface.returnToRoute()` method instead.

#### Resolved Issues

- Fixed: A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- Fixed: When `MapMarker.setOverlapAllowed()` is set to false and the map is zoomed, this can lead to a flickering of the marker assets. <!-- IOTSDK-9885 -->
- Fixed: Navigation: In some cases, speed limit data may be missing, although it is available in HERE's database. <!-- IOTSDK-10174 -->
- `VisualNavigator`: An issue was fixed, where in a rare conditions map matched positions are temporarily missing between interpolations causing the map to rotate to a wrong direction or to not rotate at all.
- The `VisualNavigator` now renders correctly, even if the principal point of the map view was changed by an application.
- Fixed: Leaving an app via back press on Android devices can lead to a freeze when the app is restarted. This can happen when the `LocationEngine` could not be properly stopped or the `VisualNavigator` is still rendering. <!-- IOTSDK-10214 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- `MapUpdater`: After initial download of a region a newer version is already available for download. <!-- IOTSDK-10417	 -->

### Version 4.7.6.0

#### Highlights

- **Important note:** It is planned to raise the minimum supported Flutter and Dart version to _Flutter 2.0_ and _Dart 2.12_ with the upcoming major release v4.8.0. With this release we also plan to switch to FFI 1.0, which means that other third-party plugins also need to be updated to use FFI 1.0, or they can't be used together with the HERE SDK. In addition, we plan to introduce [null safety](https://dart.dev/null-safety#sidenav-2-4). Note that the HERE SDK is not compatible with [Flutter 2.2.0](https://flutter.dev/docs/development/tools/sdk/releases) or higher - as the HERE SDK does not yet support FFI 1.0 until v4.8.0.

#### New Features

- Offline maps: Added `MapUpdater` class that allows to update previously downloaded regions. It also allows to check if one or more updates are available. A usage example can be seen in the OfflineMaps example app.
- Improved map rendering performance on low end devices. <!-- IOTSDK-8666 -->
- Navigation: Added support for Serbian voice maneuver notifications during guidance.

#### Resolved Issues

- Fixed: Offline maps: Some downloadable region names are not fully localized yet. <!-- IOTSDK-9301 -->
- Fixed: Offline routing: Offline routes cannot be calculated in Japan. <!-- IOTSDK-8958 -->
- Offline Maps: A retryable error is not returned via `MapDownloader.onPause()`, instead the download is stopped and must be restarted instead of resumed. <!-- IOTSDK-10020 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- When `MapMarker.setOverlapAllowed()` is set to false and the map is zoomed, this can lead to a flickering of the marker assets. <!-- IOTSDK-9885 -->
- Navigation: In some cases, speed limit data may be missing, although it is available in HERE's database. <!-- IOTSDK-10174 -->
- Leaving an app via back press on Android devices can lead to a freeze when the app is restarted. This can happen when the `LocationEngine` could not be properly stopped or the `VisualNavigator` is still rendering. <!-- IOTSDK-10214 -->

### Version 4.7.5.0

#### Highlights

- **Important note:** It is planned to raise the minimum supported Flutter and Dart version to _Flutter 2.0_ and _Dart 2.12_ with the upcoming major release v4.8.0. With this release we also plan to switch to FFI 1.0, which means that other third-party plugins also need to be updated to use FFI 1.0, or they can't be used together with the HERE SDK. In addition, we plan to introduce [null safety](https://dart.dev/null-safety#sidenav-2-4). Note that the HERE SDK is not compatible with [Flutter 2.2.0](https://flutter.dev/docs/development/tools/sdk/releases) or higher - as the HERE SDK does not yet support FFI 1.0 until v4.8.0.

#### New Features

- Routing: Added avoidance options for pedestrians with `PedestrianOptions.avoidanceOptions`.
- Search: Added support to search along _longer_ route polylines with a `GeoCorridor`. Either increase `halfWidthInMeters` when set via constructor or do not set it - by using the `GeoCorridor` constructor that only allows to set the `GeoPolyline`. The parameter `radiusInMeters` has been deprecated: Please only use `halfWidthInMeters` as constructor parameter to specify the thickness of the route corridor. When increasing `halfWidthInMeters` then a greater simplification of the polyline shape can be achieved resulting in a longer route that can be searched along. On the downside the results are less accurate and can lie farther away from the route. When `halfWidthInMeters` is not set, a suitable value is set internally based on "best guess".
- The `LocationIndicator` now supports a gray state that can be set via `LocationIndicator.isActive`.
- Navigation: Added support for Vietnamese voice maneuver notifications during guidance.
- Navigation: Added a `RoadAttributesListener` that informs on the following new road attributes:
  `isDirtRoad`, `isTunnel`, `isBridge`, `isRamp`, `isControlledAccess`, `isPrivate`, `isNoThrough`, `isTollway`, `isDividedRoad`, `isRightDrivingSide`, `isRoundabout`.
- Offline routing now also supports `AvoidanceOptions` for rectangular areas.
- Offline maps: Added more granular error states to `MapLoaderError`.

#### Resolved Issues

- `VisualNavigator`: The camera now moves instantly to the initial location when the first `Location` update is received. <!-- IOTSDK-9988 -->

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Offline maps: Some downloadable region names are not fully localized yet. <!-- IOTSDK-9301 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- Offline routing: Offline routes cannot be calculated in Japan. <!-- IOTSDK-8958 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9665 -->
- When `MapMarker.setOverlapAllowed()` is set to false and the map is zoomed, this can lead to a flickering of the marker assets. <!-- IOTSDK-9885 -->
- Offline Maps: A retryable error is not returned via `MapDownloader.onPause()`, instead the download is stopped and must be restarted instead of resumed. <!-- IOTSDK-10020 -->
- Navigation: In some cases, speed limit data may be missing, although it is available in HERE's database. <!-- IOTSDK-10174 -->
- Leaving an app via back press on Android devices can lead to a freeze when the app is restarted. This can happen when the `LocationEngine` could not be properly stopped or the `VisualNavigator` is still rendering. <!-- IOTSDK-10214 -->

### Version 4.7.4.0

#### Highlights

- **Important note:** It is planned to raise the minimum supported Flutter and Dart version to _Flutter 2.0_ and _Dart 2.12_ with the upcoming major release v4.8.0. With this release we also plan to switch to FFI 1.0, which means that other third-party plugins also need to be updated to use FFI 1.0, or they can't be used together with the HERE SDK. In addition, we plan to introduce [null safety](https://dart.dev/null-safety#sidenav-2-4). Note that the HERE SDK is not compatible with [Flutter 2.2.0](https://flutter.dev/docs/development/tools/sdk/releases) or higher - as the HERE SDK does not yet support FFI 1.0 until v4.8.0.

#### New Features

- Routing: Added `TruckType` enum to specify the type of a truck for the `TruckSpecifications`.
- Routing: Added `TruckSpecifications.trailerCount` to specify the number of trailers.
- Routing: Added `accessPoint` to `RoutePlaceType` enum. It allows to differentiate `Section`'s based on `RoutePlace.type`.
- Public transit: Added `FarePriceType` enum, `FarePrice.type`, `FarePrice.minimum` and `FarePrice.maximum` properties. `FarePrice` provides the actual price value.

#### API Changes

- Gestures: A finger down gesture stops now any ongoing animation including kinetic panning.
- Positioning: Background location updates are no longer enabled by default. They need to be enabled via `LocationEngineBase.setBackgroundLocationAllowed()`. On top, the device needs to require the needed permissions.
- Changed the `VisualNavigator.make()` constructor to `VisualNavigator()`.
- Offline maps: Added `ALREADY_INSTALLED` enum value to `MapLoaderError`. Now, downloading an existing map region will result in `ALREADY_INSTALLED` error instead of getting a `SUCCESS`.
- Routing: Deprecated `FarePrice.unit`, use the newly introduced `FarePrice.validityPeriodInSeconds` property instead.
- Routing: Deprecated the unsupported `Agency.icon` property. This property is no longer supported and will be removed with HERE SDK release v4.10.0.

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Offline maps: Some downloadable region names are not fully localized yet. <!-- IOTSDK-9301 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- Offline routing: Offline routes cannot be calculated in Japan. <!-- IOTSDK-8958 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.avoidAreas` and `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9463 -->
- When `MapMarker.setOverlapAllowed()` is set to false and the map is zoomed, this can lead to a flickering of the marker assets. <!-- IOTSDK-9885 -->
- Offline Maps: A retryable error is not returned via `MapDownloader.onPause()`, instead the download is stopped and must be restarted instead of resumed. <!-- IOTSDK-10020 -->

### Version 4.7.3.0

#### Highlights

- **Important note:** It is planned to raise the minimum supported Flutter and Dart version to _Flutter 2.0_ and _Dart 2.12_ with the upcoming major release v4.8.0. With this release we also plan to switch to FFI 1.0, which means that other third-party plugins also need to be updated to use FFI 1.0, or they can't be used together with the HERE SDK. In addition, we plan to introduce [null safety](https://dart.dev/null-safety#sidenav-2-4).

#### New Features

- Routing: Added support for `EVCarOptions` and `EVTruckOptions` for the `RefreshRouteOptions` class.
- EV Routing: Added new parameters to `BatterySpecifications`:
  - `minChargeAtChargingStationInKilowattHours`: The minimum charge when arriving at a charging station.
  - `minChargeAtDestinationInKilowattHours`: The minimum charge at the final route destination.
  - `maxChargingVoltageInVolts`: The maximum charging voltage supported by the vehicle's battery.
  - `maxChargingCurrentInAmperes`: The maximum charging current supported by the vehicle's battery.
  - `chargingSetupDurationInSeconds`: The time spent after arriving at a charging station, but before actually charging.
- `SearchEngine`: For reverse geocoding it is now possible to search in a `GeoCircle` with `searchByCoordinatesWithRadius(GeoCircle circle, SearchOptions options, SearchCallback callback)`.

#### API Changes

- Only the following _Android Gradle Plugin_ versions 3.3.3, 3.4.2, 3.5.4, 3.6.4, 4.0.1 or higher are supported - since internally the [<queries> tag](https://android-developers.googleblog.com/2020/07/preparing-your-build-for-package-visibility-in-android-11.html) is required for the internal `AndroidManifest` file used by the HERE SDK. In case of doubt, you can check the version in `your_app/android/build.gradle` and check the version set for `com.android.tools.build:gradle`. Newer projects created by your IDE of choice already use such a version, by default.

#### API Changes

- Navigation: Deprecated the `LaneAssistance` class and the related `Navigator.laneAssistanceListener` property. Use the newly introduced `ManeuverViewLaneAssistance` class and the `Navigator.maneuverViewLaneAssistanceListener` instead.

#### Resolved Issues

- Fixed: Offline routing - `RouteOptions` are currently ignored completely and only default values will be used.
- Fixed: `ReturnToRouteEngine`: The guidance maneuver at the merging point between the new route and the old route is not properly generated.

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Offline maps: Some downloadable region names are not fully localized yet. <!-- IOTSDK-9301 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- Offline routing: Offline routes cannot be calculated in Japan. <!-- IOTSDK-8958 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Offline routing: For `RouteOptions`: `AvoidanceOptions.avoidAreas` and `AvoidanceOptions.countries` are currently ignored. <!-- IOTSDK-9463 -->
- When `MapMarker.setOverlapAllowed()` is set to false and the map is zoomed, this can lead to a flickering of the marker assets. <!-- IOTSDK-9885 -->

### Version 4.7.2.0

#### Highlights

- **Important note:** It is planned to raise the minimum supported Flutter and Dart version to _Flutter 2.0_ and _Dart 2.12_ with the upcoming major release v4.8.0. With this release we also plan to switch to FFI 1.0, which means that other third-party plugins also need to be updated to use FFI 1.0, or they can't be used together with the HERE SDK. In addition, we plan to introduce [null safety](https://dart.dev/null-safety#sidenav-2-4).
- The Developer Guide has been extended and is now on par with the content that was already available for the native platforms.

#### New Features

- Added a feature to refresh a `Route`: Added the `RouteOptions.enableRouteHandle` flag to get a `RouteHandle`, a `RefreshRouteOptions` class and a `RoutingEngine.refreshRoute()` method. Note that currently `EVRouteOptions` are not supported. See the related chapter in the Developer Guide for more information.
- `LocationIndicator`: Added a new style for _pedestrians_. The new style is added to `IndicatorStyle` and can be set to a `LocationIndicator` instance to switch the default 3D map marker model to indicate the current heading and location. Optionally, the style can be customized.
-  Added an option to affect FPS rendering of the map view by decreasing or increasing the frameRate with `MapView.frameRate`. This can be useful to reduce CPU usage for low end devices. The default FPS is 60 frames per second. It is also possible to deactivate automatic render cycles by setting FPS to 0.
- Offline maps: Added `MapDownloader.clearPersistentMapStorage()` to clear the persistent storage to remove all downloaded map data.
- Simplified usage of _special speed limits_: Now the lowest current special speed limit is optionally exposed via `effectiveSpeedLimitInMetersPerSecond()`. It's no longer necessary to set a `Date()`, the HERE SDK handles this now internally based on the device's clock settings. The related APIs (`TimeDomain`, `SpecialSpeedSituationType`, `SpecialSpeedSituation`) have been deprecated. Added the following new fields to the `SpeedLimit` class:
  - `double advisorySpeedLimitInMetersPerSecond`
  - `double snowSpeedLimitInMetersPerSecond`
  - `double rainSpeedLimitInMetersPerSecond`
  - `double fogSpeedLimitInMetersPerSecond`
  - `double schoolZoneSpeedLimitInMetersPerSecond`
  - `double timeDependentSpeedLimitInMetersPerSecond`

#### API Changes

- `MapDownloader`: Added new pause / resume events to `DownloadRegionsStatusListener` to know when a download of a region or a list of regions was paused or resumed. Introduced these two new methods:
`onPause(MapLoaderError error)` and void `onResume()`. The error is populated when the download was paused by the `MapDownloader` due to a retryable error.
- `VisualNavigator` rendering is, by default, smooth again with a target frame rate set to 60 FPS. This can be adjusted for low end devices. See the `frameRate` setting for `MapView`.

#### Resolved Issues

- Fixed: `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- Fixed: Offline maps: Once any download for a `Region` fails or is cancelled, all already downloaded regions will be deleted as well. <!-- IOTSDK-7541 TODO we need to add that ANY new download will erase any earlier downloads -->

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Offline maps: Some downloadable region names are not fully localized yet. <!-- IOTSDK-9301 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `RouteOptions` are currently ignored completely and only default values will be used. <!-- TODO RESOLVED FOR 4.7.3 -->
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- Offline routing: Offline routes cannot be calculated in Japan. <!-- IOTSDK-8958 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `ReturnToRouteEngine`: The guidance maneuver at the merging point between the new route and the old route is not properly generated.  <!-- TODO RESOLVED FOR 4.7.3 -->

### Version 4.7.1.0

#### Highlights

- Added a default 3D `LocationIndicator` to show the current location and travel direction of a user. It can be added to the map view with `MapView.addMapLifecycleListener()`. Update its location via `Mapview.updateLocation()` that accepts a `Location` as parameter. The look of the default asset can be customized by setting a `MapMarker3DModel` as parameter to `LocationIndicator.setMarker3dModel()`. You can also specify the `MarkerType`: In the future, it may be used to enable different styles of markers for different use cases.
- Introduced customizable _visual navigation_. Added `CameraSettings` that can be set for `VisualNavigator`.
You can specify `cameraDistanceInMeters` to define the distance to earth, the `cameraTiltInDegrees` to specify the 3D effect (a value of 0 switches to a flat 2D view) and `cameraBearingInDegrees` which can be set to `null` to rotate the map into the travel direction (any other value will stop the rotation - for example, set it to 0 to enable north up mode). By default, rotations are enabled.

#### New Features

- Introduced _taxi_ routes. Added `TransportMode.taxi` type and a `TaxiOptions` class to calculate routes optimized for taxis via `RoutingEngine.calculateTaxiRoute()`. Note: This is a beta release of this transport mode, so there could be a few bugs and unexpected behaviors.
- Routing: Added `RouteOptions.speedCapInMetersPerSecond` to limit the maximum allowed speed for a vehicle. When set, the route duration will be shorter for car and truck transport modes. For scooter routes it may also affect the route geometry. Other transport modes are ignored.

#### API Changes

- Changed type of _screenshot_ object returned by `HereMapController.takeScreenshot()` from an `Image` object to a `ImageInfo` object. Flutter's `Image` is actually of type `Widget`, which makes it more difficult to access the RGB data. Dart's `ImageInfo` simplifies this and it can still be converted to a Flutter `Widget`, if desired.

#### Resolved Issues

- Fixed: Public transit routes do not contain maneuvers. <!-- IOTSDK-9473 -->
- Fixed: On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- Fixed: Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- Fixed: Offline maps: The new method to get _installed regions_ may result in an error. As a workaround get available map regions beforehand and try again. <!--  OLPSUP-13203 -->

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Offline maps: Once any download for a `Region` fails or is cancelled, all already downloaded regions will be deleted as well. <!-- IOTSDK-7541 TODO we need to add that ANY new download will erase any earlier downloads -->
- Offline maps: Some downloadable region names are not fully localized yet. <!-- IOTSDK-9301 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `RouteOptions` are currently ignored completely and only default values will be used. <!-- TBD -->
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- Offline routing: Offline routes cannot be calculated in Japan. <!-- IOTSDK-8958 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `ReturnToRouteEngine`: The guidance maneuver at the merging point between the new route and the old route is not properly generated.  <!-- TBD -->

### Version 4.7.0.0

#### Highlights

- Raised the _minimum_ supported Flutter version from Flutter 1.20 to Flutter 1.22 and Dart 2.10. It is planned to raise the _minimum_ supported Flutter and Dart version to _Flutter 2.0_ and _Dart 2.12_ with the upcoming major release v4.8.0.
- New Flutter _example apps_ added on [GitHub](https://github.com/heremaps/here-sdk-examples): The Flutter selection contains now the same set of example apps as the native iOS and Android platforms.
- Introduced _public transit routing_ with a new `TransitRoutingEngine` that can calculate public transit routes. It uses `TransitWaypoint` type waypoints and a `TransitRouteOptions` class to specify various transit related options. Note that the API is in an early development stage. More features and overall stabilization are planned for the next releases.
- Added a new `MapSceneLayers.vehicleRestrictions` layer. It can be activated with `MapScene.setLayerState()` and it shows the current vehicle restrictions on the map. For example, weight or height restrictions for trucks at bridges.

#### New Features

- Along with the newly introduced `TransitRoutingEngine` (see above), the following supportive types have been added: `AttributionType` enum, `FarePriceType` enum, `FareReason` enum, `PreActionType` enum, `TransitDepartureStatus` enum, `TransitIncidentType` enum, `TransitIncidentEffect` enum, `TransitMode` enum, `TransitModeFilter` enum, `Agency` class, `Attribution` class, `Fare` class, `FarePrice` class, `PreAction` class, `TransitIncident` class, `TransitDeparture` class, `TransitSectionDetails` class, TransitStop class, and `TransitTransport` class.
- Routing: Introduced a new `Span` class that is accessible from a `Section` on a `Route`. It points to the related _section notices_ to indicate possible route violations. With the `Span` class these violations can now be identified on the `Route` as they contain the length in meters and the geometry.
- Routing: Added additional constructor for `IsolineOptions.Calculation`: `IsolineOptionsCalculation.withDefaultsAndCalculationMod(IsolineRangeType rangeType, List<int> rangeValues, IsolineCalculationMode isolineCalculationMode)`.
- Search: Added new method to `SearchEngine` to get place details for a `Suggestion` that contains a `href` String. Use the new `sendRequest()` method for this.

#### API Changes

- Added a new `MapViewLifecycleListener` that replaces the deprecated `MapRepresentable`. It can be added or removed from a `Mapview`. Use this to get notified on the map view's lifecycle.
- Deprecated `MapRepresentable` and the related methods to add or remove it from a `MapView`. Use the newly introduced `MapViewLifecycleListener` instead.
- Removed the previously deprecated `GeoBox.intersects(GeoBox)` and `GeoBox.contains(GeoBox)`.
- Speed limits: Made `SpecialSpeedSituation.specialSpeedLimitInMetersPerSecond` non-optional and removed the enum items `speedBumpsPresent` and `laneDependent` from `SpecialSpeedSituationType`, because they do not contain a special speed limit.
- Added a new `RoadTextsListener` to get notified on the current road name.
- Deprecated `NavigableLocation.streetName`. Use the newly introduced `RoadTextsListener` instead.
- Removed the previously deprecated `UnitSystem.imperial` enum item.
- Removed the previously deprecated `LocationProvider` and the `LocationListener.onLocationTimeout()` method.
- Removed the previously deprecated `Section.getTransportMode()` method.
- Removed the previously deprecated `GeoCorridor(List<GeoCoordinates>, Double)` constructor.
- Removed the previously deprecated `Place.getCoordinates()`.
- Removed the previously deprecated fields and constructors from `Color`.

#### Resolved Issues

- Fixed: During navigation sometimes the next maneuver and voice instructions are triggered too early before roundabouts. <!-- IOTSDK-7145, IOTSDK-7930 -->
- Fixed: Offline maps: `Region.sizeOnDiskInBytes` is 0 for any `Region`. <!-- IOTSDK-8216 -->
- Fixed: The opening hours for a `Place` that closes after midnight end at midnight. <!-- IOTSDK-8721 -->
- Fixed: Navigation: Maneuver arrows are not rendered correctly for offline routes. <!-- IOTSDK-9093 -->

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Offline maps: Once any download for a `Region` fails or is cancelled, all already downloaded regions will be deleted as well. <!-- IOTSDK-7541 TODO we need to add that ANY new download will erase any earlier downloads -->
- Offline maps: Some downloadable region names are not fully localized yet. <!-- IOTSDK-8857 -->
- Offline maps: The new method to get _installed regions_ may result in an error. As a workaround get available map regions beforehand and try again. <!--  OLPSUP-13203 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `RouteOptions` are currently ignored completely and only default values will be used. <!-- TBD -->
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- Offline routing: Offline routes cannot be calculated in Japan. <!-- IOTSDK-8958 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- `ReturnToRouteEngine`: The guidance maneuver at the merging point between the new route and the old route is not properly generated.  <!-- TBD -->
- Public transit routes do not contain maneuvers. <!-- IOTSDK-9473 -->

### Version 4.6.5.0

#### New Features

- Added support for political views. `SDKOptions` allow now to specify the `politicalView` string. It's a three letter country code defined by ISO 3166-1 alpha-3. When set, all map data will respect the point of view of this country. Note that this is a beta feature and thus there can be bugs and unexpected behaviour.
- A `Place` can now be serialized or deserialized with `serializeCompact()` and `deserialize()` to or from a `String`.
- Routing: Added `SectionNoticeCode` and `NoticeSeverity` enums, `SectionNotice` class and `Section.sectionNotices` property to get informed on possible route violations.
- Isoline Routing:
  - Added `RoutePlaceDirection` enum with values `arrival` and `departure`.
  - Added `isolineDirection` field to `IsolineOptionsCalculation.withDefaultsAndDirection()` and `IsolineOptionsCalculation.withNoDefaults()` factory methods (with default value of `RoutePlaceDirection.departure`).
  - Extended the existing `IsolineOptions.Calculation` constructor to accept the new `RoutePlaceDirection` enum.
  - Added `RouteOptions.arrivalTime` to set an optional time when a travel is expected to end. Note that this parameter is currently only supported for isoline route calculation.
- Navigation: Added an API to notify users about changes of the current speed limit. Now a `SpeedLimitListener` can be set that allows to get the `SpeedLimit` as before, but optionally it may also contain information on `SpecialSpeedSituation` events that overrule the default speed limit. Reasons for this are defined in the `SpecialSpeedSituationType` enum. A `TimeDomain` value informs whether this speed limit is currently active or not.
- Navigation: Added a new `ReturnToRouteEngine` that allows the calculate a new route when a deviation from the original route was detected. This engine works offline on already downloaded or cached map data.
- Introduced new `SDKCache` class and `SDKCacheCallback` that allows to clear the temporarily downloaded map data via the new `clearCache()` method. Note: This will not delete downloaded offline maps data.
- Offline Search: Added new `OfflineSearchEngine.search()` method that accepts `PlaceIdQuery` and an optional `LanguageCode` to lookup a Place ID.

#### API Changes

- Routing: Deprecated the `Notice` class and `NoticeCode` enum along with `Section.notices` property, use the newly introduced `SectionNoticeCode`, `SectionNotice` class and `Section.sectionNotices` property instead.
- Search: Deprecated `SearchError.optionNotAvailable` enum value, it will be replaced by the existing `SearchError.invalidParameter` value.
- Navigation: Deprecated `NavigableLocation.speedLimitInMetersPerSecond`. Use the newly introduced `SpeedLimit` instead.

#### Highlights

- **Important note:** It is planned to raise the minimum supported Flutter and Dart version to _Flutter 2.0_ and _Dart 2.12_ with the upcoming major release v4.8.0. For this release the minimum supported Flutter version is still Flutter 1.20.0 and Dart 2.9.0.

#### Resolved Issues

- Fixed: Offline maps: The new method to get _installed regions_ may result in an error. As a workaround get available map regions beforehand and try again. <!--  OLPSUP-13203 -->

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early before roundabouts. <!-- IOTSDK-7145, IOTSDK-7930 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Offline maps: `Region.sizeOnDiskInBytes` is 0 for any `Region`. <!-- IOTSDK-8216 -->
- Offline maps: Once any download for a `Region` fails or is cancelled, all already downloaded regions will be deleted as well. <!-- IOTSDK-7541 TODO we need to add that ANY new download will erase any earlier downloads -->
- Offline maps: Some downloadable region names are not fully localized yet. <!-- IOTSDK-8857 -->
- Offline maps: The new method to get _installed regions_ may result in an error. As a workaround get available map regions beforehand and try again. <!--  OLPSUP-13203 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `RouteOptions` are currently ignored completely and only default values will be used. <!-- TBD -->
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- Offline routing: Offline routes cannot be calculated in Japan. <!-- IOTSDK-8958 -->
- The opening hours for a `Place` that closes after midnight end at midnight. <!-- IOTSDK-8721 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Navigation: Maneuver arrows are not rendered correctly for offline routes. <!-- IOTSDK-9093 -->
- `ReturnToRouteEngine`: The guidance maneuver at the merging point between the new route and the old route is not properly generated.  <!-- TBD -->

### Version 4.6.4.0

#### New Features

- Offline maps: It's now possible to pause and resume pending downloads of a map region via the `MapDownloaderTask`'s `pause()` and `resume()` methods.
- Navigation: Maneuver arrows are now rendered by default on the route shown on the map by the `VisualNavigator`. The next maneuver is shown, and removed once reached.
- Navigation: The turn-by-turn `ManeuverAction` for roundabouts is now split into 'roundaboutEnter' and 'roundaboutExit'. The behavior for the HERE SDK remains the same. An additional 'LEFT/RIGHT_TURN' action may be given when exiting a larger roundabout.
- Routing: Introduced `Waypoint.minCourseDistanceInMeters` to specify an optional distance parameter during which a user can avoid taking actions.
- The size of the viewport can now be retrieved from `MapView` with the new `viewportSize` property that returns `Size2D` in physical pixels.
- Enhanced FlyTo `MapCamera` animations from A to B with target orientation and target distance: `flyToWithOptionsAndOrientation(GeoCoordinates target, MapCameraOrientationUpdate orientation, MapCameraFlyToOptions animationOptions)`.
- New map styles have been introduced as beta versions.
  - The map styles for `normalDay`, `normalNight`, `hybridDay` and `hybridNight` will be updated with v4.8.0. The planned new map styles are already accessible under following file names as beta versions:
    - "preview.normal.day.json" - This scheme will update the current `normalDay` in v4.8.0.
    - "preview.normal.night.json" - This scheme will update the current `normalNight` in v4.8.0.
    - "preview.hybrid.day.json" - This scheme will update the current `hybridDay` in v4.8.0.
    - "preview.hybrid.night.json" - This scheme will update the current `hybridNight` in v4.8.0.
  - The legacy map styles for `normalDay`, `normalNight`, `hybridDay` and `hybridNight` will still be accessible for v4.8.0 until v4.9.0 under the file names listed below. They will be removed with v4.9.0.
    - "legacy.normal.day.json"
    - "legacy.normal.night.json"
    - "legacy.hybrid.day.json"
    - "legacy.hybrid.night.json"
    - "legacy.grey.day.json"
    - "legacy.grey.night.jso

#### API Changes

- The map styles `MapScheme.greyDay`, `MapScheme.greyNight` have been deprecated and will be removed. Use the `normal` variants instead.
- Navigation: Safety speed camera warner text notifications were always fired. Now, text notifications are only sent via `ManeuverNotificationListener` if a `SafetyCameraWarningListener` is set.

#### Resolved Issues

- For Android: The workaround required to avoid a white screen being displayed after sending an app to the background is now applied for users of both `FlutterActivity` and the `FlutterFragmentActivity`.  Until now it was not applied for `FlutterFragmentActivity`, causing an white screen if an app was using that activity.

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early before roundabouts. <!-- IOTSDK-7145, IOTSDK-7930 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Offline maps: `Region.sizeOnDiskInBytes` is 0 for any `Region`. <!-- IOTSDK-8216 -->
- Offline maps: Once any download for a `Region` fails or is cancelled, all already downloaded regions will be deleted as well. <!-- IOTSDK-7541 TODO we need to add that ANY new download will erase any earlier downloads -->
- Offline maps: Some downloadable region names are not fully localized yet. <!-- IOTSDK-8857 -->
- Offline maps: The new method to get _installed regions_ may result in an error. As a workaround get available map regions beforehand and try again. <!--  OLPSUP-13203 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `RouteOptions` are currently ignored completely and only default values will be used. <!-- TBD -->
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- Offline routing: Offline routes cannot be calculated in Japan. <!-- IOTSDK-8958 -->
- The opening hours for a `Place` that closes after midnight end at midnight. <!-- IOTSDK-8721 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->
- Navigation: Maneuver arrows are not rendered correctly for offline routes. <!-- IOTSDK-9093 -->

### Version 4.6.3.0

#### New Features

- Added new `WatermarkStyle` enum that defines the style of the HERE watermark logo. The _dark_ watermark should be used for custom styles that are brighter (like daytime) and the _light_ watermark for darker custom schemes (like night or satellite based). Added a new `loadScene()` method to `MapScene` to accept the new enum together with a custom style.
- `MapCamera`: Added `FlyToOptions` to customize the fly-to animation from current target `GeoCoordinates` to a new location. The `durationInMs` parameter defines how long the animation will run, the `bowFactor` defines a relative camera height for the ballistic curve that ranges from -1 < 0 (concave curve) to 0 (constant height) to 0 < 1 (convex curve). The maximum height can be achieved with a `bowFactor` of 1, the minimum with -1. Note that the height is relative to the distance between current target and new target to achieve a constant look regardless of the current zoom level.
- Routing: Added `sideOfStreetHint` property to `Waypoint`. These optional `GeoCoordinates` indicate which side of the street should be used to reach the waypoint. For example, if the location is to the left of the street, the route will prefer using that side in case the street has dividers. Hence, if the street has no dividers, `sideOfStreetHint` is ignored.
- Positioning: The `kCLAuthorizationStatusNotDetermined` status from iOS platform is now treated as `LocationEngineStatus.missingPermissions`. This status may be sent to listeners when the `start()` method of the `LocationEngine` is called. So now applications are not enforced to check the platform authorization status before starting to locate.
- `MapDownloader`: Added possibility to delete downloaded map regions via the new `deleteRegions()` method that accepts a list of `RegionId` elements that should be deleted asynchronously.
- `MapDownloader`: Added `InstalledRegion` class that holds information on installed regions. Added `getInstalledRegions()` method to get the new class.

#### Resolved Issues

- Fixed: Currently, a `Lane` that is reserved for bus or bicycle does not contain a direction type. <!-- IOTSDK-7931 -->
- Fixed: Navigation: Unlimited speed limits may not always be reported as expected. <!-- IOTSDK-8262, IOTSDK-8265 -->

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early before roundabouts. <!-- IOTSDK-7145, IOTSDK-7930 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Offline maps: `Region.sizeOnDiskInBytes` is 0 for any `Region`. <!-- IOTSDK-8216 -->
- Offline maps: Once any download for a `Region` fails or is cancelled, all already downloaded regions will be deleted as well. <!-- IOTSDK-7541 TODO we need to add that ANY new download will erase any earlier downloads -->
- Offline maps: Some downloadable region names are not fully localized yet. <!-- IOTSDK-8857 -->
- Offline maps: The new method to get _installed regions_ may result in an error. As a workaround get available map regions beforehand and try again. <!--  OLPSUP-13203 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `RouteOptions` are currently ignored completely and only default values will be used. <!-- TBD -->
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- The opening hours for a `Place` that closes after midnight end at midnight. <!-- IOTSDK-8721 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->

### Version 4.6.2.0

#### Highlights

- The minimum supported Flutter version was raised from 1.17 to 1.20. The minimum supported Dart version is now 2.9.0.
- Added a new _Indoor Routing_ API (beta) which allows calculating routes inside _private_ venues. The API supports routes from outside to a position inside a venue and from a position inside a venue to the outside. The API also allows showing the resulting routes on the map.

#### New Features

- Introduced beta versions of new map style combinations for use with `MapScene.loadScene()`: "preview.normal.day.json", "preview.normal.night.json", "preview.hybrid.day.json" and "preview.hybrid.night.json".
- Added new map item type: `MapArrow` elements can now be rendered on the map to indicate a direction. They can be added or removed like other map items via `MapScene`.
- `MapMarker` items can now be made invisible once they overlap each other at certain zoom levels. They contain a new property with `get/set isOverlapAllowed()`.
- `VisualNavigator`: The visibility of a `Route` can be controlled with `setRouteVisible(boolean)`. The property is exposed with `isRouteVisible()`. By default, if a route is set, it will be rendered when `startRendering()` is called, and removed with `stopRendering()`. It is possible to set or remove a route at any time, i.e., before or after calling `startRendering()`, and the route in the `MapView` will be updated accordingly.

#### API Changes

- The free flow traffic layer is now rendering green traffic flow lines by default.
- `MapLoader`: Deprecated the meaningless error `MapLoaderError.duplicateCatalog`.
- `VisualNavigator` introduced a behavioral change: The transform center (also known as principal point) of the `MapCamera` is automatically adjusted during navigation for better viewing results. Calling `startRendering()` changes the `principalPoint` property of the `MapCamera` so that the current position indicator is placed slightly at the bottom of the `MapView`. It is restored to its original value when `stopRendering()` is called.

#### Resolved Issues

- Fixed: When traffic flows are enabled, map gestures may behave slower than expected. <!-- IOTSDK-7257 -->
- Fixed: Currently, a `Lane` that is reserved for bus or bicycle does not contain a direction type. <!-- IOTSDK-7931 -->
- Fixed: Offline routing: Avoidance options are currently ignored. <!-- IOTSDK-7679 -->
- Fixed: Offline routing: Ferry links are not extracted to separate sections. <!-- IOTSDK-8034 -->
- Fixed: Navigation: Safety camera notifications may come too often. <!-- IOTSDK-8244 -->
- Fixed: When `SDKOptions` is created before initialization of `SDKNativeEngine` it may contain a corrupted path. <!-- IOTSDK-8302 -->

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early before roundabouts. <!-- IOTSDK-7145, IOTSDK-7930 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Currently, a `Lane` that is reserved for bus or bicycle does not contain a direction type. <!-- IOTSDK-7931 -->
- Offline maps: `Region.sizeOnDiskInBytes` is 0 for any `Region`. <!-- IOTSDK-8216 -->
- Offline maps: Once any download for a `Region` fails or is cancelled, all already downloaded regions will be deleted as well. <!-- IOTSDK-7541 TODO we need to add that ANY new download will erase any earlier downloads -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: `RouteOptions` are currently ignored completely and only default values will be used. <!-- TBD -->
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- Navigation: Unlimited speed limits may not always be reported as expected. <!-- IOTSDK-8262, IOTSDK-8265 -->
- The opening hours for a `Place` that closes after midnight end at midnight. <!-- IOTSDK-8721 -->
- An inner city `Route` for trucks carrying dangerous goods may not result in an error message. <!-- IOTSDK-8521 -->

### Version 4.6.1.0

#### Highlights

- Added new `flyTo()` method to `MapCamera` for basic animations from A to B by setting new target coordinates. The animation can be interrupted by gestures or any programmatical change of the camera's position or orientation.

#### New Features

- Routing: Introduced `ZoneCategory` enum and added `zoneCategories` field to to the `AvoidanceOptions` struct which is a collection of `ZoneCategory`'s.
- EV routing: Introduced `Route.getEVDetails()` which returns the accumulated `evDetails` data for all sections of a route.
- Navigation: Added a `PostActionListener`, which is accessible from `Navigator` and `VisualNavigator` via dedicated setter and getters.
- Navigation: The `exitSignTexts` (road exit number) attribute was added to `Maneuver`.
- Lane Assistance: The following new access types have been added: `automobiles`, `buses`, `taxis`, `carpools`, `pedestrians`, `trucks`, `throughTraffic`, `deliveryVehicles`, `emergencyVehicles`, `motorcycles`.
- Positioning: Added new fields to `Location` object: `bearingAccuracyInDegrees`, `speedAccuracyInMetersPerSecond`, `timestampSinceBootInMilliseconds`. Related constructors have been deprecated. Use the related newly introduced constructors instead.

#### Build System Changes

- When building for iOS, CocoaPods 1.10 or above is now required. The use of older versions can result in the linker choosing an incorrect architecture with which to link.

#### API Changes

- Routing: The `AvoidanceOptions` constructor requires to set the new field `zoneCategories`.
- Routing: Deprecated `Section.arrival` and `Section.departure`. Instead, use the newly introduced `Section.arrivalPlace` and `Section.departurePlace` to get a `RoutePlace`.
- Deprecated the `Address` fields `stateName`, `countyName`, `streetName` and the related constructors. Instead, use the newly introduced constructor that takes the new fields `state`, `country` and `street`.

#### Resolved Issues

- Fixed: Performing a `CategoryQuery` or a `TextQuery` search no longer returns `SearchError.httpError` when searching in a circle, whose radius is a number with a fraction.

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- When traffic flows are enabled, map gestures may behave slower than expected. <!-- IOTSDK-7257 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early before roundabouts. <!-- IOTSDK-7145, IOTSDK-7930 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Currently, a `Lane` that is reserved for bus or bicycle does not contain a direction type. <!-- IOTSDK-7931 -->
- Offline maps: `Region.sizeOnDiskInBytes` is 0 for any `Region`. <!-- IOTSDK-8216 -->
- Offline maps: Once any download for a `Region` fails or is cancelled, all already downloaded regions will be deleted as well. <!-- IOTSDK-7541 TODO we need to add that ANY new download will erase any earlier downloads -->
- Offline routing: Pedestrian, truck, scooter, and EV routing are not expected to work. <!-- TODO remove here, as we list this in API Ref -->
- Offline routing: Avoidance options are currently ignored. <!-- IOTSDK-7679 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: Ferry links are not extracted to separate sections. <!-- IOTSDK-8034 -->
- Offline routing: `RouteOptions` are currently ignored completely and only default values will be used. <!-- TBD -->
- Offline routing: `Maneuver` information is not available. A maneuver will only contain empty strings or default values. During guidance, maneuver data should be taken from `Navigator` instead. <!-- TBD -->
- Navigation: Unlimited speed limits may not always be reported as expected. <!-- IOTSDK-8262, IOTSDK-8265 -->
- Navigation: Safety camera notifications may come too often. <!-- IOTSDK-8244 -->
- When `SDKOptions` is created before initialization of `SDKNativeEngine` it may contain a corrupted path. <!-- IOTSDK-8302 -->

### Version 4.6.0.0

#### Highlights

- Android devices running older Adreno 330 GPUs are now supported.
- Added support for _offline maps_. Map data can now be preloaded for continents and countries worldwide. Note: This feature is released as _beta_ feature. Added the `MapDownloader` class to download the list of available regions and to download the regions. Added related classes:
  - `DownloadableRegionsCallback`: Notifies when regions are downloaded.
  - `MapDownloaderStatusListener`: Notifies on the status of the download.
  - `MapDownloaderTask`: Task to cancel downloads.
  - `MapLoaderError`: Enumeration for specifying various errors.
  - `Region`: Represents an area that can be downloaded.
  - `RegionId`: Specifies an unique identifier for a `Region`.
- Added `OfflineRoutingEngine` to calculate routes on cached or preloaded offline maps: It is now possible to calculate routes without connectivity. The engine adheres to the same interface as its online counterpart.
- Added _isoline routing_ to calculate the reachable area for the given center coordinates and a range defined in time, distance or energy consumption. Added a new `calculateIsoline()` method to `RoutingEngine`. Added related classes:
  - `IsolineOptions`: Options for isoline calculation.
  - `IsolineRangeType`: Enumeration specifying whether the range type is defined in time, distance or energy consumption.
  - `IsolineCalculationMode`: Specifies how the isoline calculation can be optimized.
  - `Isoline`: Represents a single isoline.
  - `MapMatchedCoordinates`: Contains a pair of user-defined and map-matched coordinates.

#### More New Features

- `MapPolygon` items can now be picked from `MapView`. `PickMapItemsResult` can now include a list of `MapPolygon` items.
- Added `ScooterOptions.allowHighway` property.
<!-- - Users of the exclusive _Skytree Edition_ can load the Japan map scheme for a `MapScene` via `loadScene("japan.ocm.day.json", loadSceneCallback)`. This special map scheme covers the entire world. No other map scheme should be loaded, otherwise the map falls back to the non-exclusive map schemes. By default, the Japan map feature is not available for the regular edition of this release. -->
- Added method to look at a given `GeoBox` at the map view with `lookAtAreaWithOrientationAndViewRectangle(GeoBox target, MapCameraOrientationUpdate orientation, Rectangle2D viewRectangle)`. For example, this can be used to show a route on a certain part of the map view.
- Search: Added `categories` field to `OpeningHours`. It contains `categories` related to specific `OpeningHours`. For example, when a `Place` has multiple opening hours associated with it.
- Added `SDKNativeEngine.dispose()` to release resources. It should be used in cases when it's necessary to create a new instance of `SDKNativeEngine` with the same access key id as previously used.
- Road shields are now rendered by default on the map view.
- `Navigator` and `VisualNavigator` now allow to specify a `TransportMode` for tracking. By default, car mode is used.
- Added `SafetyCameraType` to provide notifications about safety speed cameras both when on route and when in tracking mode. In tracking mode, the safety camera notifications will be given only for the portion of a road between the current position and the first junction. Added `SafetyCameraWarning` to provide information about the distance from the current position to the camera, the speed limit observed by the camera and the type of the safety camera. Added a dedicated listener that can be set to `Navigator` or `VisualNavigator`.
- Lane Assistance: Added new types to `LaneType`: Express lane, acceleration lane, deceleration lane, auxiliary lane, slow lane, passing lane, shoulder lane, regulated lane access, turn lane, center turn lane, truck parking lanes, parking lanes, variable driving lanes, bicycle lanes.

#### API Changes

- Removed beta status for scooter transport mode.
- Deprecated the `updateGeometry()` method for `MapPolygon`. Use the newly introduced set/get _geometry_ accessors instead to get or set a `GeoPolygon`.
- Deprecated the `updateGeometry()` method for `MapPolyline`. Use the newly introduced set/get _geometry_ accessors instead to get or set a `GeoPolyline`.
- Search: Deprecated the following `Contact` fields `landlinePhoneNumbers`, `mobilePhoneNumbers`, `emailAddresses`, `websiteAddresses`. Use these newly introduced fields instead: `landlinePhones`, `mobilePhones`, `emails`, `websites`. Each holds a list of newly created classes `LandlinePhone`, `MobilePhone`, `EmailAddress`, `WebsiteAddress` - containing a string representation of the item and a list of related `PlaceCategory` values.
- The free flow traffic layer does no longer render the green traffic flow lines. In the future, an API to enable / disable the flow is planned to be introduced.
- The `SDKNativeEngine` now locks access to the map data cache and persistent storage directories. When another instance of `SDKNativeEngine` is instantiated with the same access key id then now an exception is thrown.
- `MapView`: Added clamping to principal point when the coordinates are outside of the viewport.
- `Maneuver`: Deprecated `roadName`, `roadNameLanguageCode`, `roadNumber`, `nextRoadName`, `nextRoadNameLanguageCode`, `nextRoadNumber`. Added instead `RoadTexts` with `roadTexts` and `nextRoadTexts` and `LocalizedText` and `LocalizedTexts`.
- HERE Positioning now runs in it's own thread instead of separate process.

#### Resolved Issues

- Fixed: A `MapPolyline` may be unexpectedly rendered over a `MapMarker`. <!-- IOTSDK-7805 -->

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- When traffic flows are enabled, map gestures may behave slower than expected. <!-- IOTSDK-7257 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early before roundabouts. <!-- IOTSDK-7145, IOTSDK-7930 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Currently, a `Lane` that is reserved for bus or bicycle does not contain a direction type. <!-- IOTSDK-7931 -->
- Offline maps: `Region.sizeOnDiskInBytes` is 0 for any `Region`. <!-- IOTSDK-8216 -->
- Offline maps: Once any download for a `Region` fails or is cancelled, all already downloaded regions will be deleted as well. <!-- IOTSDK-7541 TODO we need to add that ANY new download will erase any earlier downloads -->
- Offline routing: Pedestrian, truck, scooter, and EV routing are not expected to work. <!-- TODO remove here, as we list this in API Ref -->
- Offline routing: Avoidance options are currently ignored. <!-- IOTSDK-7679 -->
- Offline routing: The public maneuver list in the route's sections are empty. During navigation, the maneuvers are provided as usual.
- Offline routing: Ferry links are not extracted to separate sections. <!-- IOTSDK-8034 -->
- Navigation: Unlimited speed limits may not always be reported as expected. <!-- IOTSDK-8262, IOTSDK-8265 -->
- Navigation: Safety camera notifications may come too often. <!-- IOTSDK-8244 -->
- When `SDKOptions` is created before initialization of `SDKNativeEngine` it may contain a corrupted path. <!-- IOTSDK-8302 -->

### Version 4.5.4.0

#### Highlights

- The supported device specifications have been fine tuned and contain now more granular details on the supported devices. Details can be found in the _About_ section of the Developer Guide for this edition.

#### New Features

- Extended walk routing options: Added `PedestrianOptions.walkSpeedInMetersPerSecond` property. Note that this feature is released as _beta_. By setting a walk speed you can calculate pedestrian routes specific for different walk profiles.
- Searching for a `CategoryQuery` within a `GeoCircle` or `GeoBox` is no longer marked as a _beta_ feature.
- Added new map cache options to `SDKOptions` with `SDKOptions.cacheSizeInBytes` and `SDKOptions.persistentMapStoragePath`. Also available as key in manifest (`com.here.sdk.cache_size_in_bytes`, `com.here.sdk.persistent_map_storage_path`) on Android or plist on iOS (`CacheSizeInBytes`, `PersistentMapStoragePath`). With this you can control where to store cached map data and it also allows to specify the amount of data you want to reserve for caching.
- Added new API methods to `LocationEngine` to control background positioning and battery saving options:
  - set/get `backgroundLocationAllowed(boolean)`: Enables or disables an application's background location updates. By default, background location updates are enabled if a application has background location capabilities.
  - set/get `backgroundLocationIndicatorVisible(boolean)`: Controls the visibility of a device's background location indicator. By default, the native background location indicator is visible, if an application has background location capabilities.
  - set/get `pauseLocationUpdatesAutomatically(boolean)`: Controls automatic pausing of location updates, for example, for improving the device's battery life at times when location data is unlikely to change. By default, automatic pausing of location updates is allowed.

#### API Changes

- Changed `PedestrianOptions(routeOptions, textOptions)` constructor to `PedestrianOptions(routeOptions, textOptions, 1.0)` to support the new `PedestrianOptions.walkSpeedInMetersPerSecond` property (see above).

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- When traffic flows are enabled, map gestures may behave slower than expected. <!-- IOTSDK-7257 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early before roundabouts. <!-- IOTSDK-7145, IOTSDK-7930 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Currently, a `Lane` that is reserved for bus or bicycle does not contain a direction type. Nevertheless, such a lane is included in the list of lanes. However, the lane type is not exposed yet. Therefore, it is recommended to omit lanes that do not contain at least one direction. <!-- IOTSDK-7899, IOTSDK-7931 -->
- A `MapPolyline` may be unexpectedly rendered over a `MapMarker`. <!-- IOTSDK-7805 -->

### Version 4.5.3.0

#### New Features

- Added a `NoticeCode` that describes issues after a `Route` was calculated. For example, when a route should avoid tunnels, but the only possible route needs to pass a tunnel, the `Route` contains a notice that the requested avoidance of tunnels was violated. Therefore, it is recommended to always check a calculated `Route` for possible violations. The `NoticeCode` is part of a `Notice` object. A list of possible `Notice` objects can be accessed per `Section` of a `Route`. The list will be empty, when no violation occurred.
- Addeded the ability to change the anchor point of a `MapMarker` with `Anchor2D`. By default, the marker is centered on the provided location and the anchor is at (0.5, 0.5). An anchor represents a point in a rectangle as a ratio of the marker's image width and height.
- Added search for a `CategoryQuery` within a `GeoCircle` or `GeoBox`. Extended the existing `CategoryQuery` constructors to accept `GeoCircle` or `GeoBox`. Note that this feature is currently in BETA state.

#### API Changes

- The _lane assistance_ API was marked as BETA until further notice and thus there can be bugs and unexpected behavior. The API may change for new releases without a deprecation process.
  - The lane list order was changed to always start with index 0 from the leftmost lane to the rightmost lane (last index). Currently, left-hand driving countries are not supported.

#### Known Issues

- The `VisualNavigator` API is in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- When traffic flows are enabled, map gestures may behave slower than expected. <!-- IOTSDK-7257 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early before roundabouts. <!-- IOTSDK-7145, IOTSDK-7930 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Currently, a `Lane` that is reserved for bus or bicycle does not contain a direction type. Nevertheless, such a lane is included in the list of lanes. However, the lane type is not exposed yet. Therefore, it is recommended to omit lanes that do not contain at least one direction. <!-- IOTSDK-7899, IOTSDK-7931 -->
- A `MapPolyline` may be unexpectedly rendered over a `MapMarker`. <!-- IOTSDK-7805 -->

### Version 4.5.2.0

#### Highlights

- Added suppport for scooter route calculation with the new `ScooterOptions`. Note that this is a BETA feature. Using scooter routes for navigation is not yet supported.
- Introduced a new _lane assistance_ API to notify drivers during navigation which lane is recommended to reach the next maneuvers. Use the new `LaneAsssistanceListener` to receive `LaneAssistance` events that are fired along with each voice announcement.

#### New Features

- Added new read-only property to `MapPolyline` with `GeoPolyline get geometry`.
- Added `DashPattern` class to set dashed line styles for a `MapPolyline`.
- Added a new property to `MapPolyline` to add support for fill colors when using dashed lines:
  - `ui.Color get dashFillColor`
  - `set dashFillColor(ui.Color value)`
- Added cumulative orbit method to `MapCamera` to rotate the map around arbitrary view coordinates using relative orientation values with `orbitBy(MapCameraOrientationUpdate delta, Point2D origin)`.

#### API Changes

- Cache path to store map data is now unique per access key ID (which is unique per customer). The HERE SDK automatically appends the current version of the cache and the access key ID. If you want to keep existing cache data, it may be required to copy it from `<cache-root>` to `<cache-root>/v1/<access-key-id>`, as the current version of the cache is "v1".
- Deprecated `SDKNativeEngine.setAccessKey(access_key_id, access_key_secret)`. Use `SDKNativeEngine.setAccessKeySecret(access_key_secret)` instead, in combination with setting the access key ID via `SDKOptions` when constructing a new `SDKNativeEngine`.
- Deprecated `LocationUpdateListener`. Use the new `LocationListener` instead.
- Removed deprecated `GeoCircle` constructor that accepts single precision float type for radius.

#### Resolved Issues

- Fixed: Embedded POI markers are not visible for the _hybrid night_ map scheme. <!-- IOTSDK-7494 -->
- Fixed: Pan gestures may receive a _cancel_ event before a _begin_ event. <!-- IOTSDK-7511 -->
- Fixed: During guidance tracking mode, roads with unlimited speed are now correctly reported.
<!-- IOTSDK-7375 -->

#### Known Issues

- The new `VisualNavigator` and the new _lane assistance_ API are in an early development stage. More features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- When traffic flows are enabled, map gestures may behave slower than expected. <!-- IOTSDK-7257 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early. <!-- IOTSDK-7145 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->

### Version 4.5.1.0

#### Highlights

- Improved cold startup time on certain devices like Samsung.
- A new `VisualNavigator` class has been introduced. It contains the same functionality as the `Navigator` class, but offers support for a visual guidance experience. With `startRendering()` a 3D location marker is added that smoothly follows the current location on the map. The animation is interpolated. In addition, the `MapOrientation` is updated. When a `Route` is set, the camera automatically follows the direction arrow. With the new `CameraTrackingMode`, this can be turned off, for example, to let the user freely pan the map. When tracking is turned off, the direction arrow moves on, but the map is not moved. Once `CameraTrackingMode` is enabled again, the camera follows again the current location. Note that the `Navigator` class can be replaced by the `VisualNavigator` class without any further code adaptation as `Navigator` shares the same method signatures with the new `VisualNavigator`.

#### New Features

- Introduced `Maneuver.lengthInMeters()` property to return the length of the maneuver.
- Added new `MapCameralimits` with `set targetArea(GeoBox value)` and `GeoBox get targetArea`. This allows to set a target area preventing a user from moving away too much from a desired area of interest.
- Added new `MapCameralimits` for bearing with `AngleRange get bearingRange` and `set bearingRange(AngleRange value)`.
- Introduced `SectionTransportMode` enum and `Section.getSectionTransportMode` method returning an instance of this type indicating now transport modes such as ferries. `Section.getTransportMode` has been deprecated, use the newly introduced method instead.
- Search: Introduced `SupplierReference` type and `Details.references` property, which holds the list of supplier references to a place.

#### Known Issues

- The new `VisualNavigator` is in an early development stage. More rendering features and overall stabilization are planned for the next releases. Because of the pandemic situation full test coverage is currently blocked.
- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- When traffic flows are enabled, map gestures may behave slower than expected. <!-- IOTSDK-7257 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early. <!-- IOTSDK-7145 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->
- Embedded POI markers are not visible for the _hybrid night_ map scheme. <!-- IOTSDK-7494 -->
- Pan gestures may receive a _cancel_ event before a _begin_ event. <!-- IOTSDK-7511 -->

### Version 4.5.0.0

#### Highlights

- Added advanced positioning capabilities to find your current location. On Android this requires the user's consent to decide whether or not it's okay to collect data, while on iOS this is currently not necessary.
- Switched to a more performant underlying map format that provides less size, less traffic and smaller download times. This new format does not require any adaptation on app side.
- Added a new `OfflineSearchEngine` that works without internet connectivity upon previously cached maps. It supports key word search, category search, geocoding and reverse geocoding. For example, when no internet connection is available, an app may try to fallback to the `OfflineSearchEngine` to provide instant results - although connectivity is be temporarily lost.
- Added route calculation for _electric vehicles_ (EV). It's now possible to calculate the energy consumption per route section according to the given consumption model (supported for electric cars and trucks). Charging stations are automatically added to the calculated route as waypoints to ensure that the electric vehicle doesn't run out of energy along the way (supported for electric cars).

#### New Features

- Added `LogAppender` interface to insert your own log class into the `SDKNativeEngine`. This way you can log HERE SDK messages for various predefined log levels even on release builds.
- Added in `Navigator` a static method to query the list of available languages for maneuver notifications: `List<LanguageCode> Navigator.getAvailableLanguagesForManeuverNotifications()`.
- Added a `scale` property to change the size of a `MapMarker3D`.
- Added camera tilt limits with `MapCameraLimits.setMaxTilt(double degreesFromNadir)` and
`MapCameraLimits.setMinTilt(double degreesFromNadir)`.
- Added camera zoom limits with `MapCameraLimits.setMaxZoomLevel(double zoomLevel)` and
`MapCameraLimits.setMinZoomLevel(double zoomLevel)`.
- Added new methods to calculate routes for _electric vehicles_ (car and trucks are supported):
`RoutingEngine.calculateRoute(List<Waypoint>, EVCarOptions, CalculateRouteCallback)`,
`RoutingEngine.calculateRoute(List<Waypoint>, EVTruckOptions, CalculateRouteCallback)`.
- Added the following classes and fields to support EV routing (see above):
  - `BatterySpecifications` - parameters that describe the electric vehicle's battery.
  - `ChargingConnectorAttributes` - details of the connector that is suggested to be used for charging.
  - `ChargingConnectorType` - enumeration of the available charging connector types.
  - `ChargingStation` - charging station data.
  - `ChargingSupplyType` - enumeration of available charging supply types.
  - `EVCarOptions` - options to specify how a route for an electric car should be calculated.
  - `EVConsumptionModel` - parameters specific for the electric vehicle, which are used to calculate energy consumption on a given route.
  - `EVDetails` - additional information that is available for electric vehicles.
  - `EVTruckOptions` - options to specify how a route for an electric truck should be calculated.
  - `PostActionType` - enumeration of available post action types.
  - `PostAction` - an action that must be done after arrival.
  - `RoutePlaceType` - shows whether the place on the route (such as departure or arrival) is a charging station or a regular place.
  - `Arrival.type` - the type of the arrival place.
  - `Arrival.chargeInKilowattHours` - battery charge at arrival.
  - `Arrival.chargingStation` - charging station data at arrival.
  - `Departure.type` - the type of the departure place.
  - `Departure.chargeInKilowattHours` - battery charge at departure.
  - `Departure.chargingStation` - charging station data at departure.
  - `Section.postActions` - actions that must be done after the arrival.
  - `Section.evDetails` - additional section information that is available for electric vehicles.

#### API Changes

- The minimum supported iOS version was increased from 12.0 to 12.4.
- For custom map styles _HERE Style Editor 0.26_ is required.
- Changed splash screen to be grey instead of black. This improves the experiences on devices where cold start takes longer.
- Deprecated the `LocationProvider` interface and the `Navigator` constructors that accept a `LocationProvider` as parameter. A `Navigator` can now be construced from an empty constructor.
- A `Navigator` now implements the `sdk.core.LocationListener` interface.
- Deprecated `onLocationTimeout()` of `sdk.core.LocationListener` - it is no longer needed and the necessary timeout handling is now done internally inside the `Navigator` implementation.
- Removed a deprecated `GeoCoordinates` constructor, use the previously introduced counterpart instead.
- Removed a deprecated `Anchor2D` constructor, use the previously introduced counterpart instead.
- Deprecated in `Navigator` the method `List<LanguageCode> getSupportedLanguagesForManeuverNotifications()`, use `List<LanguageCode> Navigator.getAvailableLanguagesForManeuverNotifications()` instead.

#### Resolved Issues

- Fixed: After orientation changes coordinate conversions may return incorrect values. <!-- IOTSDK-6162 -->
- Fixed: During navigation sometimes the `nextRoadName` or `nextRoadNumber` are not available when the name of the street/road is a route number. In such a case, the next `Maneuver` indicates an 'unknown road'. <!-- IOTSDK-6483 -->
- Fixed: When imperial unit system is selected along with 'EN US' language code, then `RouteTextOptions` returns 'ft' as unit, but voice guidance uses 'yards'. <!-- IOTSDK-6426 -->
- Fixed: For some regions the speed limit value can be unexpectedly `null` on highways. Roads with no speed limit are now correctly indiciated during navigation. <!--- IOTSDK-6775 -->
- Fixed: During navigation, tunnel extrapolation may not work as expected. <!-- IOTSDK-6989 -->
- Fixed: Category search along a route will crash when the `GeoCorridor.polyline` list parameter is empty. <!-- IOTSDK-7016 -->
- Fixed issues for map matching with no or unstable _heading_ information. During navigation, map matching now works even when no heading information is provided or when the speed is very low.

#### Known Issues

- Updating an existing `MapMarker` with a completely new image causes the marker to disappear for a brief moment before being drawn with the new image. <!-- IOTSDK-7197 -->
- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- When traffic flows are enabled, map gestures may behave slower than expected. <!-- IOTSDK-7257 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early. <!-- IOTSDK-7145 -->
- Starting `LocationEngine` on iOS devices fails when the device is in _flight mode_. <!-- POSD-839 -->
- The `jamFactor` indicating `TrafficSpeed` is currently calculated linear without taking road types and other parameters into account. <!-- IOTSDK-7368 -->

### Version 4.4.6.0

#### Highlights

- This release focuses on overall stability and performance improvements.

#### Resolved Issues

- Fixed: During navigation it can happen in rare cases that the distance to the next maneuver is slightly wrong. <!-- IOTSDK-6686 -->
- Fixed: Map tiles may not load automatically when losing internet connectivity and connectivity gets back, unless the user interacts with the map. <!-- IOTSDK-5727 -->
- Fixed: Random route recalculations occur during drive navigation, especially on crossroads. <!--- IOTSDK-5890 -->

#### Known Issues

- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- During navigation sometimes the `nextRoadName` or `nextRoadNumber` are not available when the name of the street/road is a route number. In such a case, the next `Maneuver` indicates an 'unknown road'. <!-- IOTSDK-6483 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- When imperial unit system is selected along with 'EN US' language code, then `RouteTextOptions` returns 'ft' as unit, but voice guidance uses 'yards'. <!-- IOTSDK-6426 -->
- For some regions the speed limit value can be unexpectedly `null` on highways. <!--- IOTSDK-6775 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. <!-- IOTSDK-7167 -->
 - During navigation, tunnel extrapolation may not work as expected. <!-- IOTSDK-6989 -->
- A category search along a route will crash when the `GeoCorridor.polyline` list parameter is empty. <!-- IOTSDK-7016 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->
- When traffic flows are enabled, map gestures may behave slower than expected. <!-- IOTSDK-7257 -->
- A `Maneuver.polyline` list of `GeoCoordinates` has only one element for the last maneuver of a route. <!-- IOTSDK-6955 -->
- `MapMarker3D` instances are only partly rendered when the camera is positioned too far from earth. <!-- IOTSDK-7136 -->
- During navigation sometimes the next maneuver and voice instructions are triggered too early. <!-- IOTSDK-7145 -->
- After orientation changes coordinate conversions may return incorrect values. <!-- IOTSDK-6162 -->

### Version 4.4.5.0

#### New Features

- Added `set image(MapImage mapImage)` and `MapImage get image` to the `MapMarker` class. This allows to change a `MapImage` for a `MapMarker` that is already shown on the map to update its appearance.
- Added `void zoomTo(double zoomLevel)` to the `MapCamera` class to set the zoom level in the range [0,22]. Access the current `zoomLevel` from the camera's `State` property.
- Added `GeoBox GeoBox.containingGeoCoordinates(List<GeoCoordinates> geoCoordinates)` to construct a `GeoBox` from a list of `Geocoordinates`.
- A `CategoryQuery` can now be created from a single `PlaceCategory` with the additional constructor `CategoryQuery.withCategoryAndFilter(PlaceCategory category, String filter, GeoCoordinates areaCenter)`.

#### Resolved Issues

- Fixed: For routes with more than two waypoints the destination reached event may be called too early. <!-- IOTSDK-6707 -->
- Fixed: In rare cases map tiles may flicker when a device is offline and the cache is used. <!-- IOTSDK-6708 -->
- Fixed: During navigation, voice commands are sometimes missing or inaccurate.<!-- IOTSDK-6874, IOTSDK-6868, IOTSDK-6859 -->
- Fixed issues with map-matched locations during turn-by-turn navigation when driving with slow speed. <!-- IOTSDK-5989 -->

#### Known Issues

- The newly introduced zoom level behaves inconsistent across different devices as the shown level of detail depends on the physical screen size of a device. <!-- HARP-8095 -->
- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- During navigation sometimes the `nextRoadName` or `nextRoadNumber` are not available when the name of the street/road is a route number. In such a case, the next `Maneuver` indicates an 'unknown road'. <!-- IOTSDK-6483 -->
- Map tiles may not load automatically when losing internet connectivity and connectivity gets back, unless the user interacts with the map. <!-- IOTSDK-5727 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- When imperial unit system is selected along with 'EN US' language code, then `RouteTextOptions` returns 'ft' as unit, but voice guidance uses 'yards'. <!-- IOTSDK-6426 -->
- During navigation it can happen in rare cases that the distance to the next maneuver is slightly wrong. <!-- IOTSDK-6686 -->
- For some regions the speed limit value can be unexpectedly `null` on highways. <!--- IOTSDK-6775 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. <!-- IOTSDK-6911 -->
 - During navigation, tunnel extrapolation may not work as expected. <!-- IOTSDK-6989 -->
- A category search along a route will crash when the `GeoCorridor.polyline` list parameter is empty. <!-- IOTSDK-7016 -->
- On iOS devices, `MapViewPin` instances disappear from `MapView` when changing device orientation. They reappear when moving the map. <!-- IOTSDK-7117 -->
- `MapViewPin` instances cannot be removed after tilting and panning the map. <!-- IOTSDK-7051 -->

### Version 4.4.4.0

#### Highlights

- Added automatic geometry simplification to `MapPolyline`: Now, the rendered polyline shape is optimized based on the current distance of the camera to earth. While not being visible for the eye, this improves the performance, for example, when rendering longer routes.

#### API Changes

- `targetSdkVersion` and `compileSdkVersion` of the internal `AndroidManifest` used by the HERE SDK have been updated from 28 to 29.
- `here.sdk.Color` was removed, use `dart.ui.color` instead.

#### Resolved Issues

- Fixed an issue with flickering street labels after credentials have been changed. <!-- IOTSDK-6714 -->
- Fixed an issue with wrong left and right voice commands during navigation. <!-- IOTSDK-6861 -->
- Fixed issue with empty IDs for reverse geocoding results: IDs of place results are no longer empty strings and contain now a valid ID. <!-- IOTSDK-5408 -->
- Route calculation: When no truck route is found due to incompatible truck restrictions, the reason is now logged and `RoutingError.noRouteFound` error is returned. For example, a log may contain: "Potential route would violate truck restriction:{"maxHeight":400}". <!-- IOTSDK-1893 -->

#### Known Issues

- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- During navigation sometimes the `nextRoadName` or `nextRoadNumber` are not available when the name of the street/road is a route number. In such a case, the next `Maneuver` indicates an 'unknown road'. <!-- IOTSDK-6483 -->
- Map tiles may not load automatically when losing internet connectivity and connectivity gets back, unless the user interacts with the map. <!-- IOTSDK-5727 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6759 -->
- For routes with more than two waypoints the destination reached event may be called too early. <!-- IOTSDK-6707 -->
- When imperial unit system is selected along with 'EN US' language code, then `RouteTextOptions` returns 'ft' as unit, but voice guidance uses 'yards'. <!-- IOTSDK-6614 -->
- During navigation it can happen in rare cases that the distance to the next maneuver is slightly wrong. <!-- IOTSDK-6686 -->
- In rare cases map tiles may flicker when a device is offline and the cache is used. <!-- IOTSDK-6708, IOTSDK-6708 -->
- For some regions the speed limit value can be unexpectedly `null` on highways. <!--- IOTSDK-6775 -->
- During navigation, voice commands are sometimes missing or inaccurate.<!-- IOTSDK-6874, IOTSDK-6868, IOTSDK-6859 -->
- During navigation, the number of sections within `RouteProgress` may not match the number of `sections` within the `Route`. <!-- IOTSDK-6911 -->

### Version 4.4.3.0

#### Highlights

- Kinetic map panning behavior was greatly improved. Now, when swiping the map moves slower which results in a more natural feel.
- Certain areas can now be excluded from route calculation with `AvoidanceOptions` that contain an `avoidAreas` list holding `GeoBox` items which routes should not cross.

#### New Features

- Added optional `Suggestion.getHref()` to get a direct link to discover more details. It is available when the suggestion result type is _category_ or _chain_.
- Added `RoadFeatures.difficultTurns` enum value. Note that it is valid only for truck transport mode.
- Added `MapError.invalidState` enum value which can be raised when a map scene is in an invalid state after a `MapView` was destroyed.
- Added a new `GeoCorridor` constructor with `radiusInMeters` as _integer_ type - as replacement for the deprecated constructor with `radiusInMeters` as _double_ type, see below.

#### Deprecated

- Deprecated `GeoCorridor` constructor with `radiusInMeters` as _double_ type. Use the newly introduced `GeoCorridor` constructor with `radiusInMeters` as _integer_ type instead, see above.

#### API Changes

- The `AvoidanceOptions(avoidFeatures, avoidCountries)` constructor was extended to allow a list of `GeoBox` items as third parameter.

#### Resolved Issues

- Fixed: During navigation sometimes a `Manuever` does not contain all expected fields. <!-- IOTSDK-6685 -->
- Fixed: When the pick radius for `pickMapItems()` is set to 1000 or higher, an app may crash when picking map polylines. <!-- IOTSDK-6476 -->
- Fixed: `SearchEngine`: `Place.getId()` is empty for reverse geocoding results. <!-- IOTSDK-5408 -->

#### Known Issues

- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- During navigation sometimes the `nextRoadName` or `nextRoadNumber` are not available when the name of the street/road is a route number. In such a case, the next `Maneuver` indicates an 'unknown road'. <!-- IOTSDK-6483 -->
- Map tiles may not load automatically when losing internet connectivity and connectivity gets back, unless the user interacts with the map. <!-- IOTSDK-5727 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6040 -->
- For routes with more than two waypoints the destination reached event may be called too early. <!-- IOTSDK-6707 -->
- When imperial unit system is selected along with 'EN US' language code, then `RouteTextOptions` returns 'ft' as unit, but voice guidance uses 'yards'. <!-- IOTSDK-6614 -->
- During navigation it can happen in rare cases that the distance to the next maneuver is slightly wrong. <!-- IOTSDK-6686 -->
- In rare cases map tiles may flicker when a device is offline. <!-- IOTSDK-6708 -->

### Version 4.4.2.0

#### New Features

- Added a new `NavigatorInterface` which describes the main turn-by-turn functionality of a `Navigator`.
- Added `Place.geoCoordinates` to get the `GeoCoordinates` of a `Place`. Note that only `Place` instances retrieved from a `Suggestion` result may not contain geographic coordinates, hence the returned value is optional.
- Added departure/arrival information to the `Section` of a `Route`:
  - Added `Departure` class with the following fields:
    - `waypointIndex`
    - `originalCoordinates`
    - `mapMatchedCoordinates`
  - Added `Arrival` class with the following fields:
    - `waypointIndex`
    - `originalCoordinates`
    - `mapMatchedCoordinates`
  - Added `Section.departure` property.
  - Added `Section.arrival` property.
- Added `Suggestion.getType()` to get the new `SuggestionType` enum that indicates whether this `Suggestion` is a _place_, a _chain_ like a store, restaurant or bussiness chain - or a `category`.

#### Deprecated

- Deprecated `Place.coordinates`, use `Place.geoCoordinates` instead. Note that only `Place` instances retrieved from a `Suggestion` result may not contain geographic coordinates, hence the returned value has become optional.

#### Resolved Issues

- Fixed: When the `Route` used to _search along the route_ is too long, now a proper error is returned with `SearchError.ROUTE_TOO_LONG`. <!-- IOTSDK-6403 -->
- Fixed: For places that are obtained from the `Suggestion` class, the geographic coordinates always contain a latitude and a longitude equal to 0. An additional places request is needed to obtain the coordinates. <!-- IOTSDK-6502 -->

#### Known Issues

- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- `SearchEngine`: `Place.getId()` is empty for reverse geocoding results. <!-- IOTSDK-5408 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- When the pick radius for `pickMapItems()` is set to 1000 or higher, an app may crash when picking map polylines. <!-- IOTSDK-6476 -->
- During navigation sometimes the `nextRoadName` or `nextRoadNumber` are not available when the name of the street/road is a route number. In such a case, the next `Maneuver` indicates an 'unknown road'. <!-- IOTSDK-6483 -->
- Map tiles may not load automatically when losing internet connectivity and connectivity gets back, unless the user interacts with the map. <!-- IOTSDK-5727 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6040 -->
- For routes with more than two waypoints the destination reached event may be called too early. <!-- IOTSDK-6707 -->
- When imperial unit system is selected along with 'EN US' language code, then `RouteTextOptions` returns 'ft' as unit, but voice guidance uses 'yards'. <!-- IOTSDK-6614 -->
- During navigation sometimes a `Manuever` does not contain all expected fields. <!-- IOTSDK-6685 -->
- During navigation it can happen in rare cases that the distance to the next maneuver is slightly wrong. <!-- IOTSDK-6686 -->

### Version 4.4.1.0

#### New Features

- Traffic flows can now be identified along a `Route`. Introduced `TrafficSpeeds` class to provide traffic speed information over a `Section` polyline. The `Section.getTrafficSpeeds()` method returns a list of `TrafficSpeeds`'s which covers the `Section` polyline.
- Added `SearchError.QUERY_TOO_LONG` and `SearchError.FILTER_TOO_LONG`. These errors will appear if the search query or search filter is too long (over 300 characters).
- Added `Route.getTransportMode()` which returns the original `TransportMode` as requested for the route calculation.

#### Resolved Issues

- Fixed: Fixed memory leaks caused by `PlatformThreading` on Android platform.
- Fixed: Voice instructions are sometimes not properly synchronised with the current map-matched location. <!--- IOTSDK-5947 -->
- Fixed: During turn-by-turn navigation, a `NavigableLocation` may not contain map-matched geographic coordinates for some regions due to data issues. <!-- IOTSDK-6344 -->

#### Known Issues

- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- `SearchEngine`: `Place.getId()` is empty for reverse geocoding results. <!-- IOTSDK-5408 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- When the pick radius for `pickMapItems()` is set to 1000 or higher, an app may crash when picking map polylines. <!-- IOTSDK-6476 -->
- For places that are obtained from the `Suggestion` class, the geographic coordinates always contain a latitude and a longitude equal to 0. An additional places request is needed to obtain the coordinates. <!-- IOTSDK-6502 -->
- During navigation sometimes the `nextRoadName` or `nextRoadNumber` are not available when the name of the street/road is a route number. In such a case, the next `Maneuver` indicates an 'unknown road'. <!-- IOTSDK-6483 -->
- Map tiles may not load automatically when losing internet connectivity and connectivity gets back, unless the user interacts with the map. <!-- IOTSDK-5727 -->
- Flutter's _hot restart_ feature does not work when the map is moved. This results in an application freeze. <!-- IOTSDK-6040 -->

### Version 4.4.0.2

#### Highlights

- New map schemes have been introduced to support satellite images together with vector-based street labels: `hybridDay` and `hybridNight`.
- Support for interactive _private venues_ has been introduced. This feature is available for building owners upon request.

#### New Features

- Added to the `MapCamera` class the method: `setTargetOrientation(MapCameraOrientationUpdate orientation)` to set only the target orientation in relation to the camera.
- By default, polylines are rendered in the order as they have been added to the map. This can now be changed at runtime by setting the draw order. It's now also possible to change the width and outline width at runtime. For this, the following methods have been added to the `MapPolyline` class:
  - `set drawOrder(int value)` to set the `DrawOrder` for a `MapPolyline`.
  - `int get drawOrder` to get the `DrawOrder` for a `MapPolyline`.
  - `set width(double value)` to set the `LineWidth` for a `MapPolyline`.
  - `double get width` to get the `LineWidth` for a `MapPolyline`.
  - `set outlineWidth(double value)` to set the `OutlineWidth` for a `MapPolyline`.
  - `double get outlineWidth` to get the `OutlineWidth` for a `MapPolyline`.
- Search for places along a route: Added the `GeoCorridor` option to filter `TextQuery` results when performing an asynchronous search request along a route with the method `TextQuery.withCorridorAreaAndAreaCenter(String query, GeoCorridor corridorArea, GeoCoordinates areaCenter)`.
- Search for places by category along a route: Added the `CategoryQuery` structure that accepts the `GeoCorridor` option in its constructors with the `filter` parameter `CategoryQuery.withFilterAndCorridorArea(List<PlaceCategory> categories, String filter, GeoCorridor corridorArea)` and without the `filter` parameter `CategoryQuery.withCorridorArea(List<PlaceCategory> categories, GeoCorridor corridorArea)` to enable category search along a route. This feature is in BETA state.
- Added to the `Details` class the method: `List<PlaceCategory> getPrimaryCategories()` to get a place category from the result of a search query.

#### Resolved Issues

- Fixed issue with hot restart not working correctly. Now, the hot restart functionality is working properly without the need to restart the app. <!-- IOTSDK-6040 -->
- Fixed: Rendering order for `MapMarker3D` is not yet supported, so the marker may appear below building footprints. Now, the rendering order for `MapMarker3D` is supported and the marker no longer appears below building footprints. <!--- HARP-9290, IOTSDK-5784 -->
- Fixed several rendering issues related to map items. <!--- IOTSDK-6291 -->
- Fixed issue with non-working gestures after a map view is recreated. <!--- IOTSDK-5935 -->

#### Known Issues

- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- `SearchEngine`: `Place.getId()` is empty for reverse geocoding results. <!-- IOTSDK-5408 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- 3d marker is not aligned with the road when using the map matched position. <!-- IOTSDK-6263 -->
- During turn-by-turn navigation, a `NavigableLocation` may not contain map-matched geographic coordinates for some regions due to data issues. <!-- IOTSDK-6344 -->
- When the pick radius for `pickMapItems()` is set to 1000 or higher, an app may crash when picking map polylines. <!-- IOTSDK-6476 -->
- For places that are obtained from the `Suggestion` class, the geographic coordinates always contain a latitude and a longitude equal to 0. An additional places request is needed to obtain the coordinates. <!-- IOTSDK-6502 -->

### Version 4.3.4.0

#### Highlights

- With this release it is no longer necessary to request the sensitive `EXTERNAL_STORAGE` Android permission from users. See the related API change below.
- To enhance TBT Navigation, we added a `MilestoneReachedListener` that informs whenever a stopover has been passed. See the related feature description with more details below.
- During TBT navigation a new `SpeedWarningListener` informs whenever the user is exceeding the current speed limits on the road. See the related feature description with more details below.

#### New Features

- Added the line cap style property to `MapPolyline` with the enum `LineCap` to change polyline ends rendered on the map.
- Added the following properties `LineCap get lineCap` and `set lineCap(LineCap value)` to get and set the `LineCap` of a `MapPolyline`.
- Added the `Milestone` class with the following fields:
  - `int sectionIndex` for the index of the section on the route that has been completed.
  - `int waypointIndex` which corresponds to the waypoint in the original user-defined waypoint list.
  - `GeoCoordinates originalCoordinates` for user-defined geographic coordinates.
  - `GeoCoordinates mapMatchedCoordinates` for map-matched geographic coordinates.
- Added the `MilestoneReachedListener` abstract class to receive notifications about the arrival at each `Milestone`, and the method: `onMilestoneReached(Milestone milestone)` called when a milestone has been reached.
- Added the `DestinationReachedListener` abstract class to receive notifications about the arrival at the destination, and the method: `onDestinationReached()` called when the destination has been reached.
- Added the following methods to the Navigator class:
  - `set milestoneReachedListener(MilestoneReachedListener value)` to set the listener that notifies when a `Milestone` has been reached.
  - `get milestoneReachedListener` to get the listener notifies when a `Milestone` has been reached.
  - `set destinationReachedListener(DestinationReachedListener value)` to set the listener that notifies when a destination has been reached.
  - `get destinationReachedListener` to get the listener that notifies when a destination has been reached.
- Added the `SpeedWarningListener` abstract class to receive notifications from the `Navigator` about the speed limit being exceeded with the following method:
  - `onSpeedWarningStatusChanged(SpeedWarningStatus status)` called whenever the status of the speed warning status has changed to any of the `SpeedWarningStatus` values.
- Added the `SpeedWarningStatus` enumeration that represents the speed warning status.
- Added the `SpeedLimitOffset` struct that indicates the offset to be used above a specific speed to be notified of the speed limit being exceeded, with the following fields:
  - `Double lowSpeedOffsetInMetersPerSecond` for the speed limit offset for low speeds.
  - `Double highSpeedOffsetInMetersPerSecond` for the speed limit offset for high speeds.
  - `Double highSpeedBoundaryInMetersPerSecond` for the high speed boundary.
- Added the `SpeedWarningOptions` struct that contains all options to be used for speed limit warnings, with the following field:
  - `SpeedLimitOffset` for the speed limit offset to be used when notifying that the speed limit has been exceeded.
- Added the following properties to the Navigator class:
  - `set speedWarningListener(SpeedWarningListener value)` to set the listener to be notified of the speed limit being exceeded or back to normal.
  - `get speedWarningListener` to get the listener to be notified of the speed limit being exceeded or back to normal.
  - `set speedWarningOptions(SpeedWarningOptions value)` to set the speed warning options.
  - `get speedWarningOptions` to get the speed warning options.

#### API Changes

- Removed the `android.permission.READ_EXTERNAL_STORAGE` and `android.permission.WRITE_EXTERNAL_STORAGE` permissions from the SDK's Android manifest file.
- Internally, the HERE SDK switched from "UpperCamelCase" to "snake_case". This has no effect on the public API, but if you have the HERE SDK plugin folder under source control, please make sure to enable case sensitivity - otherwise these naming changes will be ignored when committing the folder.

#### Resolved Issues

- Fixed: Error when loading a SVG file into a `MapImage`. Now, SVG files that are stored in the assets directory can be loaded into a `MapImage` with the method `MapImage.withFilePathAndWidthAndHeight("assets/my_svg_image.svg", 100, 100)` (call example). <!-- IOTSDK-5809 -->

#### Known Issues

- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- `SearchEngine`: `Place.getId()` is empty for reverse geocoding results. <!-- IOTSDK-5408 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Rendering order for `MapMarker3D` is not yet supported, so the marker may appear below building footprints. <!--- HARP-9290 -->

### Version 4.3.3.0

#### New Features

- Added the ability to get and set the primary language of the map using a static property `HereMapController.primaryLanguage`.

#### API Changes

- Renamed `HereMapController.pins` to `HereMapController.widgetPins`.

#### Resolved Issues

- Fixed: App crashes when access to memory storage is denied. Now, access to the memory storage is granted by setting the path to the map cache. <!-- IOTSDK-5841 -->

#### Known Issues

- Map caching may not work as expected for satellite map scheme. Existing tiles may be reloaded. <!-- IOTSDK-4381 -->
- `SearchEngine`: `Place.getId()` is empty for reverse geocoding results. <!-- IOTSDK-5408 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Rendering order for `MapMarker3D` is not yet supported, so the marker may appear below building footprints. <!--- HARP-9290 -->
- Error when loading a SVG file into a `MapImage`. <!-- IOTSDK-5809 -->
- Startup performance for navigation is very slow on certain devices. <!--- IOTSDK-5903 -->
- Random route recalculations may occur during drive navigation, especially on crossroads. <!--- IOTSDK-5890 -->
- Voice instructions are sometimes not properly synchronized with the current map-matched location. <!--- IOTSDK-5947 -->

### Version 4.3.2.0

#### Highlights

- The minimum supported Flutter version was raised to 1.17 or newer.

#### New Features

- Added support for map widget pins: Added `mapController.pinWidget(widget, coords)` and `mapController.pinWidget(widget, coords, anchor: anchor)` to add the map widget pins with and without an anchor point. Use `mapController.unpinWidget(widget)` to remove a map widget pin.
- Added the `ManeuverProgress` class which is accessible from `RouteProgress.maneuverProgress` to indicate progress details to the next and next-next maneuvers during navigation.
- Added the method `MapCamera.getBoundingBox()` to get the currently visible map area encompassed in a `GeoBox`.
- Added the method `MapCamera.setDistanceToTarget(double distanceInMeters)` to set the distance from the `MapCamera` to the target location on earth.
- Added the methods `MapView.setPrimaryLanguage(LanguageCode languageCode)` and `MapView.getPrimaryLanguage()` to set and get the primary language of the map.
- Added updated support for the `SDKOptions.cachePath` handling. If `SDKOptions.cachePath` is not set, it will be assigned a default path. A custom `cachePath` can be set in the app's manifest (Android) or Plist (iOS).
- Added the `GPXDocument` class to create a `GPX` document and to load a `GPX` file.
- Added the `GPXTrack` class to represent a single track from a `GPXDocument`.
- Added the constructor `LocationSimulator.withTrack(GPXTrack, LocationSimulatorOptions)` to specify the `GPX` track to travel and the options to specify how the location simulator will behave.

#### Deprecated
- Deprecated the property `RouteProgress.currentManeuverIndex`. Use the `RouteProgress.maneuverProgress` property instead.
- Deprecated the property `RouteProgress.currentManeuverRemainingDistanceInMeters`. Use the `RouteProgress.maneuverProgress` property instead.

#### Resolved Issues

- Fixed: The `Authentication` callback was not always called on the main thread. Now the callback is guaranteed to be always called on the main thread. <!-- IOTSDK-5338 -->
- Fixed: Android apps may crash when an app is closed with the back button. <!-- IOTSDK-5641 -->
- Fixed app crash in some scenarios when `MapView.onDestroy` is called twice. <!-- IOTSDK-5774 -->
- Fixed: Calling `navigator.getSupportedLanguagesForManeuverNotifications()` before a route is set will no longer result in an empty list. <!-- IOTSDK-5668 -->

#### Known Issues

- `SearchEngine`: `Place.getId()` is empty for reverse geocoding results. <!-- IOTSDK-5408 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Rendering order for `MapMarker3D` is not yet supported, so the marker may appear below building footprints. <!--- HARP-9290 -->
- Error when loading a SVG file into a `MapImage`. <!-- IOTSDK-5809 -->
- Heading is currently ignored during turn-by-turn navigation. <!-- IOTSDK-5762 -->

### Version 4.3.1.0

#### API Changes

- Renamed `MapView` to `HereMapController`.
- Changed `callback` name for the method `HereMap(onMapViewCreated: (MapView mapView) {mapView.loadSceneForMapScheme(...);})` to `HereMap(onMapCreated: (MapView mapView) {mapView.loadSceneForMapScheme(...);})`.

#### Resolved Issues

- Fixed: `AvoidanceOptions` will be ignored when calculating truck routes. Now, `AvoidanceOptions` are considered when calculating truck routes.

#### Known Issues

- `SearchEngine`: `Place.getId()` is empty for reverse geocoding results. <!-- IOTSDK-5408 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
- Android apps may crash when an app is closed with back button. Restarting again will work. <!-- IOTSDK-5641 -->
- Rendering order for `MapMarker3D` is not yet supported, so the marker may appear below building footprints. <!--- HARP-9290 -->
- Calling `navigator.getSupportedLanguagesForManeuverNotifications()` before a route is set will result in an empty list. <!-- IOTSDK-5668 -->

### Version 4.3.0.0

#### Highlights

- This is the initial release.

#### Known Issues

- `SearchEngine`: `Place.getId()` is empty for reverse geocoding results. <!-- IOTSDK-5408 -->
- `AvoidanceOptions` will be ignored when calculating truck routes. <!-- IOTSDK-5336 -->
- Transparency for `MapPolylines` is not supported. <!--- IOTSDK-5364 -->
