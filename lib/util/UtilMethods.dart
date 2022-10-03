import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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