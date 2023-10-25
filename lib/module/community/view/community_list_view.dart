import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/routes/app_pages.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_badge.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/shimmer_effect.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:newtest/widget/universal_appbar.dart';
import 'package:remixicon/remixicon.dart';

import '../controller/community_controller.dart';

class CommunityListView extends GetView<CommunityController> {
  const CommunityListView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: bgWhite,
      ),
      child: Scaffold(
          backgroundColor: bgWhite,
          appBar: AppBarUniversal(
              isSearching: controller.isSearching, title: 'Community'),
          body: controller.obx(
              onLoading: _ShimmerCommun(),
              (state) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: ListView.builder(
                      itemCount: controller.filteredComunList.length,
                      itemBuilder: (context, index) {
                        final data = controller.filteredComunList[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.COMMUNITY_DETAIL,parameters: {'id' : data.id});
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 100.h,
                                  child: CachedNetworkImage(
                                    imageUrl: data.picture,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                4.h.heightBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.name,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: trueBlack,
                                              fontWeight: Config.semiBold),
                                        ),
                                        Text(
                                          data.slogan.length > 50
                                              ? '${data.slogan.substring(0, 50)}..'
                                              : data.slogan,
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: basicBlack,
                                              fontWeight: Config.medium),
                                        ),
                                        2.h.heightBox,
                                        Row(
                                          children: [
                                            Icon(
                                              Remix.map_pin_line,
                                              size: 8.sp,
                                              color: Color(0xffBFC300),
                                            ),
                                            2.w.widthBox,
                                            Text(
                                              data.location['locationName'],
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  color: basicBlack,
                                                  fontWeight: Config.medium),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    4.w.widthBox,
                                    CustomBadge(
                                        title: 'Follow',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: Config.semiBold),
                                        color: bgWhite,
                                        radius: 4.r,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6.w, horizontal: 8.w),
                                        backgroundColor: bgRed)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ))),
    );
  }
}

class _ShimmerCommun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: List.generate(
              7,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerEffect(
                      height: 100.h,
                      width: double.infinity,
                      radius: 0,
                    ),
                    4.h.heightBox,
                    ShimmerEffect(
                      height: 10.h,
                      width: 120.w,
                    ),
                    2.h.heightBox,
                    ShimmerEffect(
                      height: 10.h,
                      width: 70.w,
                    ),
                    
                    4.h.heightBox,
                     ShimmerEffect(
                      height: 10.h,
                      width: 50.w,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
