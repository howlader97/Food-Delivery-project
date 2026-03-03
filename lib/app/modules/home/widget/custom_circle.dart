import 'package:al_khalifa/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';

/*class CustomCircle extends StatelessWidget {
  final double size;
  final Color borderColor;
  final double borderWidth;
  final Color? fillColor;
  final String? tag;

  const CustomCircle({
    super.key,
    this.size = 24,
    this.borderColor = Colors.grey,
    this.borderWidth = 2,
    this.fillColor,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fillColor ?? Colors.transparent,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
    );
  }
}*/


class CustomCircle extends StatelessWidget {
  final double size;
  final Color borderColor;
  final double borderWidth;
  final Color? fillColor;
  final int index;
  final int variationId;

  const CustomCircle({
    super.key,
    required this.index,
    this.size = 24,
    this.borderColor = Colors.grey,
    this.borderWidth = 2,
    this.fillColor, required this.variationId,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Obx(() => GestureDetector(
      onTap: () => controller.selectIndex(index,variationId),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: controller.selectedIndex.value == index
              ?  AppColors.primaryColor
              : Colors.transparent,
          border: Border.all(
            color: controller.selectedIndex.value == index
                ? AppColors.primaryColor
                : borderColor,
            width: borderWidth,
          ),
        ),
      ),
    ));
  }
}
