import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

class BottomSheetAction extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color titleColor;
  final IconData icon;
  final Color iconColor;
  final void Function()? onTap;

  const BottomSheetAction({
    super.key,
    required this.title,
    this.titleColor = Colors.black,
    required this.icon,
    this.iconColor = Colors.black,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap ?? () {},
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Image.asset( imagePath,height: 20.h,width: 20.w,),
                  8.w.widthBox,
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: textBig,
                      fontWeight: Config.medium,
                      color: titleColor,
                    ),
                  ),
                ],
              ),
              Icon(
                Remix.arrow_right_s_line,
                color: trueBlack,
                size: 22.sp,
              )
            ]),
            12.h.heightBox,
          ],
        ),
      ),
    );
  }
}
