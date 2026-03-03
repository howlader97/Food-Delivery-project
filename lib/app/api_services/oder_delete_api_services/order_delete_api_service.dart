import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderDeleteApiService{
  static Future<http.Response> orderDeleteApiRequest(String url) async {
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
      throw 'Order delete api Request failed $e';
    }
  }

}