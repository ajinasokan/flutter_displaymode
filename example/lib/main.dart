import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<DisplayMode> modes = <DisplayMode>[];
  DisplayMode selected;

  Future<void> fetchModes() async {
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
      print(e);

      /// e.code =>
      /// noAPI - No API support. Only Marshmallow and above.
      /// noActivity - Activity is not available. Probably app is in background
    }
    selected =
        modes.firstWhere((DisplayMode m) => m.selected, orElse: () => null);
    if (mounted) {
      setState(() {});
    }
  }

  Future<DisplayMode> getCurrentMode() async {
    return await FlutterDisplayMode.current;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: const Text('Fetch modes (Native)'),
                  onPressed: fetchModes,
                ),
                RaisedButton(
                  child: const Text('Current mode (Native)'),
                  onPressed: () async {
                    final DisplayMode mode = await getCurrentMode();
                    print(mode);
                    showDialog<void>(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: Text(mode.toString()),
                      ),
                    );
                  },
                ),
              ],
            ),
            DropdownButton<DisplayMode>(
              value: selected,
              items: modes
                  .map((DisplayMode m) => DropdownMenuItem<DisplayMode>(
                        child: Text(m.toString()),
                        value: m,
                      ))
                  .toList(),
              onChanged: (DisplayMode m) async {
                await FlutterDisplayMode.setMode(m);
                selected = m;
                if (mounted) {
                  setState(() {});
                }
              },
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext _, int i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Index: $i'),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Set default mode',
          onPressed: FlutterDisplayMode.setDeviceDefault,
          child: Icon(Icons.build),
        ),
      ),
    );
  }
}
