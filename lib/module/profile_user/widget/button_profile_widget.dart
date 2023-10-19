import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

class ButtonProfileWidget extends StatelessWidget {
  const ButtonProfileWidget(
      {super.key, required this.icon, required this.title , this.fuction});
  final IconData icon;
  final String title;
  final VoidCallback? fuction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fuction,
      
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: basicBlack,
            ),
            10.w.widthBox,
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    color: basicBlack,
                    fontWeight: Config.medium,
                    fontSize: textBig),
              ),
            ),
            Icon(
              Remix.arrow_right_s_line,
              color: trueBlack,
              size: 22.sp,
            )
          ],
        ),
      ),
    );
  }
}
