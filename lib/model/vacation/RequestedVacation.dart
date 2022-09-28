class RequestedVacation {
  RequestedVacation({
    this.id,
    this.fromDate,
    this.untilDate,
    this.status,
    this.secretCode,
    this.approvedBy,
    this.reason,
    this.employeeId,
    this.days,
    this.oldDays,
    this.vacationType,});

  int? id;
  int? fromDate;
  int? untilDate;
  String? status;
  String? secretCode;
  String? approvedBy;
  String? reason;
  int? employeeId;
  int? days;
  int? oldDays;
  String? vacationType;

  RequestedVacation.fromJson(dynamic json) {
    id = json['id'];
    fromDate = json['fromDate'];
    untilDate = json['untilDate'];
    status = json['status'];
    secretCode = json['secretCode'];
    approvedBy = json['approvedBy'];
    reason = json['reason'];
    employeeId = json['employeeId'];
    days = json['days'];
    oldDays = json['oldDays'];
    vacationType = json['vacationType'];
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
    map['vacationType'] = vacationType;
    return map;
  }
}
