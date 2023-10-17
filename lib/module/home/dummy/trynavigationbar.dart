// import 'package:flutter/material.dart';
// import 'package:newtest/module/home/view/home_view.dart';
// import 'package:newtest/theme.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
// import 'package:get/get.dart';


// class HomePage extends StatelessWidget {
//   final currentIndex = 0.obs; 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Salomon Bottom Bar'),
//       ),
//       body: Obx(() {
//         switch (currentIndex.value) {
//           case 1:
//             return HomeView();
//           case 2:
//             return Screen2();
//           case 3:
//             return Screen3();
//           default:
//             return Center(
//               child: Text(
//                 'Home',
//                 style: TextStyle(fontSize: 24),
//               ),
//             );
//         }
//       }),
//       bottomNavigationBar:Obx(() =>  Container(
//          decoration: BoxDecoration(
//     color: Colors.white,
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.5),
//         spreadRadius: 2,
//         blurRadius: 5,
//         offset: Offset(0, 3), // Geser bayangan secara vertikal dan horizontal
//       ),
//     ],
//   ),
//         child: SalomonBottomBar(
          
//           currentIndex: currentIndex.value,
//           onTap: (index) => currentIndex.value = index,
//           items: [
//             SalomonBottomBarItem(
//               icon: Icon(Icons.home),
//               title: Text('Home'),
//               selectedColor: bgRed,
//             ),
//             SalomonBottomBarItem(
//               icon: Icon(Icons.favorite),
//               title: Text('Screen 1'),
//                selectedColor: bgRed,
//             ),
//             SalomonBottomBarItem(
//               icon: Icon(Icons.settings),
//               title: Text('Screen 2'),
//          selectedColor: bgRed,
//             ),
//             SalomonBottomBarItem(
//               icon: Icon(Icons.person),
//               title: Text('Screen 3'),
//          selectedColor: bgRed,
//             ),
//           ],
//         ),
//       ),
//   )  );
//   }
// }

// class Screen1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen 1'),
//       ),
//       body: Center(
//         child: Text(
//           'Screen 1',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class Screen2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen 2'),
//       ),
//       body: Center(
//         child: Text(
//           'Screen 2',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class Screen3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen 3'),
//       ),
//       body: Center(
//         child: Text(
//           'Screen 3',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
