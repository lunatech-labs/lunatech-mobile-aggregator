import 'package:flutter/material.dart';
import 'package:flutter_apps/model/vacation/EmployeeList.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/LunatechDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String title = "LunatechApp";

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late GoogleSignIn googleSignIn;

  String? accessToken;
  String? vacationToken;
  bool loading = true;

  void loadData() async {
    accessToken = await GoogleService().getAccessToken();
 //   vacationToken = await VacationAppService().vacationToken;
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(loading) loadData();

    return loading ? const LunatechLoading() : body();
  }

  Scaffold body() {
    return Scaffold(
    appBar: AppBar(title: const Text(HomePage.title)),
    drawer: LunatechDrawer(),
    body: Center(
      child: ListView(
        children: [
          Text("Current user: ${GoogleService().getAccount().displayName}"),
          Text("Logged with email: ${GoogleService().getAccount().email}"),
          SelectableText("Authentication token: ${accessToken ?? "Loading..."}"),
    //      SelectableText("Vacation tokenn: ${vacationToken ?? "Loading..."}")
        ],
      ),
    ),
  );
  }
}
