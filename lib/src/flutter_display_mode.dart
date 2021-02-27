import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';

import 'model/display_mode.dart';

class FlutterDisplayMode {
  const FlutterDisplayMode._();

  static const MethodChannel _channel = MethodChannel('flutter_display_mode');

  static Future<List<DisplayMode>> get supported async {
    final List<dynamic> modes = (await _channel.invokeMethod<List<dynamic>>(
      'getSupportedModes',
    ))!;
    return modes.map((dynamic i) {
      final Map<String, dynamic> item =
          (i as Map<dynamic, dynamic>).cast<String, dynamic>();
      return DisplayMode.fromJson(item);
    }).toList();
  }

  static Future<DisplayMode> get current async {
    final Map<String, dynamic>? mode =
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
      'getCurrentMode',
    ))
            ?.cast<String, dynamic>();
    if (mode == null) {
      throw PlatformException(
        code: '0',
        message: 'No supported display mode founded on platform.',
      );
    }
    return DisplayMode.fromJson(mode);
  }

  static Future<void> setMode(DisplayMode mode) async {
    return await _channel.invokeMethod<void>(
      'setMode',
      <String, dynamic>{'mode': mode.id},
    );
  }

  static Future<void> setDeviceDefault() async {
    final List<DisplayMode> modes = await supported;
    if (modes.where((DisplayMode m) => m.selected).isEmpty) {
      return await _channel.invokeMethod<void>('setDeviceDefault');
    } else {
      log('You already set a default mode.');
    }
  }
}
