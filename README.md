# Flutter Display Mode

A Flutter plugin to set display mode in Android. This library should be used as a temporary fix to [#35162](https://github.com/flutter/flutter/issues/35162) until this API gets added to Flutter engine itself.

## Getting Started

Add library to pubspec:

```
dependencies:
  flutter_displaymode:
```

Get supported modes:

```dart
import 'package:flutter_displaymode/flutter_displaymode.dart';

...

try{
  List<DisplayMode> modes = await FlutterDisplayMode.supported;
  modes.forEach((m) {
    print(m);
  });
  // On OnePlus 7 Pro:
  // #1 1080x2340 @ 60Hz
  // #2 1080x2340 @ 90Hz
  // #3 1440x3120 @ 90Hz
  // #4 1440x3120 @ 60Hz
} on PlatformException catch (e) {
  // e.code =>
  // noapi - No API support. Only Marshmallow and above.
  // noactivity - Activity is not available. Probably app is in background
}
```

Get currently selected mode:

```dart
DisplayMode m = modes.firstWhere((m) => m.selected, orElse: () => null);
```

Set a mode:

```dart
await FlutterDisplayMode.setMode(modes[0]);
```