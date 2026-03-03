import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../modules/order_history/models/my_order_model.dart';
import '../../shared_prerf_services/shared_pref_services.dart';


class OrderService {

  static Future<OrderDetailsModel?> getOrderDetails() async {
    try {
      String? token = await SharedPrefServices.getUserToken();


      final response = await http.get(
        Uri.parse('https://khalifa.mtscorporate.com/orders/user/me/latest'),
          headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return OrderDetailsModel.fromJson(data);
      } else {
        print("❌ Failed to load order: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return null;
    }
  }
}

