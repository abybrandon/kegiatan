import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/event/widget/appbar_detail_event.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/asset_photo.dart';
import 'package:newtest/widget/custom_badge.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../costume_main/widget/widget_tabbar.dart';
import '../controller/costume_rent_detail_controller.dart';

part 'costume_rent_detail_costume_view.dart';
part 'costume_rent_rules_view.dart';

class CostumeRentDetailView extends StatefulWidget {
  CostumeRentDetailView({super.key});

  @override
  State<CostumeRentDetailView> createState() => _CostumeRentDetailViewState();
}

class _CostumeRentDetailViewState extends State<CostumeRentDetailView> {
  final controller = Get.find<CostumeRentDetailController>();
  @override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.fetchCostumeRentDetailById(Get.parameters["id"]!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => AnnotatedRegion(
          value: SystemUiOverlayStyle(statusBarColor: bgWhite),
          child: Scaffold(
            backgroundColor: bgWhite,
            body: Stack(
              children: [
                _BodyDetail(),
                Align(
                  alignment: Alignment.topCenter,
                  child: AppBarDetail(
                    isSearching: controller.isSearching,
                    title: controller.nameCostume,
                    isAppBarVisible: controller.isAppBarVisible,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class _BodyDetail extends StatefulWidget {
  @override
  State<_BodyDetail> createState() => _BodyDetailState();
}

class _BodyDetailState extends State<_BodyDetail>
    with SingleTickerProviderStateMixin {
  final RxInt currentImageIndex = 0.obs;

  final PageController pageController = PageController();

  void changeImage(int index) {
    currentImageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  final controller = Get.find<CostumeRentDetailController>();

  final ScrollController _controller = ScrollController();

  bool isScrolledPast130 = false;

  static const List<Tab> _tabs = [
    Tab(
      child: Text('Detail Costume'),
    ),
    Tab(
      child: Text('Rules Rent'),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: _controller,
            children: [
              Container(
                height: 250.h,
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
                          image: controller.getImages()[index],
                        );
                      },
                    );
                  },
                ),
              ),
              Column(
                children: [
                  20.h.heightBox,
                  Row(
                    children:
                        controller.getImages().asMap().entries.map((entry) {
                      int index = entry.key;
                      String url = entry.value;
                      return GestureDetector(
                          onTap: () {
                            changeImage(index);
                            print(index);
                          },
                          child: Obx(
                            () => Container(
                              width: 60.w,
                              height: 60.w,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: currentImageIndex.value == index
                                      ? bgRed
                                      : const Color(0xffE6E6E6),
                                ),
                              ),
                              child: CachedNetworkImage(imageUrl: url),
                            ),
                          ));
                    }).toList(),
                  ),
                ],
              ),
              8.heightBox,
              const _ContentBody(),
              8.h.heightBox,
              _ContentDetail(),
              20.h.heightBox,
              Container(
                decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 1))),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: basicBlack,
                  indicatorColor: basicBlack,
                  tabs: _tabs,
                  unselectedLabelColor: const Color(0xffA0A3BD),
                  onTap: (value) {
                    controller.selectedButton.value = value;
                  },
                ),
              ),
              Obx(() => controller.tabbarWidget),
              10.h.heightBox,
            ],
          ),
        ),
        Align(alignment: Alignment.bottomCenter, child: _FloatingButton()),
      ],
    );
  }
}

class _ContentBody extends GetView<CostumeRentDetailController> {
  const _ContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.nameCostume,
            style: TextStyle(
                fontSize: 16.sp,
                color: basicBlack,
                fontWeight: Config.semiBold),
          ),
          4.h.heightBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.charackterName,
                      style: TextStyle(
                          fontWeight: Config.medium,
                          fontSize: 10.sp,
                          color: basicBlack)),
                  CustomBadge(
                    title: 'Status Ready',
                    color: bgWhite,
                    backgroundColor: bgRed,
                    radius: 0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.charackterOrigin,
                      style: TextStyle(
                          fontWeight: Config.medium,
                          fontSize: 10.sp,
                          color: basicBlack)),
                ],
              ),
              4.h.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                        controller.categoryCostume.length,
                        (index) => Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: CustomBadge(
                                  title: controller.categoryCostume[index],
                                  color: bgRed,
                                  backgroundColor: bgWhite),
                            )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Gender ',
                        style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: Config.reguler,
                            color: bgRed),
                      ),
                      Icon(
                        Remix.men_line,
                        size: 14.sp,
                        color: bgRed,
                      ),
                      10.w.widthBox,
                      Text(
                        '13 Liked',
                        style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: Config.medium,
                            color: bgRed),
                      ),
                      2.w.widthBox,
                      Icon(
                        Remix.heart_fill,
                        size: 14.sp,
                        color: bgRed,
                      ),
                    ],
                  ),
                ],
              ),
              4.h.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '10 Second ago by ',
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: basicBlack,
                            fontWeight: Config.reguler),
                      ),
                      Text('RentalAyam',
                          style: TextStyle(
                              fontWeight: Config.bold,
                              fontSize: 12.sp,
                              color: bgRed)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Remix.map_pin_line,
                        size: 12.sp,
                        color: basicBlack,
                      ),
                      2.w.widthBox,
                      Text(
                        'Kota Jakarta',
                        style: TextStyle(
                            fontSize: 8.sp,
                            color: bgGrey,
                            fontWeight: Config.medium),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          8.h.heightBox,
        ],
      ),
    );
  }
}

