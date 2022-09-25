import 'package:flutter/material.dart';
import 'package:flutter_apps/widgets/RootWidget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}


class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    GoogleSignIn googleSignIn = RootWidget.of(context).googleSignIn;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column (
          children: [
            Text("Current user: ${googleSignIn.currentUser!.displayName}"),
            Text("Logged with email: ${googleSignIn.currentUser!.email}")
          ],
        ),
      )
    );
  }
}