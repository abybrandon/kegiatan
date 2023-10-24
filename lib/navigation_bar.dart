import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newtest/theme.dart';
import 'package:remixicon/remixicon.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class NavigationBar extends StatelessWidget {
  final _selectedIndex = 0.obs;

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
  }

  final currentIndex = 0.obs;

  SalomonBottomBarItem iconSolomon(
      {required String title,
      required IconData iconInactive,
      required IconData iconActive}) {
    return SalomonBottomBarItem(
      icon: Icon(
        iconInactive,
        size: 24.sp,
        color: Color(0xff080C2F).withOpacity(0.6),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      activeIcon: Icon(iconActive, size: 24.sp),
      unselectedColor: generalLabel,
      selectedColor: bgRed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: bgWhite),
      child: Scaffold(
          body: Obx(
            () {
              final children = AppPages.routes.last.children;
              final widgetList =
                  children.map<Widget>((page) => page.page()).toList();
              return IndexedStack(
                index: _selectedIndex.value,
                children: widgetList,
              );
            },
          ),
          bottomNavigationBar: Obx(
            () => SalomonBottomBar(
              backgroundColor: Colors.white,
              currentIndex: _selectedIndex.value,
              onTap: (index) => _selectedIndex.value = index,
              items: [
                iconSolomon(
                    iconActive: Remix.home_4_fill,
                    iconInactive: Remix.home_4_line,
                    title: 'Home'),
                iconSolomon(
                    iconActive: Remix.alarm_fill,
                    iconInactive: Remix.alarm_line,
                    title: 'Reminder'),
                iconSolomon(
                    iconActive: Remix.question_answer_fill,
                    iconInactive: Remix.question_answer_line,
                    title: 'Chats'),
                iconSolomon(
                    iconActive: Remix.user_fill,
                    iconInactive: Remix.user_line,
                    title: 'Profile'),
              ],
            ),
          )),
    );
  }
}
