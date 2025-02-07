# Update map data

With the `MapUpdater` class you can check if newer map versions are available and - if available - update the already installed regions. Each HERE SDK version comes hardcoded with a specific map version. This defines the map data in the cache and the downloaded regions (if any).

Note that certain HERE SDK features may require a specific map version - as indicated in the related API Reference documentation or in this guide.

> #### Note
> **Incremental map updates** are supported, by default: instead of downloading an entire region, only the parts that have changed will be installed. This results in a faster update process and less downloaded data. If the `patchHrn` field of a `CatalogConfiguration` is `null`, then incremental updates will be disabled and the map data is downloaded still incrementally to some extent, but in larger bundles resulting in more bandwidth consumption. Usually, this is handled internally by the HERE SDK and developers do not need to create a `CatalogConfiguration` on their own.
>
> In general, we provide **weekly map updates**. With incremental map updates for the first time usage, a user will have to download the full region(s). Any update after the first download can be done incremental. Note that the decision if a full download or only an incremental update is executed is done automatically by the HERE SDK.
>
> After three months the `MapUpdater` will no longer perform incremental updates, but instead download the full region again when `mapUpdater.updateCatalog(...)` is executed. So, instead of checking only for the delta of map data changes, a full batch update is performed. Before performing the update, `CatalogUpdateInfo` contains information about how much map data will be updated.

## Use the MapUpdater

When an app update is installed that integrates a new HERE SDK version, it will most likely also feature a new map version. However, the installed regions will not be automatically updated, unless the `MapUpdater` is used to perform this task. Of course, map updates can also be installed for older HERE SDK versions.

- Check the currently used map version by calling `mapUpdater.getCurrentMapVersion()`.
- Check if an update is available by calling `mapUpdater.retrieveCatalogsUpdateInfo()`.

The class needs to be created asynchronously to not block the UI thread - in the same manner as the `MapDownloader`:

```dart
SDKNativeEngine? sdkNativeEngine = SDKNativeEngine.sharedInstance;

if (sdkNativeEngine != null) {
  // Create MapUpdater in background to not block the UI thread.
  MapUpdater.fromSdkEngineAsync(sdkNativeEngine, (mapUpdaterConstructionCallback) {
    // mapUpdaterConstructionCallback has be created.
  });
}
else {
  print("Error: SDKNativeEngine not initialized.");
}
```

## Get current map version

Sometimes, it may be useful to know the map version used for the map cache and the installed `Region` data. You can use the following code snippet to log the currently used map version:

```dart
SDKNativeEngine? sdkNativeEngine = SDKNativeEngine.sharedInstance;

if (sdkNativeEngine != null) {
  // Create MapUpdater in background to not block the UI thread.
  MapUpdater.fromSdkEngineAsync(sdkNativeEngine, (mapUpdaterConstructionCallback) {
    try {
      MapVersionHandle mapVersionHandle = mapUpdaterConstructionCallback.getCurrentMapVersion();
      String versionInfo = mapVersionHandle.stringRepresentation(",");
      print("Info: Current Map Version: " + versionInfo);
    } on MapLoaderExceptionException catch(e) {
      // Handle exception.
      print("Get current map version failed: " + e.error.name.toString());
    }
  });
}
else {
  print("Error: SDKNativeEngine not initialized.");
}
```

This information is mostly useful for debugging purposes. Note that the map version is also logged by the HERE SDK when the map view is shown for the first time.

It has the format `[cache-version].[offline-maps-version],[japan-cache-version].[japan-offline-maps-version]`. An example result my look like "47.47,47.47". It is not possible to get different versions for the map cache and offline maps.

## Check for map updates

Map update checks can be performed at each application start. However, when region data has been installed, this may become a lengthy operation, so users should be informed. Usually, you first check for an update by calling `retrieveCatalogsUpdateInfo()` - this provides one or more `CatalogUpdateInfo` items that can be used to call `updateCatalog()`:

