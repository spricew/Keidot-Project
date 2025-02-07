# Add voice guidance

While driving, the user's attention should stay focused on the route. You can construct visual representations from the provided maneuver data (see above), but you can also get localized textual representations that are meant to be spoken during turn-by-turn guidance. Since these maneuver notifications are provided as a `String`, it is possible to use them together with any TTS solution.

> #### Note
> Maneuver notifications are targeted at drivers. It is not recommended to use them for pedestrian guidance.
>
> Note that the HERE SDK does not include pre-recorded voice skins. This means, you need to integrate a TTS engine for playback. Below you can find more details and examples for audio playback.

Example notifications (provided as strings):

```xml
Voice message: After 1 kilometer turn left onto North Blaney Avenue.
Voice message: Now turn left.
Voice message: After 1 kilometer turn right onto Forest Avenue.
Voice message: Now turn right.
Voice message: After 400 meters turn right onto Park Avenue.
Voice message: Now turn right.
```

To get these notifications, set up a `EventTextListener`:

```dart
// Notifies on messages that can be fed into TTS engines to guide the user with audible instructions.
// The texts can be maneuver instructions or warn on certain obstacles, such as speed cameras.
_visualNavigator.eventTextListener =
    EventTextListener((EventText eventText) {
  // Flutter itself does not provide a text-to-speech engine. Use one of the available TTS plugins to speak
  // the eventText message.
  print("Voice guidance text: $eventText");
  // We can optionally retrieve the associated maneuver. The details will be null if the text contains
  // non-maneuver related information, such as for speed camera warnings.
  if (eventText.type == TextNotificationType.maneuver) {
    HERE.Maneuver? maneuver =
        eventText.maneuverNotificationDetails?.maneuver;
  }
});
```

