import 'dart:convert';

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
  Restaurant({
    this.open,
    this.closed,
  });

  List<Closed> open;
  List<Closed> closed;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        open: List<Closed>.from(json["open"].map((x) => Closed.fromJson(x))),
        closed:
            List<Closed>.from(json["closed"].map((x) => Closed.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "open": List<dynamic>.from(open.map((x) => x.toJson())),
        "closed": List<dynamic>.from(closed.map((x) => x.toJson())),
      };
}

class Closed {
  Closed({
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
  String title;
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

  factory Closed.fromJson(Map<String, dynamic> json) => Closed(
        id: json["id"],
        title: json["title"],
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
        "title": title,
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
