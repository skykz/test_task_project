import 'dart:convert';

MenuRestaurant menuRestaurantFromJson(String str) =>
    MenuRestaurant.fromJson(json.decode(str));

String menuRestaurantToJson(MenuRestaurant data) => json.encode(data.toJson());

class MenuRestaurant {
  MenuRestaurant({
    this.categories,
    this.restaurant,
  });

  List<MenuCategory> categories;
  SubRestaurant restaurant;

  factory MenuRestaurant.fromJson(Map<String, dynamic> json) => MenuRestaurant(
        categories: List<MenuCategory>.from(
            json["categories"].map((x) => MenuCategory.fromJson(x))),
        restaurant: SubRestaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "restaurant": restaurant.toJson(),
      };
}

class MenuCategory {
  MenuCategory({
    this.id,
    this.name,
    this.dishes,
  });

  int id;
  String name;
  List<Dish> dishes;

  factory MenuCategory.fromJson(Map<String, dynamic> json) => MenuCategory(
        id: json["id"],
        name: json["name"],
        dishes: List<Dish>.from(json["dishes"].map((x) => Dish.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dishes": List<dynamic>.from(dishes.map((x) => x.toJson())),
      };
}

class Dish {
  Dish({
    this.id,
    this.title,
    this.image,
    this.price,
    this.portionWeight,
    this.description,
    this.category,
    this.restaurant,
    this.additives,
    this.extra,
  });

  int id;
  String title;
  String image;
  int price;
  int portionWeight;
  String description;
  List<DishCategory> category;
  Title restaurant;
  List<Additive> additives;
  List<dynamic> extra;

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        price: json["price"],
        portionWeight: json["portionWeight"],
        description: json["description"],
        category: List<DishCategory>.from(
            json["category"].map((x) => DishCategory.fromJson(x))),
        restaurant: titleValues.map[json["restaurant"]],
        additives: List<Additive>.from(
            json["additives"].map((x) => Additive.fromJson(x))),
        extra: List<dynamic>.from(json["extra"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "price": price,
        "portionWeight": portionWeight,
        "description": description,
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "restaurant": titleValues.reverse[restaurant],
        "additives": List<dynamic>.from(additives.map((x) => x.toJson())),
        "extra": List<dynamic>.from(extra.map((x) => x)),
      };
}

class Additive {
  Additive({
    this.id,
    this.name,
    this.addPrice,
    this.active,
  });

  int id;
  String name;
  int addPrice;
  bool active;

  factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        id: json["id"],
        name: json["name"],
        addPrice: json["addPrice"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "addPrice": addPrice,
        "active": active,
      };
}

class DishCategory {
  DishCategory({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory DishCategory.fromJson(Map<String, dynamic> json) => DishCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

enum Title { CAMELIA, DVORIK }

final titleValues =
    EnumValues({"Camelia": Title.CAMELIA, "Dvorik": Title.DVORIK});

class SubRestaurant {
  SubRestaurant({
    this.id,
    this.title,
    this.logo,
    this.image,
    this.worksFrom,
    this.worksTo,
    this.minOrder,
    this.freeOrder,
    this.address,
    this.delivery,
    this.deliveryTime,
    this.maxDeliverDist,
    this.info,
    this.feedbacksAmount,
    this.rating,
  });

  int id;
  Title title;
  String logo;
  String image;
  String worksFrom;
  String worksTo;
  int minOrder;
  dynamic freeOrder;
  String address;
  int delivery;
  int deliveryTime;
  int maxDeliverDist;
  String info;
  int feedbacksAmount;
  dynamic rating;

  factory SubRestaurant.fromJson(Map<String, dynamic> json) => SubRestaurant(
        id: json["id"],
        title: titleValues.map[json["title"]],
        logo: json["logo"],
        image: json["image"],
        worksFrom: json["worksFrom"],
        worksTo: json["worksTo"],
        minOrder: json["minOrder"],
        freeOrder: json["freeOrder"],
        address: json["address"],
        delivery: json["delivery"],
        deliveryTime: json["deliveryTime"],
        maxDeliverDist: json["maxDeliverDist"],
        info: json["info"],
        feedbacksAmount: json["feedbacksAmount"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": titleValues.reverse[title],
        "logo": logo,
        "image": image,
        "worksFrom": worksFrom,
        "worksTo": worksTo,
        "minOrder": minOrder,
        "freeOrder": freeOrder,
        "address": address,
        "delivery": delivery,
        "deliveryTime": deliveryTime,
        "maxDeliverDist": maxDeliverDist,
        "info": info,
        "feedbacksAmount": feedbacksAmount,
        "rating": rating,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
