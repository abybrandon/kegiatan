import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/event/widget/appbar_detail_event.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/asset_photo.dart';
import 'package:newtest/widget/custom_badge.dart';
import 'package:newtest/widget/loader.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/community_detail_controller.dart';

class CommunityDetailView extends GetView<CommunityDetailController> {
  const CommunityDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          controller.obx(
            onLoading: Loader(
              zeroOpacity: true,
            ),
            (state) => _BodyDetail(),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Obx(
                () => AppBarDetail(
                  isCustom: true,
                  isSearching: controller.isSearching,
                  title: controller.nameCommun.value,
                  isAppBarVisible: controller.isAppBarVisible,
                ),
              ))
        ],
      ),
    );
  }
}

class _BodyDetail extends StatefulWidget {
  const _BodyDetail({super.key});

  @override
  State<_BodyDetail> createState() => __BodyDetailState();
}

class __BodyDetailState extends State<_BodyDetail> {
  final ScrollController _controller = ScrollController();
  final controller = Get.find<CommunityDetailController>();
  bool isScrolledPast130 = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.offset >= 200.h) {
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

  final List<String> dataPict = [
    'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/costume_rent_images%2F1698079884765_.jpg?alt=media&token=53a14c0a-10a9-416d-ae2c-3ce4c195fee1&_gl=1*1f0luyo*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5ODMwMDA3Mi44MC4xLjE2OTgzMDE4ODMuNDMuMC4w',
    'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/community_image%2F1698300450197_.jpg?alt=media&token=0ae3fa70-16f9-4f51-bf4e-92eff9eb7e5f&_gl=1*35nasn*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5ODMwMDA3Mi44MC4xLjE2OTgzMDI0MTEuNTEuMC4w'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _controller,
      children: [
        Container(
          width: double.infinity,
          height: 200.h,
          child: AssetPhoto(
            image: controller.pictCommun,
            fit: BoxFit.fitWidth,
          ),
        ),
        16.h.heightBox,
        _ContentCommun(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            children: List.generate(
                100,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Container(
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: AssetPhoto(
                                    image: controller.pictCommun,
                                    height: 40.h,
                                    width: 40.w,
                                  ),
                                ),
                                12.w.widthBox,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.nameCommun.value,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: basicBlack,
                                            fontWeight: Config.semiBold),
                                      ),
                                      2.h.heightBox,
                                      Text(
                                        '10 Hour ago',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: bgGreyLite,
                                            fontWeight: Config.semiBold),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Remix.more_2_fill, size: 20.sp,)
                              ],
                            ),
                            12.h.heightBox,
                            Text(
                              'Kita Rencanya akan kesini ges otw ges',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: basicBlack,
                                  fontWeight: Config.reguler),
                            ),
                            16.h.heightBox,
                            SizedBox(
                              height: 200.h,
                              child: PageView.builder(
                                itemCount: dataPict.length,
                                onPageChanged: (index) {},
                                itemBuilder: (context, index) {
                                  return AssetPhoto(
                                    image: dataPict[index],
                                  );
                                },
                              ),
                            ),
                            4.h.heightBox,
                            Row(
                              children: [
                                Icon(
                                  Remix.heart_line,
                                  size: 22.sp,
                                ),
                                20.w.widthBox,
                                Icon(
                                  Remix.chat_3_line,
                                  size: 22.sp,
                                ),
                                20.w.widthBox,
                                Icon(
                                  Remix.bookmark_line,
                                  size: 22.sp,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
          ),
        )
      ],
    );
  }
}

class _ContentCommun extends GetView<CommunityDetailController> {
  const _ContentCommun({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                controller.nameCommun.value,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: Config.semiBold,
                    color: basicBlack),
              )),
              20.w.widthBox,
              Icon(
                Remix.more_fill,
                color: trueBlack,
                size: 20.sp,
              )
            ],
          ),
          4.h.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                controller.sloganCommun,
                style: TextStyle(
                    fontSize: 10.sp, fontWeight: Config.medium, color: bgGrey),
              )),
              20.w.widthBox,
              Row(
                children: [
                  Icon(
                    Remix.map_pin_line,
                    size: 8.sp,
                    color: Color(0xffBFC300),
                  ),
                  2.w.widthBox,
                  Text(
                    controller.locationCommun,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontSize: 8.sp,
                        color: bgGrey,
                        fontWeight: Config.medium),
                  ),
                ],
              ),
            ],
          ),
          8.h.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bio & Contact',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: Config.semiBold,
                    color: basicBlack),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse(controller.linkFacebook),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Image.asset(
                      'assets/icon/facebook.png',
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                  20.w.widthBox,
                  InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse('http:www.kontol'),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Image.asset(
                      'assets/icon/instagram.png',
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                ],
              )
            ],
          ),
          4.h.heightBox,
          BioTextWidget(
            bio: controller.bio,
          ),
          Divider(
            thickness: 1,
          ),
          6.h.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  8.w.widthBox,
                  Column(
                    children: [
                      Text(
                        '10',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: trueBlack,
                            fontWeight: Config.semiBold),
                      ),
                      Text(
                        'Post',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: bgRed,
                            fontWeight: Config.semiBold),
                      ),
                    ],
                  ),
                  20.w.widthBox,
                  Column(
                    children: [
                      Text(
                        '100',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: trueBlack,
                            fontWeight: Config.semiBold),
                      ),
                      Text(
                        'Followers',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: bgRed,
                            fontWeight: Config.semiBold),
                      ),
                    ],
                  ),
                ],
              ),
              CustomBadge(
                title: 'Follow',
                color: bgWhite,
                backgroundColor: bgRed,
                radius: 8.r,
                style: TextStyle(fontSize: 12.sp, fontWeight: Config.semiBold),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.h),
              )
            ],
          ),
          6.h.heightBox,
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class BioTextWidget extends StatelessWidget {
  final String bio;
  final int maxCharsToShow;

  BioTextWidget({required this.bio, this.maxCharsToShow = 100});

  @override
  Widget build(BuildContext context) {
    bool isExpanded = false;
    final truncatedBio =
        bio.length <= maxCharsToShow ? bio : bio.substring(0, maxCharsToShow);

    return Column(
      children: [
        Text(
          isExpanded ? bio : truncatedBio,
          style: TextStyle(
              fontSize: 10, color: Colors.black, fontWeight: FontWeight.normal),
        ),
        // if (bio.length > maxCharsToShow)
        //   GestureDetector(
        //     child: Text(
        //       isExpanded ? 'Less' : '... More',
        //       style: TextStyle(color: Colors.blue),
        //     ),
        //     onTap: () {
        //       // Toggle the "isExpanded" state when the "More" button is pressed
        //       // to expand or collapse the text.
        //       // This will trigger the widget to rebuild and update the view.
        //       isExpanded = !isExpanded;
        //     },
        //   ),
      ],
    );
  }
}
