import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<DisplayMode> modes = [];
  DisplayMode selected;

  void fetchModes() async {
    try {
      modes = await FlutterDisplayMode.supported;
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
    selected = modes.firstWhere((m) => m.selected, orElse: () => null);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Fetch modes"),
              onPressed: () => fetchModes(),
            ),
            DropdownButton<DisplayMode>(
              value: selected,
              items: modes
                  .map((m) => DropdownMenuItem(
                        child: Text(m.toString()),
                        value: m,
                      ))
                  .toList(),
              onChanged: (m) async {
                await FlutterDisplayMode.setMode(m);
                selected = m;
                setState(() {});
              },
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Index: $i'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
