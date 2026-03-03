import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class SearchApiServices{
  static Future<http.Response> searchApiRequest(String url)async{
    String? token=await SharedPrefServices.getUserToken();
    if(token == null){
      Get.toNamed(Routes.LOGIN);
    }
    try{
      final response= await http.get(Uri.parse(url),headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });
      print(response.body);
      return response;
    }catch(e){
      throw 'Error is $e';
    }
  }
}