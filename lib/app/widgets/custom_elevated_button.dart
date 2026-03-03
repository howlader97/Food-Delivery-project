import 'package:flutter/material.dart';

import '../data/app_colors.dart';
import '../data/app_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.hPadding = 20,
  });
  final void Function() onPressed;
  final String text;
  final double hPadding;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: hPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      child: Text(
        text,
        style: AppTextStyles.medium18.apply(color: Colors.white),
      ),
    );
  }
}
