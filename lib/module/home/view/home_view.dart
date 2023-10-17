import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/module/home/controller/home_controller.dart';
import 'package:newtest/theme.dart';
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
  final ScrollController _controller = ScrollController();
  final controller = Get.find<HomeController>();
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
                                    Text(
                                      'Hii , Mazuya',
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          color: bgWhite,
                                          fontWeight: FontWeight.bold),
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
                          bottom: 0.h, // Set the bottom position to 0
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
                                child: SizedBox(
                                  height: 45.h,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Search..',
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
                          )),
                    ],
                  ),
                  Column(
                    children:
                        List.generate(100, (index) => Text('hai ini $index')),
                  )
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
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    final Widget searchingTopBar = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Remix.search_2_line,
          size: 25.sp,
          color: bgRed,
        ),
        SizedBox(width: 10.w),
        Expanded(child: SizedBox(height: 43.h, child: TextField())),
        SizedBox(width: 7.w),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          splashRadius: 15.r,
          constraints: const BoxConstraints(),
          icon: Icon(
            Remix.close_fill,
            size: 20.sp,
            color: bgRed,
          ),
        ),
      ],
    );

    return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          color: bgWhite,
          child: Obx(() => controller.isAppBarVisible.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: searchingTopBar),
                    Divider(
                      thickness: 1,
                      color: bgRed,
                    )
                  ],
                )
              : SizedBox()),
        ));
  }
}

// class _AppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Size get preferredSize => Size.fromHeight(140);

//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//         preferredSize: preferredSize,
//         child: Container(
//           decoration: BoxDecoration(
//               color: bgRed,
//               borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(20),
//                   bottomLeft: Radius.circular(20))),
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             children: [
//               50.heightBox,
//               TextField(
//                 decoration: InputDecoration(
//                   filled: true,
//                   suffixIcon: Icon(
//                     Remix.search_2_line,
//                     color: bgRed,
//                   ),
//                   fillColor: Colors.grey[200],
//                   hintText: 'Enter text here ...',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class _FormHome extends StatelessWidget {
//   _FormHome({super.key});

//   RxBool isOn = false.obs;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//       child: Column(
//         children: [
//           20.heightBox,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _HomeButton(
//                   imagePath: 'assets/img/gate.png',
//                   tittle: 'Event',
//                   fuction: () {
//                     Get.toNamed(Routes.EVENT_LIST);
//                   }),
//               _HomeButton(
//                 imagePath: 'assets/img/costume.png',
//                 tittle: 'Cosplay',
//                 fuction: () {
//                   Get.toNamed(Routes.COSTUME_RENT);
//                 },
//               ),
//               _HomeButton(
//                 imagePath: 'assets/img/comunt.png',
//                 tittle: 'Commun',
//                 fuction: () {},
//               )
//             ],
//           ),
//           Obx(() => InkWell(
//               onTap: () {
//                 isOn.value = !isOn.value;
//               },
//               child: Icon(
//                 Remix.heart_2_fill,
//                 color: isOn.value ? bgRed : bgGrey,
//               )))
//         ],
//       ),
//     );
//   }
// }

// class _HomeButton extends StatelessWidget {
//   const _HomeButton(
//       {super.key,
//       required this.imagePath,
//       required this.tittle,
//       required this.fuction});
//   final String imagePath;
//   final String tittle;
//   final VoidCallback fuction;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: fuction,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Card(
//           elevation: 2,
//           child: Container(
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(300)),
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//             height: 115,
//             width: 70,
//             child: Column(
//               children: [
//                 Image.asset(
//                   imagePath,
//                   height: 72,
//                   width: 72,
//                   fit: BoxFit.contain,
//                 ),
//                 Expanded(
//                   child: Text(
//                     tittle,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: generalBody),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomeView extends StatefulWidget {
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   final ScrollController _controller = ScrollController();
//   final controller = Get.find<HomeController>();
//   bool isScrolledPast130 = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       final pixelsScrolled = _controller.offset;

//       // Cetak jumlah pixel yang telah di-scroll
//       print('Pixels Scrolled: $pixelsScrolled');

//       if (_controller.offset >= 130) {
//         if (!isScrolledPast130) {
//           controller.isAppBarVisible.value = true;
//           isScrolledPast130 = true;
//         }
//       } else {
//         if (isScrolledPast130) {
//           controller.isAppBarVisible.value = false;
//           isScrolledPast130 = false;
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double statusBarHeight = MediaQuery.of(context).padding.top;
//     return Scaffold(
      
//       body: NotificationListener<ScrollUpdateNotification>(
//         onNotification: (notification) {
//           // Handle scroll notifications here
//           return true;
//         },
//         child: Stack(
//           children: [
//             NestedScrollView(
//               controller: _controller,
//               headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//                 return <Widget>[
//                   Obx(
//                     () => controller.isAppBarVisible.value
//                         ? SliverPersistentHeader(
//                             floating: false,
//                             pinned: true,
//                             delegate: MySliverPersistentHeaderDelegate(
//                                 minHeight: 100.0,
//                                 maxHeight: 100.0,
//                                 child: Container(
//                                   color: Colors.green,
//                                   alignment: Alignment.center,
//                                   child: Text('Sliver 32 32 32'),
//                                 )),
//                           )
//                         : SliverPersistentHeader(
//                             floating: false,
//                             delegate: MySliverPersistentHeaderDelegate(
//                               minHeight: 160.0,
//                               maxHeight: 160.0,
//                               child: Container(
//                                 height: 160.0,
//                                 padding: EdgeInsets.only(
//                                     top: statusBarHeight.h, left: 16.w),
//                                 color: bgRed,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         Text(
//                                           'Hii , Mazuya',
//                                           style: TextStyle(
//                                               fontSize: 24.sp,
//                                               color: bgWhite,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                               color: bgWhite,
//                                               borderRadius: BorderRadius.only(
//                                                   bottomLeft:
//                                                       Radius.circular(8.r))),
//                                           height: 45.h,
//                                           width: 45.w,
//                                           child: Center(
//                                               child: Icon(
//                                             Remix.notification_3_line,
//                                             color: basicBlack,
//                                             size: 24.sp,
//                                           )),
//                                         ),
//                                       ],
//                                     ),
//                                     Text(
//                                       'Discover Our World',
//                                       style: TextStyle(
//                                           fontSize: 24.sp,
//                                           color: bgWhite,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                   )
//                 ];
//               },
//               body: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Obx(() => controller.isAppBarVisible.value
//                         ? SizedBox()
//                         : TextField()),
//                     Container(
//                       color: bgWhite,
//                       height: 200.0,
//                       alignment: Alignment.center,
//                       child: Text('Widget 1'),
//                     ),
//                     Column(
//                       children:
//                           List.generate(100, (index) => Text('hai ini $index')),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           Positioned(
//               top: 0, // Adjust the top position as needed
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: kToolbarHeight, // Set the height to match the AppBar's height
//                 color: Colors.blue, // Color for the widget
//                 child: Center(
//                   child: Text('Widget Above AppBar Location'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final double minHeight;
//   final double maxHeight;
//   final Widget child;

//   MySliverPersistentHeaderDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });

//   @override
//   double get minExtent => minHeight;

//   @override
//   double get maxExtent => maxHeight;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }
