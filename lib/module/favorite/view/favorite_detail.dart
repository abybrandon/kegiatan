import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import '../../../widget/confirm_dialog.dart';
import '../controller/favorite_detail_controller.dart';

class FavoriteDetail extends GetView<FavoriteDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: generalBgWeak,
        appBar: AppBar(
          actions: [
            // IconButton(
            //     onPressed: () async {
            //       // if (controller.isEventSaved.value) {
            //       //   controller.deleteDetailEvent(controller.eventDetail.value);
            //       // } else {
            //       //   controller.saveDetailEvent(controller.eventDetail.value);
            //       // }

            //       SharedPreferences prefs =
            //           await SharedPreferences.getInstance();
            //       List<String>? data = prefs.getStringList('savedEventList');

            //     },
            //     icon: Obx(() => Icon(
            //           Remix.heart_3_fill,
            //           color: controller.isEventSaved.value
            //               ? Colors.pink
            //               : Colors.white,
            //         )))
          ],
          backgroundColor: bgRed,
        ),
        body: controller.obx((state) => _BodyDetail(), onLoading: Loader()));
  }
}

class _BodyDetail extends GetView<FavoriteDetailController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          10.heightBox,
          SizedBox(
            height: 250,
            child: Swiper(
              loop: false,
              viewportFraction: 0.8,
              scale: 1,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: controller.savedEventList2.value!.eventPict[index],
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );
              },
              itemCount: controller.savedEventList2.value!.eventPict.length,
              pagination:
                  const SwiperPagination(builder: SwiperPagination.dots),
              control: null,
            ),
          ),
          20.heightBox,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgWhite,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    controller.savedEventList2.value!.eventName,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  10.heightBox,
                  Text(
                    controller.savedEventList2.value!.organizerEvent,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  10.heightBox,
                  Text(
                    controller.savedEventList2.value!.city,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  10.heightBox,
                ]),
          ),
          20.heightBox,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgWhite,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(controller.savedEventList2.value!.deskripsi),
                  10.heightBox,
                ]),
          ),
          20.heightBox,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgWhite,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: controller.savedEventList2.value!.guestStart
                    .map((e) => Text(e))
                    .toList()),
          ),
          20.heightBox,
        ],
      ),
    );
  }
}

class _ErrorDialog extends StatelessWidget {
  const _ErrorDialog();

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      headerIcon: Remix.save_line,
      headerIconColor: primaryDefault,
      headerText: 'Error',
      body: Container(
        margin: EdgeInsets.only(
          top: 12.h,
          bottom: 10.h,
        ),
        child: Text(
          'No Internet Connection',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: generalBody,
          ),
        ),
      ),
      onApply: () {
        Get.back();
      },
    );
  }
}
