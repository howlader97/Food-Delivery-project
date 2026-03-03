import 'dart:convert';

import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileApiServices{
  static Future<http.Response>  getProfileDataRequest(String url) async {
    String? token=await SharedPrefServices.getUserToken();
    if(token==null || token.isEmpty){
      Get.toNamed(Routes.LOGIN);
    }
    try{
      final response=await http.get(Uri.parse(url),headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer $token",
      });
      return response;
    }catch(e){
      throw ("Get All Request Menu Failed $e");
    }
  }

  static Future<http.Response> editProfileRequest(
      String url,
      Map<String, dynamic> body,
      ) async {
    String? token=await SharedPrefServices.getUserToken();
    if(token==null){
      Get.toNamed(Routes.LOGIN);
    }
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw ("Edit Profile Request Failed $e");
    }
  }

}

