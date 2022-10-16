import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/SignInPage.dart';
import 'package:flutter_apps/util/configs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Lunatech Center',
      theme: lightTheme,
      home: const SignInPage(),
    );
  }
}
