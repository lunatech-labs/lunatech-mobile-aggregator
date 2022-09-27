import 'package:flutter/material.dart';
import 'package:flutter_apps/model/EmployeeList.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late GoogleSignIn googleSignIn;

  String? accessToken;
  Iterable<EmployeeList>? employees;

  void loadData() async {
    accessToken = await GoogleService().getAccessToken();
    employees = await VacationAppService().getEmployees();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            Text("Current user: ${GoogleService().getAccount().displayName}"),
            Text("Logged with email: ${GoogleService().getAccount().email}"),
            SelectableText("Authentication token: ${accessToken ?? "Loading..."}"),
            Text("Employees: ${employees ?? "Loading..."}")
          ],
        ),
      ),
    );
  }
}
