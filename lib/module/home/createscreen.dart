import 'package:newtest/module/home/controller.dart';
import 'package:newtest/module/home/filterdata.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/sizedbox_extension.dart';

class Create_Screen extends StatelessWidget {
  Create_Screen({super.key});
  final JadwalKegiatanController controller = JadwalKegiatanController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          ElevatedButton(
              onPressed: () {
                controller.getDate(context);
                print(controller.selectedDate.value);
              },
              child: Text('Pilih tanggal')),
          30.heightBox,
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
                controller.createLocation(
                  controller.controller.text,
                  controller.controller1.text,
                );
                print(controller.selectedDate);
              },
              child: Text('press'))
        ]),
      ),
    );
  }
}
