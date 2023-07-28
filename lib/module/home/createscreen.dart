import 'package:newtest/module/home/controller.dart';
import 'package:newtest/module/home/filterdata.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/sizedbox_extension.dart';

class PhotoListWidget extends GetView<JadwalKegiatanController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.photoList.isEmpty) {
        return SizedBox.shrink();
      }
      return Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.photoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.file(controller.photoList[index]),
            );
          },
        ),
      );
    });
  }
}

class Create_Screen extends StatelessWidget {
  Create_Screen({super.key});
  final JadwalKegiatanController controller =
      Get.put(JadwalKegiatanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            30.heightBox,
            PhotoListWidget(),
            Obx(
              () => controller.image.value != null
                  ? PhotoListWidget()
                  : InkWell(
                      onTap: () {
                        controller.getImageGalery();
                      },
                      child: Placeholder()),
            ),
            40.heightBox,
            CustomTextField(
              errorText: 'tryvalue',
              hintText: 'Kota',
              controller: controller.controller,
            ),
            10.heightBox,
            CustomTextField(
              hintText: 'tryvalue2',
              errorText: 'Provinsi',
              controller: controller.controller1,
            ),
            ElevatedButton(
                onPressed: () {
                  controller.getDate(context);
                  print(controller.selectedDate.value);
                },
                child: Text('Pilih tanggal')),
            6.heightBox,
            ElevatedButton(
                onPressed: () {
                  // controller.createJadwalKegiatan(
                  //   controller.controller.text,
                  //   controller.controller1.text,
                  //   controller.selectedDate.value,
                  // );
                  controller.createJadwalKegiatanwithfoto(
                      controller.controller.text,
                      controller.controller1.text,
                      controller.selectedDate.value,
                      controller.photoList);
                  print(controller.selectedDate);
                },
                child: Text('Upload'))
          ]),
        ),
      ),
    );
  }
}
