import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

class ButtonProfileWidget extends StatelessWidget {
  const ButtonProfileWidget(
      {super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: basicBlack,
          ),
          10.w.widthBox,
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: basicBlack,
                  fontWeight: Config.medium,
                  fontSize: textMedium),
            ),
          ),
          Icon(
            Remix.arrow_right_s_line,
            color: trueBlack,
            size: 20.sp,
          )
        ],
      ),
    );
  }
}
