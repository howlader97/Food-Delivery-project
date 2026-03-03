class AllMenuModel {
  final String name;
  final double price;
  final String menuImage;
  final String menuItemList;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;

  AllMenuModel({
    required this.name,
    required this.price,
    required this.menuImage,
    required this.menuItemList,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create an instance from JSON
  factory AllMenuModel.fromJson(Map<String, dynamic> json) {
    return AllMenuModel(
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      menuImage: json['menu_image'] ?? '',
      menuItemList: json['menu_item_list'] ?? '',
      id: json['id'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Convert object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'menu_image': menuImage,
      'menu_item_list': menuItemList,
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Helper to parse a list of menus from JSON
  static List<AllMenuModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((e) => AllMenuModel.fromJson(e)).toList();
  }
}
