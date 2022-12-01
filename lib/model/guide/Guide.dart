

import 'GuideItem.dart';

class Guide {
  String name;
  String id;
  Map<int, GuideItem> items;

  Guide({required this.name, required this.id}):
    items = {};

  Guide.fromJson(Map<String, dynamic> json):
    name = json['name'],
    id = json['id'],
    items = { for (var item in (json['data'] as List<dynamic>)
        .map(GuideItem.fromJson)) item.id : item };



}
