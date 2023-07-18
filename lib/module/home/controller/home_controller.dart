import 'package:get/get.dart';
import 'package:newtest/module/home/model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../widget/multi_select/multi_select.dart';
import '../../../widget/toast.dart';
import '../city.dart';

class HomeController extends GetxController {
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('event');

  final CollectionReference locationColection =
      FirebaseFirestore.instance.collection('location');
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  final RxList<JadwalKegiatan> jadwalList = <JadwalKegiatan>[].obs;

  final RxList<JadwalKegiatan> dateList = <JadwalKegiatan>[].obs;

  Rxn<DateTimeRange> selectedDate = Rxn<DateTimeRange>();

  RxBool isSorting = false.obs;

  String getFormattedDate(Timestamp date) {
    initializeDateFormatting('id_ID', null);
    final dateFormat = DateFormat.yMMMMd('id_ID');
    final timeFormat = DateFormat.Hm('id_ID');
    final formattedDate = dateFormat.format(date.toDate());
    final formattedTime = timeFormat.format(date.toDate());

    return '$formattedDate $formattedTime';
  }

  @override
  void onInit() {
    getLocation();
    fetchData();
    super.onInit();
  }

  final RxList<LocationModel> allCity = <LocationModel>[].obs;

  final RxList<LocationModel> selectedCity = <LocationModel>[].obs;

  List<SelectItem<String>> get roleOption {
    return allCity.map(
      (city) {
        return SelectItem(
          label: city.province,
          value: city.id,
        );
      },
    ).toList();
  }

  Future<void> getLocation() async {
    try {
      final QuerySnapshot snapshot = await locationColection.get();
      final List<LocationModel> fethedLocation = snapshot.docs
          .map((doc) =>
              LocationModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      allCity.value = fethedLocation;
    } catch (error) {
      print(error.toString());
    }
  }

  //delete data
  Future<void> deleteDocument(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('event')
          .doc(documentId)
          .delete();
      Toast.showSuccessToastWithoutContext('Berhasil Hapus');
      fetchData();
    } catch (e) {
      print('Terjadi kesalahan saat menghapus dokumen: $e');
    }
  }

//take date
  Future<void> takeDate(context) async {
    final selectedDates = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (selectedDates != null) {
      selectedDate.value = selectedDates;
      firstDateSelected = selectedDates.start;
      endDateSelected = selectedDates.end;
    }
  }

  late DateTimeRange selectedDatesValue;

  late DateTime firstDateSelected;
  late DateTime endDateSelected;
  //try query
  Future<void> tryQuery({bool? sortingAtoZ, String? cityFilter}) async {
    try {
      Query query = FirebaseFirestore.instance.collection('event');

      // if (sortingAtoZ != null) {
      //   query = query.orderBy('city', descending: !sortingAtoZ);
      // }
      if (selectedDate.value != null) {
        final startDate = firstDateSelected;
        final endDate = endDateSelected;

        // Filter tanggal
        query = query.where('createdDate', isGreaterThanOrEqualTo: startDate);
        query = query.where('createdDate', isLessThanOrEqualTo: endDate);

        query = query.orderBy('createdDate');
      }
      final QuerySnapshot snapshot = await query.get();

      final List<JadwalKegiatan> fetchedEvents = snapshot.docs
          .map((doc) =>
              JadwalKegiatan.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      List<JadwalKegiatan> filteredList = fetchedEvents.where((event) {
        return event.tryValue2 == 'Bekasi';
      }).toList();

      jadwalList.value = filteredList;
      if (fetchedEvents.isNotEmpty) {
        print('data ada');
      } else {
        print('data kosong');
        jadwalList.clear();
      }
    } catch (e) {
      print(e.toString());
    }
  }

//filter tanggal
  Future<void> fetchbyDate(context) async {
    final selectedDates = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (selectedDates != null) {
      final startDate = selectedDates.start;
      final endDate = selectedDates.end;

      // Langkah 3: Buat query ke Firebase Firestore
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('event')
          .where('createdDate', isGreaterThanOrEqualTo: startDate)
          .where('createdDate', isLessThanOrEqualTo: endDate)
          .orderBy('createdDate', descending: false)
          .get();

      final List<JadwalKegiatan> fetchedEvents = snapshot.docs
          .map((doc) =>
              JadwalKegiatan.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      if (fetchedEvents.isEmpty) {
        // Kasus ketika tidak ada data yang sesuai dengan tanggal yang dipilih
        print('Data kosong');
      } else {
        // Kasus ketika ada data yang sesuai dengan tanggal yang dipilih
        jadwalList.value = fetchedEvents;
        for (var event in fetchedEvents) {
          print(event.toString());
        }
        print('data ada');
      }
    }
  }

  Future<void> fetchData() async {
    try {
      final QuerySnapshot snapshot =
          await eventCollection.orderBy('createdDate', descending: true).get();
      final List<JadwalKegiatan> fetchedEvents = snapshot.docs
          .map((doc) =>
              JadwalKegiatan.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      jadwalList.value = fetchedEvents;
    } catch (error) {
      print(error.toString());
    }
  }
}
