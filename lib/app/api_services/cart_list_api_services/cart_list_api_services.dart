import 'dart:convert';

import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartListApiServices {
  static Future<http.Response> cartListApiRequest(String url) async {
    String? token = await SharedPrefServices.getUserToken();
    if (token == null) {
      Get.toNamed(Routes.LOGIN);
    }
    try {
      final response =await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      throw 'Cart List api Request failed $e';
    }
  }

  static Future<http.Response> deleteCartApiRequest(String url) async {
    String? token = await SharedPrefServices.getUserToken();
    if (token == null) {
      Get.toNamed(Routes.LOGIN);
    }
    try {
      final response =await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      throw 'Cart List api Request failed $e';
    }
  }

  static Future<http.Response> decreaseCartItemRequest(String url)async{
    String? token=await SharedPrefServices.getUserToken();
    if(token == null){
      Get.toNamed(Routes.LOGIN);
    }
    try{
      final response=await http.post(Uri.parse(url),headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      );
      return response;
    }catch(e){
      throw 'api request failed $e';
    }
  }

  static Future<dynamic> increaseCartQtyService(
      String url,
      Map<String, dynamic> body,
      ) async {

    String? token = await SharedPrefServices.getUserToken();
    if (token == null) {
      Get.toNamed(Routes.LOGIN);
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw 'Increase quantity request failed $e';
    }
  }

}
