# Examples and use cases

Explore practical examples and use cases to effectively utilize indoor maps and venues with the HERE SDK. This section covers a range of topics to help you get the most out of our indoor mapping capabilities.

## List all indoor maps

The HERE SDK for Flutter (_Navigate Edition_) allows you to list all private venues that are accessible for your account and the selected collection. `VenueMap` contains a list which holds `VenueInfo` elements containing venue Identifier, venue ID and venue Name.

```dart
List<VenueInfo> venueInfo = _venueEngine!.venueMap.getVenueInfoList();
for (int i = 0; i < venueInfo.length; i++) {
  int venueId = venueInfo[i].venueId;
  print("Venue Identifier: " + venueInfo[i].venueIdentifier + " Venue Id: $venueId" + " Venue Name: "+venueInfo[i].venueName);
}
```
For maps with venue identifier as UUID, `venueId` would return 0.

## Load and show a venue

The HERE SDK for Flutter (_Navigate Edition_) allows you to load and visualize venues by an identifier. You must know the venue's identifier for the current set of credentials. There are several ways to load and visualize the venues.

`VenueMap` has two methods to add a venue to the map: `selectVenueAsync()` and `addVenueAsync()`. Both methods use `getVenueService().addVenueToLoad()` to load the venue by an identifier and then add it to the map. The method `selectVenueAsync()` also selects the venue:

```dart
_venueEngine.venueMap.selectVenueAsync(String venueIdentifier);
```

```dart
_venueEngine.venueMap.addVenueAsync(String venueIdentifier);
```

> #### Note
>
> For legacy maps with an `int` based venue ID, `VenueMap` still supports `selectVenueAsync(int venueID)` and `addVenueAsync(int venueID)` to load the venue by venue ID.

A venue can also be selected by providing a venue identifier:

```dart
Container(
padding: EdgeInsets.only(left: 8, right: 8),
// Widget for opening venue by provided ID.
child: TextField(
    decoration: InputDecoration(
        border: InputBorder.none, hintText: 'Enter a venue identifier'),
    onSubmitted: (text) {
        try {
        // Try to parse a venue identifier.
        String venueIdentifier = text;
        // Select a venue by identifier.
        _venueEngineState.selectVenue(venueIdentifier);
        } on FormatException catch (_) {
        print("Venue identifier should be a number!");
        }
    }),
),
```

Once the venue is loaded, the `VenueService` calls the `VenueMapListener.onGetVenueCompleted()` method:

```dart
@override
  onGetVenueCompleted(String venueIdentifier, VenueModel? venueModel, bool online, VenueStyle? venueStyle) {
    if(venueModel == null) {
      print("Failed to load venue Identifier: " + venueIdentifier);
    }
  }
```

> #### Note
>
> For legacy maps with an `int` based venue ID, `VenueService` calls the `VenueListener.onGetVenueCompleted(venueID, venueModel, online, venueStyle)` method.


Once the venue is loaded successfully, if you are using the `addVenueAsync()` method, only the `VenueLifecycleDelegate.onVenueAdded()` method will be triggered. If you are using the `selectVenueAsync()`method, the `VenueSelectionDelegate.onSelectedVenueChanged()` method will also be triggered.

```dart
// A listener for the venue selection event.
class VenueSelectionListenerImpl extends VenueSelectionListener {
  late VenueEngineState _venueEngineState;

  VenueSelectionListenerImpl(VenueEngineState venueEngineState) {
    _venueEngineState = venueEngineState;
  }

  @override
  onSelectedVenueChanged(Venue? deselectedVenue, Venue? selectedVenue) {
    _venueEngineState.onVenueSelectionChanged(selectedVenue);
    // This functions is used to facilitate the toggling of topology visibility.
    // Setting isTopologyVisible property to true will render the topology on scene and false will lead to hide the topology.
    selectedVenue?.isTopologyVisible = true;
  }
}
```

A `Venue` can also be removed from the `VenueMap`, which triggers the `VenueLifecycleListener.onVenueRemoved(veueIdentifier)` method:

```dart
_venueEngine.venueMap.removeVenue(venue);
```

