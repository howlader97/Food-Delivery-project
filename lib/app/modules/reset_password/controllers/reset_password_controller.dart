import 'package:al_khalifa/app/api_services/auth_api_services/auth_api_services.dart';
import 'package:al_khalifa/app/api_services/utility/urls.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:al_khalifa/app/widgets/showCustomSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  //TODO: Implement ResetPasswordController
  var isObSecure4 = true.obs;

  void togglePassVisibility() {
    isObSecure4.value = !isObSecure4.value;
  }
  var isObSecure5 = true.obs;

  void toggleConfirmPassVisibility() {
    isObSecure5.value = !isObSecure5.value;
  }

  bool resetPasswordInProgress=false;
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmPassController=TextEditingController();
  
  Future<void> getResetPassword()async{
    resetPasswordInProgress=true;
    update();
    final email=await SharedPrefServices.getUserEmail();
    final otp=await SharedPrefServices.getUserOtp();
    try{
      final response=await AuthApiServices.resetPasswordRequest(Urls.resetPassword, <String,dynamic>{
        "email": email,
        "otp": otp,
        "password": passwordController.text.trim(),
      });
      if(response.statusCode == 200){
        showCustomSnackbar(context: Get.context!, title: 'success', message: "Password reset successfully.",backgroundColor: Colors.green);
        //Get.snackbar('Success', 'Password reset successfully.',backgroundColor:Colors.green.shade100);
        Get.toNamed(Routes.LOGIN);
      }else{
        showCustomSnackbar(context: Get.context!, title: 'Failed', message: '${response.body}', backgroundColor: Colors.red.shade400,);
       // Get.snackbar('Failed', '${response.body}',backgroundColor:Colors.red.shade400);
      }
    }catch(e){
      resetPasswordInProgress=false;
      update();
      showCustomSnackbar(context: Get.context!, title: 'Error', message: 'Something went wrong: ${e.toString()}',);
     // Get.snackbar('Error', 'Something went wrong: ${e.toString()}');
    }
  }
}
