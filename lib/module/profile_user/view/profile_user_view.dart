import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/local_storage/local_storage_helper.dart';
import 'package:newtest/routes/app_pages.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/bottom_sheet_action.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../controller/profile_user_controller.dart';
import '../widget/button_profile_widget.dart';

class ProfileUserView extends StatelessWidget {
  const ProfileUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 20.w, top: 45.h),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_HeaderSection(), 32.h.heightBox, _BodySection()]),
          ),
        ),
      ),
    );
  }
}

class _BodySection extends GetView<ProfileUserController> {
  const _BodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: TextStyle(
              color: bgRed, fontWeight: Config.medium, fontSize: textMedium),
        ),
        8.h.heightBox,
        ButtonProfileWidget(
          icon: Remix.user_3_line,
          title: 'Change Username',
          fuction: () {
            Get.toNamed(
              Routes.CHANGE_USERNAME,
            );
          },
        ),
        ButtonProfileWidget(
          icon: Remix.mail_line,
          title: 'Change Email',
        ),
        ButtonProfileWidget(
          icon: Remix.lock_password_line,
          title: 'Change Pasword',
          fuction: () {
            Get.toNamed(
              Routes.CHANGE_PASSWORD,
            );
          },
        ),
        ButtonProfileWidget(
          icon: Remix.logout_box_line,
          title: 'Logout',
          fuction: () async {
            await SharedPreferenceHelper.removeUserData();
            Get.offAllNamed(Routes.LOGIN);
          },
        ),
        4.h.heightBox,
        Text(
          'General',
          style: TextStyle(
              color: bgRed, fontWeight: Config.medium, fontSize: textMedium),
        ),
        8.h.heightBox,
        ButtonProfileWidget(
          icon: Remix.notification_3_line,
          title: 'Notification',
        ),
        ButtonProfileWidget(
          icon: Remix.global_line,
          title: 'Language',
        ),
        ButtonProfileWidget(
          icon: Remix.star_line,
          title: 'Rate Us',
        ),
        ButtonProfileWidget(
          icon: Remix.heart_2_line,
          title: 'Liked Content',
          fuction: () {
            showModalBottomSheet(
              context: Get.overlayContext!,
              builder: (context) {
                return _SingleActionLikedContent();
              },
            );
          },
        ),
        4.h.heightBox,
        Text(
          'Support',
          style: TextStyle(
              color: bgRed, fontWeight: Config.medium, fontSize: textMedium),
        ),
        8.h.heightBox,
        ButtonProfileWidget(
          icon: Remix.article_line,
          title: 'Terms of Service',
        ),
        ButtonProfileWidget(
          icon: Remix.shield_keyhole_line,
          title: 'Data Policy',
        ),
        ButtonProfileWidget(
          icon: Remix.information_line,
          title: 'Contact Us',
          fuction: () {
            controller.sendOTP();
          },
        ),
      ],
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile',
          style: TextStyle(
              fontSize: 18.sp, color: bgRed, fontWeight: FontWeight.bold),
        ),
        4.h.heightBox,
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80.r),
              child: Image.network(
                'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                width: 60.w,
                height: 60.h,
                fit: BoxFit.cover,
              ),
            ),
            10.w.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AbyBrandon',
                  style: TextStyle(
                      fontSize: textBig,
                      color: trueBlack,
                      fontWeight: Config.semiBold),
                ),
                Text(
                  'aby.brandon@gmail.com',
                  style: TextStyle(
                      fontSize: textMedium,
                      color: basicBlack,
                      fontWeight: Config.medium),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _SingleActionLikedContent extends StatelessWidget {
  const _SingleActionLikedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 20.w,
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Remix.heart_2_fill, color: bgRed, size: 20.sp,),
                12.w.widthBox,
                Text(
                  'Liked Content',
                  style: TextStyle(
                      color: bgRed, fontWeight: Config.semiBold, fontSize: 16.sp),
                ),
              ],
            ),
            20.h.heightBox,
            BottomSheetAction(
              title: 'Liked Event',
              icon: Remix.file_info_line,
              iconColor: bgRed,
              imagePath: 'assets/img/gate.png',
              onTap: () {
                Get.back();
              },
            ),
            BottomSheetAction(
              title: 'Liked Costume',
              icon: Remix.shirt_line,
              imagePath: 'assets/img/costume.png',
              iconColor: bgRed,
              onTap: () {
                Get.back();
              },
            ),
            BottomSheetAction(
              title: 'Liked Community',
              imagePath: 'assets/img/comunt.png',
              icon: Remix.file_info_line,
              iconColor: bgRed,
              onTap: () {
                Get.back();
              },
            ),
          ]),
    );
  }
}
