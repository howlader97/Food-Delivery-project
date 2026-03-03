import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String? title; // এখন optional
  final VoidCallback? onSeeAllTap;
  final IconData? leadingIcon;
  final bool centerTitle;
  final String? seeAllText;
  final IconData? seeAllIcon;
  final VoidCallback? onLeadingTap;

  const CustomHeader({
    super.key,
    this.title,
    this.onSeeAllTap,
    this.leadingIcon,
    this.centerTitle = false,
    this.seeAllText,
    this.seeAllIcon,
    this.onLeadingTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (leadingIcon != null)
            Positioned(
              left: 0,
              child: IconButton(
                onPressed: onLeadingTap,
                icon: Icon(leadingIcon, color: Colors.green),
              ),
            ),
          if (title != null)
            Align(
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: leadingIcon != null ? 48 : 0),
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          if (!centerTitle && onSeeAllTap != null)
            Positioned(
              right: 0,
              child: InkWell(
                onTap: onSeeAllTap,
                child: Row(
                  children: [
                    Text(
                      seeAllText ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      seeAllIcon ?? Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
