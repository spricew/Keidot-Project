# Alternative options

Apart from installing map data as `Regions` into the persisted storage, you can also prefetch data into the cache without the need to use the `MapDownloader`. If you are only interested in finding specific data, you can use the `SegmentDataLoader`, which works only on already cached or downloaded region data.

## Access map data on-the-fly

Use the `SegmentDataLoader` to load OCM map data attributes of a map segment.

1. With `getSegmentsAroundCoordinates​(GeoCoordinates coordinates, double radiusInMeters)` you can access OCM map data to load a list of `OCMSegmentId` IDs.
2. With these IDs you can synchronously load a `SegmentData` object containing information on `SegmentSpanData` that contains, for example, the `PhysicalAttributes` of a road, `SegmentSpeedLimit` information and more data from the OCM map.

The API works offline on cached or persisted map data.

## Prefetch map data

The HERE SDK provides support for route prefetching of map data. This allows to improve the user experience - for example, during turn-by-turn navigation to handle temporary network losses gracefully.

Note that this is not needed if [offline maps](offline-maps.md) are already downloaded for the region where a trip takes place. In this case, all map data is already there, and no network connection is needed. Unlike, for example, the dedicated `OfflineRoutingEngine`, the `Navigator` or `VisualNavigator` will decide automatically when it is necessary to fallback to cached data or offline map data. In general, navigation requires map data, even if it is executed headless without showing a map view. The reason for this is that map data needs to be accessed during navigation for map matching and, for example, to notify on certain road attributes like speed limits. This data is taken from the available data on the device - or in case it is not there, it needs to be downloaded during navigation. Therefore, it can be beneficial to prefetch more data in anticipation of the road ahead. Without prefetching, temporary connection losses can be handled less gracefully.

> #### Note
> Note that this is a beta release of this feature, so there could be a few bugs and unexpected behaviors. Related APIs may change for new releases without a deprecation process.

The `RoutePrefetcher` constructor requires a `SDKNativeEngine` instance as only parameter. You can get it via `SDKNativeEngine.sharedInstance` after the HERE SDK has been initialized.

