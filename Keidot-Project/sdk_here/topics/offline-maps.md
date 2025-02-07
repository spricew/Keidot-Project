# Get started with offline maps

In situations where an internet connection is slow, unreliable, or unavailable, offline maps provide a crucial solution. Whether on-the-go or intentionally conserving bandwidth, offline maps ensure a seamless and responsive user experience.

While online maps offer the most accurate and up-to-date data, along with features like comprehensive search results, offline maps are highly advantageous when bandwidth is limited. With preloaded offline maps, you can access essential features of the HERE SDK — such as search, routing, navigation, and mapping—without an internet connection or consuming data.

Offline maps, also known as persistent maps or preloaded maps, offer comparable functionality to online maps. You can search for places, calculate routes, start guidance (_Navigate Edition_ only), and interact with the `MapView` just as you would with online data.

These maps can be loaded as `Region` at various granular levels — from entire continents and countries to states, cities, or even specific areas. Additionally, you can prefetch map data around a location, along a route, or within a user-defined polygon area for even greater customization.

## How does it work?

1. The map data cache will get populated automatically. It is not persisted and it's size can be changed.
2. Use the `MapDownloader` to permanently install offline maps in the form of `Region` data stored on disk.
3. Use the `MapUpdater` to update installed offline maps.
4. Use the `MapDownloader` to delete installed offline maps.

> #### Note
> Backward compatibility of installed offline maps is supported for one year. There is no guarantee that new versions of the HERE SDK support map versions that are older than one year. Likewise, there is no guarantee that versions of the HERE SDK that are older than one year support new map versions: forward compatibility is supported for one year. This should give customers enough time to update installed offline maps and the HERE SDK itself.

The following core features support offline map data:

- **Search**: Use the `OfflineSearchEngine` as equivalent to the online operable `SearchEngine` to search for places.
  - Needs to be executed on already downloaded or cached map data to make use of offline features. - The online engine will not return results when it is executed offline - even if offline data is available.
- **Routing**: Use the `OfflineRoutingEngine` as equivalent to the online operable `RoutingEngine` to calculate routes.
  - Needs to be executed on already downloaded or cached map data to make use of offline features. - The online engine will not return results when it is executed offline - even if offline data is available.
- **Mapping**: The `MapView` will make use of offline data - with a few exceptions like for raster layer such as satellite imagery.
  - Once a `Region` has been downloaded with the `MapDownloader` - or when an area has been cached by panning the map  - the `MapView` is fully operable for this area without an internet connection. However, the dedicated online engines like the `SearchEngine` or the `RoutingEngine` will never make use of the cached or downloaded map data.
- **Navigation**: The `Navigator` and the `VisualNavigator` work fully with offline map data to support offline turn-by-turn guidance. Worth to mention: The `Navigator` works headless (without a `MapView`), but it also requires map data to deliver events.

## Differentiate between the cache, offline and online maps

You have two ways to access map data offline:

