import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/model/settings/AppSettings.dart';

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlaygroundScreen();
  }
}

class _PlaygroundScreen extends State<PlaygroundScreen> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Playground Area")),
      body: Column(
        children: [
          Row(children: [
            Text("Dark mode"),
            Switch(
                value: AppSettings().themeMode == ThemeMode.dark,
                onChanged: (value) {
                  AppSettings()
                      .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  setState(() {});
                })
          ]),
          Switch(value: switchValue, onChanged: (val) => setState((){switchValue = val;})),
          SizedBox(height: 30, width: 30,),
        ],
      ),
    );
  }
}
