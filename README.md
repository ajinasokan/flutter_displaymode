# Flutter Display Mode

A Flutter plugin to set display mode in Android. This library should be used as a temporary fix to [#35162](https://github.com/flutter/flutter/issues/35162) until this API gets added to Flutter engine itself.

## Getting Started

Add [package](https://pub.dev/packages/flutter_displaymode) to pubspec:

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
// if this is null it means app is in auto mode
// once you have made a selection flag will be enabled
DisplayMode m = modes.firstWhere((m) => m.selected, orElse: () => null);
```

Set a mode:

```dart
// this setting is per session. 
// so do this inside initState of your root widget.
await FlutterDisplayMode.setMode(modes[0]);
```

You can check out an example [here](https://github.com/ajinasokan/flutter_displaymode/blob/master/example/lib/main.dart).