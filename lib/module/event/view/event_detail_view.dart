import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:newtest/module/event/controller/detail_event_controller.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/asset_photo.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:newtest/widget/universal_appbar.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/button_tabbar.dart';
import '../../../widget/confirm_dialog.dart';

part '../widget/tabbar_map.dart';
part '../widget/tabbar_deskripsi.dart';
part '../widget/tabbar_guest_start.dart';

class EventDetailView extends GetView<DetailEventController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        backgroundColor: bgWhite,
        // appBar:
        // AppBarUniversal(
        // isSearching: controller.isSearching,
        // title: '',
        // isCustom: true,
        // ),
        // AppBar(
        //   elevation: 0,
        //   leading: Padding(
        //     padding: EdgeInsets.symmetric(
        //       vertical: 12.h,
        //       horizontal: 16.w,
        //     ),
        //     child: IconButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       padding: EdgeInsets.zero,
        //       constraints: const BoxConstraints(),
        //       splashRadius: 15.r,
        //       icon: Icon(
        //         Remix.arrow_left_line,
        //         size: 20.sp,
        //         color: bgRed,
        //       ),
        //     ),
        //   ),
        //   actions: [
        //     IconButton(
        //         onPressed: () async {
        //           if (controller.isEventSaved.value) {
        //             controller.deleteDetailEvent(controller.eventDetail.value);
        //           } else {
        //             controller.saveDetailEvent(controller.eventDetail.value);
        //           }
        //         },
        //         icon: Obx(() => Icon(
        //               Remix.heart_3_fill,
        //               color:
        //                   controller.isEventSaved.value ? bgRed : Colors.grey,
        //             ))),
        //     10.widthBox
        //   ],
        //   backgroundColor: bgWhite,
        // ),
        body: controller.obx(
            (state) => Stack(
                  children: [
                    _BodyDetail(),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: _FloatingButton())
                  ],
                ),
            onLoading: Loader()));
  }
}

class _BodyDetail extends GetView<DetailEventController> {
  
  final List<String> imageList = [
    'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_7.png?alt=media&token=ee2f9bac-f45d-4058-b010-b4bd38f8a050&_gl=1*en66nn*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNDguNDguMC4w',
    'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_1.png?alt=media&token=ff16e608-4ba9-4fa3-beb7-b0e83e000a41&_gl=1*1tq85ck*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNTguMzguMC4w',
    'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_5.png?alt=media&token=c490e068-023f-438a-8b59-d7e90a90845c&_gl=1*dncxim*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNjYuMzAuMC4w',
    'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_2.png?alt=media&token=f30376f6-05dd-423c-9684-b21067c86dfa&_gl=1*240u9e*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNzQuMjIuMC4w',
    // Tambahkan URL gambar lainnya sesuai kebutuhan Anda
  ];

  final RxInt currentImageIndex = 0.obs;
  final PageController pageController = PageController();

  void changeImage(int index) {
    currentImageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          40.heightBox,
              Row(
              children: [
                Expanded(
                  flex: 2, // Mengambil 2/3 dari lebar
                  child: Container(
                    height: 300,
                    child: AnimatedBuilder(
                      animation: pageController,
                      builder: (context, child) {
                        return PageView.builder(
                          controller: pageController,
                          itemCount: imageList.length,
                          onPageChanged: (index) {
                            changeImage(index);
                          },
                          itemBuilder: (context, index) {
                            return Image.network(imageList[index]);
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            20.h.heightBox,
                            Column(
                              children: imageList.asMap().entries.map((entry) {
                                int index = entry.key;
                                String url = entry.value;
                                return GestureDetector(
                                  onTap: () {
                                    changeImage(index);
                                    print(index);
                                  },
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: currentImageIndex == index
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ),
                                    child: Image.network(url),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
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
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: bgRed),
                  ),
                  10.heightBox,
                  Text(
                    controller.organizerEvent,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  10.heightBox,
                  Text(
                    controller.city,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  10.heightBox,
                ]),
          ),
          Divider(height: 4, thickness: 4),
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
                    'Tanggal 17 Agustus - 20 Agustus',
                    style: TextStyle(fontWeight: Config.semiBold),
                  ),
                  10.heightBox,
                ]),
          ),
          Divider(height: 4, thickness: 4),
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
                  Text('Detail Event',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Obx(
                          () => ButtonTabbar(
                              tittle: 'Deskripsi',
                              function: () {
                                controller.selectedButton.value = 0;
                              },
                              isSelected: controller.selectedButton.value == 0),
                        ),
                        Obx(
                          () => ButtonTabbar(
                              tittle: 'Guest Start',
                              function: () {
                                controller.selectedButton.value = 1;
                              },
                              isSelected: controller.selectedButton.value == 1),
                        ),
                        Obx(
                          () => ButtonTabbar(
                              tittle: 'Maps',
                              function: () {
                                controller.selectedButton.value = 2;
                              },
                              isSelected: controller.selectedButton.value == 2),
                        ),
                        Obx(
                          () => ButtonTabbar(
                              tittle: 'Rundown',
                              function: () {
                                controller.selectedButton.value = 3;
                              },
                              isSelected: controller.selectedButton.value == 3),
                        ),
                        Obx(
                          () => ButtonTabbar(
                              tittle: 'Rules',
                              function: () {
                                controller.selectedButton.value = 3;
                              },
                              isSelected: controller.selectedButton.value == 3),
                        ),
                      ],
                    ),
                  ),
                  20.heightBox,
                  Obx(() {
                    switch (controller.selectedButton.value) {
                      case 0:
                        //task
                        return _DescriptionPage();
                      case 1:
                        return const _GuestStartPage();
                      case 2:
                        return const _MapsEvent();
                      case 3:
                        return const _MapsEvent();
                      case 4:
                        return const _DescriptionPage();
                      default:
                        return _MapsEvent();
                    }
                  }),
                ]),
          ),
          80.heightBox,
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
        Get.offAllNamed(Routes.HOME);
      },
    );
  }
}

class _FloatingButton extends GetView<DetailEventController> {
  const _FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // mengatur posisi bayangan (x, y)
          ),
        ],
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h, top: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HTM',
                      style: TextStyle(
                          fontSize: 16, fontWeight: Config.bold, color: bgRed),
                    ),
                    Text(
                      '70k - 140k',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: Config.bold,
                          color: generalBody),
                    ),
                  ],
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  width: 158.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bgRed,
                      ),
                      onPressed: () {},
                      child: const Text('Cek Ticket')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
