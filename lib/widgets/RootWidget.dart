import 'package:flutter/cupertino.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/widgets/HomePage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RootWidget extends InheritedWidget {
  static const homepage = HomePage(title: "Lunatech Home");

  RootWidget({super.key, required this.googleSignIn})
      : services = Services(googleSignIn),super(child: homepage);

  final GoogleSignIn googleSignIn;
  final Services services;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static RootWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<RootWidget>()!;
}

class Services {
  Services(this.googleSignIn);

  final GoogleSignIn googleSignIn;

  GoogleSignInAuthentication? _authentication;
  VacationAppService? _vacationAppService;

  Future<GoogleSignInAuthentication> authentication() async {
    _authentication ??= await googleSignIn.currentUser!.authentication;
    return _authentication!;
  }

  Future<VacationAppService> vacationAppService() async {
    if (_vacationAppService == null) {
      _vacationAppService = VacationAppService(await authentication());
      await _vacationAppService!.authenticate();
    }
    return _vacationAppService!;
  }
}
