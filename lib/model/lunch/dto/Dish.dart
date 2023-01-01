class Dish {
  Dish(
    this.uuid,
    this.name,
    this.description,
    this.isVegetarian,
    this.isHalal,
    this.hasSeaFood,
    this.hasPork,
    this.hasBeef,
    this.hasChicken,
    this.isGlutenFree,
    this.hasLactose,
  );

  String uuid;
  String name;
  String description;
  bool isVegetarian;
  bool isHalal;
  bool hasSeaFood;
  bool hasPork;
  bool hasBeef;
  bool hasChicken;
  bool isGlutenFree;
  bool hasLactose;

  Dish.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        description = json['description'],
        isVegetarian = json['isVegetarian'],
        isHalal = json['isHalal'],
        hasSeaFood = json['hasSeaFood'],
        hasPork = json['hasPork'],
        hasBeef = json['hasBeef'],
        hasChicken = json['hasChicken'],
        isGlutenFree = json['isGlutenFree'],
        hasLactose = json['hasLactose'];

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "name": name,
      "description": description,
      "isVegetarian": isVegetarian,
      "isHalal": isHalal,
      "hasSeaFood": hasSeaFood,
      "hasPork": hasPork,
      "hasBeef": hasBeef,
      "hasChicken": hasChicken,
      "isGlutenFree": isGlutenFree,
      "hasLactose": hasLactose,
    };
  }

  @override
  String toString() {
    return 'Dish{name: $name, description: $description}';
  }

  String dietaryEmojis() {
    // TODO refactor this to have its own methods?
    StringBuffer buffer = StringBuffer();
    if (isVegetarian) buffer.write("🌱");
    if (hasLactose) buffer.write("🥛");
    if (hasSeaFood) buffer.write("🦐");
    if (hasPork) buffer.write("🐷");
    if (hasBeef) buffer.write("🐮");
    if (hasChicken) buffer.write("🐔");
    if (isGlutenFree) buffer.write("🌾");
    if (isHalal) buffer.write("حلال");
    return buffer.toString();
  }
}
