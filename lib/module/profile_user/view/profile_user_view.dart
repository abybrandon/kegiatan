import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/local_storage/local_storage_helper.dart';
import 'package:newtest/routes/app_pages.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/bottom_sheet_action.dart';
import 'package:newtest/widget/confirm_dialog.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:newtest/widget/toast.dart';
import 'package:remixicon/remixicon.dart';
import '../controller/profile_user_controller.dart';
import '../widget/button_profile_widget.dart';

part '../widget/single_action_liked_content.dart';
part '../widget/single_action_delete_account.dart';

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
          icon: Remix.lock_password_line,
          title: 'Change Password',
          fuction: () {
            Get.toNamed(
              Routes.CHANGE_PASSWORD,
            );
          },
        ),
        ButtonProfileWidget(
          icon: Remix.delete_bin_5_line,
          title: 'Delete Account',
          fuction: () {
            showDialog(
              context: context,
              builder: (context) {
                return ConfirmDialog(
                  headerIcon: Remix.information_line,
                  headerText: 'Delete Account',
                  body: Text(
                    'Are you sure want to delete your account? By doing this you will lose all of your saved data and will not be able to retrive it.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: Config.medium,
                    ),
                  ),
                  onApply: () async {},
                );
              },
            );
          },
        ),
        ButtonProfileWidget(
          icon: Remix.logout_box_line,
          title: 'Logout',
          fuction: () async {
            showDialog(
              context: context,
              builder: (context) {
                return ConfirmDialog(
                  headerIcon: Remix.information_line,
                  headerText: 'Logout',
                  body: Text(
                    'Are you sure want to Logout',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: Config.medium,
                    ),
                  ),
                  onApply: () async {
                    
            await SharedPreferenceHelper.removeUserData();
            Get.offAllNamed(Routes.LOGIN);
                  },
                );
              },
            );
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
          fuction: () {
            Toast.showErrorToastWithoutContext('Error you cant login');
          },
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
