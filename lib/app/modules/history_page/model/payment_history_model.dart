class PaymentHistoryModel {
  final int id;
  final int userId;
  final int orderId;
  final double totalAmount;
  final String trxId;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentHistoryModel({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.totalAmount,
    required this.trxId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      trxId: json['trx_id'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'order_id': orderId,
      'total_amount': totalAmount,
      'trx_id': trxId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static List<PaymentHistoryModel> fromJsonList(List<dynamic> list) {
    return list.map((item) => PaymentHistoryModel.fromJson(item)).toList();
  }
}
