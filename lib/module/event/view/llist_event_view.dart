import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/event/controller/event_controller.dart';
import 'package:newtest/module/event/widget/filter_date.dart';
import 'package:newtest/routes/app_pages.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shimmer/shimmer.dart';

import '../widget/filter_city_widget.dart';

class ListEventView extends GetView<EventController> {
  ListEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: generalBgWeak,
        appBar: _AppBar(),
        body: Column(
          children: [
          
            FilterList(),
            10.heightBox,
            ListEventItem()
          ],
        ));
  }
}

class ShimmerGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom pada grid
          crossAxisSpacing: 10.w, childAspectRatio: 0.7,
          mainAxisSpacing: 10.h,
        ),
        itemCount: 6, // Ganti sesuai dengan jumlah item yang ingin ditampilkan
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ListEventItem extends GetView<EventController> {
  const ListEventItem({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        onLoading: ShimmerGridView(),
        (state) => Expanded(
                child: GridView.builder(
              itemCount: controller.filteredEventList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Jumlah kolom pada grid
                crossAxisSpacing: 10.w, childAspectRatio: 0.7,
                mainAxisSpacing: 10.h,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final event = controller.filteredEventList[index];
                return InkWell(
                  onDoubleTap: () {
                    bool alreadyLiked =
                        controller.likedEventList.contains(event.id);
                    if (alreadyLiked) {
                      controller.likedEventList.remove(event.id);
                      controller.dislikeEvent(event.id);
                    } else if (!alreadyLiked) {
                      controller.likedEventList.add(event.id);
                      controller.likeEvent(event.id);
                    }
                  },
                  onTap: () {
                    Get.toNamed(Routes.EVENT_DETAIL,
                        parameters: {'id': event.id});
                  },
                  child: Stack(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: event.eventPict[0],
                              height: 170,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.low,
                            ),
                            4.h.heightBox,
                            Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(event.eventName),
                                    Text(
                                      controller
                                          .getFormattedDate(event.createdDate),
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.w),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                                onTap: () {
                                  bool alreadyLiked = controller.likedEventList
                                      .contains(event.id);
                                  if (alreadyLiked) {
                                    controller.likedEventList.remove(event.id);
                                    controller.dislikeEvent(event.id);
                                  } else if (!alreadyLiked) {
                                    controller.likedEventList.add(event.id);
                                    controller.likeEvent(event.id);
                                  }
                                },
                                child: Obx(
                                  () => Icon(
                                    Remix.heart_fill,
                                    color: controller.likedEventList
                                            .contains(event.id)
                                        ? bgRed
                                        : generalGrey,
                                  ),
                                ))),
                      )
                    ],
                  ),
                );
              },
            )));
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

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.h,
                color: generalLine,
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40.w,
                    height: 12.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 85.w,
                    height: 12.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 35.w,
                    height: 12.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    height: 12.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends GetView<EventController> implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(55.h);

  @override
  Widget build(BuildContext context) {
    final Widget notSearchingTopBar = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        const Expanded(child: SizedBox.shrink()),
        IconButton(
          onPressed: () => controller.isSearching.value = true,
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
          onPressed: () => controller.isSearching.value = true,
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
          onPressed: () => controller.isSearching.value = true,
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
            controller: controller.searchController,
            onSubmitted: (_) {
                controller.searchQuery.value = controller.searchController.text;
                  controller.filterEventList();
            },
          ),
        ),
        7.w.widthBox,
        IconButton(
          onPressed: () {
            // controller.searchController.clear();
            controller.isSearching.value = false;
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

    return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          decoration: BoxDecoration(
              color: bgWhite, border: Border(bottom: BorderSide(color: bgRed))),
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
                    if (controller.isSearching.value) {
                      return searchingTopBar;
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
