import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SalomonBottomBarItem(
                  icon: Icon(Remix.home_heart_line),
                  title: Text('Home'),
                  activeIcon: Icon(Remix.home_heart_fill),
                  unselectedColor: generalLabel,
                  selectedColor: bgRed),
              SalomonBottomBarItem(
                icon: Icon(Remix.heart_line),
                activeIcon: Icon(Remix.heart_fill),
                unselectedColor: generalLabel,
                title: Text('Screen 1'),
                selectedColor: Colors.red,
              ),
              SalomonBottomBarItem(
                  icon: Icon(Remix.notification_2_line),
                  title: Text('Screen 2'),
                  activeIcon: Icon(Remix.notification_2_fill),
                  unselectedColor: generalLabel,
                  selectedColor: bgRed),
              SalomonBottomBarItem(
                icon: Icon(Remix.user_2_line),
                title: Text('Screen 3'),
                activeIcon: Icon(Remix.user_2_fill),
                unselectedColor: generalLabel,
                selectedColor: Colors.orange,
              ),
            ],
          ),
        ));
  }
}
