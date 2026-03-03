import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../modules/checkout/model/order_model.dart';
import '../../shared_prerf_services/shared_pref_services.dart';
import '../utility/urls.dart';

class OrderService {
  // Change return type to be more specific
  Future<bool> postOrder(OrderRequest orderRequest) async {
    String? token = await SharedPrefServices.getUserToken();
    // Check if token exists
    if (token == null || token.isEmpty) {
      throw Exception('User not authenticated');
    }
    try {
      final response = await http.post(
        Uri.parse(Urls.order),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(orderRequest.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return true; // Return the response data
      } else {
        // Provide more detailed error information
        throw Exception(
          'Failed to post order: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting order: $e');
    }
  }
}
