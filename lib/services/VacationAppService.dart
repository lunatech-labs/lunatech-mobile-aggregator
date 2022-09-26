import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class VacationAppService {
  VacationAppService(this.authentication);

  static const String _vacationUrl = "vacation.lunatech.nl";

  final GoogleSignInAuthentication authentication;
  String? vacationToken;

  Future<void> authenticate() async {
    String accessToken = authentication.accessToken!;

    final queryParameters = {"accessToken": accessToken};
    Uri uri = Uri.https(_vacationUrl, "/api/authenticate", queryParameters);
    var token = await http.get(uri).then((response) => response.body);

    vacationToken = "Bearer $token";
  }

  Future<List<dynamic>> getEmployees() async {
    var request = http.get(Uri.https(_vacationUrl, "/api/employees"),
        headers: {"Authorization": vacationToken!});

    return request.then((value) => jsonDecode(value.body));
  }
}
