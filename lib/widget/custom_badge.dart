import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBadge extends StatelessWidget {
  final String title;
  final Color color;
  final Color backgroundColor;
  final double? minWidth;
  final double? minHeight;
  final TextStyle? style;
  final EdgeInsets? padding;
  final Color? textColor;
  final bool? righSideBorder;
  final int? maxLengthCut;
  final bool truncateText;
  final bool isUser;
  final double? radius;

  const CustomBadge({
    super.key,
    required this.title,
    required this.color,
    required this.backgroundColor,
    this.minHeight,
    this.minWidth,
    this.style,
    this.padding,
    this.textColor,
    this.righSideBorder,
    this.maxLengthCut,
    this.truncateText = false,
    this.isUser = false,
    this.radius,
  });

  int get lengthWidth {
    return title.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 45.w,
        minHeight: minHeight ?? 0.w,
      ),
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: 4.h,
            horizontal: 6.w,
          ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: color),
        borderRadius: righSideBorder ?? false
            ? BorderRadius.horizontal(right: Radius.circular(radius ?? 30.r))
            : BorderRadius.circular(radius ?? 30.r),
      ),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: style?.copyWith(color: textColor ?? color) ??
            TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w600,
              color: textColor ?? color,
            ),
      ),
    );
  }
}
