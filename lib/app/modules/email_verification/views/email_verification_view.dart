import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/email_verification_controller.dart';

class EmailVerificationView extends GetView<EmailVerificationController> {
   EmailVerificationView({super.key});
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
                     SizedBox(height: 160.h),
                    Text("Recover Password", style: AppTextStyles.medium32),
                     SizedBox(height: 12.h),
                    Center(
                      child: Text(
                        'Enter the Email Address that you used when\nregister to recover your password, You will receive a\nVerification code.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                     SizedBox(height: 25.h),
                    TextFormField(
                      controller: controller.emailTEController,
                      decoration: InputDecoration(hintText: 'Enter your Email'),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your email address';
                        } else if (value?.isEmail == false) {
                          return 'Enter your valid email address';
                        }
                        return null;
                      },
                    ),
                     SizedBox(height: 35.h),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<EmailVerificationController>(
                        builder: (emailController) {
                          if(emailController.emailInProgress){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          return ElevatedButton(
                            onPressed: () {
                             if(_globalKey.currentState!.validate()){
                               emailController.getEmailVerify();
                             }
                            },
                            child: Text("submit"),
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
