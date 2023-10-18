import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../controller/home_controller.dart';

class SearchView extends GetView<HomeController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.h.heightBox,
            Text(
              'Search',
              style: TextStyle(
                  fontSize: 18.sp, color: basicBlack, fontWeight: Config.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 1.5,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ThemeData().colorScheme.copyWith(
                              primary: bgRed,
                            ),
                      ),
                      child: SizedBox(
                        height: 45.h,
                        child: TextField(
                          controller: controller.searchController,
                          onChanged: (value) {
                            controller.searchText.value = value;
                          },
                          style: TextStyle(
                              fontWeight: Config.medium,
                              color: basicBlack,
                              fontSize: 16.sp),
                          decoration: InputDecoration(
                              hintText: 'Search..',
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.searchController.clear();
                                    controller.searchText.value = '';
                                  },
                                  child: Icon(
                                    Remix.close_line,
                                    size: 22.sp,
                                  )),
                              contentPadding: EdgeInsets.only(top: 5.h),
                              prefixIcon: Icon(
                                Remix.search_line,
                                size: 22.sp,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: semiGrey,
                                  fontWeight: Config.medium),
                              filled: true,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              fillColor: bgWhite),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: basicBlack,
                          fontWeight: Config.bold),
                    ))
              ],
            ),
            22.h.heightBox,
            Obx(() => controller.searchText.value != ''
                ? Column(
                    children: [
                      _SuggestRow(
                        featureName: 'Event',
                      ),
                      16.h.heightBox,
                      _SuggestRow(
                        featureName: 'Costume',
                      ),
                      16.h.heightBox,
                      _SuggestRow(
                        featureName: 'Community',
                      ),
                    ],
                  )
                : SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}

class _SuggestRow extends GetView<HomeController> {
  const _SuggestRow({super.key, required this.featureName});
  final String featureName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Expanded(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: 'Search " ',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: basicBlack,
                    fontWeight: Config.semiBold),
                children: <TextSpan>[
                  TextSpan(
                    text: controller.searchText.value,
                    style: TextStyle(color: bgRed),
                  ),
                  TextSpan(
                    text: '" in $featureName',
                  ),
                ],
              ),
            ),
          ),
        ),
        Icon(
          Remix.search_line,
          size: 20.sp,
          color: bgRed,
        )
      ],
    );
  }
}
