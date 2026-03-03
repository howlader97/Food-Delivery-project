import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "  • ",
            style: TextStyle(fontSize: 22),
          ),
          Expanded(
            child: Text(
                text,
                style: AppTextStyles.regular14
            ),
          ),
        ],
      ),
    );
  }
}