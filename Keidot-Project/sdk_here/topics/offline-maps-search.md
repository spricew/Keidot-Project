# Offline search features

The ability to search for places efficiently is crucial, whether one is connected to the internet or working in an offline environment. To address both scenarios, the HERE SDK offers two versatile search solutions: the online-only `SearchEngine` and its offline equivalent, the `OfflineSearchEngine`. The `OfflineSearchEngine` is designed to provide the same robust search capabilities as its online counterpart, ensuring seamless information retrieval even without an internet connection. Just like the `SearchEngine`, the `OfflineSearchEngine` can be easily constructed and integrated into your applications:

```dart
try {
  // Allows to search on already downloaded or cached map data.
  _offlineSearchEngine = OfflineSearchEngine();
} on InstantiationException {
  throw ("Initialization of OfflineSearchEngine failed.");
}
```

The `OfflineSearchEngine` provides almost the same interfaces as the `SearchEngine`, but the results may slightly differ as the results are taken from already downloaded or cached map data instead of initiating a new request to a HERE backend service.

This way the data may be, for example, older compared to the data you may receive when using the `SearchEngine`. On the other hand, this class may provide results faster - as no online connection is necessary.

> #### Note
> You can only search on already cached or preloaded offline maps data. When you use only cached map data, it may happen that not all tiles are loaded. In that case, no results can be found until also these tiles are loaded. With offline maps this cannot happen and the required map data is guaranteed to be available for the downloaded region. Therefore, it is recommended to not rely on cached map data.

Although most of the available `OfflineSearchEngine` interfaces are also available in the `SearchEngine`, the opposite is not the case, simply because not every online feature is also accessible from offline data.

