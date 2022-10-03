import 'package:flutter_apps/util/UtilMethods.dart';

class VacationRequest {
  String? email;
  DateTime? from;
  DateTime? until;
  VacationType? vacationType;

  VacationRequest({this.email, this.from, this.until, this.vacationType});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "from": formatDate(from!),
      "until": formatDate(until!),
      "vacationType": vacationType == VacationType.paid ? "PAID" : "UNPAID",
    };
  }
}

enum VacationType {
  paid, unpaid
}