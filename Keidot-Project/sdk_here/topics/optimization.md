# Manage data and OTA costs

This guide provides strategies to reduce the size of the HERE SDK and enhance its runtime performance by minimizing the amount of data that needs to be loaded or processed.

## Overview of OCM layers

Several features of the HERE SDK are stored in the OCM map data format (Optimized Client Maps).

Utilizing the `LayerConfiguration`, you can control:

- The amount of map data that is loaded into the cache during online panning of the `MapView`.
- The volume of data downloaded when adding a new `Region` for offline use.

For instance, if turn-by-turn navigation is not utilized within an application, the corresponding feature configuration `NAVIGATION` can be omitted. This adjustment results in less data being downloaded into the cache while panning the `MapView`. Moreover, the size of the data downloaded when adding a new `Region` will be considerably reduced.

As of now, the below features can be specified. The table also shows which features are enabled, by default:

<center><p>
<table style="width:500">
  <tr>
    <th style="vertical-align:top">Feature</th>
    <th style="vertical-align:top">Enabled</th>
    <th style="vertical-align:top">Description</th>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>detailRendering</code></td>
    <td style="vertical-align:top">Yes</td>
    <td style="vertical-align:top">Additional rendering details like buildings. Only used for the <code>MapView</code>. When not set, the data will be excluded when downloading offline regions or prefetching areas that contain such data. However, during online usage such data may still be downloaded into the cache and shown.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>navigation</code></td>
    <td style="vertical-align:top">Yes</td>
    <td style="vertical-align:top">Map data that is used for map matching during navigation. When not set, navigation may not work properly when being used online or offline.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>offlineSearch</code></td>
    <td style="vertical-align:top">Yes</td>
    <td style="vertical-align:top">Map data that is used to search. When not set, the <code>OfflineSearchEngine</code> may not work properly when being used.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>offlineRouting</code></td>
    <td style="vertical-align:top">Yes</td>
    <td style="vertical-align:top">Map data that is used to calculate routes. When not set, the <code>OfflineRoutingEngine</code> may not work properly when being used.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>truck</code></td>
    <td style="vertical-align:top">Yes</td>
    <td style="vertical-align:top">Map data that is used to calculate truck routes. When not set, the <code>OfflineRoutingEngine</code> may not work properly when being used to calculate truck routes. It is also used for map matching during truck navigation. When not set, truck navigation may not work properly when being used offline. Online truck navigation will still work when the device has an online connection.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>landmarks3d</code></td>
    <td style="vertical-align:top">No</td>
    <td style="vertical-align:top">Map data that is used to render textured 3D landmarks. When not set, the data will be excluded when downloading offline regions or prefetching areas that contain such data. When the <code>LANDMARKS</code> layer is set to be visible for a <code>MapScene</code>, 3D landmarks will still be visible during online usage.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>junctionView3x4</code>, <code>junctionView16x9</code></td>
    <td style="vertical-align:top">No</td>
    <td style="vertical-align:top">3D visuals for complex junctions. This asset data can be used to show SVG images during guidance. If enabled, downloaded regions will include junction view images to be used with the corresponding <code>JunctionViewWarning</code> event. This could be useful to download the assets before starting a trip. If not enabled, the required data will be downloaded when needed. Each image can occupy up to 15 MB. Note that future releases of the HERE SDK will optimize the size by reducing the level of realism. By default, the layer is not enabled.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>junctionSign3x4</code>, <code>junctionSign4x3</code>, <code>junctionSign3x5</code>, <code>junctionSign5x3</code>, <code>junctionSign16x9</code></td>
    <td style="vertical-align:top">No</td>
    <td style="vertical-align:top">Signpost visuals. This asset data can be used to show SVG images during guidance. If enabled, downloaded regions will include junction view images to be used with the corresponding <code>SignpostWarning</code> event. If not enabled, the required data will be downloaded when needed. Each image can occupy up to 300 KB. If not enabled, the required data will be downloaded when needed. By default, the layer is not enabled.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>rendering</code></td>
    <td style="vertical-align:top">Yes</td>
    <td style="vertical-align:top">A basic set of rendering features such as Carto POIs. As a base layer, this feature cannot be disabled.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>rdsTraffic</code></td>
    <td style="vertical-align:top">No</td>
    <td style="vertical-align:top">Map data that provides traffic broadcast functionality using RDS-TMC format. It should be used when there is no internet connection, so that the routing module can utilize traffic data coming over the radio channel to create routes with the <code>OfflineRoutingEngine</code>.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>ev</code></td>
    <td style="vertical-align:top">No</td>
    <td style="vertical-align:top">Offline map data for EV charging stations.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>truckServiceAttributes</code></td>
    <td style="vertical-align:top">No</td>
    <td style="vertical-align:top">Enables truck related attributes to be returned by <code>OfflineSearchEngine</code>.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>fuelStationAttributes</code></td>
    <td style="vertical-align:top">No</td>
    <td style="vertical-align:top">Enables fuel attributes to be returned by <code>OfflineSearchEngine</code>.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>offlineBusRouting</code></td>
    <td style="vertical-align:top">No</td>
    <td style="vertical-align:top">Map data that is used to calculate bus routes. When not set, the <code>OfflineRoutingEngine</code> may not be able to calculate routes with <code>BusOptions</code>.</td>
  </tr>
  <tr>
    <td style="vertical-align:top"><code>terrain</code></td>
    <td style="vertical-align:top">No</td>
    <td style="vertical-align:top">Map data that is used to represent topographical data.</td>
  </tr>
