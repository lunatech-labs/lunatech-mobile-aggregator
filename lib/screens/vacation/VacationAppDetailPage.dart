import 'package:flutter/material.dart';
import 'package:flutter_apps/model/vacation/dto/EmployeeDetail.dart';
import 'package:flutter_apps/model/vacation/dto/AvailableVacation.dart';
import 'package:flutter_apps/model/vacation/dto/RequestedVacation.dart';
import 'package:flutter_apps/screens/vacation/VacationAppRequestVacation.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';

import '../../services/GoogleService.dart';

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
        floatingActionButton: loading ? null : actionButton(),
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
            children: [
              const SizedBox(
                height: 50,
                child: TabBar(tabs: [
                  Tab(icon: Icon(Icons.upcoming, color: Colors.red)),
                  Tab(icon: Icon(Icons.event_available, color: Colors.red))
                ]),
              ),
              SizedBox(
                height: 400,
                child: TabBarView(children: [
                  vacationRequests(),
                  availableVacations()
                ]),
              )
            ],
          )),
    );
  }

  Widget vacationRequests() {
    return ListView.builder(
        itemCount: employee!.vacationRequests.length,
        itemBuilder: (context, index) =>
            vacationRequest(employee!.vacationRequests[index]));
  }

  Widget vacationRequest(RequestedVacation vacationRequest) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Material(
          child: InkWell(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text("From: "),
                                  Text(vacationRequest.formattedFromDate!,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey))
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Until: "),
                                Text(vacationRequest.formattedUntilDate!,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey))
                              ],
                            )
                          ]),
                    ),
                    Text(vacationRequest.status ?? "Unknown")
                  ]))),
    );
  }

  Widget availableVacations() {
    return ListView.builder(
        itemCount: employee!.vacationRows.length,
        itemBuilder: (context, index) =>
            availableVacation(employee!.vacationRows[index]));
  }

  Widget availableVacation(AvailableVacation availableVacation) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 150,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Year: ", style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold)),
                Text(availableVacation.year!.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.grey))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Remaining Days: ", style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(availableVacation.numberOfVacationDays!.toString(),
                      style: const TextStyle(fontSize: 14, color: Colors.grey))
                ],
              )
            ]),
          ),
          Column(
            children: [
              const Text("Valid Up To",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(availableVacation.formattedExpirationDate!)
            ],
          )
        ]));
  }

  Widget? actionButton() {
    if(widget.email != GoogleService().getAccount().email) {
      return null;
    }

    return FloatingActionButton(
        onPressed: () => navigateToPage(context, const VacationAppRequestVacation()).then((value){
          setState(() => loading = true);
          _loadData();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Vacation has been requested")
          ));
        }),
        child: const Icon(Icons.add)
    );
  }

  void _loadData() async {
    employee = await VacationAppService().getEmployee(widget.email);
    setState(() => loading = false);
  }
}
