import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../controller/reminder_controller.dart';

class ReminderView extends GetView<ReminderController> {
  const ReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgWhite,
        body: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 20.w, top: 45.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Event Reminder',
              style: TextStyle(
                  fontSize: 18.sp, color: bgRed, fontWeight: FontWeight.bold),
            ),
            16.h.heightBox,
            controller.reminderData.isEmpty ? _NoDataRemind() : _DataReminder()
          ]),
        ),
      ),
    );
  }
}

class _NoDataRemind extends StatelessWidget {
  const _NoDataRemind({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        45.h.heightBox,
        Image.asset(
          'assets/noDataRemind.jpg',
          width: 280.w,
          height: 280.h,
        ),
        25.h.heightBox,
        Center(
          child: Text(
            "It seems like your reminder list is empty. Let's start by adding some important events",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _DataReminder extends StatelessWidget {
  const _DataReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: SizedBox(
              height: 58.h,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    height: 58.h,
                    decoration: BoxDecoration(
                        color: bgRed,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            bottomLeft: Radius.circular(8.r))),
                    child: SvgPicture.asset(
                      'assets/bell-ring.svg',
                      width: 32.w,
                      height: 32.h,
                      color: bgWhite,
                    ),
                  ),
                  10.w.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Harajuku Festival 2023',
                          style: TextStyle(
                              fontSize: textBig,
                              fontWeight: Config.semiBold,
                              color: trueBlack),
                        ),
                        Text(
                          '12 - 13 Oktober 2023',
                          style: TextStyle(
                              fontSize: textMedium,
                              fontWeight: Config.semiBold,
                              color: basicBlack),
                        ),
                        Row(
                          children: [
                            Icon(
                              Remix.map_pin_line,
                              color: Color(0xffBFC300),
                              size: 10.sp,
                            ),
                            2.w.widthBox,
                            Text(
                              'Jakarta',
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: Config.medium,
                                  color: basicBlack),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  20.h.heightBox,
                  IconButton(
                    onPressed: null,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 15.r,
                    icon: Icon(
                      Remix.more_2_fill,
                      size: 20.sp,
                      color: trueBlack,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
