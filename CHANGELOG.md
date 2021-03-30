## 0.3.1-nullsafety.0

* Add `FlutterDisplayMode.setHighRefreshRate` and `FlutterDisplayMode.setLowRefreshRate` methods

## 0.3.0-nullsafety.0

* Breaking changes to fix [issue#9](https://github.com/ajinasokan/flutter_displaymode/issues/9)
* `FlutterDisplayMode.current` renamed to `FlutterDisplayMode.active`
* `FlutterDisplayMode.setMode` renamed to `FlutterDisplayMode.setPreferredMode`
* Added `FlutterDisplayMode.preferred`
* Removed `DisplayMode.selected` field. Use `FlutterDisplayMode.active` instead.

## 0.2.0-nullsafety.0

* Migrate to null safety.

## 0.1.1

* Fix pubspec warning for iOS [issue#4](https://github.com/ajinasokan/flutter_displaymode/issues/4)

## 0.1.0

* Support get current mode from platform.
* Support default mode set according to platform setting.
* Code stylus improving.

## 0.0.1

* Initial release.
