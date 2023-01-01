import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/vacation/VacationEmployeeDetail.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';

import '../../model/vacation/dto/EmployeeOverview.dart';

class VacationEmployeesOverviewPage extends StatefulWidget {
  const VacationEmployeesOverviewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _VacationEmployeeOverviewState();
  }
}

class _VacationEmployeeOverviewState extends State<VacationEmployeesOverviewPage> {
  List<EmployeeOverview> employeesList = [];
  List<EmployeeOverview> filteredEmployees = [];

  late String userEmail;

  _VacationEmployeeOverviewState() {
    userEmail = GoogleService().getAccount().email;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _loadData());
  }

  @override
  Widget build(BuildContext context) {
    return LunatechScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            title: const Text('Vacation App'),
            bottom: AppBar(
                automaticallyImplyLeading: false,
                title: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.white,
                    child: Center(
                        child: TextField(
                      onChanged: _filterEmployees,
                      style: const TextStyle(
                        color: Colors.black
                      ),
                      decoration: const InputDecoration(
                          hintText: 'Search for employee',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.grey)),
                    )))),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (_, index) => employeeToItem(filteredEmployees[index]),
            childCount: filteredEmployees.length,
          ))
        ],
      ),
    );
  }

  Widget employeeToItem(EmployeeOverview employee) {
    bool isUser = employee.email == userEmail;

    return Column(
      children: [
        Container(
          height: isUser ? 120 : 80,
          color: Colors.black,
          child: Material(
            child: InkWell(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(employee.name,
                      style: TextStyle(
                          fontWeight:
                              isUser ? FontWeight.bold : FontWeight.normal)),
                  Text(
                      'Remaining days: ${employee.totalDaysThisYear.toString()}',
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.secondary))
                ],
              )),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          VacationEmployeeDetailPage(email: employee.email))),
            ),
          ),
        ),
        const Divider(thickness: 1, height: 0)
      ],
    );
  }

  void _loadData() async {
    final loadingScreen = showLoadingScreen(context);
    employeesList = await VacationAppService().getEmployees();
    if (!mounted) return;
    loadingScreen.stopLoading(context);
    setState(() => filteredEmployees = employeesList);
  }

  void _filterEmployees(String value) {
    String lowerCaseSearch = value.toLowerCase();

    bool employeeCondition(EmployeeOverview employee) {
      if (employee.name.toLowerCase().contains(lowerCaseSearch)) return true;
      if (employee.email.toLowerCase().contains(lowerCaseSearch)) return true;
      return false;
    }

    setState(() {
      filteredEmployees = employeesList.where(employeeCondition).toList();
    });
  }
}
