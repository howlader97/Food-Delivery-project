import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class CustomProfileTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;

  const CustomProfileTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(label, style: AppTextStyles.medium18),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.regular14.copyWith(
              color: AppColors.greyColor,
            ),
          ),
        ),
      ],
    );
  }
}
