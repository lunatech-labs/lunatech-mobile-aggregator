import 'package:flutter/material.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/screens/HomePage.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      await GoogleService().signIn().then((_) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false));
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const LunatechLoading() : body(context);
  }

  Scaffold body(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset("lib/static/logo-lunatech.svg", height: 120, width: 120),
            InkWell(
              onTap: () => _handleSignIn(context), // Image tapped
              splashColor: Colors.white10, // Splash color over image
              child: Ink.image(
                fit: BoxFit.fill,
                width: 194,
                height: 46,
                image: const AssetImage("lib/static/logo-google.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
