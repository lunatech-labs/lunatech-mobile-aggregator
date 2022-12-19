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
            height: 300,
            child: RefreshIndicator(
                onRefresh: test,
                child: ListView(children: const [
                  ColoredBox(
                      color: Colors.red,
                      child: SizedBox(height: 100, width: 300)),
                  ColoredBox(
                      color: Colors.grey,
                      child: SizedBox(height: 100, width: 300)),
                ])),
          )
        ]));
  }

  Future<void> test() async {
    print("Test");
    return Future.delayed(const Duration(seconds: 2));
  }
}
