import 'package:intl/intl.dart';

class AvailableVacation {
  AvailableVacation({
    this.id,
    this.numberOfVacationDays,
    this.year,
    this.mandatory,
    this.expirationDate,
    this.employeeId,
  }){
    formattedExpirationDate = _formatMillis(expirationDate as int?);
  }

  num? id;
  num? numberOfVacationDays;
  num? year;
  bool? mandatory;
  num? expirationDate;
  num? employeeId;

  String? formattedExpirationDate;

  AvailableVacation.fromJson(dynamic json) {
    id = json['id'];
    numberOfVacationDays = json['numberOfVacationDays'];
    year = json['year'];
    mandatory = json['mandatory'];
    expirationDate = json['expirationDate'];
    employeeId = json['employeeId'];

    formattedExpirationDate = _formatMillis(expirationDate as int?);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['numberOfVacationDays'] = numberOfVacationDays;
    map['year'] = year;
    map['mandatory'] = mandatory;
    map['expirationDate'] = expirationDate;
    map['employeeId'] = employeeId;
    return map;
  }

  static String? _formatMillis(int? millis){
    if(millis != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
      DateFormat formatter = DateFormat("dd-MM-yyyy");
      return formatter.format(dateTime);
    }
    return null;
  }
}