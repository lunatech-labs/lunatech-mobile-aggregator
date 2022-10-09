import 'package:flutter_apps/util/UtilMethods.dart';

import '../vacation_type.dart';

class VacationRequest {
  String email;
  DateTime from;
  DateTime until;
  VacationType vacationType;

  VacationRequest(
      {required this.email,
      required this.from,
      required this.until,
      required this.vacationType});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "from": formatDate(from),
      "until": formatDate(until),
      "vacationType": vacationType.name,
    };
  }
}