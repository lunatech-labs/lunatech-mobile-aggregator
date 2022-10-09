import 'package:flutter/material.dart';
import 'package:flutter_apps/model/vacation/dto/EmployeeDetail.dart';
import 'package:flutter_apps/model/vacation/dto/RequestedVacation.dart';
import 'package:flutter_apps/model/vacation/form/CancelRequest.dart';
import 'package:flutter_apps/screens/vacation/VacationRequestForm.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';

class VacationRequestDetail extends StatefulWidget {
  const VacationRequestDetail(this.vacation, this.employeeEmail, {super.key});

  final RequestedVacation vacation;
  final String employeeEmail;

  @override
  State<StatefulWidget> createState() {
    return _VacationRequestDetailState();
  }
}

class _VacationRequestDetailState extends State<VacationRequestDetail> {
  bool _loading = false;
  late RequestedVacation vacation;

  @override
  void initState() {
    super.initState();
    vacation = widget.vacation;
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? LunatechLoading() : _body();
  }

  Widget _body() {
    return Scaffold(
      appBar: AppBar(title: const Text("Vacation App"), actions: _actions()),
      body: _content(),
    );
  }

  Widget _content() {
    return Center(
        child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("From: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(vacation.formattedFromDate!)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Until: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(vacation.formattedUntilDate!)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Days: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(vacation.days.toString())
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(vacation.status!)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Approved By: ",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(vacation.approvedBy ?? "")
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Reason: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(vacation.reason ?? "")
      ]),
    ]));
  }

  List<Widget> _actions() {
    return [
      PopupMenuButton<int>(
          itemBuilder: (context) => [
                const PopupMenuItem(value: 0, child: Text("Cancel")),
                const PopupMenuItem(value: 1, child: Text("Edit"))
              ],
          onSelected: (selected) {
            switch (selected) {
              case 0:
                _cancelRequest();
                break;
              case 1:
                _updateRequest();
            }
          })
    ];
  }

  void _cancelRequest() async {
    setState(() => _loading = true);
    await VacationAppService().cancelVacation(
        widget.employeeEmail, widget.vacation.id, CancelRequest());

    await _refreshVacation();
    setState(() => _loading = false);
  }

  void _updateRequest() async {
    setState(() => _loading = true);
    await navigateToPage(context, VacationRequestForm(widget.employeeEmail, vacation: vacation));
    await _refreshVacation();
    setState(() => _loading = false);
  }

  Future<void> _refreshVacation() async {
    EmployeeDetail employee =
        await VacationAppService().getEmployee(widget.employeeEmail);
    vacation = employee.vacationRequests
        .firstWhere((request) => request.id == vacation.id);
  }
}
