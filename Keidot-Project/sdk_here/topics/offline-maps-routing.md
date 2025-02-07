# Offline routing features

In addition to the online-only `RoutingEngine`, there is also an equivalent for offline use cases available: the `OfflineRoutingEngine`. This offline version is designed to offer the same robust routing capabilities as its online counterpart, ensuring seamless navigation even without an internet connection.

> #### Note
> You can only calculate routes on already cached or preloaded offline maps data. When you use only cached map data, it may happen that not all tiles are loaded for the lower zoom levels. In that case, no route can be found until also the lower zoom levels are loaded - even if you see the map. With offline maps this cannot happen and the required map data is guaranteed to be available for the downloaded region. Therefore, it is recommended to not rely on cached map data.

The `OfflineRoutingEngine` can be constructed in the same straightforward manner as the `RoutingEngine`:

```dart
RoutingInterface _routingEngine;
RoutingEngine _onlineRoutingEngine;
OfflineRoutingEngine _offlineRoutingEngine;

...

try {
  _onlineRoutingEngine = RoutingEngine();
} on InstantiationException {
  throw ("Initialization of RoutingEngine failed.");
}

try {
  // Allows to calculate routes on already downloaded or cached map data.
  _offlineRoutingEngine = OfflineRoutingEngine();
} on InstantiationException {
  throw ("Initialization of OfflineRoutingEngine failed.");
}
```

> #### Note
> Transit routes (via `TransitRoutingEngine`) and EV routes (`EVCarOptions` and `EVTruckOptions`) are not yet supported and only work online. The `OfflineRouteEngine` will fail with `RoutingError.invalidParameter` in case of unsupported transport modes.

The `OfflineRoutingEngine` provides the same interfaces as the `RoutingEngine`, but the results may slightly differ as the results are taken from already downloaded or cached map data instead of initiating a new request to a HERE backend service.

This way the data may be, for example, older compared to the data you may receive when using the `RoutingEngine`. On the other hand, this class provides results faster - as no online connection is necessary.

However, the resulting routes contain only an empty list of maneuvers. If you need to get maneuvers during guidance, you can get them directly from the `Navigator` or `VisualNavigator` via the provided `nextManeuverIndex`. This is shown in the [Navigation](navigation.md) section.

All available interfaces of the `OfflineRoutingEngine` are also available in the `RoutingEngine` and both engines adopt the same interface. This makes it easy to switch between both engine instances as we will show below.

> #### Note
> To get a quick overview of how all of this works, you can take a look at the `RoutingExample` class. It contains all code snippets shown below and it is part of the "routing_hybrid_app" example you can find on [GitHub](https://github.com/heremaps/here-sdk-examples).

Below we show how to switch between `OfflineRoutingEngine` and `RoutingEngine`. For example, when you are on the go, it can happen that your connection is temporarily lost. In such a case it makes sense to calculate routes on the already cached or downloaded map data with the `OfflineRoutingEngine`.

To do so, first you need to check if the device has lost its connectivity. As a second step you can use the preferred engine:

```dart
void useOnlineRoutingEngine() {
  _routingEngine = _onlineRoutingEngine;
  _showDialog('Switched to RoutingEngine', 'Routes will be calculated online.');
}

void useOfflineRoutingEngine() {
  _routingEngine = _offlineRoutingEngine;
  // Note that this does not show how to download offline maps. For this, check the "offline_maps_app" example.
  _showDialog(
      'Switched to OfflineRoutingEngine', 'Routes will be calculated offline on cached or downloaded map data.');
}
```

Now, you can execute the same code on the current `_routingEngine` instance, as shown in the previous sections above.

> #### Note
> If the device is offline, the online variant will not find routes and will report an error. Vice versa, when the device is online, but no cached or preloaded map data is available for the area you want to use, the offline variant will report an error as well.

Note that the code to check if the device is online or not is left out here. You may use a third-party plugin for this or try to make an actual connection - and when that fails, you can switch to the `OfflineRoutingEngine` - or the other way round: you can try offline routing first to provide a fast experience for the user, but when no map data is available, you can try online.

> #### Note
> You can find the _routing_hybrid_app example app on [GitHub](https://github.com/heremaps/here-sdk-examples).