</table>
</p></center>

Note that each of the listed features relates to one or more OCM layer groups. The names of the OCM layer groups can be seen per feature in the API Reference. However, for most use cases knowing the related OCM layer name is not relevant.

In addition, there are two layers, `ADAS` and `EHORIZON` (Electronic Horizon), that are currently not relevant for use with the HERE SDK editions and can be ignored for now. By default, they are already disabled.

## Configure OCM layers to minimize data load

Setting a `LayerConfiguration` involves specifying a list of `Feature` items via `SDKOptions.layerConfiguration`. Only the features in this list will be enabled; all others will be disabled. If the intention is to disable a single feature, ensure all other desired features are included in the list, or they will be automatically disabled as well.

For example, if the feature list contains `navigation` and `TRUCK`, then it enables only navigation and truck features and disables all others.

Only the `LayerConfiguration` will be used that was set globally when a `Region` was downloaded or cached for the first time. If you want to update the `LayerConfiguration` for an already downloaded region, delete the region and download it again - or call `mapUpdater.performFeatureUpdate()` (see also below).

If a feature is disabled, then it means that required data for that feature will not occupy space in the cache or as part of a `Region` download. It also means, that the feature cannot be used offline. And sometimes even an error may occur - for example, when trying to use the `OfflineSearchEngine` although `offlineSearch` has been disabled. Find more details below.

> #### Note
> Engines like the `SearchEngine` or the `RoutingEngine` will never make use of cached or downloaded map data. Only the `OfflineSearchEngine` and `OfflineRoutingEngine` will use such data if the related features have not been disabled. For example, if you are sure that your app fully operates online, it is safe to disable the offline search feature. However, if you want to ensure that an app can also search for POIs when there is a temporary connection loss, you may want to switch to the `OfflineSearchEngine` when such a loss is detected - and therefore, you should not disable the related feature.

As listed above, for some disabled features, a device may still download corresponding data when a device has online connectivity and the feature is needed. For example, when the `landmarks3d` feature is disabled, but the corresponding `MapScene` layer is enabled, then the device will still download the needed textures to render a 3D landmark when it becomes visible in the `MapView` viewport.

For all listed features from above - except for `offlineSearch` and `offlineRouting`, the HERE SDK will first check if the needed data is available in the cache. If not found there, it will look if there is a downloaded `Region` for offline use. If not found, the HERE SDK will try to download the needed data over the air. For `offlineSearch` and `offlineRouting` the behavior will be the same, but no data will be requested over the air.

<!-- TODO this needs to be reviewed again when modularization is ready.
Features are enabled, by default, based on the module configuration. If an edition of the HERE SDK includes the `OfflineSearchEngine`, then the "OFFLINE_SEARCH" layer is enabled, otherwise not.
For the _Headless Edition_ all features are enabled, except for "DETAIL_RENDERING" and "LANDMARKS_3D".
-->

## Set a LayerConfiguration

At first, specify the desired layer configuration:

```dart
// With this layer configuration we enable only the listed layers.
// All the other layers including the default layers will be disabled.
var enabledFeatures = [LayerConfigurationFeature.detailRendering,LayerConfigurationFeature.rendering,LayerConfigurationFeature.offlineSearch];
```

Set the created `layerConfiguration` object to `SDKOptions` and initialize the HERE SDK as usual.