```dart
void _checkForMapUpdates() {
  if (_mapUpdater == null) {
    _showDialog("Note", "MapUpdater instance not ready. Try again.");
    return;
  }

  _mapUpdater.retrieveCatalogsUpdateInfo((mapLoaderError, catalogList) {
    if (mapLoaderError != null) {
      print("CatalogUpdateCheck Error: " + mapLoaderError.toString());
      return;
    }

    // When error is null, then the list is guaranteed to be not null.
    if (catalogList!.isEmpty) {
      print("CatalogUpdateCheck: No map updates are available.");
    }

    _logCurrentSDKVersion();
    _logCurrentMapVersion();

    for (CatalogUpdateInfo catalogUpdateInfo in catalogList) {
      print("CatalogUpdateCheck - Catalog name:" + catalogUpdateInfo.installedCatalog.catalogIdentifier.hrn);
      print("CatalogUpdateCheck - Installed map version:" +
          catalogUpdateInfo.installedCatalog.catalogIdentifier.version.toString());
      print("CatalogUpdateCheck - Latest available map version:" + catalogUpdateInfo.latestVersion.toString());
      _performMapUpdate(catalogUpdateInfo);
    }
  });
}
```

## Update map data and map version

As a next step we implement the code to perform the map update. This will also raise the map version:

```dart
// Downloads and installs map updates for any of the already downloaded regions.
// Note that this example only shows how to download one region.
void _performMapUpdate(CatalogUpdateInfo catalogUpdateInfo) {
  if (_mapUpdater == null) {
    _showDialog("Note", "MapUpdater instance not ready. Try again.");
    return;
  }

  // This method conveniently updates all installed regions if an update is available.
  // Optionally, you can use the CatalogUpdateTask to pause / resume or cancel the update.
  CatalogUpdateTask catalogUpdateTask = _mapUpdater.updateCatalog(
      catalogUpdateInfo,
      CatalogUpdateProgressListener((RegionId regionId, int percentage) {
        // Handle events from onProgress().
        print("CatalogUpdate: Downloading and installing a map update. Progress for ${regionId.id}: $percentage%.");
      }, (MapLoaderError? mapLoaderError) {
        // Handle events from onPause().
        if (mapLoaderError == null) {
          print("CatalogUpdate:  The map update was paused by the user calling catalogUpdateTask.pause().");
        } else {
          print("CatalogUpdate: Map update onPause error. The task tried to often to retry the update: " +
              mapLoaderError.toString());
        }
      }, (MapLoaderError? mapLoaderError) {
        // Handle events from onComplete().
        if (mapLoaderError != null) {
          print("CatalogUpdate: Map update completion error: " + mapLoaderError.toString());
          return;
        }

        print("CatalogUpdate: One or more map update has been successfully installed.");
        _logCurrentMapVersion();

        // It is recommend to call now also `getDownloadableRegions()` to update
        // the internal catalog data that is needed to download, update or delete
        // existing `Region` data. It is required to do this at least once
        // before doing a new download, update or delete operation.
      }, () {
        // Handle events from onResume():
        print("CatalogUpdate: A previously paused map update has been resumed.");
      }));
}
```

Note that calling `updateCatalog()` is internally optimized to update only the parts of a `Region` that actually have changed. This means that for most cases an update does not require a user to redownload all packages and instead, each region is divided into several internal bundles that are only downloaded again when there was a map data change in it. This procedure is also known as incremental map updates.

- If no offline maps have been installed, calling `mapUpdater.updateCatalog()` will only clear the cache and the cache will be subsequently filled with new data for the latest available map version.

- The cache will always use the same map version as offline maps. If offline maps are updated, the cache will be also updated. The cache version will never be older than the offline maps version.

> #### Note
> It is not possible to enforce a map update by uninstalling all downloaded regions via `deleteRegions()` and then downloading the desired regions again. In that case, the same map version would be downloaded. However, if `updateCatalog()` is executed beforehand then a map update may be indicated and can be installed.

Please ensure the following when updating maps:

- Once `mapUpdater.updateCatalog()` has completed, it is required to call `getDownloadableRegions()` to update the internal catalog data that is needed to download, update or delete existing `Region` data.
- During an ongoing map update and related operations, not all `MapDownloader` and `MapUpdater` features may be accessible. While many operations can be performed in parallel, in some cases, a failure may be indicated by an error message. If this happens, wait until the current operation succeeds before trying again.

When you call `deleteRegions()` and you get a retryable error, then there was probably an internet connectivity issue: in this case, `DownloadRegionsStatusListener` fires an `onPause()` event - and the affected download is in a paused state. If any download is in a paused state, it is not possible to delete a region, because the storage might be in an inconsistent state: to solve this issue, unpause the download or cancel it - then try again.

For more information, take a look at the "offline_maps_app" example app on [GitHub](https://github.com/heremaps/here-sdk-examples/tree/master/examples/latest/navigate/flutter/offline_maps_app).
