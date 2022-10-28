import 'package:flutter_apps/util/UtilMethods.dart';

class VacationLog {
  VacationLog({
    required this.id,
    required this.fromDate,
    required this.numberOfVacationDays,
    this.comment,
    required this.year,
    required this.employeeId,
    required this.togglEntryId,
  });

  VacationLog.fromJson(dynamic json)
      : id = json['id'],
        fromDate = json['fromDate'],
        numberOfVacationDays = json['numberOfVacationDays'],
        comment = json['comment'],
        year = json['year'],
        employeeId = json['employeeId'],
        togglEntryId = json['togglEntryId'];

  int id;
  int fromDate;
  num numberOfVacationDays;
  String? comment;
  int year;
  int employeeId;
  int togglEntryId;
  String? get formattedFromDate => _formatMillis(fromDate);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fromDate'] = fromDate;
    map['numberOfVacationDays'] = numberOfVacationDays;
    map['comment'] = comment;
    map['year'] = year;
    map['employeeId'] = employeeId;
    map['togglEntryId'] = togglEntryId;
    return map;
  }

  static String? _formatMillis(int? millis) {
    if (millis != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
      return formatDate(dateTime);
    }
    return null;
  }
}