> #### Note
>
> For legacy maps with an `int` based venue ID, if you are using the `addVenueAsync()` method, the `VenueLifecycleListener.onVenueAdded()` method will be triggered.
> When removing an `int` based venue ID from `VenueMap`, the `VenueLifecycleListener.onVenueRemoved(venueID)` is triggered.

## Label text preference

You can override the default label text preference for a venue.

Once the `VenueEngine` is initialized, a callback is called. From this point on, there is access to the `VenueService`. The optional method `setLabeltextPreference()` can be called to set the label text preference during rendering. Overriding the default style label text preference provides an opportunity to set the following options as a list where the order defines the preference:

- "OCCUPANT_NAMES"
- "SPACE_NAME"
- "INTERNAL_ADDRESS"
- "SPACE_TYPE_NAME"
- "SPACE_CATEGORY_NAME"

These can be set in any desired order. For example, if the label text preference does not contain "OCCUPANT_NAMES" then it will switch to "SPACE_NAME" and so on, based on the order of the list. Nothing is displayed if no preference is found.

```dart
class VenueEngineWidget extends StatefulWidget {
  final VenueEngineState state;

  VenueEngineWidget({required this.state});

  @override
  VenueEngineState createState() => state;
}

// The VenueEngineState listens to different venue events and helps another
// widgets react on changes.
class VenueEngineState extends State<VenueEngineWidget> {
  late VenueServiceListener _serviceListener;

  void onVenueEngineCreated() {
    var venueMap = venueEngine!.venueMap;
    // Add needed listeners.
    _serviceListener = VenueServiceListenerImpl();
    _venueEngine!.venueService.addServiceListener(_serviceListener);

    // Start VenueEngine. Once authentication is done, the authentication
    // callback will be triggered. Afterwards, VenueEngine will start
    // VenueService. Once VenueService is initialized,
    // VenueServiceListener.onInitializationCompleted method will be called.
    venueEngine!.start(_onAuthCallback);

    if(HRN != "") {
      // Set platform catalog HRN
      venueEngine!.venueService.setHrn(HRN);
    }

    // Set label text preference
    venueEngine!.venueService.setLabeltextPreference(LabelPref);
  }
}
```

## Select venue drawings and levels

A `Venue` object allows you to control the state of the venue.

The property `selectedDrawing` allows to get and set a drawing which will be visible on the map. When a new drawing is selected, the `VenueDrawingSelectionListener.onDrawingSelected()` method is triggered.

The following provides an example of how to select a drawing when an item is clicked in a `ListView`:

```dart
  // Create a list view item from the drawing.
  Widget _drawingItemBuilder(BuildContext context, VenueDrawing drawing) {
    bool isSelectedDrawing = drawing.identifier == _selectedDrawing!.identifier;
    Property? nameProp = drawing.properties["name"];
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: isSelectedDrawing ? Colors.blue : Colors.white,
          padding: EdgeInsets.zero
      ),
      child: Text(
        nameProp != null ? nameProp.asString : "",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelectedDrawing ? Colors.white : Colors.black,
          fontWeight: isSelectedDrawing ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onPressed: () {
        // Hide the list with drawings.
        _isOpen = false;
        // Select a drawing, if the user clicks on the item.
        _selectedVenue!.selectedDrawing = drawing;
      },
    );
  }
```

The properties `selectedLevel` and `selectedLevelIndex` allow you to get and set a selected level. If a new level is selected, the `VenueLevelSelectionListener.onLevelSelected()` method is triggered.

The following provides an example of how to select a level when an item is clicked in a `ListView`:

```dart
  // Create a list view item from the level.
  Widget _levelItemBuilder(BuildContext context, VenueLevel level) {
    bool isSelectedLevel = level.identifier == _selectedLevel!.identifier;
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: isSelectedLevel ? Colors.blue : Colors.white,
          padding: EdgeInsets.zero
      ),
      child: Text(
        level.shortName,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelectedLevel ? Colors.white : Colors.black,
          fontWeight: isSelectedLevel ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onPressed: () {
        // Select a level, if the user clicks on the item.
        _selectedVenue!.selectedLevel = level;
      },
    );
  }
```

