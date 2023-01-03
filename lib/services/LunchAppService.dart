import 'dart:convert';

import 'package:flutter_apps/model/lunch/dto/Event.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:http/http.dart' as http;

class LunchAppService {
  static const String _lunchUrl = "lunch.lunatech.nl";
  static const Map<String, String> _defaultQueryParam = {};

  static LunchAppService? _appService;

  Future<String> token;

  LunchAppService._internal() : token = authenticate();

  factory LunchAppService() {
    _appService ??= LunchAppService._internal();
    return _appService!;
  }

  static Future<String> authenticate() async {
    var accessToken = await GoogleService().getAccessToken();
    var queryParameters = {"accessToken": accessToken};

    Uri uri = Uri.https(_lunchUrl, "/api/authenticate", queryParameters);
    var token = await http.post(uri).then((response) => response.body);
    return "Bearer $token";
  }

  Future<List<Event>> getEvents() {
    return _getRequest("/api/events")
        .then((response) => jsonDecode(response.body) as List<dynamic>)
        .then((json) => json.map((event) => Event.fromJson(event)).toList());
  }

  static logout() {
    _appService = null;
  }

  Future<http.Response> _getRequest(String endpoint, {Map<String, String> queryParams = _defaultQueryParam}) async {
    return token.then((token) => http.get(Uri.https(_lunchUrl, endpoint, queryParams), headers: {"Authorization": token}));
  }
}
