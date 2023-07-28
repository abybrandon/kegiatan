import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/event/controller/event_controller.dart';
import 'package:newtest/module/event/widget/filter_date.dart';
import 'package:newtest/routes/app_pages.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widget/empty_state.dart';
import '../widget/filter_city_widget.dart';
import 'event_detail_view.dart';

class ListEventView extends GetView<EventController> {
  ListEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: generalBgWeak,
        appBar: AppBar(
          title: Text('Event List'),
          backgroundColor: bgRed,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  controller.searchQuery.value = value;
                  controller.filterEventList();
                },
              ),
            ),
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
                  onTap: () {
                    Get.toNamed(Routes.EVENT_DETAIL,
                        parameters: {'id': event.id});
                  },
                  child: Stack(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Container(
                              height: 170,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        event.eventPict[0],
                                      ))),
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
                              onTap: () {},
                              child: Icon(
                                Remix.heart_fill,
                                color: generalGrey,
                              ),
                            )),
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
            CitySelectorMulti(
              tittle: Obx(
                () => Text(
                  controller.filterCity.value,
                  style: TextStyle(
                      fontSize: 14.sp,
                      overflow: TextOverflow.clip,
                      color: bgWhite,
                      fontWeight: FontWeight.w400),
                ),
              ),
              label: 'System Role',
              items: controller.cityOption,
              onSelect: (selectedItems) {},
            ),
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
