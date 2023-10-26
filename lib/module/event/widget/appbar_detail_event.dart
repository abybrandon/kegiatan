import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../controller/detail_event_controller.dart';

class AppBarDetail extends StatelessWidget {
  @override
  AppBarDetail(
      {required this.isSearching,
      this.controller,
      required this.title,
      this.fuctionFilter,
      this.fuctionMore,
      this.fuctionSearch,
      this.isCustom = false,
      required this.isAppBarVisible,
      this.customWidget = const SizedBox.shrink()});
  final TextEditingController? controller;
  final RxBool isSearching;
  final String title;
  final VoidCallback? fuctionFilter;
  final VoidCallback? fuctionMore;
  final dynamic Function(String)? fuctionSearch;
  final bool isCustom;
  final Widget customWidget;
  final RxBool isAppBarVisible;

  @override
  Widget build(BuildContext context) {
    final Widget notSearchingTopBar = Obx(() => Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 15.r,
              icon: Icon(
                Remix.arrow_left_line,
                size: 20.sp,
                color: isAppBarVisible.value ? basicBlack : bgWhite,
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Text(
                isAppBarVisible.value ? title : '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: basicBlack,
                    fontWeight: Config.semiBold),
              ),
            ),
            24.w.widthBox,
            IconButton(
              onPressed: fuctionFilter,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 15.r,
              icon: Icon(
                Remix.heart_line,
                size: 20.sp,
                color: isAppBarVisible.value ? basicBlack : bgWhite,
              ),
            ),
            20.w.widthBox,
            IconButton(
              onPressed: fuctionFilter,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 15.r,
              icon: Icon(
                Remix.bookmark_line,
                size: 20.sp,
                color: isAppBarVisible.value ? basicBlack : bgWhite,
              ),
            ),
            20.w.widthBox,
            IconButton(
              onPressed: fuctionMore,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 15.r,
              icon: Icon(
                Remix.more_2_fill,
                size: 20.sp,
                color: isAppBarVisible.value ? basicBlack : bgWhite,
              ),
            ),
          ],
        ));

  final Widget customBar = Obx(() => Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 15.r,
              icon: Icon(
                Remix.arrow_left_line,
                size: 20.sp,
                color: isAppBarVisible.value ? basicBlack : bgWhite,
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Text(
                isAppBarVisible.value ? title : '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: basicBlack,
                    fontWeight: Config.semiBold),
              ),
            ),
           
            20.w.widthBox,
            IconButton(
              onPressed: fuctionMore,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 15.r,
              icon: Icon(
                Remix.more_2_fill,
                size: 20.sp,
                color: isAppBarVisible.value ? basicBlack : bgWhite,
              ),
            ),
          ],
        
        ));

    return Obx(() => Material(
          color: isAppBarVisible.value ? bgWhite : Colors.transparent,
       
          child: SizedBox(
            height: 70.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    child: isCustom ? customBar : notSearchingTopBar),
              ],
            ),
          ),
        ));
  }
}
