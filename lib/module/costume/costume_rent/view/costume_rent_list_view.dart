import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newtest/routes/app_pages.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_badge.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../event/view/llist_event_view.dart';
import '../controller/costume_rent_controller.dart';

class CostumeRentListView extends GetView<CostumeRentController> {
  const CostumeRentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        onLoading: ShimmerGridView(),
        (state) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(
                  child: Wrap(
                      spacing: 20.w,
                      runSpacing: 20.h,
                      children: List.generate(
                          controller.filtereddataList.length, (index) {
                        final data = controller.filtereddataList[index];
                        return Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.COSTUME_RENT_DETAIL,
                                    parameters: {'id': data.id});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 8.h),
                                width: 150.w,
                                height: 243.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Color(0xFFE6E6E6)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: CachedNetworkImage(
                                        imageUrl: data.listPhotoCostume[0],
                                        height: 150.h,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        filterQuality: FilterQuality.low,
                                      ),
                                    ),
                                    4.h.heightBox,
                                    Text(
                                      data.nameCostume,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: trueBlack,
                                          fontWeight: Config.semiBold),
                                    ),
                                    Text(
                                      data.charackterOrigin.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          color: Color(0xff4AD6C9)
                                              .withOpacity(0.8),
                                          fontWeight: Config.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rp ${data.priceRent['rentPrice']} / ${data.priceRent['rentDay']} Day',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 8.sp,
                                              color: bgGrey,
                                              fontWeight: Config.medium),
                                        ),
                                        Text(
                                          'Full Set',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 8.sp,
                                              color: bgGrey,
                                              fontWeight: Config.medium),
                                        ),
                                      ],
                                    ),
                                    4.h.heightBox,
                                    Row(
                                      children: List.generate(
                                        data.categoryCostume.length,
                                        (index) => Padding(
                                          padding: EdgeInsets.only(right: 2.w),
                                          child: CustomBadge(
                                            minWidth: 30.w,
                                            title: data.categoryCostume[index],
                                            color: bgRed,
                                            backgroundColor: bgWhite,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w),
                                          ),
                                        ),
                                      ),
                                    ),
                                    2.h.heightBox,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Remix.map_pin_line,
                                              size: 8.sp,
                                              color: Color(0xffBFC300),
                                            ),
                                            2.w.widthBox,
                                            Text(
                                              data.locationName,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  color: basicBlack,
                                                  fontWeight: Config.medium),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Remix.heart_2_fill,
                                              size: 8.sp,
                                              color: trueLove,
                                            ),
                                            2.w.widthBox,
                                            Text(
                                              '13 Liked',
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  color: trueLove,
                                                  fontWeight: Config.medium),
                                            ),
                                            2.w.widthBox,
                                            Icon(
                                              Remix.more_2_fill,
                                              size: 8.sp,
                                              color: trueBlack,
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: bgRed,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 2.h),
                              child: Text(
                                controller.isBooked(data.status),
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    color: bgWhite,
                                    fontWeight: Config.semiBold),
                              ),
                            ),
                            Positioned(
                              right: 14.w,
                              top: 12.h,
                              child: Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0x66C9C1C1),
                                    shape: OvalBorder(),
                                  ),
                                  child: InkWell(
                                      onTap: () {
                                        // bool alreadyLiked = controller
                                        //     .likeddataList
                                        //     .contains(data.id);
                                        // if (alreadyLiked) {
                                        //   controller.likeddataList
                                        //       .remove(data.id);
                                        //   controller.dislikedata(data.id);
                                        // } else if (!alreadyLiked) {
                                        //   controller.likeddataList
                                        //       .add(data.id);
                                        //   controller.likedata(data.id);
                                        // }
                                      },
                                      child: Obx(
                                        () => Icon(
                                          controller.likeddataList
                                                  .contains(data.id)
                                              ? Remix.heart_fill
                                              : Remix.heart_line,
                                          color: controller.likeddataList
                                                  .contains(data.id)
                                              ? bgRed
                                              : bgWhite,
                                        ),
                                      ))),
                            ),
                          ],
                        );
                      })),
                ),
              ),
            ));
  }
}
