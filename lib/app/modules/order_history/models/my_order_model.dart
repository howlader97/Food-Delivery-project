class OrderDetailsModel {
  final int id;
  final double totalAmount;
  final String phoneNumber;
  final String deliveryAddress;
  final String deliveryFullAddress;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final List<OrderItem> orderItems;

  OrderDetailsModel({
    required this.id,
    required this.totalAmount,
    required this.phoneNumber,
    required this.deliveryAddress,
    required this.deliveryFullAddress,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.orderItems,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      phoneNumber: json['phone_number'] ?? '',
      deliveryAddress: json['delivery_address'] ?? '',
      deliveryFullAddress: json['delivery_full_address'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: User.fromJson(json['user']),
      orderItems: (json['order_items'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class User {
  final String firstName;
  final String lastName;
  final String email;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class OrderItem {
  final int id;
  final Food food;
  final Variation variation;

  OrderItem({required this.id, required this.food, required this.variation});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      food: Food.fromJson(json['food']),
      variation: Variation.fromJson(json['variation'])
    );
  }
}

class Food {
  final String name;
  final String description;
  final String foodImageUrl;
  final double price;
  final int? perPerson;
  final int categoryId;

  Food({
    required this.name,
    required this.description,
    required this.foodImageUrl,
    required this.price,
    this.perPerson,
    required this.categoryId,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      foodImageUrl: json['food_image_url'] ?? '',
      price: (json['price'] as num).toDouble(),
      perPerson: json['per_person'],
      categoryId: json['category_id'],
    );
  }
}

class Variation {
  final int id;
  final String name;
  final double price;

  Variation({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      id: json['id'],
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
    );
  }
}