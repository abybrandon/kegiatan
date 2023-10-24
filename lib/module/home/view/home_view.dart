import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/home/controller/home_controller.dart';
import 'package:newtest/module/home/view/search_view.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_badge.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';
import 'package:extended_sliver/extended_sliver.dart';
import '../../../routes/app_pages.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  final controller = Get.find<HomeController>();
  final ScrollController _controller = ScrollController();
  bool isScrolledPast130 = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset >= 140.0) {
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
    double statusBarHeight = MediaQuery.of(context).padding.top;

    List<Color> duplicateColor(Color color, int count) {
      List<Color> colors = List<Color>.generate(count, (int index) => color);
      return colors;
    }

    return Stack(
      children: [
        AnnotatedRegion(
          value: SystemUiOverlayStyle(statusBarColor: bgRed),
          child: Scaffold(
            backgroundColor: bgWhite,
            body: NotificationListener<ScrollUpdateNotification>(
              onNotification: (notification) {
                // Handle scroll notifications here
                return true;
              },
              child: ListView(
                controller: _controller,
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 130.0,
                            padding: EdgeInsets.only(left: 16.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors:
                                    duplicateColor(bgRed, 11) + [Colors.white],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Obx(
                                      () => Text(
                                        'Hii , ${controller.userData.value}',
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            color: bgWhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: bgWhite,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  Radius.circular(8.r))),
                                      height: 45.h,
                                      width: 45.w,
                                      child: Center(
                                          child: Icon(
                                        Remix.notification_3_line,
                                        color: basicBlack,
                                        size: 24.sp,
                                      )),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Discover Our World',
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      color: bgWhite,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 25.h,
                            color: bgWhite,
                          )
                        ],
                      ),
                      Positioned(
                          bottom: 0.h,
                          left: 0.w,
                          right: 0.w,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Card(
                              elevation: 1.5,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: bgRed,
                                      ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Get.dialog(SearchView());
                                  },
                                  child: SizedBox(
                                    height: 45.h,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Search..',
                                          enabled: false,
                                          
                                          contentPadding:
                                              EdgeInsets.only(top: 10.h),
                                          prefixIcon: Icon(
                                            Remix.search_line,
                                            size: 22.sp,
                                          ),
                                          hintStyle: TextStyle(
                                              fontSize: 14.sp,
                                              color: semiGrey,
                                              fontWeight: Config.medium),
                                          filled: false,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          fillColor: Colors.transparent),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  _ListRecord()
                ],
              ),
            ),
          ),
        ),
        Obx(() => controller.isAppBarVisible.value
            ? Positioned(
                top: 0.h,
                left: 0.w,
                right: 0.w,
                child: Padding(
                  padding: EdgeInsets.only(top: statusBarHeight.h - 1),
                  child: _HomeAppBar(),
                ))
            : SizedBox.shrink())
      ],
    );
  }
}

class _HomeAppBar extends GetView<HomeController>
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.h);
  _HomeAppBar({focusNode});

  @override
  Widget build(BuildContext context) {
    final Widget searchingTopBar = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Card(
            elevation: 1.5,
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ThemeData().colorScheme.copyWith(
                      primary: bgRed,
                    ),
              ),
              child: InkWell(
                onTap: () {
                  Get.dialog(SearchView());
                },
                child: SizedBox(
                  height: 38.h,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search..',
                        contentPadding: EdgeInsets.only(bottom: 2.h, top: 2.h),
                        prefixIcon: Icon(
                          Remix.search_line,
                          size: 22.sp,
                        ),
                        hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: semiGrey,
                            fontWeight: Config.medium),
                        filled: true,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: bgWhite),
                  ),
                ),
              ),
            ),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: searchingTopBar),
            ],
          ),
        ));
  }
}

