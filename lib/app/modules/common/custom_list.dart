import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/app_text_styles.dart';

class CustomList extends StatelessWidget {
  final String chargeType;
  final String amount;

  const CustomList({super.key, required this.chargeType, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h), // responsive padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(chargeType, style: AppTextStyles.regular14)),
          Flexible(child: Text(amount, style: AppTextStyles.regular14)),
        ],
      ),
    );
  }
}
