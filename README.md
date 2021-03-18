# Flutter Display Mode

[![pub package](https://img.shields.io/pub/v/flutter_displaymode.svg)](https://pub.dev/packages/flutter_displaymode)

A Flutter plugin to set display mode in Android. This library should be used as a temporary fix to [#35162](https://github.com/flutter/flutter/issues/35162) until this API gets added to Flutter engine itself.

## Getting Started

Add [package](https://pub.dev/packages/flutter_displaymode) to `pubspec.yaml` then re-run `flutter pub get` and restart your app:

```
dependencies:
  flutter_displaymode: 0.1.1
```

For null safe version:

```
dependencies:
  flutter_displaymode: 0.3.0-nullsafety.0
```

## Methods

Following methods are for >= 0.3.0 versions. For old version see [pub docs](https://pub.dev/documentation/flutter_displaymode/0.1.1/).

### Get supported modes

`FlutterDisplayMode.supported` returns all the modes that can be set as the preferred mode. This always returns `DisplayMode.auto` as one of the modes.

```dart
import 'package:flutter_displaymode/flutter_displaymode.dart';

try {
  modes = await FlutterDisplayMode.supported;
  modes.forEach(print);

  /// On OnePlus 7 Pro:
  /// #0 0x0 @0Hz // Automatic
  /// #1 1080x2340 @ 60Hz
  /// #2 1080x2340 @ 90Hz
  /// #3 1440x3120 @ 90Hz
  /// #4 1440x3120 @ 60Hz

  /// On OnePlus 8 Pro:
  /// #0 0x0 @0Hz // Automatic
  /// #1 1080x2376 @ 60Hz
  /// #2 1440x3168 @ 120Hz
  /// #3 1440x3168 @ 60Hz
  /// #4 1080x2376 @ 120Hz
} on PlatformException catch (e) {
  /// e.code =>
  /// noAPI - No API support. Only Marshmallow and above.
  /// noActivity - Activity is not available. Probably app is in background
}
```

### Get active mode

`FlutterDisplayMode.active` fetches the currently active mode. This is not always the preferred mode set by `FlutterDisplayMode.setPreferredMode`. It can be altered by the system based on the display settings.

```dart
final DisplayMode m = await FlutterDisplayMode.active;
```

### Set preferred mode

`FlutterDisplayMode.setPreferredMode` changes the preferred mode. It is upto the system to use this mode. Sometimes system can choose not switch to this based on internal heuristics. Check `FlutterDisplayMode.active` to see if it actually switches.

```dart
/// This setting is per session. 
/// Please ensure this was placed with `initState` of your root widget.
await FlutterDisplayMode.setPreferredMode(modes[1]);
```

### Get preferred mode

`FlutterDisplayMode.preferred` returns the currently preferred mode. If not manually set with `FlutterDisplayMode.setPreferredMode` then it will be `DisplayMode.auto`.

```dart
final DisplayMode m = await FlutterDisplayMode.preferred;
```

You can check out an example [here](https://github.com/ajinasokan/flutter_displaymode/blob/master/example/lib/main.dart).

