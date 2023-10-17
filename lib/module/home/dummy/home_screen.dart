// import 'package:newtest/module/home/controller.dart';
// import 'package:newtest/module/home/createscreen.dart';
// import 'package:newtest/module/home/filterdata.dart';
// import 'package:newtest/module/home/showlist_bysearch.dart';
// import 'package:newtest/module/home/trynotification.dart';
// import 'package:newtest/module/login/controller/login_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// import '../../local_storage/local_storage_helper.dart';
// import '../../routes/app_pages.dart';

// class EventListView extends StatefulWidget {
//   @override
//   State<EventListView> createState() => _EventListViewState();
// }

// class _EventListViewState extends State<EventListView> {
//   final JadwalKegiatanController controller =
//       Get.put(JadwalKegiatanController());

//   final LoginController controller1 = Get.put(LoginController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Event List'),
//           actions: [
//             InkWell(
//               child: Icon(Icons.logout),
//               onTap: () {
//                 setState(() {
//                   SharedPreferenceHelper.removeUserUid();
//                 });
//                 Get.toNamed(Routes.LOGIN);
//               },
//             )
//           ],
//         ),
//         body: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   Get.to(Create_Screen());
//                 },
//                 child: Text('Create Data')),
//             ElevatedButton(
//                 onPressed: () {
//                   Get.to(Showlistrange());
//                 },
//                 child: Text('Show Data by search')),
//             ElevatedButton(
//                 onPressed: () {
//                   Get.to(DateSelectionPage());
//                 },
//                 child: Text('Show data by pick date')),
//             ElevatedButton(
//                 onPressed: () {
//                   print(controller1.tokenNew);
//                 },
//                 child: Text('print token')),
//             ElevatedButton(
//                 onPressed: () {
//                   Get.to(ApiScreen());
//                 },
//                 child: Text('print token')),
//             Obx(() => controller.jadwalList.isNotEmpty
//                 ? Expanded(
//                     child: ListView.builder(
//                       itemCount: controller.jadwalList.length,
//                       itemBuilder: (context, index) {
//                         final jadwal = controller.jadwalList[index];
//                         return ListTile(
//                           title: Text(jadwal.tryValue1),
//                           subtitle: Text(jadwal.tryValue2),
//                         );
//                       },
//                     ),
//                   )
//                 : CircularProgressIndicator()),
//           ],
//         ));
//   }
// }
