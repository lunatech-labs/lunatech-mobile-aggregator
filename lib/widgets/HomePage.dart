import 'package:flutter/material.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/widgets/RootWidget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late GoogleSignIn googleSignIn;

  GoogleSignInAuthentication? authentication;
  String? employees;

  void loadData(BuildContext context) async {
    var rootServices = RootWidget
        .of(context)
        .services;
    authentication = await rootServices.authentication();
    VacationAppService vacationAppService = await rootServices
        .vacationAppService();
    employees = await vacationAppService.getEmployees().then((employeesJson) {
      return employeesJson.map((employee) => employee["name"])
        .join("\n");
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    googleSignIn = RootWidget
        .of(context)
        .googleSignIn;
    loadData(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            Text("Current user: ${googleSignIn.currentUser!.displayName}"),
            Text("Logged with email: ${googleSignIn.currentUser!.email}"),
            SelectableText(
                "Authentication token: ${authentication?.accessToken ??
                    "Loading..."}"),
            Text("Employees: ${employees ?? "Loading..."}")
          ],
        ),
      ),
    );
  }
}
