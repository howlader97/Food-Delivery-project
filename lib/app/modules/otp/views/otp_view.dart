import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  OtpView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  children: [
                    SizedBox(height: 160.h),
                    Text("Verification", style: AppTextStyles.medium32),
                    SizedBox(height: 12.h),
                    Center(
                      child: Text(
                        'We sent Verification code to your Email address',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    PinCodeTextField(
                      controller: controller.otpController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter valid otp';
                        }
                        return null;
                      },
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.primaryColor,
                        selectedColor: Colors.green,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) {},
                      onChanged: (value) {},
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                    SizedBox(height: 25.h),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<OtpController>(
                        builder: (otpController) {
                          if (otpController.otpInProgress) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                otpController.getOtpVerification();
                              }
                            },
                            child: Text("Next"),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 25.h),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: GetBuilder<OtpController>(
                  builder: (c) {
                    return Row(
                      children: [
                        Spacer(),
                        Text(
                          "Didn't receive a code!",
                          style: AppTextStyles.medium13,
                        ),
                        InkWell(
                          onTap: c.canResend ? c.resendOtp : null,
                          child: Text(
                            "  Resend",
                            style: AppTextStyles.medium14.copyWith(
                              color: c.canResend
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 25.h)),
            SliverToBoxAdapter(
              child: Center(
                child: GetBuilder<OtpController>(
                  builder: (c) => Text(
                    c.canResend
                        ? "00.59"
                        : "00:${c.remainingSeconds.toString().padLeft(2, '0')} sec",
                    style: AppTextStyles.regular14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
