import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:newtest/module/event/controller/detail_event_controller.dart';
import 'package:newtest/module/event/widget/expandable_widget.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/asset_photo.dart';
import 'package:newtest/widget/date_formatter.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/button_tabbar.dart';
import '../../../widget/confirm_dialog.dart';
import '../widget/appbar_detail_event.dart';

part '../widget/tabbar_map.dart';
part '../widget/tabbar_deskripsi.dart';
part '../widget/tabbar_guest_start.dart';
part '../widget/tabbar_content.dart';

class EventDetailView extends StatefulWidget {
  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  final controller = Get.find<DetailEventController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchEventDetailById(Get.parameters["id"]!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: bgWhite),
      child: Scaffold(
          backgroundColor: bgWhite,
          body: controller.obx(
            (state) => Stack(
              children: [
                Obx(() => controller.eventDetail.value == null
                    ? Loader()
                    : _BodyDetail()),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: _FloatingButton()),
                Align(
                  alignment: Alignment.topCenter,
                  child: AppBarDetail(
                    isSearching: controller.isSearching,
                    title: controller.nameEvent,
                    isAppBarVisible: controller.isAppBarVisible,
                  ),
                )
              ],
            ),
            onLoading: Loader(),
            onError: (error) {
              return CircularProgressIndicator();
            },
          )),
    );
  }
}

class _BodyDetail extends StatefulWidget {
  @override
  State<_BodyDetail> createState() => _BodyDetailState();
}

class _BodyDetailState extends State<_BodyDetail> {
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

  final controller = Get.find<DetailEventController>();

  final ScrollController _controller = ScrollController();
  bool isScrolledPast130 = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset >= 10.h) {
        if (!isScrolledPast130) {
          controller.isAppBarVisible.value = true;
          isScrolledPast130 = true;
        }
      } else {
        if (isScrolledPast130) {
          controller.isAppBarVisible.value = false;
          isScrolledPast130 = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 300.h,
                  child: AnimatedBuilder(
                    animation: pageController,
                    builder: (context, child) {
                      return PageView.builder(
                        controller: pageController,
                        itemCount: controller.getImages().length,
                        onPageChanged: (index) {
                          currentImageIndex.value = index;
                        },
                        itemBuilder: (context, index) {
                          return AssetPhoto(
                            height: 100.h,
                            image: controller.getImages()[index],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 300.h,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          20.h.heightBox,
                          Column(
                            children: controller
                                .getImages()
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              String url = entry.value;
                              return GestureDetector(
                                  onTap: () {
                                    changeImage(index);
                                    print(index);
                                  },
                                  child: Obx(
                                    () => Container(
                                      width: 75.w,
                                      height: 75.w,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              currentImageIndex.value == index
                                                  ? bgRed
                                                  : Color(0xffE6E6E6),
                                        ),
                                      ),
                                      child: CachedNetworkImage(imageUrl: url),
                                    ),
                                  ));
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
          16.heightBox,
          _ContentBody()
        ],
      ),
    );
  }
}

class _ContentBody extends GetView<DetailEventController> {
  _ContentBody({super.key});

  DateUtil dateUtil = DateUtil();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                      fontWeight: Config.semiBold,
                      fontSize: 16.sp,
                      color: bgRed),
                ),
                2.heightBox,
                Row(
                  children: [
                    Text('Event Organizer : ',
                        style: TextStyle(
                            fontWeight: Config.medium,
                            fontSize: 8.sp,
                            color: bgGrey)),
                    Text(controller.eventOrganizer,
                        style: TextStyle(
                            fontWeight: Config.medium,
                            fontSize: 8.sp,
                            color: Color(0xff4AD6C9))),
                  ],
                ),
                16.h.heightBox,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60.r),
                      child: Container(
                          padding: EdgeInsets.only(bottom: 1.h),
                          width: 24.w,
                          height: 24.h,
                          color: basicBlack,
                          child: Center(
                            child: Icon(
                              Remix.map_pin_line,
                              color: bgWhite,
                              size: 20.sp,
                            ),
                          )),
                    ),
                    4.w.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            controller.locationName,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: basicBlack,
                                fontWeight: Config.semiBold),
                          ),
                          2.h.heightBox,
                          Text(
                            controller.locationAddress,
                            style: TextStyle(
                                fontSize: 8.sp,
                                color: bgGrey,
                                fontWeight: Config.medium),
                          ),
                          2.h.heightBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Get Direction',
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    color: bgRed,
                                    fontWeight: Config.medium),
                              ),
                              2.w.widthBox,
                              Image.asset(
                                'assets/img/google-maps.png',
                                height: 14.h,
                                width: 14.w,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                8.h.heightBox,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60.r),
                      child: Container(
                          width: 24,
                          height: 24,
                          padding: EdgeInsets.only(bottom: 1.h),
                          color: basicBlack,
                          child: Center(
                            child: Icon(
                              Remix.time_line,
                              color: bgWhite,
                              size: 20.sp,
                            ),
                          )),
                    ),
                    4.w.widthBox,
                    Text(
                      '${dateUtil.formatTimestamps(controller.eventDetail.value?.eventDate.startDate, controller.eventDetail.value?.eventDate.endDate)}, ${controller.time}',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: basicBlack,
                          fontWeight: Config.semiBold),
                    ),
                  ],
                ),
                4.h.heightBox,
              ]),
        ),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Obx(
                        () => ButtonTabbar(
                            tittle: 'Overview',
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
                            tittle: 'Content',
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
                      return const _ContentPage();
                    case 3:
                      return const _MapsEvent();
                    case 4:
                      return const _DescriptionPage();
                    default:
                      return _DescriptionPage();
                  }
                }),
              ]),
        ),
        80.heightBox,
      ],
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
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h, top: 16.h),
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
                      'Ticket Price',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: Config.bold,
                          color: bgRed),
                    ),
                    Text(
                      'RP 70.000 - 140.000',
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
                      onPressed: () {
                        controller.updateDocument();
                      },
                      child: Text(
                        'Check Ticket',
                        style: TextStyle(
                            fontWeight: Config.semiBold,
                            color: bgWhite,
                            fontSize: 16.sp),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
