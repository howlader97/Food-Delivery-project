import 'package:al_khalifa/app/api_services/auth_api_services/auth_api_services.dart';
import 'package:al_khalifa/app/api_services/utility/urls.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class EmailVerificationController extends GetxController {
  bool emailInProgress=false;
  final TextEditingController emailTEController=TextEditingController();
  Future<void> getEmailVerify()async{
    emailInProgress=true;
    update();
    try{
      final response=await AuthApiServices.emailVerifyRequest(Urls.emailVerify,{
        "email": emailTEController.text.trim(),
      });
      emailInProgress=false;
      update();
      print(response.body);
      print(response.statusCode.toString());
      if(response.statusCode == 200){
       await SharedPrefServices.saveUserEmail(emailTEController.text);
        Get.snackbar('Success', "Email verification successful",backgroundColor: Colors.green.shade100);
        Get.toNamed(Routes.OTP);
      }else{
        Get.snackbar('Failed', '${response.body}',backgroundColor: Colors.red.shade400);
      }
    }catch(e){
      emailInProgress=false;
      update();
      Get.snackbar('Error', 'Something went wrong: ${e.toString()}');
    }
  }
}
