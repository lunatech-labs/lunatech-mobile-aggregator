import 'package:flutter/material.dart';
import 'package:flutter_apps/model/vacation/VacationRequest.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';
import 'package:intl/intl.dart';

class VacationAppRequestVacation extends StatefulWidget {
  const VacationAppRequestVacation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RequestVacationStatus();
  }
}

class _RequestVacationStatus extends State<VacationAppRequestVacation> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fromDateController = TextEditingController();
  TextEditingController untilDateController = TextEditingController();
  int radioValue = 0;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? const LunatechLoading() : Scaffold(
      appBar: AppBar(title: const Text("Vacation App")),
      floatingActionButton: actionButton(),
      body: body(),
    );
  }

  Widget body() {
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [_fromField(), _untilField(), _typeOfVacationField()],
          ),
        ));
  }

  Widget _fromField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SizedBox(
          width: 250,
          child: Column(
            children: [
              const Text("From Date"),
              dateFormField(fromDateController)
            ],
          )),
    );
  }

  Widget _untilField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SizedBox(
          width: 250,
          child: Column(
            children: [
              const Text("Until Date"),
              dateFormField(untilDateController)
            ],
          )),
    );
  }

  _typeOfVacationField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SizedBox(
          width: 300,
          child: Column(
            children: [
              const Text("Vacation Type"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("PAID",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Radio(
                            value: 0,
                            groupValue: radioValue,
                            onChanged: (value) => setState(() {
                                  radioValue = value ?? 0;
                                })),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("UNPAID",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Radio(
                            value: 1,
                            groupValue: radioValue,
                            onChanged: (value) => setState(() {
                                  radioValue = value ?? 0;
                                })),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget actionButton() {
    return FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() => loading = true);

            VacationRequest vacationRequest = VacationRequest(
                email: GoogleService().getAccount().email,
                from: baseDateFormat.parse(fromDateController.text),
                until: baseDateFormat.parse(untilDateController.text),
                vacationType: radioValue == 0 ? VacationType.paid : VacationType.unpaid);

            VacationAppService().requestVacation(vacationRequest).then((response) {
              if (response.statusCode == 200) {
                Navigator.pop(context);
              } else {
                setState(() => loading = false);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Vacation Request Failed")
                ));
              }
            });
          }
        });
  }

  TextFormField dateFormField(TextEditingController controller) {
    return TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          icon: Icon(Icons.calendar_month),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)));

          if (pickedDate != null) {
            setState(() {
              controller.text = formatDate(pickedDate);
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Date is mandatory";
          }
          return null;
        });
  }
}
