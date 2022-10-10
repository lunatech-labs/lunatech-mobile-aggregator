import 'package:flutter/material.dart';

enum Status { requested, approved, rejected, updated, cancelled }

extension StatusExtension on Status {
  String get value {
    switch (this) {
      case Status.requested:
        return "Requested";
      case Status.approved:
        return "Approved";
      case Status.rejected:
        return "Rejected";
      case Status.updated:
        return "Updated";
      case Status.cancelled:
        return "Cancelled";
    }
  }

  Color get color {
    switch(this) {
      case Status.requested:
        return Colors.black12;
      case Status.approved:
        return Colors.green;
      case Status.rejected:
        return Colors.red;
      case Status.updated:
        return Colors.blue;
      case Status.cancelled:
        return Colors.black45;
    }
  }

  static Status? fromValue(String value){
    for(Status status in Status.values){
      if(status.value == value){
        return status;
      }
    }
    return null;
  }
}