class _ContentOwner extends GetView<CostumeRentDetailController> {
  const _ContentOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(80.r),
                child: Container(
                  color: bgRed,
                  height: 45.h,
                  width: 45.w,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/uploads%2FnoPhoto.png?alt=media&token=727f17d6-63c3-45e3-948f-d54d6c96b2eb&_gl=1*1nyzdex*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5Nzc2ODE3OC41MS4xLjE2OTc3Njg5MzguMzIuMC4w',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              4.w.widthBox,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '10 Second ago by ',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: basicBlack,
                                  fontWeight: Config.reguler),
                            ),
                            Text(
                              'Rental Ayam',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: bgRed,
                                  fontWeight: Config.medium),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Remix.map_pin_line,
                              size: 12.sp,
                              color: bgGrey,
                            ),
                            2.w.widthBox,
                            Text(
                              'Kota Jakarta',
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: bgGrey,
                                  fontWeight: Config.medium),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomBadge(
                      title: 'See Profile Owner',
                      color: bgRed,
                      backgroundColor: bgWhite,
                      radius: 0,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ContentDetail extends GetView<CostumeRentDetailController> {
  _ContentDetail({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Size Avail',
                  style: TextStyle(
                      fontWeight: Config.semiBold,
                      fontSize: 12.sp,
                      color: basicBlack)),
              Text('Brand',
                  style: TextStyle(
                      fontWeight: Config.semiBold,
                      fontSize: 12.sp,
                      color: basicBlack)),
            ],
          ),
          6.h.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: ['S', 'M', 'L', 'XL'].map((size) {
                  final isAvailable = controller.sizeAvail.contains(size);
                  final textColor = isAvailable ? basicBlack : Colors.white;
                  final bgColor =
                      isAvailable ? Colors.white : bgGrey.withOpacity(0.1);
                  RxBool isTrue = false.obs;
                  isTrue.value = isAvailable;
                  return _WidgetSize(
                    size: size,
                    textColor: textColor,
                    bgColor: bgColor,
                    isAvail: isTrue,
                  );
                }).toList(),
              ),
              CustomBadge(
                title: controller.brandName,
                color: bgGrey,
                backgroundColor: bgWhite,
                radius: 0,
                textColor: basicBlack,
                style: TextStyle(fontSize: 12.sp, fontWeight: Config.medium),
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _WidgetSize extends StatelessWidget {
  _WidgetSize(
      {super.key,
      required this.size,
      required this.textColor,
      required this.bgColor,
      required this.isAvail});
  final String size;
  final Color textColor;
  Color bgColor;
  final RxBool isOn = false.obs;

  final RxBool isAvail;
  Color bgColorRed = bgRed;
  Color bgTextRed = bgWhite;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: InkWell(
            onTap: () {
              if (isAvail.value) {
                isOn.value = !isOn.value;
              } else {}
            },
            child: Container(
              width: 30.w,
              height: 31.h,
              decoration: ShapeDecoration(
                color: isOn.value ? bgColorRed : bgColor,
                shape: OvalBorder(
                  side: BorderSide(
                    width: 1.w,
                    color: isOn.value ? bgColorRed : bgColor,
                  ),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 1,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Center(
                child: Text(
                  size,
                  style: TextStyle(
                    color: isOn.value ? bgTextRed : textColor,
                    fontSize: 14.sp,
                    fontWeight: Config.medium,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class _FloatingButton extends GetView<CostumeRentDetailController> {
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
                      'Rent Rate',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: Config.bold,
                          color: bgRed),
                    ),
                    Text(
                      'RP 130.000 / 3 Day',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: Config.bold,
                          color: generalBody),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Remix.error_warning_line,
                      size: 20.sp,
                      color: bgRed,
                    ),
                    12.w.widthBox,
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: 48.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: basicBlack,
                          ),
                          onPressed: () {},
                          child: Icon(
                            Remix.store_3_line,
                            size: 20.sp,
                            color: bgWhite,
                          )),
                    ),
                    12.w.widthBox,
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: 48.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: bgRed,
                          ),
                          onPressed: () {},
                          child: Icon(
                            Remix.discuss_line,
                            size: 20.sp,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
