import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/vacation/VacationAppDetailPage.dart';
import 'package:flutter_apps/services/VacationAppService.dart';

import '../../model/vacation/EmployeeList.dart';
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
  List<EmployeeList> employeesList = [];

  @override
  Widget build(BuildContext context) {
    if(loading) _loadData();

    return Scaffold(
        appBar: AppBar(title: const Text("Vacation App")),
        drawer: LunatechDrawer(),
        body: loading ? _waitingText() : _listView());
  }

  ListView _listView() {
    return ListView.separated(
      itemCount: employeesList.length,
      itemBuilder: (_, index) => employeeToItem(employeesList[index]),
      separatorBuilder: (_, __) => const Divider(height: 0),
    );
  }

  Widget _waitingText() {
    return const Center(child: Text("Loading..."));
  }

  Widget employeeToItem(EmployeeList employee) {
    return SizedBox(
      height: 50,
      child: Material(
        child: InkWell(
          child: Center(child: Text(employee.name)),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VacationAppDetailPage(email: employee.email))),
        ),
      ),
    );
  }

  void _loadData() async {
    employeesList = await VacationAppService().getEmployees();
    loading = false;
    setState(() => {});
  }
}
