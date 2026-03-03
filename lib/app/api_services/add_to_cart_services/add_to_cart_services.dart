import 'dart:convert';

import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddToCartServices {
  static Future<dynamic> addToCartServices(
    String url,
    Map<String, dynamic> body,
  ) async {
    String? token = await SharedPrefServices.getUserToken();
    if (token == null) {
      Get.toNamed(Routes.LOGIN);
    }
    try {
      final response = http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw 'Add to cart Request Failed $e';
    }
  }
}
