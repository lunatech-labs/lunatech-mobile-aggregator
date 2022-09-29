import 'package:flutter/material.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/screens/HomePage.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInPage> {
  bool loading = false;

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      setState(() => loading = true);
      await GoogleService().signIn().then((_) =>
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false));
    } catch (error) {
      print(error);
      setState(() => loading = false);

    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const LunatechLoading(): body(context);
  }

  Scaffold body(BuildContext context) {
    return Scaffold(
    body: Center(
      child: TextButton(
          onPressed: () => _handleSignIn(context),
          child: const Text("Test login")),
    ),
  );
  }
}
