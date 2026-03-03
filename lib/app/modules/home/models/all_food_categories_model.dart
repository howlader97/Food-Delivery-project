import 'package:al_khalifa/app/modules/home/models/popular_food_item_model.dart';

class AllFoodCategoriesModel {
  final int id;
  final String name;
  final String description;
  final String categoryImageUrl;
  final List<Food> foods;
  final String createTime;
  final String updateTime;

  AllFoodCategoriesModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryImageUrl,
    required this.foods,
    required this.createTime,
    required this.updateTime,
  });

  factory AllFoodCategoriesModel.fromJson(Map<String, dynamic> json) {
    return AllFoodCategoriesModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categoryImageUrl: json['category_image_url'],
      foods: (json['foods'] as List)
          .map((food) => Food.fromJson(food))
          .toList(),
      createTime: json['create_time'],
      updateTime: json['update_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category_image_url': categoryImageUrl,
      'foods': foods.map((food) => food.toJson()).toList(),
      'create_time': createTime,
      'update_time': updateTime,
    };
  }
}

class Food {
  final int id;
  final String name;
  final String description;
  final String foodImageUrl;
  final double price;
  final FoodRatings foodRatings;
  final String createTime;
  final String updateTime;
  final List<Variation> variations;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.foodImageUrl,
    required this.price,
    required this.foodRatings,
    required this.createTime,
    required this.updateTime,
    required this.variations,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json["id"],
      name: json['name'],
      description: json['description'],
      foodImageUrl: json['food_image_url'],
      price: (json['price'] as num).toDouble(),
      foodRatings: FoodRatings.fromJson(json['food_ratings']),
      createTime: json['create_time'],
      updateTime: json['update_time'],
      variations: (json['variations'] as List)
          .map((v) => Variation.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'food_image_url': foodImageUrl,
      'price': price,
      'food_ratings': foodRatings.toJson(),
      'create_time': createTime,
      'update_time': updateTime,
      'variations': variations.map((v) => v.toJson()).toList(),
    };
  }
}

class FoodRatings {
  final double averageRating;

  FoodRatings({required this.averageRating});

  factory FoodRatings.fromJson(Map<String, dynamic> json) {
    return FoodRatings(
      averageRating: (json['average_rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average_rating': averageRating,
    };
  }
}

// class Variation {
//   final String name;
//   final double price;
//
//   Variation({
//     required this.name,
//     required this.price,
//   });
//
//   factory Variation.fromJson(Map<String, dynamic> json) {
//     return Variation(
//       name: json['name'],
//       price: (json['price'] as num).toDouble(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'price': price,
//     };
//   }
// }
