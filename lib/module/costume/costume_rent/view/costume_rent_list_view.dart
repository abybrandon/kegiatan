import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/empty_state.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/costume_rent_controller.dart';
import '../model/costume_rent_model.dart';
class CostumeRentListView extends GetView<CostumeRentController> {
  const CostumeRentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgWhite,
         title: Text(
            'Costume Rental',
            style: TextStyle(color: bgRed),
          ),
        leading: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 16.w,
            ),
            child: IconButton(
              onPressed: () {
                // Get.back();
                controller.tryBool.value = !controller.tryBool.value;
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 15.r,
              icon: Obx(() => Icon(
                Remix.heart_2_fill,
                size: 20.sp,
                color: controller.tryBool.value ? bgBlue : bgRed,
              ),)
            ),
          ),
      ),
      body: 
      RefreshIndicator(
        onRefresh: () async => controller.allAsetsListPagingController.refresh(),
        child: PagedListView(
          pagingController: controller.allAsetsListPagingController,
          builderDelegate: PagedChildBuilderDelegate<CostumeRentPagination>(
            itemBuilder: (_, item, __) {
              return _ListRecord(data: item);
            },
            firstPageProgressIndicatorBuilder: (_) => const CircularProgressIndicator(),
            firstPageErrorIndicatorBuilder: (_) => const EmptyState(),
            noItemsFoundIndicatorBuilder: (_) => const EmptyState(),
          ),
        )));
      // ),
      // Obx(() => ListView.builder(
      //   itemCount: controller.filteredCostumeList.length,
      //   itemBuilder: (context, index) {
      //   final data = controller.filteredCostumeList[index];
      //   return Text(data.name, style: TextStyle(fontSize: 16),);
      // },))
    
  }
}

class _ListRecord extends StatelessWidget {
  const _ListRecord ({super.key, required this.data});
final CostumeRentPagination data;
  @override
  Widget build(BuildContext context) {
    return Text(data.name);
  }
}