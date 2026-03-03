
import 'package:flutter/material.dart';

void showCustomSnackbar({
  required BuildContext context,
  required String title,
  required String message,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 850),
      margin: const EdgeInsets.only(
        top: 20 ,left: 16, right: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),
          ),
        ],
      ),
      backgroundColor: backgroundColor,

    ),
  );
}