In addition, the place ID that identifies the location in the [HERE Places API](https://www.here.com/docs/bundle/places-search-api-developer-guide/page/topics/what-is.html) is different for offline search results.

Usually, with a free-form `TextQuery`, places can be found offline at least within a radius of 62.5 Km. Capitals can be found globally from anywhere. Adding a dedicated location such as a city name to the query string will search nearby that location.

> #### Note
> Currently, it is not possible to use offline search in Japan and no results will be found.

Below we show one possible use case for the `OfflineSearchEngine`. For example, when you are on the go, your connection can be temporarily lost. In such a case it makes sense to search in the already downloaded map data.

To do so, first you need to check if the device has lost its connectivity. As a second step, you can use the preferred search engine:

```dart
if (useOnlineSearchEngine) {
  _onlineSearchEngine.searchByText(query, searchOptions, (SearchError? searchError, List<Place>? list) async {
    _handleSearchResults(searchError, list, queryString);
  });
} else {
  _offlineSearchEngine.searchByText(query, searchOptions, (SearchError? searchError, List<Place>? list) async {
    _handleSearchResults(searchError, list, queryString);
  });
}
```

To handle the search results, you can use a `_handleSearchResults()` function that is shown as part of the example app. The code to handle the results was already shown above.

In a similar fashion, you can also reverse geocode addresses:

```dart
if (useOnlineSearchEngine) {
  _onlineSearchEngine.searchByCoordinates(geoCoordinates, reverseGeocodingOptions,
      (SearchError? searchError, List<Place>? list) async {
    _handleReverseGeocodingResults(searchError, list);
  });
} else {
  _offlineSearchEngine.searchByCoordinates(geoCoordinates, reverseGeocodingOptions,
      (SearchError? searchError, List<Place>? list) async {
    _handleReverseGeocodingResults(searchError, list);
  });
}
```

Or you can geocode an address to a geographic coordinate with:

```dart
if (useOnlineSearchEngine) {
  _onlineSearchEngine.searchByAddress(query, geocodingOptions, (SearchError? searchError, List<Place>? list) async {
    _handleGeocodingResults(searchError, list, queryString);
  });
} else {
  _offlineSearchEngine.searchByAddress(query, geocodingOptions, (SearchError? searchError, List<Place>? list) async {
    _handleGeocodingResults(searchError, list, queryString);
  });
}
```

Note that the code to check if the device is online or not is left out here. You may use a third-party plugin for this or try to make an actual connection - and when that fails, you can switch to the `OfflineSearchEngine` - or the other way round: you can try offline search first to provide a fast experience for the user, but when no map data is available, you can try online.

> #### Note
> You can find the full code for this section as part of the "search_hybrid_app" example on [GitHub](https://github.com/heremaps/here-sdk-examples/).

## Use offline search with indexing

In order to improve search results for the `OfflineSearchEngine` you can set `OfflineSearchIndex.Options`. By default, indexing is disabled.

Indexing provides a mechanism to find places in installed `Region` data - even if they are far away from the provided search center. This will help to match the behavior of the `SearchEngine` which does this, by default, without the need to create a search index as it operates only online.

You can set a `OfflineSearchIndexListener` to track the index building process.

> #### Note
> This is a beta release of this feature, so there could be a few bugs and unexpected behaviors. APIs may change for new releases without a deprecation process.

Internally, indexing creates additional data on the device to make all installed map content searchable.

If indexing is enabled it will affect all operations that modify persistent storage content:

- `mapDownloader.downloadRegions(..)`
- `mapDownloader.deleteRegions(..)`
- `mapDownloader.clearPersistentMapStorage(..)`
- `mapDownloader.repairPersistentMap(..)`
- `mapDownloader.performMapUpdate(..)`
- `mapDownloader.performFeatureUpdate(..)`
- `mapDownloader.updateCatalog(..)`

These methods will ensure that the index is created, deleted or updated to contain entries from `Region` data that are installed in the persistent storage.

Creating an index takes time and this will make all operations that download or update offline maps longer, but usually not more than a few seconds up to a couple of minutes (depending on the amount of installed offline maps data). The stored index also increases the space occupied by offline maps by around 5%.

## Bring your own places for offline use

The HERE SDK allows to bring your own places at runtime when searching for places offline.

With the `OfflineSearchEngine` it is possible to inject custom data for places that can be found with the offline. Such personal places can be found by regular queries. The results are ranked as other places coming directly from HERE.

You can create multiple `GeoPlace` instances that can contain your custom place data. These instances can then be added to a `MyPlaces` data source:

```dart
List<GeoPlace> geoPlaces = [
        GeoPlace.makeMyPlace("Pizza Pino", GeoCoordinates(52.518032, 13.420632)),
        GeoPlace.makeMyPlace("PVR mdh", GeoCoordinates(52.51772, 13.42038)),
        GeoPlace.makeMyPlace("Harley's bar", GeoCoordinates(52.51764, 13.42062))
    ];

    _myPlaces.addPlaces(geoPlaces, (TaskOutcome taskOutcome) {
      if (taskOutcome == TaskOutcome.completed) {
        // Task completed.
      } else {
        // Task cancelled.
      }
    });
```

This data source can then be attached to the `OfflineSearchEngine`:

```dart
offlineSearchEngine.attach(_myPlaces, (TaskOutcome taskOutcome) {
  if (taskOutcome == TaskOutcome.completed) {
    // Task completed.
  } else {
    // Task cancelled.
  }
});
```

`addPlaces()` and `attach()` operate asynchronously as thousands of places may be added at once by an application. Both methods return a `TaskHandle`, so that the operation can be cancelled. The `TaskOutcome`event informs when the operation has finished.

Below is one example how you can find such places:

```dart
double radiusInMeters = 100.0;
var queryArea = TextQueryArea.withCircle(GeoCircle(GeoCoordinates(52.518032, 13.420632), radiusInMeters));
TextQuery textQuery = TextQuery.withArea("Pizza Pino", queryArea);
offlineSearchEngine.searchByText(textQuery, SearchOptions(), (searchError, placeList) {
  // ...
});
```

Note that the added places stay in memory as long as the `offlineSearchEngine` instance is alive.
