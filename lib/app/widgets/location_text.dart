import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/app_colors.dart';
import '../data/app_text_styles.dart';
import '../data/image_path.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.text,
    this.showIcon = false,
    this.title = 'Location: ',
  });
  final String text;
  final String title;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        if (showIcon) Image.asset(ImagePath.location, height: 20.h),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: AppTextStyles.regular14.apply(
                    color: AppColors.primaryTextColor,
                  ),
                ),
                TextSpan(
                  text: text,
                  style: AppTextStyles.regular14.apply(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
