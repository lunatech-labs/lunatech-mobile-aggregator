import 'dart:convert';

import 'GoogleService.dart';
import 'package:http/http.dart' as http;

class WifiAppService {
  static const _wifiAppUrl = "10.0.2.2:9000";
  static final _wifiAppService = WifiAppService._internal();

  Future<String> wifiToken;

  WifiAppService._internal() : wifiToken = authenticate();

  factory WifiAppService() {
    return _wifiAppService;
  }

  Future<String> generateWifiPassword() {
    return wifiToken
        .then((token) => http.post(Uri.http(_wifiAppUrl, "/api/wifi"),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Authorization": token
            },
            encoding: Encoding.getByName('utf-8')))
        .then((response) => response.body);
  }

  static Future<String> authenticate() async {
    var accessToken = await GoogleService().getAccessToken();

    var token = await http
        .post(Uri.http(_wifiAppUrl, "/api/authenticate"),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
            },
            encoding: Encoding.getByName('utf-8'),
            body: {"accessToken": accessToken})
        .then((response) => response.body);

    return "Bearer $token";
  }
}
