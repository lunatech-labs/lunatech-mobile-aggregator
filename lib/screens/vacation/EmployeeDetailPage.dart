import 'package:flutter/material.dart';
import 'package:flutter_apps/model/vacation/dto/EmployeeDetail.dart';
import 'package:flutter_apps/model/vacation/dto/AvailableVacation.dart';
import 'package:flutter_apps/model/vacation/dto/RequestedVacation.dart';
import 'package:flutter_apps/model/vacation/dto/status.dart';
import 'package:flutter_apps/screens/vacation/VacationRequestDetail.dart';
import 'package:flutter_apps/screens/vacation/VacationRequestForm.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechBackground.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';

import '../../services/GoogleService.dart';

class EmployeeDetailPage extends StatefulWidget {
  const EmployeeDetailPage({super.key, required this.email});

  final String email;

  @override
  State<StatefulWidget> createState() {
    return EmployeeDetailState();
  }
}

class EmployeeDetailState extends State<EmployeeDetailPage> {
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
    return LunatechBackground(child: Column(children: [overview(), tabView()]));
  }

  Widget overview() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Remaining Days"),
                Text(employee!.totalNumberOfDays!,
                    style: const TextStyle(color: Colors.green))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget tabView() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
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
                Expanded(
                  child: TabBarView(
                      children: [vacationRequests(), availableVacations()]),
                )
              ],
            )),
      ),
    );
  }

  Widget vacationRequests() {
    return ListView.separated(
        itemCount: employee!.vacationRequests.length,
        itemBuilder: (context, index) =>
            vacationRequest(employee!.vacationRequests[index]),
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 0,
              thickness: 1,
            ));
  }

  Widget vacationRequest(RequestedVacation vacationRequest) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => navigateToPage(
            context, VacationRequestDetail(vacationRequest, widget.email)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: 120,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Text(vacationRequest.status?.value ?? "Unknown")
          ]),
        ),
      ),
    );
  }

  Widget availableVacations() {
    return ListView.separated(
        itemCount: employee!.vacationRows.length,
        itemBuilder: (context, index) =>
            availableVacation(employee!.vacationRows[index]),
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 0, thickness: 1));
  }

  Widget availableVacation(AvailableVacation availableVacation) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 150,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Year: ",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(availableVacation.year!.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.grey))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Remaining Days: ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
    if (widget.email != GoogleService().getAccount().email) {
      return null;
    }

    return FloatingActionButton(
        onPressed: () =>
            navigateToPage(context, VacationRequestForm(widget.email))
                .then((value) {
              setState(() => loading = true);
              _loadData();
            }),
        child: const Icon(Icons.add));
  }

  void _loadData() async {
    employee = await VacationAppService().getEmployee(widget.email);
    setState(() => loading = false);
  }
}
