class VacationRequest {
  String? email;
  DateTime? from;
  DateTime? until;
  VacationType? vacationType;

  VacationRequest(this.email, this.from, this.until, this.vacationType);
}

enum VacationType {
  PAID, UNPAID
}