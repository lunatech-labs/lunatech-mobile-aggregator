import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/blog/BlogPage.dart';
import 'package:flutter_apps/services/GoogleService.dart';
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
      if (!mounted) return;
      loadingScreen.stopLoading(context);
    }
  }

  @override
  void initState() {
    super.initState();
    GoogleService().isSignedIn().then((signedIn) {
      if (signedIn) _handleSignIn(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [backgroundColor, backgroundColor.withOpacity(0.8)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.3, 1])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_lunatechLogo(), _googleSignInButton(context)],
          ),
        ),
      ),
    );
  }

  Container _lunatechLogo() {
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset("lib/static/logo-lunatech.svg",
              height: 120, width: 120),
          const Text("LUNATECH", style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
            letterSpacing: 3
          ))
        ],
      ),
    );
  }

  Widget _googleSignInButton(BuildContext context) {
    return Material(
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
    );
  }
}
