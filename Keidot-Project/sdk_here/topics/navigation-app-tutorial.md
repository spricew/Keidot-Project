# Build a navigation app

You have two choices to start guidance. Either by using the headless `Navigator` - or with the help of the `VisualNavigator`. Both provide the same interfaces, as the `Navigator` offers a subset of the `VisualNavigator`, but the `VisualNavigator` provides visual rendering assistance on top - with features such as smooth interpolation between discrete `Location` updates.

Below, we decide to use the `VisualNavigator`.

The basic principles of a navigation app are:

1. Create a `Route`. Without a route to follow you cannot start guidance, unless you want to start tracking mode.
2. Create a `VisualNavigator` instance and start rendering (or create a `Navigator` instance if you want to render the guidance view on your own).
3. Set a `Route` to the `VisualNavigator`, unless you want to start tracking mode.
4. Fed in location updates into the `VisualNavigator`. Without location data, no route progress along a route can be detected. Also, events on upcoming road events such as road signs are not possible without knowing the location of a user. Locations can be simulated - or you can feed real location updates.

The [navigation_quick_start_app](https://github.com/heremaps/here-sdk-examples/tree/master/examples/latest/navigate/flutter/navigation_quick_start_app) example on GitHub shows the basic principles of a navigation app.

The basic skeleton of a navigation app looks like below:

```dart
_startGuidance(HERE.Route route) {
  try {
    // Without a route set, this starts tracking mode.
    _visualNavigator = HERE.VisualNavigator();
  } on InstantiationException {
    throw Exception("Initialization of VisualNavigator failed.");
  }

  // This enables a navigation view including a rendered navigation arrow.
  _visualNavigator!.startRendering(_hereMapController!);

  // Hook in one of the many listeners. Here we set up a listener to get instructions on the maneuvers to take while driving.
  // For more details, please check the "navigation_app" example and the Developer Guide.
  _visualNavigator!.eventTextListener = HERE.EventTextListener((HERE.EventText eventText) {
    String text = eventText.text;
    print("Maneuver instruction text: $text");
  });

  // Set a route to follow. This leaves tracking mode.
  _visualNavigator!.route = route;

  // VisualNavigator acts as LocationListener to receive location updates directly from a location provider.
  // Any progress along the route is a result of getting a new location fed into the VisualNavigator.
  _setupLocationSource(_visualNavigator!, route);
}
```

To get started, we can choose a simulated source by using the `LocationSimulator`. This class provides location events based on the route's geometry:

```dart
_setupLocationSource(HERE.LocationListener locationListener, HERE.Route route) {
  try {
    // Provides fake GPS signals based on the route geometry.
    _locationSimulator = HERE.LocationSimulator.withRoute(route, HERE.LocationSimulatorOptions());
  } on InstantiationException {
    throw Exception("Initialization of LocationSimulator failed.");
  }

  _locationSimulator!.listener = locationListener;
  _locationSimulator!.start();
}
```

The above code snippet shows all the code needed to start simulated guidance using simulated `Location` events taken from the `Route`. It uses the `VisualNavigator` instance, so the HERE SDK will take over the rendering part until `stopRendering()` is called.

Now you are ready to add as many event listeners or warners to the `VisualNavigator` instance as you wish. There is nothing special about attaching listeners — you can essentially use the code snippets shown in the related [navigation](navigation.md) sections.

In the future, we plan to provide more ready-to-use UI building blocks to help with the visualization of event data, such as for maneuvers.

Below, we delve into the steps recommended for building a flexible location provider in greater detail. We also show how to create a simulator class for testing during development, which demonstrates various options to customize route playback.

## Implement a location provider

A location provider is necessary to be provide `Location` instances to the `VisualNavigator`. It can feed location data from any source. Below we plan to use an implementation that allows to switch between native location data from the device and simulated location data for test drives.

As already mentioned above, the `VisualNavigator` conforms to the `LocationListener` interface, so it can be used as listener for classes that call `onLocationUpdated()`.

As a source for location data, we use a `HEREPositioningProvider` that is based on the code as shown in the [Positioning](get-locations.md) section.

> #### Note
> For navigation it is recommended to use `LocationAccuracy.NAVIGATION` when starting the `LocationEngine` as this guarantees the best results during turn-by-turn navigation.

To deliver events, we need to start the `herePositioningProvider`:

```dart
// Call this to start getting locations from a device's sensor.
_herePositioningProvider.startLocating(_visualNavigator, LocationAccuracy.navigation);
```

The required HERE SDK `Location` type includes bearing and speed information along with the current geographic coordinates and other information that is consumed by the `VisualNavigator`. The more accurate and complete the provided data is, the more precise the overall navigation experience will be.

Note that the `bearing` value taken from the `Location` object determines the direction of movement which is then indicated by the `LocationIndicator` asset that rotates into that direction. When the user is not moving, then the last rotation is kept until a new bearing value is set. Depending on the source for the `Location` data, this value can be more or less accurate.

Internally, the `timestamp` of a `Location` is used to evaluate, for example, if the user is driving through a tunnel or if the signal is simply lost.

You can find a reference implementation of a location provider on [GitHub](https://github.com/heremaps/here-sdk-examples/). The "navigation_app" example shows how HERE Positioning can be used for navigation.

## Set up a location simulator

During development, it may be convenient to playback the expected progress on a route for testing purposes. The `LocationSimulator` provides a continuous location signal that is taken from the original route coordinates.

Below we integrate the `LocationSimulator` as an alternative provider to allow switching between real location updates and simulated ones.

```dart
import 'package:here_sdk/core.dart' as HERE;
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/navigation.dart' as HERE;
import 'package:here_sdk/routing.dart' as HERE;

// A class that provides simulated location updates along a given route.
// The frequency of the provided updates can be set via LocationSimulatorOptions.
class HEREPositioningSimulator {
  HERE.LocationSimulator? _locationSimulator;

  // Provides location updates based on the given route (route playback).
  void startLocating(HERE.Route route, HERE.LocationListener locationListener) {
    _locationSimulator?.stop();

    _locationSimulator = _createLocationSimulator(route, locationListener);
    _locationSimulator!.start();
  }

  void stop() {
    _locationSimulator?.stop();
  }

  // Provides fake GPS signals based on the route geometry.
  HERE.LocationSimulator _createLocationSimulator(HERE.Route route, HERE.LocationListener locationListener) {
    HERE.LocationSimulatorOptions locationSimulatorOptions = HERE.LocationSimulatorOptions();
    locationSimulatorOptions.speedFactor = 2;
    locationSimulatorOptions.notificationInterval = Duration(milliseconds: 500);

    HERE.LocationSimulator locationSimulator;

    try {
      locationSimulator = HERE.LocationSimulator.withRoute(route, locationSimulatorOptions);
    } on InstantiationException {
      throw Exception("Initialization of LocationSimulator failed.");
    }

    locationSimulator.listener = locationListener;

    return locationSimulator;
  }
}
```

In addition, by setting `LocationSimulatorOptions`, we can specify, how fast the current simulated location will move. By default, the `notificationInterval` is 1 s and the `speedFactor` is 1.0, which is equal to the average speed a user normally drives or walks along each route segment without taking into account any traffic-related constraints. The default speed may vary based on the road geometry, road condition and other statistical data, but it is never higher than the current speed limit. Values above 1.0 will increase the speed proportionally. If the route contains insufficient coordinates for the specified time interval, additional location events will be interpolated by the `VisualNavigator`.

> #### Note
> The locations emitted by the `LocationSimulator` are not interpolated and they are provided based on the source. In case of a `Route`, the coordinates of the route geometry will be used (which are very close to each other). In case of a `GPXTrack`, the coordinates are emitted based on the GPX data: for example, if there are hundreds of meters between two coordinates, then only those two coordinates are emitted based on the time settings. However, when fed into the `VisualNavigator`, the rendered map animations will be interpolated by the `VisualNavigator`.

The `VisualNavigator` will skip animations if the distance between consecutive `Location` updates is greater than 100 m. If the `speedFactor` is increased, the distance between location updates changes as well - if the notification interval is not adjusted accordingly: for example, if you want to change the speed factor to 8, you should also change the notification interval to 125 ms (1000 ms / 8) in order to keep the distance between the `Location` updates consistent. The `notificationInterval` and the `speedFactor` are inversely proportional. Accordingly, for a `speedFactor` of 3, the recommended `notificationInterval` is 330 ms.

Note that we need to ensure to stop any ongoing simulation (or real location source) before starting a new one.

You can see the code from above included in the "navigation_app" example on [GitHub](https://github.com/heremaps/here-sdk-examples/tree/master/examples/latest/navigate/flutter/navigation_app).
