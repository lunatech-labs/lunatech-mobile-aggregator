import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/LunatechLoading.dart';

LunatechLoading showLoadingScreen(BuildContext context) {
  const loadingScreen = LunatechLoading();
  Navigator.of(context).push(PageRouteBuilder(
      opaque: false, pageBuilder: (a, b, c) => loadingScreen));

  return loadingScreen;
}

Future<dynamic> navigateToPage(BuildContext context, Widget widget, {removeStash = false}){
  if(removeStash) {
    return Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => widget), (route) => false);
  } else {
    return Navigator.push(
        context, MaterialPageRoute(builder: (_) => widget));
  }
}

final DateFormat baseDateFormat = DateFormat("dd-MM-yyyy");

formatDate(DateTime dateTime){
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  return dateFormat.format(dateTime);
}

String keepOrShortenString(String value, int length) =>
    value.length < length ? value : "${value.substring(0, length-2)}...";