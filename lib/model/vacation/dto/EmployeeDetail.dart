import 'AvailableVacation.dart';
import 'RequestedVacation.dart';

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
  List<AvailableVacation> vacationRows = [];
  List<RequestedVacation> vacationRequests = [];

  EmployeeDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    fullTime = json['fullTime'];
    isAdmin = json['isAdmin'];
    totalNumberOfDays = json['totalNumberOfDays'];
    json['vacationRows'].forEach((v) {
      vacationRows.add(AvailableVacation.fromJson(v));
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
