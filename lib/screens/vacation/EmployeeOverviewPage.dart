import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/vacation/EmployeeDetailPage.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/widgets/LunatechBackground.dart';
import 'package:flutter_apps/widgets/LunatechListItem.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';

import '../../model/vacation/dto/EmployeeOverview.dart';
import '../../widgets/LunatechDrawer.dart';

class EmployeeOverviewPage extends StatefulWidget {
  const EmployeeOverviewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EmployeeOverviewState();
  }
}

class _EmployeeOverviewState extends State<EmployeeOverviewPage> {
  bool loading = true;
  List<EmployeeOverview> employeesList = [];

  late String userEmail;

  _EmployeeOverviewState(){
    userEmail = GoogleService().getAccount().email;
  }

  @override
  Widget build(BuildContext context) {
    if(loading) _loadData();

    return Scaffold(
        appBar: AppBar(title: const Text("Vacation App")),
        drawer: const LunatechDrawer(),
        body: loading ? const LunatechLoading() : _listView());
  }

  Widget _listView() {
    return LunatechBackground(
      child: ListView.separated(
        itemCount: employeesList.length,
        itemBuilder: (_, index) => employeeToItem(employeesList[index]),
        separatorBuilder: (_, __) => const Divider(height: 0),
      ),
    );
  }

  Widget employeeToItem(EmployeeOverview employee) {
    bool isUser = employee.email == userEmail;

    return LunatechListItem(
      height: isUser ? 120 : 80,
      child: InkWell(
        child: Center(child: Text(employee.name, style: TextStyle(
          fontWeight: isUser ? FontWeight.bold : FontWeight.normal
        ))),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeDetailPage(email: employee.email))),
      ),
    );
  }

  void _loadData() async {
    employeesList = await VacationAppService().getEmployees();
    loading = false;
    setState(() => {});
  }
}
