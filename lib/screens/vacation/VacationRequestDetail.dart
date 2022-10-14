import 'package:flutter/material.dart';
import 'package:flutter_apps/model/vacation/dto/EmployeeDetail.dart';
import 'package:flutter_apps/model/vacation/dto/RequestedVacation.dart';
import 'package:flutter_apps/model/vacation/dto/status.dart';
import 'package:flutter_apps/model/vacation/form/CancelRequest.dart';
import 'package:flutter_apps/screens/vacation/VacationRequestForm.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechBackground.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';

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
    return LunatechScaffold(
      appBar: AppBar(title: const Text("Vacation App"), actions: _actions()),
      body: _content(),
    );
  }

  Widget _content() {
    return LunatechBackground(
      child: SizedBox.expand(
        child: FractionallySizedBox(
          heightFactor: 0.8,
          widthFactor: 0.9,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [_daysSection(), _statusSection()])),
          ),
        ),
      ),
    );
  }

  Widget _daysSection() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        width: 120,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("From: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(vacation.formattedFromDate!)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Until: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(vacation.formattedUntilDate!)
              ],
            )
          ],
        ),
      ),
      Column(
        children: [
          Text(vacation.days.toString(),
              style:
                  const TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
          const Text("Days", style: TextStyle(fontWeight: FontWeight.bold))
        ],
      )
    ]);
  }

  Widget _statusSection() {
    return SizedBox(
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: vacation.status!.color,
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Center(
              child: Text(vacation.status!.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: vacation.status! == Status.requested
                          ? Colors.black
                          : Colors.white))),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Approved By: ",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(vacation.approvedBy ?? "")
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Reason: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(vacation.reason ?? "")
          ],
        )
      ]),
    );
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
    await navigateToPage(
        context, VacationRequestForm(widget.employeeEmail, vacation: vacation));
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
