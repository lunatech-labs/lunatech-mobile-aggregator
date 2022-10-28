import 'package:flutter/material.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/screens/BlogPage.dart';
import 'package:flutter_apps/widgets/LunatechBackground.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../util/UtilMethods.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInPage> {

  Future<void> _handleSignIn(BuildContext context) async {
    LunatechLoading loadingScreen = showLoadingScreen(context);
    try {
      await GoogleService().signIn().then((_) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BlogPage()),
          (route) => false));
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      if(!mounted) return;
      loadingScreen.stopLoading(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LunatechBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset("lib/static/logo-lunatech.svg", height: 120, width: 120),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _handleSignIn(context), // Image tapped
                  child: Ink.image(
                    fit: BoxFit.fill,
                    width: 194,
                    height: 46,
                    image: const AssetImage("lib/static/logo-google.png"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
