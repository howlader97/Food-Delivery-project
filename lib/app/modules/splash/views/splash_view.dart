import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/image_path.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
  Get.put(SplashController());
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Image.asset(ImagePath.splashBackground, fit: BoxFit.cover),
            Center(child: Image.asset(ImagePath.splashIcon,height: 200.h,width: 200.w,)),
          ],
        ),
      ),
    );
  }
}
