import 'package:newtest/module/home/city.dart';
import 'package:newtest/module/home/model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:newtest/widget/toast.dart';

class JadwalKegiatanController extends GetxController {
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('location');
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  final RxList<JadwalKegiatan> jadwalList = <JadwalKegiatan>[].obs;

  final RxList<JadwalKegiatan> dateList = <JadwalKegiatan>[].obs;

  Rxn<DateTime> selectedDate = Rxn<DateTime>();

  Future<void> getDate(context) async {
    final DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now());
    if (pickerDate != null && selectedDate != pickerDate) {
      selectedDate.value = pickerDate;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final QuerySnapshot snapshot = await eventCollection.get();
      final List<JadwalKegiatan> fetchedEvents = snapshot.docs
          .map((doc) =>
              JadwalKegiatan.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      jadwalList.value = fetchedEvents;
    } catch (error) {}
  }

  Future<void> createJadwalKegiatan(
      String tryValue, String try2Value, DateTime? date) async {
    try {
      if (tryValue.isNotEmpty && try2Value.isNotEmpty) {
        final newDoc = eventCollection.doc();

        final createdDate = date != null ? Timestamp.fromDate(date) : null;
        final newJadwalKegiatan = JadwalKegiatan(
            tryValue, try2Value, newDoc.id, createdDate as Timestamp);
        await newDoc
            .set(newJadwalKegiatan.toJson())
            .then((value) => print('data berhasil upload'));
        // Refresh the list after creating the new JadwalKegiatan
        await fetchData();
      }
    } catch (e) {
      // Handle error
      print('gagal upload');
    }
  }

  Future<void> createLocation(String city, String province) async {
    try {
      final CollectionReference eventCollectionLocaiton =
          FirebaseFirestore.instance.collection('location');
      final newDoc = eventCollectionLocaiton.doc();

      final newJadwalKegiatan = LocationModel(city, province, newDoc.id);
      await newDoc.set(newJadwalKegiatan.toJson()).then(
          (value) => Toast.showErrorToastWithoutContext('Berhasil Upload'));
      // Refresh the list after creating the new JadwalKegiatan
      await fetchData();
    } catch (e) {
      // Handle error
      print('gagal upload');
    }
  }
  // Future<void> fetchJadwalKegiatan() async {
  //   try {
  //     final QuerySnapshot snapshot = await _firestore.collection('event').get();
  //     final List<JadwalKegiatan> jadwalList = snapshot.docs.map((doc) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       return JadwalKegiatan(data['try'], data['try2']);
  //     }).toList();
  //     update();
  //     jadwalKegiatanList.assignAll(jadwalList);
  //   } catch (error) {
  //     print(error);
  //   }
  // }
}
