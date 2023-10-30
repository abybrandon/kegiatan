import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/sizedbox_extension.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              headerIcon,
              size: 20.sp,
              color: headerIconColor ?? bgRed,
            ),
            SizedBox(width: 9.34.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headerText,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: bgRed,
                    ),
                  ),
                  6.h.heightBox,
                  body ?? const SizedBox(),
                  12.h.heightBox,
                ],
              ),
            )
          ],
        ),
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
                    BorderSide.none
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
                        elevation: 0, backgroundColor: bgRed,
                        minimumSize: Size.fromHeight(41.sp),
                      ),
                    ) ??
                    ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: bgRed,
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