class _ListRecord extends GetView<HomeController> {
  const _ListRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.h.heightBox,
        _HeaderTittle(
          title: 'Feature',
          hideTitle: true,
        ),
        8.h.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _FeatureButton(
              imageName: 'assets/img/gate.png',
              title: 'Event',
              fuction: () {
                Get.toNamed(Routes.EVENT_LIST);
              },
            ),
            _FeatureButton(
              imageName: 'assets/img/costume.png',
              title: 'Costume',
              fuction: () {
                Get.toNamed(Routes.COSTUME_RENT);
              },
            ),
            _FeatureButton(
              imageName: 'assets/img/comunt.png',
              title: 'Community',
            )
          ],
        ),
        20.h.heightBox,
        _HeaderTittle(
          title: 'Search Event by city',
        ),
        8.h.heightBox,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Row(
              children: List.generate(
                  controller.dataCity.length,
                  (index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 6.h),
                            decoration: BoxDecoration(
                                color: bgRed,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Text(
                              '${controller.dataCity[index]}',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: bgWhite,
                                  fontWeight: Config.medium),
                            )),
                      )),
            ),
          ),
        ),
        20.h.heightBox,
        _HeaderTittle(
          title: 'Event Near You',
        ),
        8.h.heightBox,
        _EventRecord(),
        16.h.heightBox,
        _HeaderTittle(
          title: 'Popular Costume',
        ),
        8.h.heightBox,
        _CostumeRecord(),
        16.h.heightBox,
        _HeaderTittle(
          title: 'Community Near You',
          hideTitle: true,
        ),
        Column(
          children: List.generate(
              3,
              (index) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/img/group.png',
                          fit: BoxFit.cover,
                        ),
                        2.h.heightBox,
                        Text(
                          'Community Group Cosplay',
                          style: TextStyle(
                              fontWeight: Config.reguler,
                              color: trueBlack,
                              fontSize: 12.sp),
                        )
                      ],
                    )),
                  )),
        )
      ],
    );
  }
}

class _FeatureButton extends StatelessWidget {
  const _FeatureButton(
      {super.key, required this.title, this.fuction, required this.imageName});
  final String title;
  final String imageName;
  final VoidCallback? fuction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: fuction,
          child: Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              color: Color(0xffF8F8F8),
            ),
            child: Center(
              child: Image.asset(
                imageName,
                height: 45.h,
                width: 45.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        2.h.heightBox,
        Text(
          title,
          style: TextStyle(
              fontSize: 14.sp, color: basicBlack, fontWeight: Config.semiBold),
        ),
      ],
    );
  }
}

class _HeaderTittle extends StatelessWidget {
  const _HeaderTittle(
      {super.key, required this.title, this.fuction, this.hideTitle = false});
  final String title;
  final VoidCallback? fuction;
  final bool hideTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14.sp,
                color: basicBlack,
                fontWeight: Config.semiBold),
          ),
          hideTitle
              ? SizedBox.shrink()
              : InkWell(
                  onTap: fuction,
                  child: Text(
                    'See All',
                    style: TextStyle(
                        fontSize: 14.sp, color: bgRed, fontWeight: Config.bold),
                  ),
                ),
        ],
      ),
    );
  }
}

class _EventRecord extends GetView<HomeController> {
  const _EventRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Row(
          children: List.generate(
              controller.dataEvent.length,
              (index) => Padding(
                  padding: EdgeInsets.only(right: 18.w),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        width: 123.w,
                        height: 209.h,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFE6E6E6)),
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
                              child: Image.asset(
                                'assets/img/${controller.dataEvent[index]['image']}',
                                height: 150.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            4.h.heightBox,
                            Text(
                              '${controller.dataEvent[index]['eventName']}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: trueBlack,
                                  fontWeight: Config.semiBold),
                            ),
                            Text(
                              '${controller.dataEvent[index]['dateEvent']}',
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: bgGrey,
                                  fontWeight: Config.medium),
                            ),
                            2.h.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      'Kota ${controller.dataEvent[index]['city']}',
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
                                      '13',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          color: trueLove,
                                          fontWeight: Config.medium),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}

class _CostumeRecord extends GetView<HomeController> {
  const _CostumeRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Row(
          children: List.generate(
              controller.dataCostume.length,
              (index) => Padding(
                  padding: EdgeInsets.only(right: 18.w),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        width: 123.w,
                        height: 239.h,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFE6E6E6)),
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
                              child: Image.asset(
                                'assets/img/${controller.dataCostume[index]['image']}',
                                height: 150.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            4.h.heightBox,
                            Text(
                              '${controller.dataCostume[index]['nameCostume']}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: trueBlack,
                                  fontWeight: Config.semiBold),
                            ),
                            Text(
                              '${controller.dataCostume[index]['charackterOrigin']}',
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: bgRed,
                                  fontWeight: Config.medium),
                            ),
                            Text(
                              'Rp ${controller.dataCostume[index]['priceRent']['rentPrice']} / ${controller.dataCostume[index]['priceRent']['rentDay']} Day',
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: bgGrey,
                                  fontWeight: Config.medium),
                            ),
                            2.h.heightBox,
                            CustomBadge(
                              title: 'Anime',
                              backgroundColor: bgWhite,
                              color: bgRed,
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              minWidth: 0,
                            ),
                            4.h.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      'Kota ${controller.dataCostume[index]['location']}',
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
                                      '13',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          color: trueLove,
                                          fontWeight: Config.medium),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}
