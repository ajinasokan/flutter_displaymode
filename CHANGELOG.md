## 0.7.0

* Android project upgrades

## 0.6.0

* Android project upgrades (Gradle 8, AGP 8.0, compileSDK 33, Java 17). Thanks to [@vbuberen](https://github.com/vbuberen)

## 0.5.0

* Calling `setHighRefreshRate` or `setLowRefreshRate` will always set the display mode. Fixes #20
* Setting compileSdkVersion to 30
* Cleaned up all deprecation warnings. Fixes #14

## 0.4.1

* Migrate to mavenCentral. Thanks to [@alvarisi](https://github.com/alvarisi)

## 0.4.0

* Removed deprecated `registerWith` function to cleanup warnings

## 0.3.2

* Fix setHighRefreshRate/setLowRefreshRate

## 0.3.1-nullsafety.0

* Add `FlutterDisplayMode.setHighRefreshRate` and `FlutterDisplayMode.setLowRefreshRate` methods

## 0.3.0-nullsafety.0

* Breaking changes to fix [issue#9](https://github.com/ajinasokan/flutter_displaymode/issues/9)
* `FlutterDisplayMode.current` renamed to `FlutterDisplayMode.active`
* `FlutterDisplayMode.setMode` renamed to `FlutterDisplayMode.setPreferredMode`
* Added `FlutterDisplayMode.preferred`
* Removed `DisplayMode.selected` field. Use `FlutterDisplayMode.active` instead.

## 0.2.0-nullsafety.0

* Migrate to null safety. Thanks [@AlexV525](https://github.com/AlexV525)

## 0.1.1

* Fix pubspec warning for iOS [issue#4](https://github.com/ajinasokan/flutter_displaymode/issues/4)

## 0.1.0

* Support get current mode from platform.
* Support default mode set according to platform setting.
* Code stylus improving.

## 0.0.1

* Initial release.
