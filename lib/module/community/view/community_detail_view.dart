import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/event/widget/appbar_detail_event.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/asset_photo.dart';
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
        20.h.heightBox,
        Center(
          child: Column(
            children: List.generate(100, (index) => Text('hehe')),
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
    final truncatedBio = bio.length <= maxCharsToShow ? bio : bio.substring(0, maxCharsToShow);

    return Column(
      children: [
        Text(
          isExpanded ? bio : truncatedBio,
          style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.normal),
        ),
        if (bio.length > maxCharsToShow)
          GestureDetector(
            child: Text(
              isExpanded ? 'Less' : '... More',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              // Toggle the "isExpanded" state when the "More" button is pressed
              // to expand or collapse the text.
              // This will trigger the widget to rebuild and update the view.
              isExpanded = !isExpanded;
            },
          ),
      ],
    );
  }
}
