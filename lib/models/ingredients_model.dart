


class IngredientsModel {
  String? name;
  int? id;
  String? timeToPrepare;
  Ingredients? ingredients;

  IngredientsModel({this.name, this.id, this.timeToPrepare, this.ingredients});

  IngredientsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    timeToPrepare = json['timeToPrepare'];
    ingredients = json['ingredients'] != null
        ? Ingredients.fromJson(json['ingredients'])
        : null;
  }
}

class Ingredients {
  List<Vegetables>? vegetables;
  List<Spices>? spices;
  List<Appliances>? appliances;

  Ingredients({this.vegetables, this.spices, this.appliances});

  Ingredients.fromJson(Map<String, dynamic> json) {
    if (json['vegetables'] != null) {
      vegetables = <Vegetables>[];
      json['vegetables'].forEach((v) {
        vegetables!.add(Vegetables.fromJson(v));
      });
    }
    if (json['spices'] != null) {
      spices = <Spices>[];
      json['spices'].forEach((v) {
        spices!.add(Spices.fromJson(v));
      });
    }
    if (json['appliances'] != null) {
      appliances = <Appliances>[];
      json['appliances'].forEach((v) {
        appliances!.add(Appliances.fromJson(v));
      });
    }
  }
}

class Vegetables {
  String? name;
  String? quantity;

  Vegetables({this.name, this.quantity});

  Vegetables.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
  }
}

class Appliances {
  String? name;
  String? image;

  Appliances({this.name, this.image});

  Appliances.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}

class Spices {
  String? name;
  String? quantity;

  Spices({this.name, this.quantity});

  Spices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
  }
}
