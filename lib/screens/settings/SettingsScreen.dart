import 'package:flutter/material.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return LunatechScaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: ListView(
          shrinkWrap: true,
          children: const [ListTile(title: Text("Test"))],
        ));
  }
}
