import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:al_khalifa/app/data/image_path.dart';
import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_elevated_button.dart';
import '../controllers/onbording2_controller.dart';

class Onbording2View extends GetView<Onbording2Controller> {
  const Onbording2View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagePath.onboarding2),
            SizedBox(height: 45.h),
            Text('Chose Your Meal', style: AppTextStyles.bold20),
            SizedBox(height: 15.h),
            Text(
              'All the best restaurants with their top menu waiting for you,they can’t wait for your order',
              textAlign: TextAlign.center,
              style: AppTextStyles.regular16.apply(
                color: AppColors.primaryTextColor,
              ),
            ),
            SizedBox(height: 115.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  child: Text(
                    'Skip',
                    style: AppTextStyles.medium18.apply(
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  text: 'Next',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
