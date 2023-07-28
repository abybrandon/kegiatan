import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:newtest/module/event/controller/detail_event_controller.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import '../../../widget/confirm_dialog.dart';

class EventDetailView extends GetView<DetailEventController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: generalBgWeak,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  if (controller.isEventSaved.value) {
                    controller.deleteDetailEvent(controller.eventDetail.value);
                  } else {
                    controller.saveDetailEvent(controller.eventDetail.value);
                  }

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  List<String>? data = prefs.getStringList('savedEventList');
                  // print(data!.length);
                  // prefs.remove('savedEventList');
                  // print(data!.map((e) => e.length));
                  // controller.checkEventSaved(controller.eventDetail.value);
                  // print(controller.isEventSaved);
                },
                icon: Obx(() => Icon(
                      Remix.heart_3_fill,
                      color: controller.isEventSaved.value
                          ? Colors.pink
                          : Colors.white,
                    )))
          ],
          backgroundColor: bgRed,
        ),
        body: controller.obx((state) => _BodyDetail(), onLoading: Loader()));
  }
}

class _BodyDetail extends GetView<DetailEventController> {
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
                  imageUrl: controller.listPict[index],
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(), // Widget yang ditampilkan selama gambar sedang diunduh
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error), // Widg
                );
              },
              itemCount: controller.listPict.length,
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
                    controller.nameEvent,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  10.heightBox,
                  Text(
                    controller.organizerEvent,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  10.heightBox,
                  Text(
                    controller.city,
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
                  Text(controller.deskripsi),
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
                children:
                    controller.listGuestStart.map((e) => Text(e)).toList()),
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
                  InkWell(
                    child: Container(
                      height: 400,
                      child: FlutterMap(
                        nonRotatedChildren: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.h),
                              child: InkWell(
                                onTap: () {
                                  controller.openMapsSheet(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 4.h),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/img/google-maps.png',
                                        height: 15,
                                        width: 15,
                                        fit: BoxFit.contain,
                                      ),
                                      10.widthBox,
                                      Text(
                                        'Get Direction',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          RichAttributionWidget(
                            popupBackgroundColor: Colors.white,
                            animationConfig: const ScaleRAWA(),
                            showFlutterMapAttribution: false,
                            attributions: [
                              TextSourceAttribution(
                                  'OpenStreetMap contributors',
                                  onTap: () {}),
                            ],
                          ),
                        ],
                        options: MapOptions(
                          maxZoom: 18,
                          center: LatLng(
                              controller.latitudeLoc, controller.longitudeLoc),
                          zoom: 13.0,
                        ),
                        children: [
                          TileLayer(
                            keepBuffer: 10,
                            errorTileCallback: (tile, error, stackTrace) =>
                                Get.dialog(_ErrorDialog()),
                            evictErrorTileStrategy:
                                EvictErrorTileStrategy.notVisibleRespectMargin,
                            errorImage:
                                AssetImage('assets/img/google-maps.png'),
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                            panBuffer: 10,
                            tileProvider: NetworkTileProvider(),
                          ),
                          MarkerLayer(markers: [
                            Marker(
                                width: 20.0,
                                height: 20.0,
                                point: LatLng(controller.latitudeLoc,
                                    controller.longitudeLoc),
                                builder: (ctx) => Container(
                                      child: Icon(
                                        Icons.location_pin,
                                        color: Colors.red,
                                        size: 30.0,
                                      ),
                                    ))
                          ])
                        ],
                      ),
                    ),
                  ),
                  10.heightBox,
                ]),
          ),
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
