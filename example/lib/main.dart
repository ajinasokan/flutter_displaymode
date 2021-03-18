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
  DisplayMode? active;
  DisplayMode? preferred;

  Future<void> fetchAll() async {
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

    preferred = await FlutterDisplayMode.preferred;

    active = await FlutterDisplayMode.active;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Available modes',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      fetchAll();
                    },
                    label: const Text('Fetch'),
                  ),
                ],
              ),
              if (modes.isEmpty) const Text('Nothing here'),
              for (DisplayMode mode in modes)
                Row(
                  children: [
                    Radio<DisplayMode>(
                      value: mode,
                      groupValue: preferred,
                      onChanged: (DisplayMode? newMode) async {
                        await FlutterDisplayMode.setPreferredMode(newMode!);
                        await Future<dynamic>.delayed(
                            const Duration(milliseconds: 100));
                        await fetchAll();
                        setState(() {});
                      },
                    ),
                    if (mode == DisplayMode.auto)
                      const Text('Automatic')
                    else
                      Text(mode.toString()),
                    if (mode == active) const Text(' [ACTIVE]'),
                  ],
                ),
              const Divider(),
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
        ),
        // floatingActionButton: const FloatingActionButton(
        //   tooltip: 'Set default mode',
        //   onPressed: FlutterDisplayMode.setDeviceDefault,
        //   child: Icon(Icons.build),
        // ),
      ),
    );
  }
}
