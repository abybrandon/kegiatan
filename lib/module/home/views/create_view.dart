import 'package:flutter/material.dart';
import 'package:newtest/module/home/contorller/jadwal_kegiatan_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:newtest/module/home/views/showdate.dart';

class Create_Screen extends StatelessWidget {
  Create_Screen({super.key});
  final JadwalKegiatanController controller = JadwalKegiatanController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              controller.getDate(context);
              print(controller.selectedDate.value);
            },
            child: Text('haias')),
        ElevatedButton(
            onPressed: () {
              Get.to(DateSelectionPage());
            },
            child: Text('haias')),
        TextField(
          controller: controller.controller,
        ),
        TextField(
          controller: controller.controller1,
        ),
        ElevatedButton(
            onPressed: () {
              controller.createJadwalKegiatan(
                  controller.controller.text,
                  controller.controller1.text,
                  controller.selectedDate.value as DateTime?);
              print(controller.selectedDate);
            },
            child: Text('press'))
      ]),
    );
  }
}
