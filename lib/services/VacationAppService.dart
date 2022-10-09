import 'dart:convert';

import 'package:flutter_apps/model/vacation/dto/EmployeeDetail.dart';
import 'package:flutter_apps/model/vacation/dto/EmployeeOverview.dart';
import 'package:flutter_apps/model/vacation/form/CancelRequest.dart';
import 'package:flutter_apps/model/vacation/form/UpdateRequest.dart';
import 'package:flutter_apps/model/vacation/form/VacationRequest.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:http/http.dart' as http;

class VacationAppService {
  static const String _vacationUrl = "vacation.lunatech.nl";
  static const Map<String, String> _defaultQueryParam = {};

  static final VacationAppService _vacationAppService =
      VacationAppService._internal();

  Future<String> vacationToken;

  VacationAppService._internal() : vacationToken = authenticate();

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

  Future<List<EmployeeOverview>> getEmployees() async {
    return _buildRequest("/api/employees")
        .then((response) => jsonDecode(response.body) as List<dynamic>)
        .then((json) => json
            .map((employee) => EmployeeOverview.fromJson(employee))
            .toList());
  }

  Future<EmployeeDetail> getEmployee(String email) async {
    return _buildRequest("/api/employees/$email")
        .then((response) => jsonDecode(response.body) as Map<String, dynamic>)
        .then((json) => EmployeeDetail.fromJson(json));
  }

  Future<http.Response> requestVacation(VacationRequest vacationRequest) async {
    return vacationToken.then((token) => http.post(
        Uri.https(_vacationUrl, "api/requests"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": token
        },
        encoding: Encoding.getByName('utf-8'),
        body: vacationRequest.toJson()));
  }

  Future<http.Response> cancelVacation(String employeeEmail, int vacationId, CancelRequest cancelRequest) async {
    return vacationToken.then((token) => http.delete(
        Uri.https(_vacationUrl, "api/employees/$employeeEmail/requests/$vacationId"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": token
        },
        encoding: Encoding.getByName('utf-8'),
        body: cancelRequest.toJson()));
  }

  Future<http.Response> updateVacation(String employeeEmail, int vacationId, UpdateRequest updateRequest) async {
    return vacationToken.then((token) => http.put(
        Uri.https(_vacationUrl, "api/employees/$employeeEmail/requests/$vacationId"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": token
        },
        encoding: Encoding.getByName('utf-8'),
        body: updateRequest.toJson()));
  }

  Future<http.Response> _buildRequest(String endpoint,
      {Map<String, String> queryParams = _defaultQueryParam}) async {
    return vacationToken.then((token) => http.get(
        Uri.https(_vacationUrl, endpoint, queryParams),
        headers: {"Authorization": token}));
  }
}
