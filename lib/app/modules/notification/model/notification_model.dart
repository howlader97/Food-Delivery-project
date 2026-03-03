import 'dart:convert';

class NotificationModel {
  final String title;
  final String content;
  final String image;
  final int id;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.title,
    required this.content,
    required this.image,
    required this.id,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  /// JSON → Model
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: json['image'] ?? '',
      id: json['id'] ?? 0,
      isRead: json['is_read'] ?? false,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  /// Model → JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'image': image,
      'id': id,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// JSON String → List<NotificationModel>
  static List<NotificationModel> listFromJson(String jsonStr) {
    final data = json.decode(jsonStr) as List;
    return data.map((e) => NotificationModel.fromJson(e)).toList();
  }
}
