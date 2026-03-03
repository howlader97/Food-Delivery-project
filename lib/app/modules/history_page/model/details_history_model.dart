class DetailsHistoryModel {
  final double totalAmount;
  final String phoneNumber;
  final String deliveryAddress;
  final String deliveryFullAddress;
  final int id;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel? user;
  final List<OrderItemModel> orderItems;

  DetailsHistoryModel({
    required this.totalAmount,
    required this.phoneNumber,
    required this.deliveryAddress,
    required this.deliveryFullAddress,
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    required this.orderItems,
  });

  factory DetailsHistoryModel.fromJson(Map<String, dynamic> json) {
    return DetailsHistoryModel(
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      phoneNumber: json['phone_number'] ?? '',
      deliveryAddress: json['delivery_address'] ?? '',
      deliveryFullAddress: json['delivery_full_address'] ?? '',
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      orderItems: json['order_items'] != null
          ? (json['order_items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_amount': totalAmount,
      'phone_number': phoneNumber,
      'delivery_address': deliveryAddress,
      'delivery_full_address': deliveryFullAddress,
      'id': id,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user?.toJson(),
      'order_items': orderItems.map((e) => e.toJson()).toList(),
    };
  }
}

class UserModel {
  final String firstName;
  final String lastName;
  final String email;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}

class OrderItemModel {
  final int id;
  final FoodModel? food;

  OrderItemModel({
    required this.id,
    this.food,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? 0,
      food: json['food'] != null ? FoodModel.fromJson(json['food']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food': food?.toJson(),
    };
  }
}

class FoodModel {
  final int id; //change id
  final String name;
  final String description;
  final String foodImageUrl;
  final double price;
  final String? perPerson;
  final int categoryId;

  FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.foodImageUrl,
    required this.price,
    this.perPerson,
    required this.categoryId,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id']??-1,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      foodImageUrl: json['food_image_url'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      perPerson: json['per_person'],
      categoryId: json['category_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'food_image_url': foodImageUrl,
      'price': price,
      'per_person': perPerson,
      'category_id': categoryId,
    };
  }
}
