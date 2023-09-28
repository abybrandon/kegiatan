import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/routes/app_pages.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

class MenuAdmin extends StatelessWidget {
  const MenuAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgRed,
        title: Text('Admin Menu'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCard(
                title: 'Create Event',
                icon: Remix.pencil_fill,
                function: () {
                  Get.toNamed(Routes.CREATE_EVENT_ADMIN);
                }),
            10.h.heightBox,
            CustomCard(
                title: 'Create Artist',
                icon: Remix.shield_user_line,
                function: () {
                  Get.toNamed(Routes.CREATE_ARTIST_ADMIN);
                }),
            10.h.heightBox,
            CustomCard(
                title: 'Create Location',
                icon: Remix.user_location_line,
                function: () {}),
                   10.h.heightBox,
            CustomCard(
                title: 'Post Costume Rent',
                icon: Remix.wechat_pay_line,
                function: () {
                  Get.toNamed(Routes.CREATE_COSTUME_RENT);
                }),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback function;

  CustomCard({required this.title, required this.icon, required this.function});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Card(
        elevation: 2.0,
        child: ListTile(
          onTap: function,
          leading: Icon(
            icon,
            size: 20.sp,
            color: bgRed,
          ),
          title: Text(
            title,
            style: TextStyle(
                color: generalBody,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp),
          ),
          trailing: Icon(
            Icons.arrow_forward,
            size: 24.sp,
            color: bgRed,
          ),
        ),
      ),
    );
  }
}
