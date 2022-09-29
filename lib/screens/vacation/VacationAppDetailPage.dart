import 'package:flutter/material.dart';
import 'package:flutter_apps/model/vacation/EmployeeDetail.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';

class VacationAppDetailPage extends StatefulWidget {
  const VacationAppDetailPage({super.key, required this.email});

  final String email;

  @override
  State<StatefulWidget> createState() {
    return VacationAppDetailState();
  }
}

class VacationAppDetailState extends State<VacationAppDetailPage> {
  EmployeeDetail? employee;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    if (loading) _loadData();

    return Scaffold(
        appBar: AppBar(title: const Text("Vacation App")),
        body: loading ? const LunatechLoading() : body());
  }

  Widget body() {
    return Column(children: [overview(), tabView()]);
  }

  Widget overview() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(employee!.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(employee!.email!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Remaining Days"),
              Text(employee!.totalNumberOfDays!,
                  style: const TextStyle(color: Colors.green))
            ],
          )
        ],
      ),
    );
  }

  Widget tabView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: DefaultTabController(
          length: 2,
          child: Column(
            children: const [
              SizedBox(
                height: 50,
                child: TabBar(tabs: [
                  Tab(icon: Icon(Icons.directions_bike, color: Colors.red)),
                  Tab(icon: Icon(Icons.directions_car, color: Colors.red))
                ]),
              ),
              SizedBox(
                height: 100,
                child: TabBarView(children: [
                  Icon(Icons.directions_bike),
                  Icon(Icons.directions_car)
                ]),
              )
            ],
          )),
    );
  }

  void _loadData() async {
    employee = await VacationAppService().getEmployee(widget.email);
    setState(() => loading = false);
  }
}
