import 'package:al_khalifa/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class PaymentMethod extends GetView<CheckoutController> {
  final String paymentWay;
  final int index;

  const PaymentMethod({
    super.key,
    required this.paymentWay,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
              () => Padding(
            padding: EdgeInsets.all(8.r),
            child: GestureDetector(
              onTap: () {
                controller.select(index);
              },
              child: Container(
                height: 20.r,
                width: 20.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.r,
                    color: controller.selectedIndex.value == index
                        ? AppColors.primaryColor
                        : AppColors.greyColor,
                  ),
                ),
                child: controller.selectedIndex.value == index
                    ? Center(
                  child: Container(
                    height: 10.r,
                    width: 10.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
                    : null,
              ),
            ),
          ),
        ),
        Text(paymentWay, style: AppTextStyles.medium16),
      ],
    );
  }
}
