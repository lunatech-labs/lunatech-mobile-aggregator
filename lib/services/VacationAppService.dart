import 'dart:convert';

import 'package:flutter_apps/model/vacation/EmployeeDetail.dart';
import 'package:flutter_apps/model/vacation/EmployeeList.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:http/http.dart' as http;

class VacationAppService {
  static const String _vacationUrl = "vacation.lunatech.nl";
  static const Map<String, String> _defaultQueryParam = {};

  static final VacationAppService _vacationAppService = VacationAppService._internal();

  Future<String> vacationToken;

  VacationAppService._internal(): vacationToken = authenticate();

  factory VacationAppService() {
    return _vacationAppService;
  }

  static Future<String> authenticate() async {
    var accessToken = await GoogleService().getAccessToken();
    var queryParameters = {"accessToken": accessToken};

    Uri uri = Uri.https(_vacationUrl, "/api/authenticate", queryParameters);
    var token = await http.get(uri).then((response) => response.body);
    return "Bearer $token";
  }

  Future<List<EmployeeList>> getEmployees() async {
    return _buildRequest("/api/employees")
        .then((response) => jsonDecode(response.body) as List<dynamic>)
        .then((json) => json.map((employee) => EmployeeList.fromJson(employee)).toList());
  }

  Future<EmployeeDetail> getEmployee(String email) async {
    return _buildRequest("/api/employees/$email")
        .then((response) => jsonDecode(response.body) as Map<String, dynamic>)
        .then((json) => EmployeeDetail.fromJson(json));
  }

  Future<http.Response> _buildRequest(String endpoint,
      {Map<String, String> queryParams = _defaultQueryParam}) async {

    return vacationToken.then((token) => http.get(
        Uri.https(_vacationUrl, endpoint, queryParams),
        headers: {"Authorization": token}));
  }
}
