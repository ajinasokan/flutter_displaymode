import 'dart:async';

import 'package:flutter/services.dart';

class DisplayMode {
  final int id;
  final int width;
  final int height;
  final double refreshRate;
  final bool selected;

  DisplayMode({
    this.id,
    this.width,
    this.height,
    this.refreshRate,
    this.selected,
  });

  @override
  String toString() {
    return "#$id ${width}x${height} @ ${refreshRate.toInt()}Hz";
  }
}

class FlutterDisplayMode {
  static const MethodChannel _channel =
      const MethodChannel('flutter_displaymode');

  static Future<List<DisplayMode>> get supported async {
    List<dynamic> modes = await _channel.invokeMethod('getSupportedModes');
    return modes.map((i) {
      final item = i as Map;
      return DisplayMode(
        id: item["id"],
        width: item["width"],
        height: item["height"],
        refreshRate: item["refreshRate"],
        selected: item["selected"],
      );
    }).toList();
  }

  static Future<void> setMode(DisplayMode mode) async {
    return await _channel.invokeMethod('setMode', {"mode": mode.id});
  }
}
