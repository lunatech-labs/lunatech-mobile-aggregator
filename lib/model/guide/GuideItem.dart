class GuideItem {
  int id;
  String title;
  String detail;
  bool done;

  GuideItem({ required this.title, required this.detail, required this.id, this.done = false});


  GuideItem.fromJson(dynamic json):
    id = json['id'],
    title = json['title'],
    detail = json['detail'],
    done = json['done'] ?? false;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['detail'] = detail;
    map['done'] = done;
    return map;
  }
}