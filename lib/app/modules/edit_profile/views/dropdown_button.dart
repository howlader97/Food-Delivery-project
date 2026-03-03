import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = 'Select option',
    this.labelBuilder,
    this.enabled = true,
    this.borderRadius = 12,
    this.borderColor,
    this.strokeWidth = 1.2,
    this.padding,
    this.dropdownMaxHeight,
    this.dropdownWidth,
    this.icon,
    this.isExpanded = true,
    this.errorText,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.backgroundColor,
  });

  final List<T> items;
  final T? value;
  final void Function(T? value) onChanged;
  final String hintText;
  final String Function(T item)? labelBuilder;
  final bool enabled;
  final double borderRadius;
  final Color? borderColor;
  final double strokeWidth;
  final EdgeInsetsGeometry? padding;
  final double? dropdownMaxHeight;
  final double? dropdownWidth;
  final Widget? icon;
  final bool isExpanded;
  final String? errorText;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final defaultMaxHeight = mq.size.height * 0.45;

    final effectiveBorder = Border.all(
      color: borderColor ?? const Color(0xFFE5E7EB),
      width: strokeWidth.r,
    );

    final effectiveHintStyle =
        hintStyle ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey);

    final effectiveTextStyle =
        textStyle ?? Theme.of(context).textTheme.bodyMedium;

    final buttonPadding =
        contentPadding ??
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              isExpanded: isExpanded,
              hint: Text(hintText, style: effectiveHintStyle),
              value: value,
              onChanged: enabled ? onChanged : null,
              items: items
                  .map(
                    (item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        (labelBuilder?.call(item)) ?? item.toString(),
                        style: effectiveTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              // Button styling
              buttonStyleData: ButtonStyleData(
                padding: buttonPadding,
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius.r),
                  // responsive radius
                  border: effectiveBorder,
                ),
                elevation: 0,
                width: isExpanded ? double.infinity : null,
              ),
              // Icon
              iconStyleData: IconStyleData(
                icon: icon ?? const Icon(Icons.keyboard_arrow_down),
              ),
              // Dropdown menu styling
              dropdownStyleData: DropdownStyleData(
                maxHeight: dropdownMaxHeight ?? defaultMaxHeight,
                width: dropdownWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius.r),
                  // responsive radius
                  border: effectiveBorder,
                ),
                elevation: 2,
                padding: EdgeInsets.symmetric(vertical: 8.h),
              ),
              // Each menu item padding/height
              menuItemStyleData: MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              ),
            ),
          ),
          if (errorText != null) ...[
            SizedBox(height: 6.h),
            Text(
              errorText!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }
}