Here we just print the text. You can use a TTS plugin, such as [flutter_tts](https://pub.dev/packages/flutter_tts), to translate the voice text to an audible message a driver can hear.

Note that speed camera warnings are only available for certain countries and they are only included as `EventText` when a `SafetyCameraWarningListener` is set.

**Natural guidance uses significant objects to improve maneuver notifications.**

Optionally, you can also enable natural guidance: `EventText` texts can be enhanced to include significant objects (such as traffic lights or stop signs) along a route to make maneuvers better understandable. Example: "At the next traffic light turn left onto Wall street". By default, this feature is disabled. To enable it, add at least one `NaturalGuidanceType` such as `trafficLight` to `ManeuverNotificationOptions` via the list of `includedNaturalGuidanceTypes`.

You can set a `LanguageCode` to localize the notification text and a `UnitSystem` to decide on metric or imperial length units. Make sure to call this before a route is set, otherwise the default settings is (`enUs`, `metric`). For more `ManeuverNotificationOptions` consult the API Reference.

```dart
void _setupVoiceTextMessages() {
    LanguageCode ttsLanguageCode = getLanguageCodeForDevice(
        VisualNavigator.getAvailableLanguagesForManeuverNotifications());
    ManeuverNotificationOptions maneuverNotificationOptions = ManeuverNotificationOptions.withDefaults();
    // Set the language in which the notifications will be generated.
    maneuverNotificationOptions.language = ttsLanguageCode;
    // Set the measurement system used for distances.
    maneuverNotificationOptions.unitSystem = UnitSystem.metric;
    _visualNavigator.maneuverNotificationOptions = maneuverNotificationOptions;
    print("LanguageCode for maneuver notifications: $ttsLanguageCode.");
}
```

Internally, maneuver notification texts are generated from the `Maneuver` data you can access from the `RouteProgress` event. The `RouteProgress` event is frequently generated based on the passed location updates. For maneuver notifications you can specify how often and when the text messages should be generated. This can be specified via `ManeuverNotificationTimingOptions`.

For each `ManeuverNotificationType` you can set `ManeuverNotificationTimingOptions` for each transport mode and road type. You can also specify the timings in distance in meters or in seconds:

1. `ManeuverNotificationType.range`: first notification. Specified via `rangeNotificationDistanceInMeters` or `rangeNotificationTimeInSeconds`.
2. `ManeuverNotificationType.reminder`: second notification. Specified via `reminderNotificationDistanceInMeters` or `reminderNotificationTimeInSeconds`.
3. `ManeuverNotificationType.distance`: third notification. Specified via `distanceNotificationDistanceInMeters` or `distanceNotificationTimeInSeconds`.
4. `ManeuverNotificationType.action`: fourth notification. Specified via `actionNotificationDistanceInMeters` or `actionNotificationTimeInSeconds`.

The types are ordered by distance. If you want to customize TTS messages only a few meters before the maneuver, set only `distanceNotificationDistanceInMeters`. You can also omit types via `maneuverNotificationOptions.includedNotificationTypes`. For example, if you set only the `distance` type, you will not get any other notifications - even when the maneuver takes place (= `action`).

Below we tweak only the `distance` type value for cars (= transport mode) on highways (road type) and keep all other values as they are:

```dart
// Get currently set values - or default values, if no values have been set before.
// By default, notifications for cars on highways are sent 1300 meters before the maneuver
// takes place.
ManeuverNotificationTimingOptions carHighwayTimings =
    navigator.getManeuverNotificationTimingOptions(TransportMode.car, RoadType.highway);

// Set ManeuverNotificationType.distance (third notification):
// Set a new value for cars on highways and keep all other values unchanged.
carHighwayTimings.distanceNotificationDistanceInMeters = 1500;

// Apply the changes.
navigator.setManeuverNotificationTimingOptions(TransportMode.car, RoadType.highway, carHighwayTimings);

// By default, we keep all types. If you set an empty list you will disallow generating the texts.
// The names of the type indicate the use case: For example, range is the farthest notification.
// action is the notification when the maneuver takes place.
// And reminder and distance are two optional notifications when approaching the maneuver.
maneuverNotificationOptions.includedNotificationTypes = [
  ManeuverNotificationType.range, // first notification.
  ManeuverNotificationType.reminder, // second notification.
  ManeuverNotificationType.distance, // third notification.
  ManeuverNotificationType.action // fourth notification.
];
```

By default, the maneuver notification texts are in plain orthographic form ("Wall Street"). Some TTS engines support phonemes, which add the plain text "Wall Street" additionally also in SSML notation: "&quot;wɔːl&quot;striːt". This results in a better pronunciation. Call the below code to enable phonemes:

```dart
// Add phoneme support with SSML.
// Note that phoneme support may not be supported by all TTS engines.
maneuverNotificationOptions.enablePhoneme = true;
maneuverNotificationOptions.notificationFormatOption = NotificationFormatOption.ssml;
```

Example voice message with phonemes:

```xml
After 300 meters turn right onto <lang xml:lang="ENG"><phoneme alphabet="nts"  ph="&quot;wɔːl&quot;striːt" orthmode="ignorepunct">Wall Street</phoneme></lang>.
```

Take a look at the API Reference to find more options that can be set via `ManeuverNotificationOptions`.

Note that the HERE SDK supports 37 languages. You can query the languages from the `VisualNavigator` with `VisualNavigator.getAvailableLanguagesForManeuverNotifications()`. All languages within the HERE SDK are specified as `LanguageCode` enum. <!-- TODO not yet available for Fluter! ... To convert this to a `Locale` instance, you can use a `LanguageCodeConverter`. This is an open source utility class you find as part of the "navigation_app" example on [GitHub](examples.md). -->

> #### Note
> Each of the supported languages to generate maneuver notifications is stored as a voice skin inside the HERE SDK framework. Unzip the framework and look for the folder `voice_assets`. You can remove assets you are not interested in to decrease the size of the HERE SDK package. See [maps](maps.md) section on details how to remove files.

However, in order to feed the maneuver notification into a TTS engine, you also need to ensure that your preferred language is supported by the TTS engine of your choice. Usually each device comes with some preinstalled languages, but not all languages may be present initially.

> #### Note
> The "spatial_audio_navigation_app" example shows how to use the `VisualNavigator` together with native code for Android and iOS to play back the TTS audio messages with audio panning to indicate directions via the stereo panorama. You can find the example on [GitHub](https://github.com/heremaps/here-sdk-examples).

## Supported languages for voice guidance

Below you can find a list of all supported voice languages together with the name of the related voice skin that is stored inside the HERE SDK framework:

- Arabic (Saudi Arabia): voice_package_ar-SA
- Czech: voice_package_cs-CZ
- Danish: voice_package_da-DK
- German: voice_package_de-DE
- Greek: voice_package_el-GR
- English (British): voice_package_en-GB
- English (United States): voice_package_en-US
- Spanish (Spain): voice_package_es-ES
- Spanish (Mexico): voice_package_es-MX
- Farsi (Iran): voice_package_fa-IR
- Finnish: voice_package_fi-FI
- French (Canada): voice_package_fr-CA
- French: voice_package_fr-FR
- Hebrew: voice_package_he-IL
- Hindi: voice_package_hi-IN
- Croatian: voice_package_hr-HR
- Hungarian: voice_package_hu-HU
- Indonesian: (Bahasa) voice_package_id-ID
- Italian: voice_package_it-IT
- Japanese: voice_package_ja-JP
- Korean: voice_package_ko-KR
- Norwegian: (Bokmål) voice_package_nb-NO
- Dutch: voice_package_nl-NL
- Portuguese (Portugal)	voice_package_pt-PT
- Portuguese (Brazil): voice_package_pt-BR
- Polish: voice_package_pt-PT
- Romanian: voice_package_ro-RO
- Russian: voice_package_ru-RU
- Slovak: voice_package_sk-SK
- Serbian: voice_package_sr-CS
- Swedish: voice_package_sv-SE
- Thai: voice_package_th-TH
- Turkish: voice_package_tr-TR
- Ukrainian: voice_package_uk-UA
- Vietnamese: voice_package_vi-VN
- Chinese (Simplified China): voice_package_zh-CN
- Chinese (Traditional Hong Kong): voice_package_zh-HK
- Chinese (Traditional Taiwan): voice_package_zh-TW

Open the HERE SDK framework and search for the `voice_assets` folder. If you want to shrink the size of the framework, you can remove the voice packages you do not need.

## Spatial audio maneuver notifications

The same `voiceText` as provided by the `EventTextListener` (see above) can be also enhanced with spatial audio information.

Spatial audio notifications allow to adjust the stereo panorama of the text-to-speech strings in real-time. This happens based on the next cue (maneuver and warners) location in relation to a driver sitting in a vehicle.

With the `EventTextListener` you get not only a maneuver text for the next cue, but also the azimuth elements which compose one of the spatial audio trajectories defined by the HERE SDK on `EventTextListener.SpatialNotificationDetails`. The resulting `SpatialTrajectoryData` contains the next azimuth angle to be used and it indicates whether the spatial audio trajectory has finished or not.

In order to retrieve this information, `EventTextOptions.enableSpatialAudio` must be enabled.

Use `SpatialManeuverAudioCuePanning` to start panning and pass `CustomPanningData` to update the `estimatedAudioCueDuration` of the `SpatialManeuver` and to customize its `initialAzimuthInDegrees` and `sweepAzimuthInDegrees` properties.

Take a look at the "spatial_audio_navigation_app" example on [GitHub](https://github.com/heremaps/here-sdk-examples) for more details.
