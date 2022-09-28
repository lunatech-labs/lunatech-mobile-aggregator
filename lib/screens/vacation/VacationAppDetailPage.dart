import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/model/vacation/EmployeeDetail.dart';
import 'package:flutter_apps/services/VacationAppService.dart';

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
        body: Center(
            child: Text(
                loading ? "Loading..." : "Detail page for ${employee!.name}")
        )
    );
  }

  void _loadData() async {
    employee = await VacationAppService().getEmployee(widget.email);
    setState(() => loading = false);
  }
}