- **Map Cache**: By default, all map data is cached onto the device while using the map. This storage is persisted between sessions, but the storage size is limited and old cache data may be replaced with newer map data. Note: You can change the default [cache path and the size](key-concepts.md) with the `SDKOptions` you can pass into the `SDKNativeEngine` when you initialize the HERE SDK programmatically. Cached map data is stored in the local **map cache storage**. More about the cache can be found [here](tips-engines.md#work-with-the-map-cache). Note that you can use a `RoutePrefetcher` to actively fill data into the cache (see below.)

- **Offline Maps**: With offline maps you can download entire regions or even continents to preload their map data for offline use - including places, routing and other data. A dedicated `MapDownloader` enables you to get and to maintain this data. Offline maps data is persisted between sessions and the data will not be deleted unless the user decides so. Offline maps are stored in the local **persistent map storage**. This is a second map storage and fully separated from the map cache. Usually, downloading offline maps happens over Wi-Fi as there are gigabytes of data to be loaded. Offline map data is used as a complete alternative to online services and the cached map when there is no connectivity.

By default, when interacting with a map view, the HERE SDK will automatically make use of online data, the local map cache and the persistent map storage to provide the best possible user experience:

1. The HERE SDK will first check if map data can be shown from the map cache storage for the current viewport area - even if the device is online.
2. If no cached data is available for the current viewport, the HERE SDK will look for offline maps data in the persistent map storage - even if the device is online. If no offline maps data is found:
  - If the device is offline: The map will be shown with less details or even no details.
  - If the device is online: New map data will be shown and downloaded into the cache, unless the offline switch is active. When the cache is full, a least recently used ([LRU](https://en.wikipedia.org/wiki/Cache_replacement_policies#Least_recently_used_(LRU))) strategy is applied.

For example, when the Berlin region is installed on a device and the device is online, then no map data will be downloaded into the map cache when panning the Berlin map area - and the installed region data will be used instead.

> #### Note
> When the HERE SDK should be used offline for search and routing, you need to use dedicated offline engines to access cached or pre-downloaded offline map data. Use the `OfflineSearchEngine` and `OfflineRoutingEngine` to access map data offline. Their counterparts, the `SearchEngine` and `RoutingEngine`, will only provide results when an online connection is available - otherwise you will get an error. Therefore, you need to decide which engine to use.

The dedicated offline engines, like the `OfflineRoutingEngine`, will never download any online data, regardless of the connectivity of the device or the global offline switch.

While the HERE SDK offers dedicated online and offline feature engines, for turn-by-turn navigation there is no such distinction: the `Navigator` and `VisualNavigator` engines require map data either from the map cache or from offline maps data in the persistent map storage - if available. If no data is found, the data will be downloaded automatically into the cache, unless the global offline switch is active.

> #### Note
> Offline maps work for all map schemes that are vector based. Satellite based map schemes are not part of the downloaded map data.

## Use the global offline switch

The HERE SDK offers a global offline switch to make the HERE SDK radio-silent. This offline mode prevents the HERE SDK from initiating any online connection:

```dart
SDKNativeEngine.sharedInstance?.isOfflineMode = true;
```

Defaults to `false`, which means the HERE SDK uses an online connection. When set to `true`, this prevents the HERE SDK from initiating any online connection - except when `PassThroughFeature` items are set.

This mode will, for example, prevent that new map tiles are loaded into the cache. If you are using the _Navigate Edition_, then you can still use features such as offline search (via dedicated engine), offline routing (via dedicated engine) or offline guidance.

It does not matter if the device itself is put to flight mode or not: when active, the switch will block any attempt from the HERE SDK to make a request. Therefore, no online data will be consumed until the offline mode is disabled again.

However, when initializing the HERE SDK a few requests may still be made - if you want to start your application offline already before initializing the HERE SDK, then set the flag `offlineMode` in `SDKOptions` to `true`. If you do not plan to change this at runtime, then this flag alone is enough to operate fully offline.

When the HERE SDK is switched offline, all ongoing and queued requests are stopped. With the `SDKNativeEngine` you can define exceptions of this rule by setting a list of `PassThroughFeature` items that are still allowed to access online data - for example, to fetch traffic data. By default, no exceptions are set.

When the HERE SDK is switched to operate in offline mode, then all map data that is rendered on the `MapView` is either fetched from the cache or the persisted storage. Note that the latter requires pre-downloaded map data which is only available for editions such as the _Navigate Edition_.

When the HERE SDK is switched to operate in offline mode and certain map layers are enabled on top with `MapFeatures`, such as `vehicleRestrictions`, then this data can only be used when it was already cached or downloaded as part of a `Region` into the persisted storage. This rule applies to all available map features.

> #### Note
> By default, some `MapFeatures` layers are not enabled for offline use: for example, the `terrain` layer needs to be enabled with a "FeatureConfiguration" to be part of a downloadable `Region`. For an overview, please consult the [optimization guide](optimization.md). Despite this, all layers are accessible offline when they have been cached beforehand - basically, by panning the map on the screen.

## Try the Offline Maps example app

Explore the core features of offline maps with best practice code examples by trying the "offline_maps_app" example app. You can find this example app on [GitHub](https://github.com/heremaps/here-sdk-examples).

## FAQ - Frequently asked questions

- **How does offline search work?** By default, the `OfflineSearchEngine` searches in the persistent offline map data, but in case there is no `Region` loaded, it will try to use the map cache.

- **How does offline routing work?** Offline routing is intended to be used with offline maps and not solely with cached map data. If no offline map data is available, the `OfflineRoutingEngine` tries to find the missing data in the map cache. If map data is missing for any part of a route, then the route calculation will fail.

- **How is the map cache different from offline maps?** Caching happens automatically, when the map view is panned. On top, with the `RoutePrefetcher` you can also request data to be fetched into the map cache. The data in the map cache is not meant to be stored permanently and it can be replaced with newer data when there's a need for this - for example, when the cache is full. Offline maps, on the other hand, are persisted and they are stored at a different path on the device. With dedicated APIs like the `MapDownloader`, specific areas in the world can be downloaded permanently - and also updated or deleted upon a user's request.

- **Can there be a mismatch of data when I use the online RoutingEngine?** When you are using the `RoutingEngine`, then the calculated route will be always based on the latest available map data - even if on the device itself an older map version is used. For example, a route may take a newly built bridge which is not known in older map versions. This will mostly affect the visual appearance of the map. For example, the bridge may not be rendered on the map view as expected. However, the navigation experience will still be based on the new route - even if the device operates fully offline - or if offline maps for that region have been already installed (and not updated yet). Either way, the `navigator` will still provide guidance based on the route and navigate over the bridge. The `navigator` will also not request any new data when it finds existing offline or cached map data - even if the device is online. However, in order to avoid potential mismatches it can help to update to the latest map versions with the `MapUpdater` before starting a trip. Note that when the provided location from your GPS source is close enough to the route, then no map-matching is done to save resources. Only when the location is farther away from the route, then the HERE SDK will try to map-match the location to a street.

- **Is it possible to pre-install offline maps on a device?** Upon request, it is possible to manually create such packages to preload map data. However, there is no API available for this and you need to contact us to clarify the details.
