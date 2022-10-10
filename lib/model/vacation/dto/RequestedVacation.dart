import 'package:flutter_apps/model/vacation/dto/status.dart';
import 'package:flutter_apps/model/vacation/vacation_type.dart';
import 'package:flutter_apps/util/UtilMethods.dart';

class RequestedVacation {
  RequestedVacation({
    required this.id,
    required this.fromDate,
    required this.untilDate,
    this.status,
    this.secretCode,
    this.approvedBy,
    this.reason,
    required this.employeeId,
    required this.days,
    this.oldDays,
    required this.vacationType,
  }) {
    formattedFromDate = _formatMillis(fromDate);
    formattedUntilDate = _formatMillis(untilDate);
  }

  int id;
  int fromDate;
  int untilDate;
  Status? status;
  String? secretCode;
  String? approvedBy;
  String? reason;
  int employeeId;
  int days;
  int? oldDays;
  VacationType vacationType;

  String? formattedFromDate;
  String? formattedUntilDate;

  RequestedVacation.fromJson(dynamic json)
      : id = json['id'],
        fromDate = json['fromDate'],
        untilDate = json['untilDate'],
        status = StatusExtension.fromValue(json['status']),
        secretCode = json['secretCode'],
        approvedBy = json['approvedBy'],
        reason = json['reason'],
        employeeId = json['employeeId'],
        days = json['days'],
        oldDays = json['oldDays'],
        vacationType = VacationTypeExtension.fromName(json['vacationType'])! {
    formattedFromDate = _formatMillis(fromDate);
    formattedUntilDate = _formatMillis(untilDate);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fromDate'] = fromDate;
    map['untilDate'] = untilDate;
    map['status'] = status;
    map['secretCode'] = secretCode;
    map['approvedBy'] = approvedBy;
    map['reason'] = reason;
    map['employeeId'] = employeeId;
    map['days'] = days;
    map['oldDays'] = oldDays;
    map['vacationType'] = vacationType.name;
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
