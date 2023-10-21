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
      this.customWidget = const SizedBox.shrink()});
  final TextEditingController? controller;
  final RxBool isSearching;
  final String title;
  final VoidCallback? fuctionFilter;
  final VoidCallback? fuctionMore;
  final dynamic Function(String)? fuctionSearch;
  final bool isCustom;
  final Widget customWidget;
  final controllerEvent = Get.find<DetailEventController>();

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
            color: controllerEvent.isAppBarVisible.value ? bgRed : bgWhite,
          ),
        ),
        SizedBox(width: 24.w),
        Text(
          title,
          style: TextStyle(
              fontSize: 16.sp, color: bgWhite, fontWeight: Config.semiBold),
        ),
        const Expanded(child: SizedBox.shrink()),
        IconButton(
          onPressed: fuctionFilter,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: 15.r,
          icon: Icon(
            Remix.heart_line,
            size: 20.sp,
            color: controllerEvent.isAppBarVisible.value ? bgRed : bgWhite,
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
            color: controllerEvent.isAppBarVisible.value ? bgRed : bgWhite,
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
            color: controllerEvent.isAppBarVisible.value ? bgRed : bgWhite,
          ),
        ),
      ],
    ));


    return Obx(() => Container(
      height: 70.h,
      
      decoration: BoxDecoration(
        
        color: controllerEvent.isAppBarVisible.value ? bgWhite : Colors.transparent,
        border:  Border(
                bottom: BorderSide(color: controllerEvent.isAppBarVisible.value ? bgRed : Colors.transparent, width: 2.h),
              )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 16.w,
              ),
              child: notSearchingTopBar),
        ],
      ),
    ));
  }
}
