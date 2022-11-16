import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_apps/model/vacation/dto/AvailableVacation.dart';
import 'package:flutter_apps/model/vacation/dto/EmployeeDetail.dart';
import 'package:flutter_apps/model/vacation/dto/RequestedVacation.dart';
import 'package:flutter_apps/model/vacation/dto/VacationLog.dart';
import 'package:flutter_apps/model/vacation/dto/status.dart';
import 'package:flutter_apps/model/vacation/form/VacationRequest.dart';
import 'package:flutter_apps/screens/vacation/VacationRequestDetail.dart';
import 'package:flutter_apps/screens/vacation/VacationRequestForm.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechBackground.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';

import '../../model/vacation/form/CancelRequest.dart';
import '../../services/GoogleService.dart';

class EmployeeDetailPage extends StatefulWidget {
  const EmployeeDetailPage({super.key, required this.email});

  final String email;

  @override
  State<StatefulWidget> createState() {
    return EmployeeDetailState();
  }
}

class EmployeeDetailState extends State<EmployeeDetailPage> with TickerProviderStateMixin {
  EmployeeDetail? employee;
  int? logsYear;
  List<bool> expandedVacationsRequests = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _loadData());
    _tabController = TabController(vsync: this, length: 3);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LunatechScaffold(
        appBar: AppBar(title: const Text("Vacation App")),
        floatingActionButton: actionButton(),
        body: body());
  }

  Widget body() {
    return Column(children: [overview(), tabView()]);
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
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(employee?.name ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                Text(employee?.email ?? "",
                    style: const TextStyle(fontSize: 14, color: Colors.grey))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Remaining Days"),
                Text(employee?.totalNumberOfDays ?? "",
                    style: const TextStyle(color: Colors.green))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget tabView() {
    Color tabsColor = Theme.of(context).colorScheme.secondary;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(color: Colors.white),
        child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: TabBar(tabs: [
                    Tab(child: Text("Requested", style: TextStyle(color: tabsColor))),
                    Tab(child: Text("Passed", style: TextStyle(color: tabsColor))),
                    Tab(child: Text("Available", style: TextStyle(color: tabsColor)))
                  ], indicatorColor: tabsColor, controller: _tabController),
                ),
                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: [vacationRequests(), pastVacations(), availableVacations()]),
                )
              ],
            )),
      ),
    );
  }

  // Requestedd vacations
  Widget vacationRequests() {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        elevation: 1,
        expansionCallback: (int index, bool isExpanded) =>
          setState(() => expandedVacationsRequests[index] = !expandedVacationsRequests[index]),
        children: employee?.vacationRequests.asMap().entries
            .map((entry) => vacationRequest(entry.value, expandedVacationsRequests[entry.key]))
            .toList() ?? []
      ),
    );
  }

  ExpansionPanel vacationRequest(RequestedVacation vacationRequest, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: vacationRequestHeader(vacationRequest)),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: vacationRequestBody(vacationRequest),
      ),
      isExpanded: expanded
    );
  }

  Widget vacationRequestHeader(RequestedVacation vacationRequest) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
    width: 120,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("From: ",
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                Text(vacationRequest.formattedFromDate!,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.grey))
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Until: ",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold)),
              Text(vacationRequest.formattedUntilDate!,
                  style: const TextStyle(
                      fontSize: 14, color: Colors.grey))
            ],
          )
        ]),
        ),
      Text(vacationRequest.status!.value,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: vacationRequest.status!.color))
      ]);
  }

  Widget vacationRequestBody(RequestedVacation vacationRequest) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text("Approved By: ",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(vacationRequest.approvedBy ?? "")
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Reason: ",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(vacationRequest.reason ?? "")
        ],
      ),
      vacationRequest.status == Status.cancelled ? Container() : vacationRequestActions(vacationRequest)
    ]);
  }

  Widget vacationRequestActions(RequestedVacation vacationRequest) {
    Color buttonsColor = Theme.of(context).colorScheme.secondary;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Expanded(
        child: IconButton(onPressed: () => _cancelRequest(vacationRequest),
          icon: Icon(Icons.delete, color: buttonsColor)
        ),
      ),
      Expanded(
        child: IconButton(onPressed: () => _updateRequest(vacationRequest),
          icon: Icon(Icons.edit, color: buttonsColor)
        ),
      )
    ]);
  }

  // Past Vacations
  Widget pastVacations() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(scrollDirection: Axis.horizontal,
            itemCount: employee!.vacationLogsYears.length,
            itemBuilder: (context, index) => TextButton(
                onPressed: () => setState(() => logsYear = employee!.vacationLogsYears[index]),
                child: Text(employee!.vacationLogsYears[index].toString()))
          ),
        ),
        Expanded(
          child: ListView.separated(
              itemCount: employee?.vacationLogs[logsYear]?.length ?? 0,
              itemBuilder: (context, index) =>
                  vacationLog(employee!.vacationLogs[logsYear]![index]),
              separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 0,
                thickness: 1,
              )),
        ),
      ],
    );
  }

  Widget vacationLog(VacationLog vacationLog) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 150,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("From date: ",
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(vacationLog.formattedFromDate ?? "",
                    style: const TextStyle(fontSize: 14, color: Colors.grey))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Number of days: ",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(vacationLog.numberOfVacationDays.toString(),
                      style: const TextStyle(fontSize: 14, color: Colors.grey))
                ],
              )
            ]),
          )
        ]));
  }

  // Available Vacations
  Widget availableVacations() {
    return ListView.separated(
        itemCount: employee?.vacationRows.length ?? 0,
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

  // Service calls
  Widget? actionButton() {
    if (widget.email != GoogleService().getAccount().email) {
      return null;
    }

    return FloatingActionButton(
        onPressed: () =>
            navigateToPage(context, VacationRequestForm(widget.email))
                .then((value) => _loadData()),
        child: const Icon(Icons.add));
  }

  void _loadData() async {
    final loadingScreen = showLoadingScreen(context);
    employee = await VacationAppService().getEmployee(widget.email);

    logsYear = employee!.vacationLogsYears.last;
    expandedVacationsRequests = employee!.vacationRequests.map((e) => false).toList();

    if (!mounted) return;
    loadingScreen.stopLoading(context);
    setState(() {});
  }

  void _cancelRequest(RequestedVacation requestedVacation) async {
    final loadingScreen = showLoadingScreen(context);
    await VacationAppService().cancelVacation(
        widget.email, requestedVacation.id, CancelRequest());

    if (!mounted) return;
    loadingScreen.stopLoading(context);

    _loadData();
  }

  void _updateRequest(RequestedVacation requestedVacation) async {
    final loadingScreen = showLoadingScreen(context);
    await navigateToPage(
        context, VacationRequestForm(widget.email, vacation: requestedVacation));

    if (!mounted) return;
    loadingScreen.stopLoading(context);

    _loadData();
  }
}
