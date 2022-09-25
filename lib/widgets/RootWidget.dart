import 'package:flutter/cupertino.dart';
import 'package:flutter_apps/widgets/HomePage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RootWidget extends InheritedWidget {
  static const homepage = HomePage(title: "Lunatech Home");
  const RootWidget({
    super.key,
    required this.googleSignIn
  }) : super(child: homepage);

  final GoogleSignIn googleSignIn;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static RootWidget of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<RootWidget>()!;
}