```dart
var layerConfiguration = LayerConfiguration(enabledFeatures);
sdkOptions.layerConfiguration = layerConfiguration;

// Now use the SDKOptions for initializing a new SDKNativeEngine instance.
```
## Update the feature configuration

Layer configurations can be updated any time by setting new `SDKOptions` to create a new instance of a `SDKNativeEngine`.

Call `mapUpdater.performFeatureUpdate(..)` to apply a new `LayerConfiguration` which will overwrite the previous one. When you are using a `MapView`, then you also need to reinitialize all engines including the `SDKNativeEngine` and the `MapView`.

> #### Note
> When calling `mapUpdater.performFeatureUpdate(..)`, then cached map data is purged only when an installed region is identified. The map data adheres to the LRU (Least Recently Used) eviction policy, so any updates will exclusively apply to newly downloaded data and not retroactively to existing cached data. For immediate cache invalidation, users can manually clear the cache. Otherwise, stale cache data may still be accessed by the HERE SDK, for example, when using the `OfflineSearchEngine`.

Call `performFeatureUpdate()` when a feature configuration has been changed. An implementation may look like below:

```dart
// ReCreate MapUpdater in background to not block the UI thread.
MapUpdater.fromSdkEngineAsync(SDKNativeEngine.sharedInstance!,
    (mapUpdater) {
  _mapUpdater = mapUpdater;
  _mapUpdater.performFeatureUpdate(
      MapUpdateProgressListener((regionId, percentage) {
    // Handle feature update progress.
    print(
        "FeatureUpdate: Downloading and installing a map feature update. Progress for" +
            regionId.id.toString() +
            ":" +
            percentage.toString());
  }, (error) {
    if (error == null) {
      print(
          "Feature update onPause error. The task tried to often to retry the update: " +
              error.toString());
    } else {
      print(
          "FeatureUpdate: The map feature update was paused by the user.");
    }
  }, (error) {
    if (error == null) {
      print("Feature update completion error: " + error.toString());
    } else {
      print(
          "FeatureUpdate: One or more map update has been successfully installed.");
    }
  }, () {
    print(
        "FeatureUpdate: A previously paused map feature update has been resumed.");
  }));
});
```

Note that it is the developer's responsibility to decide when to perform the update. It happens async and may take time depending on how many regions have been installed. The HERE SDK does not decide or notify when such an update can be made. It is not necessary to call this, when the feature configuration has not been changed by a developer.

### Update the feature configuration when using a MapView

To enable or disable a layer configuration at runtime when showing a `MapView`, calling `mapUpdater.performFeatureUpdate(..)` alone is not sufficient. All engines, including `SdkNativeEngine` and `MapView`, must be reinitialized. Below we show an example of the steps.

```dart
// Set your credentials for the HERE SDK.
SDKOptions sdkOptions =
    SDKOptions.withAccessKeySecret(accessKeyId, accessKeySecret);
sdkOptions.layerConfiguration = layerConfiguration;

// Releases resources used by the SDK.
SdkContext.release();

// Needs to be called before accessing SDKOptions to load necessary libraries.
SdkContext.init(IsolateOrigin.main);

try {
  // Invoking makeSharedInstance will invalidate any existing references to the previous instance of SDKNativeEngine.
  await SDKNativeEngine.makeSharedInstance(sdkOptions);
} on InstantiationException {
  throw Exception("Failed to initialize the HERE SDK.");
}

rebuildMapView();

// ReCreate MapDownloader.
MapDownloader.fromSdkEngineAsync(SDKNativeEngine.sharedInstance!,
    (mapDownloader) {
  _mapDownloader = mapDownloader;
});

// Reinitialize other necessary engines as required.
```
2. Update the current `MapView` instance to recreate the rendering surface that was invalidated by the invocation of `makeSharedInstance()`.

To allow re-creation of `MapView`, a unique Key may be assigned to the Scaffold widget. Modifying the key ensures that Flutter completely rebuilds the widget.

```dart
void _rebuildMap() {
  setState(() {
    // Force rebuild of mapview.
    _refreshKey = UniqueKey();
  });
}
```
3. Reinitialize the `MapUpdater` and use it to call `performFeatureUpdate(..)`.

```dart
MapUpdater.fromSdkEngineAsync(SDKNativeEngine.sharedInstance!,
    (mapUpdater) {
  _mapUpdater = mapUpdater;
  _mapUpdater.performFeatureUpdate(mapUpdateProgressListener);
});
```
Keep in mind, that when no `MapView` is used in your application, then it is enough to normalize the new layer configuration by calling `performFeatureUpdate()`.
