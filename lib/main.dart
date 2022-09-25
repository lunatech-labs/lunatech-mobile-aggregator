import 'package:flutter/material.dart';
import 'package:flutter_apps/widgets/HomePage.dart';
import 'package:flutter_apps/widgets/SignInPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lunatech Center',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SignInPage(),
    );
  }
}
