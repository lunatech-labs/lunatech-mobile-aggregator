import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/model/settings/AppSettings.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlaygroundScreen();
  }
}

class _PlaygroundScreen extends State<PlaygroundScreen>
    with TickerProviderStateMixin {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return LunatechScaffold(
        appBar: AppBar(title: Text("Playground Area")),
        body: Column(children: [
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
          Switch(
              value: switchValue,
              onChanged: (val) => setState(() {
                    switchValue = val;
                  })),
          const SizedBox(
            height: 30,
            width: 30,
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: GestureDetector(
              onTap: () => setState(() {}),
              child: AnimatedContainer(
                  height: 200,
                  width: 200,
                  duration: const Duration(milliseconds: 4000),
                  color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0)),
            ),
          )
        ]));
  }
}
