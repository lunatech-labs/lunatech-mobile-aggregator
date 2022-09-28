class PastVacation {
  PastVacation({
    this.id,
    this.numberOfVacationDays,
    this.year,
    this.mandatory,
    this.expirationDate,
    this.employeeId,
  });

  PastVacation.fromJson(dynamic json) {
    id = json['id'];
    numberOfVacationDays = json['numberOfVacationDays'];
    year = json['year'];
    mandatory = json['mandatory'];
    expirationDate = json['expirationDate'];
    employeeId = json['employeeId'];
  }

  num? id;
  num? numberOfVacationDays;
  num? year;
  bool? mandatory;
  num? expirationDate;
  num? employeeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['numberOfVacationDays'] = numberOfVacationDays;
    map['year'] = year;
    map['mandatory'] = mandatory;
    map['expirationDate'] = expirationDate;
    map['employeeId'] = employeeId;
    return map;
  }
}