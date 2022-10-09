import 'package:flutter_apps/model/vacation/vacation_type.dart';
import 'package:flutter_apps/util/UtilMethods.dart';

class UpdateRequest {
  DateTime newFrom;
  DateTime newUntil;
  VacationType vacationType;

  UpdateRequest({required this.newFrom, required this.newUntil, required this.vacationType});

  Map<String, dynamic> toJson() {
    return {
      "newFrom": formatDate(newFrom),
      "newUntil": formatDate(newUntil),
      "vacationType": vacationType.name,
    };
  }
}