import 'package:flutter/material.dart';
import 'package:flutter_apps/model/vacation/dto/RequestedVacation.dart';
import 'package:flutter_apps/model/vacation/form/UpdateRequest.dart';
import 'package:flutter_apps/model/vacation/form/VacationRequest.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';

import '../../model/vacation/vacation_type.dart';

class VacationRequestForm extends StatefulWidget {
  const VacationRequestForm(this.employeeEmail, {super.key, this.vacation});

  final String employeeEmail;
  final RequestedVacation? vacation;

  @override
  State<StatefulWidget> createState() {
    return _VacationRequestFormStatus();
  }
}

class _VacationRequestFormStatus extends State<VacationRequestForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fromDateController = TextEditingController();
  TextEditingController untilDateController = TextEditingController();
  int radioValue = 0;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    fromDateController.text = widget.vacation?.formattedFromDate ?? "";
    untilDateController.text = widget.vacation?.formattedUntilDate ?? "";
    radioValue = widget.vacation?.vacationType == VacationType.unpaid ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LunatechLoading()
        : LunatechScaffold(
            appBar: AppBar(title: const Text("Vacation App")),
            floatingActionButton: actionButton(),
            body: body(),
          );
  }

  Widget body() {
    return Form(
        key: _formKey,
        child: SizedBox.expand(
          child: FractionallySizedBox(
            heightFactor: 0.85,
            widthFactor: 0.85,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black26)]
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [_fromField(), _untilField(), _typeOfVacationField()],
                ),
              ),
            ),
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
              dateFormField(fromDateController,
                  toDate: untilDateController.text.isNotEmpty
                      ? baseDateFormat.parse(untilDateController.text)
                      : null)
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
              dateFormField(untilDateController,
                  fromDate: fromDateController.text.isNotEmpty
                      ? baseDateFormat.parse(fromDateController.text)
                      : null)
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

            if(widget.vacation == null) {
              _createVacationRequest();
            } else {
              _updateVacationRequest();
            }
          }
        });
  }

  void _createVacationRequest() {
    VacationRequest vacationRequest = VacationRequest(
        email: widget.employeeEmail,
        from: baseDateFormat.parse(fromDateController.text),
        until: baseDateFormat.parse(untilDateController.text),
        vacationType:
            radioValue == 0 ? VacationType.paid : VacationType.unpaid);

    VacationAppService()
        .requestVacation(vacationRequest)
        .then((response) {
      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Vacation has been requested")));
      } else {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Vacation Request Failed")));
      }
    });
  }

  void _updateVacationRequest() {
    UpdateRequest vacationRequest = UpdateRequest(
        newFrom: baseDateFormat.parse(fromDateController.text),
        newUntil: baseDateFormat.parse(untilDateController.text),
        vacationType:
        radioValue == 0 ? VacationType.paid : VacationType.unpaid);

    VacationAppService()
        .updateVacation(widget.employeeEmail, widget.vacation!.id, vacationRequest)
        .then((response) {
      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Vacation has been updated")));
      } else {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Vacation Request Failed")));
      }
    });
  }

  TextFormField dateFormField(TextEditingController controller,
      {DateTime? fromDate, DateTime? toDate}) {
    DateTime? initialDate = controller.text.isNotEmpty
        ? baseDateFormat.parse(controller.text)
        : null;

    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
            icon: Icon(Icons.calendar_month,
                color: Theme.of(context).colorScheme.secondary),
            enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.secondary)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary))),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate ?? fromDate ?? DateTime.now(),
              firstDate: fromDate ?? DateTime.now(),
              lastDate: toDate ?? DateTime.now().add(const Duration(days: 365)),
              builder: ((context, child) {
                final themeData = Theme.of(context);
                return Theme(
                    data: themeData.copyWith(
                        colorScheme: themeData.colorScheme.copyWith(
                            onPrimary: themeData.brightness == Brightness.dark ? Colors.black : Colors.white,
                            primary: themeData.brightness == Brightness.dark ? Colors.white : themeData.colorScheme.secondary),
                        textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                          foregroundColor: themeData.colorScheme.secondary, // button text color
                        ))),
                    child: child!);
              }));

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
