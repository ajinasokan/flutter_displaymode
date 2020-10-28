# Flutter Display Mode

[![pub package](https://img.shields.io/pub/v/flutter_displaymode.svg)](https://pub.dev/packages/flutter_displaymode)

A Flutter plugin to set display mode in Android. This library should be used as a temporary fix to [#35162](https://github.com/flutter/flutter/issues/35162) until this API gets added to Flutter engine itself.

## Getting Started

Add [package](https://pub.dev/packages/flutter_displaymode) to `pubspec.yaml` then re-run `flutter pub get` and restart your app:

```
dependencies:
  flutter_displaymode: 0.1.1
```

## Methods

### Get supported modes

```dart
import 'package:flutter_displaymode/flutter_displaymode.dart';

///...///

try {
  modes = await FlutterDisplayMode.supported;
  modes.forEach(print);

  /// On OnePlus 7 Pro:
  /// #1 1080x2340 @ 60Hz
  /// #2 1080x2340 @ 90Hz
  /// #3 1440x3120 @ 90Hz
  /// #4 1440x3120 @ 60Hz

  /// On OnePlus 8 Pro:
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

### Get current mode before any mode selected (acurate before manually set)

```dart
final DisplayMode m = await FlutterDisplayMode.current;
```

### Get currently selected mode

```dart
/// If this is null it means app is in auto mode.
/// Once you have made a selection flag will be enabled.
final DisplayMode m = modes.firstWhere((DisplayMode m) => m.selected, orElse: () => null);
```

### Set the mode to default (worked before manually set)

```dart
await FlutterDisplayMode.setDefaultMode();
```

### Set a mode

```dart
/// This setting is per session. 
/// Please ensure this was placed with `initState` of your root widget.
await FlutterDisplayMode.setMode(modes[0]);
```

You can check out an example [here](https://github.com/ajinasokan/flutter_displaymode/blob/master/example/lib/main.dart).

