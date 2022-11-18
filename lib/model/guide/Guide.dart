

import 'GuideItem.dart';

class Guide {
  String name;
  String id;
  List<GuideItem> items;

  Guide({required this.name, required this.id}):
    items = List<GuideItem>.empty();

  Guide.fromJson(Map<String, dynamic> json):
    name = json['name'],
    id = json['id'],
    items = (json['data'] as List<dynamic>)
        .map(GuideItem.fromJson).toList();


}
