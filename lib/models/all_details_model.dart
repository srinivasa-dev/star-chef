


class AllDetailsModel {
  List<Dishes>? dishes;
  List<PopularDishes>? popularDishes;

  AllDetailsModel({this.dishes, this.popularDishes});

  AllDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['dishes'] != null) {
      dishes = <Dishes>[];
      json['dishes'].forEach((v) {
        dishes!.add(Dishes.fromJson(v));
      });
    }
    if (json['popularDishes'] != null) {
      popularDishes = <PopularDishes>[];
      json['popularDishes'].forEach((v) {
        popularDishes!.add(PopularDishes.fromJson(v));
      });
    }
  }
}

class Dishes {
  String? name;
  double? rating;
  String? description;
  List<String>? equipments;
  String? image;
  int? id;

  Dishes(
      {this.name,
        this.rating,
        this.description,
        this.equipments,
        this.image,
        this.id});

  Dishes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rating = json['rating'];
    description = json['description'];
    equipments = json['equipments'].cast<String>();
    image = json['image'];
    id = json['id'];
  }
}

class PopularDishes {
  String? name;
  String? image;
  int? id;

  PopularDishes({this.name, this.image, this.id});

  PopularDishes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    id = json['id'];
  }
}
