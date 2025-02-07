# Enable background updates

In case you want to continue receiving location updates while the application is running in the background, you first need to enable such capability by adding the needed permissions. On Android, this is only necessary if you target Android 10 (API level 29) or higher. Add the following permission to the app's `AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
```

Note that in order to support Android 14 or newer, also the `FOREGROUND_SERVICE_LOCATION` permission is required.

In addition, if you want to keep the application running in background on Android devices on Android API level 29 or higher, you need to start a foreground service or similar. Remember that on Android requesting background locations is different than requesting a foreground location permission. Check the [Android documentation](https://developer.android.com/training/location/permissions#request-background-location) for more details. Note that the [positioning example app](https://github.com/heremaps/here-sdk-examples) does not (yet) show how to support background positioning on Android 29 or higher.

> #### Note
> If your application targets Android API level 28 or lower, as long as your app already requests the permissions mentioned in the [Add permissions](get-locations.md#add-permissions) section, you don't need to make any changes to support background updates.

On iOS you can enable background updates by adding the following key to the app's `Info.plist` file:

```xml
<key>UIBackgroundModes</key>
	<array>
		<string>location</string>
        <string>processing</string>
	</array>
```

The "processing" mode is needed for iOS versions 13.0 and above. When added also the following is needed:

```xml
<key>BGTaskSchedulerPermittedIdentifiers</key>
    <array>
        <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    </array>
```

Check the [iOS documentation](https://developer.apple.com/documentation/xcode/configuring-background-execution-modes) for more details.

Remember that the user needs to be requested for authorization. Check the [Add the Required Permissions](get-locations.md#add-permissions) section for suggestions on how to request permissions from the user.

Once the authorization is cleared, you are all set. On iOS devices, you can enable or disable location updates in the background with the `LocationEngine.setBackgroundLocationAllowed()` method. Also on iOS devices, you can set the visibility of the application's background location indicator with the method `LocationEngine.setBackgroundLocationIndicatorVisible()`.

The final check for iOS devices would be to ensure that the location updates won't pause when the device is stationary by passing `false` to the `LocationEngine.setPauseLocationUpdatesAutomatically()` method.

> #### Note
> `setBackgroundLocationAllowed()` and `setBackgroundLocationIndicatorVisible()` will return `LocationEngineStatus.notAllowed` if the application does not have background location capabilities enabled. Otherwise, `LocationEngineStatus.ok` will be returned.
>
> On Android platforms, `setBackgroundLocationAllowed()`, `setBackgroundLocationIndicatorVisible()` and `setPauseLocationUpdatesAutomatically()` will return `LocationEngineStatus.notSupported`.

In addition, it is recommended to listen to the `AppLifecycleState` when you have background updates enabled.