With the `RoutePrefetcher` you can download map data in advance. The map data will be loaded into the [map cache](tips-engines.md#work-with-the-map-cache). Note that the map cache has its own size constraints and may already contain data: the `RoutePrefetcher` may need to evict old cached data in order to store new map data.

- It is recommended to call once `routePrefetcher.prefetchAroundLocationWithRadius(currentGeoCoordinates, radiusInMeters)` before starting a trip. This call prefetches map data around the provided location into the map cache and it ensures, that there is enough map data available when a user starts to follow the route - assuming that the route starts from the current location of the user. Note that the prefetching for this call happens asynchronously only when a free execution thread is available. Otherwise, it will wait until one is free - therefore, this call should have only a minimal impact on the overall app performance.

- after navigation has started, consider to call once `routePrefetcher.prefetchAroundRouteOnIntervals​(navigator)`: It prefetches map data within a corridor along the route that is currently set to the provided `Navigator` instance. If no route is set, no data will be prefetched. The route corridor defaults to a length of 10 km and a width of 5 km. Map data is prefetched only in discrete intervals. Prefetching starts 1 km before reaching the end of the current corridor. Prefetching happens based on the current map-matched location - as indicated by the `RouteProgress` event. The first prefetching will start after traveling a distance of 9 km along the route. If a new route is set to the `navigator`, it is not necessary to call this method again - however, it has also no negative impact when it is called twice or more times.

The "navigation_app" shows an example how to use the `RoutePrefetcher`.

If the `RoutePrefetcher` was successfully used at the start of a route - and then later the connectivity is lost, the cached data will be preserved even across future power cycles until the map cache is evicted. More about the map cache's eviction policy can be found [here](tips-engines.md#work-with-the-map-cache).

- For convenience, you can alternatively call both methods together before starting navigation. However, as a trade-off, there might not be enough time to prefetch all required data when the trip starts soon thereafter.
- Keep in mind that `prefetchAroundRouteOnIntervals()` increases network traffic continuously during guidance.

Of course, guidance will be also possible without any prefetched data, but the experience may be less optimized:

Both calls help to optimize temporary offline use cases that rely on cached map data. While the `prefetchAroundLocationWithRadius()` can be also used outside of a navigation use case, `prefetchAroundRouteOnIntervals()` requires an ongoing navigation scenario.

Alternatively, you can prefetch map data for the entire route in advance. Use `RoutePrefetcher.prefetchGeoCorridor()` to prefetch tile data for a `GeoCorridor` created from the route's shape. Since this can take a little longer - depending on the length of the route, the corridor's width and the network - a progress is reported via `PrefetchStatusListener.onProgress()`. Once the operation is completed, an `PrefetchStatusListener.onComplete()` event is sent.

> #### Note
> In case the route passes already downloaded `Region` data, then these parts of the corridor are reused and not downloaded again.
> Similarly, prefetching will not download data twice that is already available in the map cache. In general, all prefetched data is not stored permanently on the device and may be evicted when newer data is loaded at a later point in time. Also, the available space depends on the map cache size, which can be configured by the user. If not enough space is available, a `MapLoaderError` will be issued. More information on the map cache can be found [here](tips-engines.md#work-with-the-map-cache).

Another way to prefetch map data can implemented with the `PolygonPrefetcher`. This allows to fetch data independent from a concrete `Route`. Instead only a `GeoPolygon` is required to indicate where to download the data. Note that this data is only stored temporarily in the map cache - same as for the `RoutePrefetcher`. The `PolygonPrefetcher` also allows to estimate the expected downloaded `MapDataSize` prior to downloading the data.

## Download an area

Instead of downloading a predefined `Region`, alternatively, you can specify a custom area to download. This area can be set as a polygon or, for example, as a `GeoBox`, as shown below.

The HERE SDK optimizes storage by saving map data only once, even if the area has been previously downloaded as part of another area or `Region`.

The `DownloadRegionsStatusListener` used for downloading `Region` data is also used when downloading an area. It provides updates on the installation progress in the same way. When downloading an area has been completed, the list contains only one unique `RegionId` identifying the area. It's recommended to store this ID with a human readable name, as this will make it easier to delete the downloaded area in the future by calling `mapDownloader.deleteRegions(...)`. You can access the ID of a downloaded area through `InstalledRegions`.

> #### Note
> You can call `mapDownloader.downloadArea(...)` in parallel to download multiple areas simultaneously.

Below is an example of how to persistently install the area currently visible in the viewport:

```dart
onDownloadAreaClicked() {
  _showDialog("Note",
      "Downloading the area that is currently visible in the viewport.");

  GeoBox geoBox = _getMapViewGeoBox();
  GeoPolygon polygonArea = GeoPolygon.withGeoBox(geoBox);

  MapDownloaderTask mapDownloaderTask = _mapDownloader.downloadArea(
      polygonArea,
      DownloadRegionsStatusListener(
              (MapLoaderError? mapLoaderError, List<RegionId>? list) {
            // Handle events from onDownloadRegionsComplete().
            if (mapLoaderError != null) {
              _showDialog(
                  "Error", "Download area completion error: $mapLoaderError");
              return;
            }

            String message =
                "Download area status. Completed 100%! ID: " +
                    list!.first.id.toString();
            print(message);
          }, (RegionId regionId, int percentage) {
        // Handle events from onProgress().
        // Note that this ID is uniquely created and can be used to delete the area in the future.
        String message = "Download of area. ID: " +
            regionId.id.toString() +
            ". Progress: " +
            percentage.toString() +
            "%.";
        print(message);
      }, (MapLoaderError? mapLoaderError) {
        // Handle events from onPause().
        if (mapLoaderError == null) {
          _showDialog("Info",
              "The area download was paused by the user calling mapDownloaderTask.pause().");
        } else {
          _showDialog("Error",
              "Download area onPause error. The task tried to often to retry the download: $mapLoaderError");
        }
      }, () {
        // Handle events from onResume().
        _showDialog("Info", "A previously paused area download has been resumed.");
      }));
}
```

For this example we use a `GeoBox` to define the region we want to download. The above code including the code for `getMapViewGeoBox()` can be found in the accompanying "OfflineMaps" example app, you can find on [GitHub](https://github.com/heremaps/here-sdk-examples/tree/master/examples/latest/navigate/flutter/offline_maps_app).
