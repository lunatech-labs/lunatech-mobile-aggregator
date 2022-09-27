import 'package:flutter/material.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/screens/HomePage.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      await GoogleService().signIn().then((_) =>
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
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
