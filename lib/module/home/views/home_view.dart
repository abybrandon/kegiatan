import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtest/module/home/contorller/jadwal_kegiatan_controller.dart';
import 'package:get/get.dart';
import 'package:newtest/module/home/views/create_view.dart';

class EventListView extends StatelessWidget {
  final JadwalKegiatanController controller =
      Get.put(JadwalKegiatanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Event List'),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(Create_Screen());
                },
                child: Text('hai')),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.jadwalList.length,
                  itemBuilder: (context, index) {
                    final jadwal = controller.jadwalList[index];
                    return ListTile(
                      title: Text(jadwal.tryValue1),
                      subtitle: Text(jadwal.tryValue2),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
