import 'package:flutter/material.dart';
import 'package:flutter_apps/model/settings/AppSettings.dart';
import 'package:flutter_apps/screens/SignInPage.dart';
import 'package:flutter_apps/util/configs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    AppSettings().addListener(() => setState((){}));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Lunatech Center',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: AppSettings().themeMode,
      home: const SignInPage(),
    );
  }
}
