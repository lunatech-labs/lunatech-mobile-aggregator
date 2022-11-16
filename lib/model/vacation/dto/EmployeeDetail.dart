import 'AvailableVacation.dart';
import 'RequestedVacation.dart';
import 'VacationLog.dart';

class EmployeeDetail {
  EmployeeDetail(
      {required this.id,
      required this.email,
      required this.name,
      this.fullTime,
      required this.isAdmin,
      this.totalNumberOfDays,
      this.vacationRows = const [],
      this.vacationRequests = const [],
      this.vacationLogs = const {}});

  String id;
  String email;
  String name;
  String? fullTime;
  bool isAdmin;
  String? totalNumberOfDays;

  List<RequestedVacation> vacationRequests;
  List<AvailableVacation> vacationRows;
  Map<int, List<VacationLog>> vacationLogs;

  List<int> get vacationLogsYears {
    var years = vacationLogs.keys.toList();
    years.sort((a, b) => b.compareTo(a));
    return years;
  }

  EmployeeDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        name = json['name'],
        fullTime = json['fullTime'],
        isAdmin = json['isAdmin'] == "true",
        totalNumberOfDays = json['totalNumberOfDays'],
        vacationRows = (json['vacationRows'] as List<dynamic>)
            .map(AvailableVacation.fromJson).toList(),
        vacationRequests = (json['vacationRequests'] as List<dynamic>)
            .map(RequestedVacation.fromJson).toList(),
        vacationLogs = {
          for (var v in json['vacationLogs'] as List<dynamic>)
            v[0]: (v[1] as List<dynamic>).map(VacationLog.fromJson).toList()
        };

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    map['fullTime'] = fullTime;
    map['isAdmin'] = isAdmin;
    map['totalNumberOfDays'] = totalNumberOfDays;
    map['vacationRows'] = vacationRows.map((v) => v.toJson()).toList() ?? [];
    map['vacationRequests'] =
        vacationRequests.map((v) => v.toJson()).toList() ?? [];
    return map;
  }
}
