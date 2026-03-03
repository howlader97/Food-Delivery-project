import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
   ResetPasswordView({super.key});
final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Form(
        key: _globalKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  children: [
                     SizedBox(height: 140.h),
                    Text("Create New Password", style: AppTextStyles.medium32,textAlign: TextAlign.center,),
                     SizedBox(height: 12.h),
                    Center(
                      child: Text(
                        'Type and confirm a secure new password for your account',
                        textAlign: TextAlign.center,
                      ),
                    ),
                     SizedBox(height: 30.h),
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordController,
                        obscureText: controller.isObSecure4.value,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isObSecure4.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: controller.togglePassVisibility,
                          ),
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your password';
                          }
                          if (value!.length != 6) {
                            return 'Password must be six digit or letter';
                          }
                          return null;
                        },
                      ),
                    ),
                     SizedBox(height: 20.h),
                    Obx(
                      () => TextFormField(
                        controller: controller.confirmPassController,
                        obscureText: controller.isObSecure5.value,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isObSecure5.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: controller.toggleConfirmPassVisibility,
                          ),
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your password';
                          }
                          if (value!.length != 6) {
                            return 'Enter six digit or letter';
                          }
                          if (value != controller.passwordController.text) {
                            return 'password not matching';
                          }
                          return null;
                        },
                      ),
                    ),
                     SizedBox(height: 35.h),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<ResetPasswordController>(
                        builder: (resetController) {
                          if(resetController.resetPasswordInProgress){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if(_globalKey.currentState!.validate()){
                                resetController.getResetPassword();
                              }
                            },
                            child: Text("Confirm"),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
