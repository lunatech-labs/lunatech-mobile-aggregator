import 'package:intl/intl.dart';

import 'Dish.dart';

class Event {
  Event(
    this.menuUuid,
    this.menuPerDayUuid,
    this.name,
    this.date,
    this.location,
    this.attending,
    this.attendees,
    this.dishes,
    this.formattedDate,
  ) {
    formattedDate = _formatMillis(date);
  }

  String menuUuid;
  String menuPerDayUuid;
  String name;
  int date;
  String location;
  bool attending;
  int attendees;
  List<Dish> dishes;

  String formattedDate;

  Event.fromJson(Map<String, dynamic> json)
      : menuUuid = json['menuUuid'],
        menuPerDayUuid = json['menuPerDayUuid'],
        name = json['name'],
        date = json['date'],
        location = json['location'],
        attending = json['attending'],
        attendees = json['attendees'],
        dishes = (json['availableDishes'] as List).map((i) => Dish.fromJson(i)).toList(),
        formattedDate = _formatMillis(json['date']);

  Map<String, dynamic> toJson() {
    return {
      "menuUuid": menuUuid,
      "menuPerDayUuid": menuPerDayUuid,
      "name": name,
      "date": date,
      "location": location,
      "attending": attending,
      "attendees": attendees,
      "availableDishes": dishes.map((i) => i.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Event{name: $name}';
  }

  static String _formatMillis(int millis) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    DateFormat formatter = DateFormat("dd-MM-yyyy");
    return formatter.format(dateTime);
  }
}
