class EmployeeDetail {
  EmployeeDetail({
    this.id,
    this.email,
    this.name,
    this.fullTime,
    this.isAdmin,
    this.totalNumberOfDays,
    this.vacationRows = const [],
    this.vacationRequests = const [],
  });

  String? id;
  String? email;
  String? name;
  String? fullTime;
  String? isAdmin;
  String? totalNumberOfDays;
  List<PastVacation> vacationRows = [];
  List<RequestedVacation> vacationRequests = [];

  EmployeeDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    fullTime = json['fullTime'];
    isAdmin = json['isAdmin'];
    totalNumberOfDays = json['totalNumberOfDays'];
    json['vacationRows'].forEach((v) {
      vacationRows.add(PastVacation.fromJson(v));
    });
    json['vacationRequests'].forEach((v) {
      vacationRequests.add(RequestedVacation.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    map['fullTime'] = fullTime;
    map['isAdmin'] = isAdmin;
    map['totalNumberOfDays'] = totalNumberOfDays;
    map['vacationRows'] = vacationRows.map((v) => v.toJson()).toList() ?? [];
    map['vacationRequests'] = vacationRequests.map((v) => v.toJson()).toList() ?? [];
    return map;
  }
}

class PastVacation {
  PastVacation({
    this.id,
    this.numberOfVacationDays,
    this.year,
    this.mandatory,
    this.expirationDate,
    this.employeeId,
  });

  PastVacation.fromJson(dynamic json) {
    id = json['id'];
    numberOfVacationDays = json['numberOfVacationDays'];
    year = json['year'];
    mandatory = json['mandatory'];
    expirationDate = json['expirationDate'];
    employeeId = json['employeeId'];
  }

  num? id;
  num? numberOfVacationDays;
  num? year;
  bool? mandatory;
  num? expirationDate;
  num? employeeId;

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
}

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
