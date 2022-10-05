import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/vacation/VacationAppDetailPage.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/widgets/LunatechListItem.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';

import '../../model/vacation/EmployeeOverview.dart';
import '../../widgets/LunatechDrawer.dart';

class VacationAppListPage extends StatefulWidget {
  const VacationAppListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _VacationAppListState();
  }
}

class _VacationAppListState extends State<VacationAppListPage> {
  bool loading = true;
  List<EmployeeOverview> employeesList = [];

  late String userEmail;

  _VacationAppListState(){
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

  ListView _listView() {
    return ListView.separated(
      itemCount: employeesList.length,
      itemBuilder: (_, index) => employeeToItem(employeesList[index]),
      separatorBuilder: (_, __) => const Divider(height: 0),
    );
  }

  Widget employeeToItem(EmployeeOverview employee) {
    bool isUser = employee.email == userEmail;

    return LunatechListItem(
      height: 80,
      color: isUser ? Colors.redAccent : Colors.white,
      child: InkWell(
        child: Center(child: Text(employee.name)),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VacationAppDetailPage(email: employee.email))),
      ),
    );
  }

  void _loadData() async {
    employeesList = await VacationAppService().getEmployees();
    loading = false;
    setState(() => {});
  }
}
