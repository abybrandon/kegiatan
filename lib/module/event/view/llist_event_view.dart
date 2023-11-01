import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/event/controller/event_controller.dart';
import 'package:newtest/module/event/widget/filter_date.dart';
import 'package:newtest/module/event/widget/filter_event_list.dart';
import 'package:newtest/routes/app_pages.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/date_formatter.dart';
import 'package:newtest/widget/shimmer_effect.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:newtest/widget/universal_appbar.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shimmer/shimmer.dart';

import '../widget/filter_city_widget.dart';

class ListEventView extends GetView<EventController> {
  ListEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: bgWhite,
      ),
      child: Scaffold(
          backgroundColor: bgWhite,
          appBar: AppBarUniversal(
            isSearching: controller.isSearching,
            title: 'Event',
            controller: controller.searchController,
            fuctionFilter: () {
              showModalBottomSheet(
                context: Get.overlayContext!,
                isScrollControlled: true,
                builder: (context) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: Get.height * 0.7),
                    child: FilterEventList(),
                  );
                },
              );
            },
            fuctionSearch: (p0) {
              controller.searchQuery.value = controller.searchController.text;
              controller.filterEventList();
            },
          ),
          body: _BodyContent()),
    );
  }
}

class ShimmerGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(
          child: Wrap(
              spacing: 20.w,
              runSpacing: 20.h,
              children: List.generate(10, (index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  width: 150.w,
                  height: 209.h,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFE6E6E6)),
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
                      ShimmerEffect(
                        height: 150.h,
                        width: double.infinity,
                      ),
                      4.h.heightBox,
                      ShimmerEffect(
                        height: 10.h,
                        width: 100.w,
                      ),
                      4.h.heightBox,
                      ShimmerEffect(
                        height: 10.h,
                        width: 50.w,
                      ),
                    ],
                  ),
                );
              })),
        ),
      ),
    );
  }
}

class FilterList extends GetView<EventController> {
  const FilterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                await controller.takeDate(context);
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: bgRed, borderRadius: BorderRadius.circular(8)),
                  child: Obx(
                    () => Text(
                      controller.filterDate.value,
                      style: TextStyle(
                          fontSize: 14.sp,
                          overflow: TextOverflow.clip,
                          color: bgWhite,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
            ),
            8.w.widthBox,
            // CitySelectorMulti(
            //   tittle: Obx(
            //     () => Text(
            //       controller.filterCity.value,
            //       style: TextStyle(
            //           fontSize: 14.sp,
            //           overflow: TextOverflow.clip,
            //           color: bgWhite,
            //           fontWeight: FontWeight.w400),
            //     ),
            //   ),
            //   label: 'System Role',
            //   items: controller.cityOption,
            //   onSelect: (selectedItems) {},
            // ),
            8.w.widthBox,
            InkWell(
              onTap: () async {
                Get.bottomSheet(
                  FilterDateEvent(),
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                );
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: bgRed, borderRadius: BorderRadius.circular(8)),
                  child: Obx(
                    () => Text(
                      controller.filterDate.value,
                      style: TextStyle(
                          fontSize: 14.sp,
                          overflow: TextOverflow.clip,
                          color: bgWhite,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
            ),
            8.w.widthBox,
            InkWell(
              onTap: () async {
                controller.datePickerRange(context);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: bgRed, borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Coba tanggal',
                  style: TextStyle(
                      fontSize: 14.sp,
                      overflow: TextOverflow.clip,
                      color: bgWhite,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BodyContent extends GetView<EventController> {
  _BodyContent({super.key});

  DateUtil dateUtil = DateUtil();
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
                          controller.filteredEventList.length, (index) {
                        final event = controller.filteredEventList[index];
                        return Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.EVENT_DETAIL,
                                    parameters: {'id': event.id});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 8.h),
                                width: 150.w,
                                height: 212.h,
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
                                        imageUrl: event.eventPict[0],
                                        height: 150.h,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        filterQuality: FilterQuality.low,
                                      ),
                                    ),
                                    4.h.heightBox,
                                    Text(
                                      event.eventName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: trueBlack,
                                          fontWeight: Config.semiBold),
                                    ),
                                    Text(
                                      '${dateUtil.formatTimestamps(event.eventDate.startDate, event.eventDate.endDate)}',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          color: bgGrey,
                                          fontWeight: Config.medium),
                                    ),
                                    2.h.heightBox,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Remix.map_pin_line,
                                                  size: 8.sp,
                                                  color: Color(0xffBFC300),
                                                ),
                                                2.w.widthBox,
                                                Expanded(
                                                  child: Text(
                                                    event.city,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 8.sp,
                                                        color: basicBlack,
                                                        fontWeight:
                                                            Config.medium),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        4.w.widthBox,
                                        Row(
                                          children: [
                                            Icon(
                                              Remix.heart_2_fill,
                                              size: 8.sp,
                                              color: trueLove,
                                            ),
                                            2.w.widthBox,
                                            Text(
                                              '130',
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
                                controller.getWeekStatus(event.createdDate),
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
                                        bool alreadyLiked = controller
                                            .likedEventList
                                            .contains(event.id);
                                        if (alreadyLiked) {
                                          controller.likedEventList
                                              .remove(event.id);
                                          controller.dislikeEvent(event.id);
                                        } else if (!alreadyLiked) {
                                          controller.likedEventList
                                              .add(event.id);
                                          controller.likeEvent(event.id);
                                        }
                                      },
                                      child: Obx(
                                        () => Icon(
                                          controller.likedEventList
                                                  .contains(event.id)
                                              ? Remix.heart_fill
                                              : Remix.heart_line,
                                          color: controller.likedEventList
                                                  .contains(event.id)
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
