import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme.dart';

class ConfirmDialog extends StatelessWidget {
  final IconData headerIcon;
  final Color? headerIconColor;
  final String headerText;
  final Widget? body;
  final String? cancelLabel;
  final String? applyLabel;
  final Function()? onCancel;
  final Function()? onApply;
  final ButtonStyle? applyStyle;

  const ConfirmDialog({
    super.key,
    required this.headerIcon,
    this.headerIconColor,
    required this.headerText,
    this.body,
    this.cancelLabel,
    this.applyLabel,
    this.onCancel,
    this.onApply,
    this.applyStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(
        vertical: 18.h,
        horizontal: 16.w,
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              headerIcon,
              size: 16.sp,
              color: headerIconColor ?? primaryDefault,
            ),
            SizedBox(width: 9.34.sp),
            Text(
              headerText,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: headerWeak,
              ),
            )
          ],
        ),
        body ?? const SizedBox(),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  if (onCancel != null) {
                    onCancel!();
                  }
                  Get.back();
                },
                style: ButtonStyle(
                  side: MaterialStatePropertyAll(
                    BorderSide(
                      color: const Color(0xFFD9DBE9),
                      width: 1.sp,
                    ),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.sp),
                    ),
                  ),
                  minimumSize: MaterialStatePropertyAll(
                    Size.fromHeight(41.sp),
                  ),
                ),
                child: Text(
                  cancelLabel ?? 'Cancel',
                  style: const TextStyle(
                    color: Color(0xFF6E7191),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (onApply != null) {
                    if (onApply is Future<dynamic> Function()) {
                      await onApply!();
                    } else {
                      onApply!();
                    }
                  }
                  Get.back();
                },
                style: applyStyle?.merge(
                      ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: Size.fromHeight(41.sp),
                      ),
                    ) ??
                    ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: Size.fromHeight(41.sp),
                    ),
                child: Text(applyLabel ?? 'Yes'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
