import 'dart:async';

import 'package:al_khalifa/app/api_services/auth_api_services/auth_api_services.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:al_khalifa/app/widgets/showCustomSnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api_services/utility/urls.dart';
import '../../../routes/app_pages.dart';

class SignupOtpController extends GetxController {
    bool otpInProgress=false;
    final TextEditingController otpTEController=TextEditingController();

    Future<void> getOtpVerification()async{
      otpInProgress=true;
      update();
      final email= await SharedPrefServices.getUserEmail();
      try{
        final response=await AuthApiServices.signUpOtpRequest(Urls.otpSignUp, <String,dynamic>{
          "email": email,
          "otp": otpTEController.text.trim()
        });
        otpInProgress=false;
        update();
        print(response.statusCode.toString());
        print(response.body);
        if(response.statusCode == 200){
          showCustomSnackbar(context: Get.context!, title: 'Success', message: 'Otp Verification Successful', backgroundColor: Colors.green,);
         // Get.snackbar('Success', "Otp Verification Successful",backgroundColor: Colors.green.shade100);
          Get.toNamed(Routes.LOGIN);
        }else{
          showCustomSnackbar(context: Get.context!, title: 'Failed', message: '${response.body}', backgroundColor: Colors.red.shade400,);
         // Get.snackbar("Error", '${response.body}',backgroundColor: Colors.red.shade400);
        }
      }catch(e){
        otpInProgress=false;
        update();
        showCustomSnackbar(context: Get.context!, title: 'Error', message: 'Something went wrong: ${e.toString()}',);
        //Get.snackbar('Error', 'Something went wrong: ${e.toString()}');
      }
    }


    int remainingSecond = 0;
    Timer? _timer;
    bool canToResend = true;


    void startToTimer() {
      canToResend = false;
      remainingSecond = 59;
      update();

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingSecond == 0) {
          canToResend = true;
          timer.cancel();
        } else {
          remainingSecond--;
        }
        update();
      });
    }

    Future<void> resendOtp() async {
      if (!canToResend) return;
      try {
        final savedEmail = await SharedPrefServices.getUserEmail();
        final response = await AuthApiServices.emailVerifyRequest(
          Urls.emailVerify,
          {"email": savedEmail},
        );
        if (response.statusCode == 200) {
          Get.snackbar('Success', 'OTP resent successfully');
          startToTimer();
        } else {
          Get.snackbar('Failed', '${response.body}');
        }
      } catch (e) {
        Get.snackbar('Error', 'Resend failed: ${e.toString()}');
      }
    }

    @override
    void onClose() {
      _timer?.cancel();
      super.onClose();
    }
}
