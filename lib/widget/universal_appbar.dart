import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

class AppBarUniversal extends StatelessWidget implements PreferredSizeWidget {
  @override
  AppBarUniversal(
      {required this.isSearching,
      this.controller,
      required this.title,
      this.fuctionFilter,
      this.fuctionMore,
      this.fuctionSearch,
      this.isCustom = false,
      this.customWidget = const SizedBox.shrink()});

  Size get preferredSize => Size.fromHeight(50.h);
  final TextEditingController? controller;
  final RxBool isSearching;
  final String title;
  final VoidCallback? fuctionFilter;
  final VoidCallback? fuctionMore;
  final dynamic Function(String)? fuctionSearch;
  final bool isCustom;
  final Widget customWidget;

  @override
  Widget build(BuildContext context) {
    final Widget notSearchingTopBar = Row(
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
            color: bgRed,
          ),
        ),
        SizedBox(width: 24.w),
        Text(
          title,
          style: TextStyle(
              fontSize: 16.sp, color: bgRed, fontWeight: Config.semiBold),
        ),
        const Expanded(child: SizedBox.shrink()),
        IconButton(
          onPressed: () => isSearching.value = true,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: 15.r,
          icon: Icon(
            Remix.search_line,
            size: 20.sp,
            color: bgRed,
          ),
        ),
        20.w.widthBox,
        IconButton(
          onPressed: fuctionFilter,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: 15.r,
          icon: Icon(
            Remix.equalizer_line,
            size: 20.sp,
            color: bgRed,
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
            color: bgRed,
          ),
        ),
      ],
    );

    final Widget searchingTopBar = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Remix.search_line,
          size: 25.sp,
          color: bgRed,
        ),
        10.w.widthBox,
        Expanded(
          child: CustomTextField(
              errorText: '',
              normalTextfield: true,
              borderStyle: const UnderlineInputBorder(),
              padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 6.h),
              hintText: 'Search...',
              autoFocus: true,
              controller: controller,
              onSubmitted: fuctionSearch),
        ),
        7.w.widthBox,
        IconButton(
          onPressed: () {
            // controller.searchController.clear();
            isSearching.value = false;
          },
          padding: EdgeInsets.zero,
          splashRadius: 15.r,
          constraints: const BoxConstraints(),
          icon: Icon(
            Remix.close_fill,
            size: 20.sp,
            color: bgRed,
          ),
        ),
      ],
    );

    final Widget customWidgetExtention = Row(
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
            color: bgRed,
          ),
        ),
        customWidget],
    );

    return PreferredSize(
        preferredSize: preferredSize,
        child: Material(
    color: bgWhite,
    elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 16.w,
                ),
                child: Obx(
                  () {
                    if (isSearching.value) {
                      return searchingTopBar;
                    } else if (isCustom) {
                      return customWidgetExtention;
                    } else {
                      return notSearchingTopBar;
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
