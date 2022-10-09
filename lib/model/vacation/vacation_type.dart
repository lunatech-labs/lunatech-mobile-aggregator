enum VacationType { paid, unpaid }

extension VacationTypeExtension on VacationType {
  String get name {
    switch (this) {
      case VacationType.paid:
        return "PAID";
      case VacationType.unpaid:
        return "UNPAID";
    }
  }

  static VacationType? fromName(String name) {
    switch (name) {
      case "PAID":
        return VacationType.paid;
      case "UNPAID":
        return VacationType.unpaid;
    }
    return null;
  }
}
