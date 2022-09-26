import 'package:flutter/material.dart';
import 'package:flutter_apps/widgets/RootWidget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ["email"],
    hostedDomain: "lunatech.nl"
  );

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn().then((response) =>
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => RootWidget(googleSignIn: _googleSignIn))));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () => _handleSignIn(context),
            child: const Text("Test login")),
      ),
    );
  }
}