A full example of the UI switchers to control drawings and levels is available in the "indoor_map_app" example app, available on [GitHub](https://github.com/heremaps/here-sdk-examples).

## Customize the style of a venue

You can change the visual style of `VenueGeometry` objects. Geometry style and/or label style objects must be created and provided to the `Venue.setCustomStyle()` method:

```dart
// Create geometry and label styles for the selected geometry.
final VenueGeometryStyle _geometryStyle =
  VenueGeometryStyle(Color.fromARGB(255, 72, 187, 245), Color.fromARGB(255, 30, 170, 235), 1);
final VenueLabelStyle _labelStyle =
  VenueLabelStyle(Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 0, 130, 195), 1, 28);
```

```dart
_selectedVenue.setCustomStyle([geometry], _geometryStyle, _labelStyle);
```
## Select space by identifier

The ID of spaces, levels and drawings can be extracted using `getIdentifier()`, e.g. for spaces call: `spaces.getIdentifier()`. Then, for using those id values, a specific space can be searched in a level or a drawing with `getGeometryById(String id)`.

```dart
List<String> geometriesID = [];
List<VenueGeometry> geometries = [];
geometriesID.forEach((id) {
VenueGeometry? geometry = venue.selectedDrawing.getGeometryByIdentifier(id);
geometries.add(geometry!);
});
final VenueGeometryStyle _geometryStyle =
VenueGeometryStyle(Color.fromARGB(255, 72, 187, 245), Color.fromARGB(255, 30, 170, 235), 1);
final VenueLabelStyle _labelStyle =
VenueLabelStyle(Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 0, 130, 195), 1, 28);
_selectedVenue.setCustomStyle(geometries, _geometryStyle, _labelStyle);
```

## Handle tap gestures on a venue

You can select a venue object by tapping it. First, create a tap listener subclass which will put a `MapMarker` on top of the selected geometry:

```dart
class VenueTapController extends TapListener {
  final HereMapController hereMapController;
  final VenueMap venueMap;

  MapImage? _markerImage;
  MapMarker? _marker;

  VenueTapController(
      {required this.hereMapController,
      required this.venueMap}) {
    // Set a tap listener.
    hereMapController.gestures.tapListener = this;
    // Get an image for MapMarker.
    _loadFileAsUint8List('poi.png').then((imagePixelData) => _markerImage =
        MapImage.withPixelDataAndImageFormat(imagePixelData, ImageFormat.png));
  }

  Future<Uint8List> _loadFileAsUint8List(String fileName) async {
    // The path refers to the assets directory as specified in pubspec.yaml.
    ByteData fileData = await rootBundle.load('assets/' + fileName);
    return Uint8List.view(fileData.buffer);
  }
}
```

Inside the tap listener, you can use the tapped geographic coordinates as parameter for the `VenueMap.getGeometry()` and `VenueMap.getVenue()` methods:

```dart
  @override
  onTap(Point2D origin) {
    deselectGeometry();

    // Get geo coordinates of the tapped point.
    GeoCoordinates? position = hereMapController!.viewToGeoCoordinates(origin);
    if (position == null) {
      return;
    }

    // Get a VenueGeometry under the tapped position.
    VenueGeometry? geometry = venueMap.getGeometry(position);
    if (geometry != null) {
      // If there is a geometry, put a marker on top of it.
      _addPOIMapMarker(position);
    } else {
      // If no geometry was tapped, check if there is a not-selected venue under
      // the tapped position. If there is one, select it.
      Venue? venue = venueMap.getVenue(position);
      if (venue != null) {
        venueMap.selectedVenue = venue;
      }
    }
  }

  void deselectGeometry() {
    // If the map marker is already on the screen, remove it.
    if (_marker != null) {
      hereMapController!.mapScene.removeMapMarker(_marker!);
      _marker = null;
    }
  }

  void _addPOIMapMarker(GeoCoordinates geoCoordinates) {
    if (_markerImage == null) {
      return;
    }

    // By default, the anchor point is set to 0.5, 0.5 (= centered).
    // Here the bottom, middle position should point to the location.
    Anchor2D anchor2D = Anchor2D.withHorizontalAndVertical(0.5, 1);
    _marker = MapMarker.withAnchor(geoCoordinates, _markerImage!, anchor2D);
    hereMapController!.mapScene.addMapMarker(_marker!);
  }
```

A full example of the usage of the map tap event with venues is available in the "indoor_map_app" example app, available on [GitHub](https://github.com/heremaps/here-sdk-examples).
