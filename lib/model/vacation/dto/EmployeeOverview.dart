class EmployeeOverview {
  const EmployeeOverview(this.id, this.email, this.name, this.fullTime, this.isAdmin,
      this.totalDaysThisYear, this.approvedThisYear);

  final int id;
  final String email;
  final String name;
  final String fullTime;
  final bool isAdmin;
  final num totalDaysThisYear;
  final num approvedThisYear;

  EmployeeOverview.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"]),
        email = json["email"],
        name = json["name"],
        fullTime = json["fullTime"],
        isAdmin = json["isAdmin"] == "true",
        totalDaysThisYear = num.parse(json["totalDaysThisYear"]),
        approvedThisYear = num.parse(json["approvedThisYear"]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "fullTime": fullTime,
      "isAdmin": isAdmin,
      "totalDaysThisYear": totalDaysThisYear,
      "approvedThisYear": approvedThisYear,
    };
  }

  @override
  String toString() {
    return 'EmployeeList{name: $name}';
  }
}
