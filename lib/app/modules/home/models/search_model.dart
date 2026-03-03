import 'dart:convert';

import 'package:al_khalifa/app/modules/home/models/popular_food_item_model.dart';

class SearchModel {
  final int id;
  final String name;
  final String description;
  final String foodImageUrl;
  final int price;
  final int categoryId;
  final Category category;
  final FoodRatings foodRatings;
  final DateTime createTime;
  final DateTime updateTime;
  final List<Variation> variations;

  SearchModel({
    required this.id,
    required this.name,
    required this.description,
    required this.foodImageUrl,
    required this.price,
    required this.categoryId,
    required this.category,
    required this.foodRatings,
    required this.createTime,
    required this.updateTime,
    required this.variations,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      foodImageUrl: json['food_image_url'] ?? '',
      price: _parsePrice(json['price']),
      categoryId: json['category_id'] ?? 0,
      category: Category.fromJson(json['category'] ?? {}),
      foodRatings: FoodRatings.fromJson(json['food_ratings'] ?? {}),
      createTime: DateTime.tryParse(json['create_time'] ?? '') ?? DateTime.now(),
      updateTime: DateTime.tryParse(json['update_time'] ?? '') ?? DateTime.now(),
      variations: (json['variations'] as List<dynamic>?)
          ?.map((v) => Variation.fromJson(v))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'food_image_url': foodImageUrl,
    'price': price,
    'category_id': categoryId,
    'category': category.toJson(),
    'food_ratings': foodRatings.toJson(),
    'create_time': createTime.toIso8601String(),
    'update_time': updateTime.toIso8601String(),
    'variations': variations.map((v) => v.toJson()).toList(),
  };

  static List<SearchModel> listFromJsonString(String jsonString) {
    final decoded = json.decode(jsonString) as List<dynamic>;
    return decoded.map((e) => SearchModel.fromJson(e)).toList();
  }

  static int _parsePrice(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString().split('.')[0]) ?? 0;
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'name': name};
}

class FoodRatings {
  final double averageRating;

  FoodRatings({required this.averageRating});

  factory FoodRatings.fromJson(Map<String, dynamic> json) {
    final val = json['average_rating'];
    if (val == null) return FoodRatings(averageRating: 0);
    return FoodRatings(averageRating: (val is num) ? val.toDouble() : double.tryParse(val.toString()) ?? 0);
  }

  Map<String, dynamic> toJson() => {'average_rating': averageRating};
}


