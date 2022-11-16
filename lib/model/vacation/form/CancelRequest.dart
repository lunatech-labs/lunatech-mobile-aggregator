class CancelRequest {
  String? reason;

  CancelRequest({this.reason});

  Map<String, dynamic> toJson() {
    return {
      "reason": reason ?? "",
    };
  }
}