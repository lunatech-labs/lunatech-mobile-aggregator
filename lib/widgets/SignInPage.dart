import 'package:flutter/material.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/widgets/HomePage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      await GoogleService().signIn().then((_) =>
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage(title: "This is a shitty app")),
              (route) => false));
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
