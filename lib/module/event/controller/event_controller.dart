import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:newtest/module/event/model/event_model.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../../local_storage/local_storage_helper.dart';
import '../../../theme.dart';
import '../../../widget/multi_select/multi_select.dart';
import '../../../widget/toast.dart';
import '../../home/city.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'detail_event_controller.dart';

class EventController extends GetxController with StateMixin {
  final CollectionReference eventCollection = FirebaseFirestore.instance
      .collection('events')
      .doc('events')
      .collection('eventList');

  final CollectionReference locationColection =
      FirebaseFirestore.instance.collection('location');

  @override
  void onInit() {
    fetchLikedEventsFromFirestore();
    getLocation();
    fetchData();
    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<EventController>();
    Get.delete<DetailEventController>();
    super.onClose();
  }

  //listEvent
  RxList<EventModel> eventList = <EventModel>[].obs;

  //fetch data
  Future<void> fetchData() async {
    change(null, status: RxStatus.loading());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      change(null, status: RxStatus.loading());

      Toast.showErrorToastWithoutContext('No Internet Connection');
      print('jalan');
    } else {
      try {
        final QuerySnapshot snapshot = await eventCollection
            .orderBy('createdDate', descending: true)
            .get();
        final List<EventModel> fetchedEvents = snapshot.docs
            .map((doc) =>
                EventModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        eventList.value = fetchedEvents;
        filteredEventList.assignAll(eventList);
      } catch (error) {
        Toast.showErrorToastWithoutContext('Error Get Data');
        print(error.toString());
      }
    }
    change(null, status: RxStatus.success());
  }

  //filtered list
  RxList<EventModel> filteredEventList = <EventModel>[].obs;
  RxString searchQuery = RxString('');
  RxString filterCity = 'Semua Kota'.obs;

  void filterEventList() {
    change(null, status: RxStatus.loading());
    final List<EventModel> filteredEvents = eventList
        .where((event) =>
            event.eventName
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            event.city.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
    filteredEventList.value = filteredEvents;
    change(null, status: RxStatus.success());
  }

  //filter tanggal
  final RxInt selectedValue = 1.obs;
  Rxn<DateTimeRange> selectedDate = Rxn<DateTimeRange>();
  RxString filterDate = 'Semua Tanggal'.obs;

  void radioOnchange(int? value, context) {
    switch (value) {
      case 1:
        selectedValue.value = value!;

        print(value);
        break;
      case 2:
        selectedValue.value = value!;
        print(value);
        break;
      case 3:
        selectedValue.value = value!;
        print(value);
        break;
      case 4:
        selectedValue.value = value!;
        datePickerRange(context);
        break;
      default:
        1;
    }
  }

  Future<void> queryDate({DateTime? startDate, DateTime? endDate}) async {
    change(null, status: RxStatus.loading());
    try {
      Query query = FirebaseFirestore.instance.collection('event');

      if (startDate != null) {
        // Filter tanggal
        query = query.where('createdDate', isGreaterThanOrEqualTo: startDate);
        query = query.where('createdDate', isLessThanOrEqualTo: endDate);
        query = query.orderBy('createdDate');
        // query = query.where('city', whereIn: ['Karawang', 'Bogor']);
        DateFormat formatter = DateFormat('MM-dd-yyyy');
        String formattedStartDate = formatter.format(startDate);
        String formattedEndDate = formatter.format(startDate);
        filterDate.value = '$formattedStartDate - $formattedEndDate';
      }

      final QuerySnapshot snapshot = await query.get();

      final List<EventModel> fetchedEvents = snapshot.docs
          .map((doc) => EventModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      filteredEventList.assignAll(fetchedEvents);

      if (fetchedEvents.isNotEmpty) {
        print('data ada');
      } else {
        print('data kosong');
        eventList.clear();
      }
    } catch (e) {
      print(e.toString());
    }
    change(null, status: RxStatus.success());
  }

  //get data

  //custom date picker
  Future<void> datePickerRange(context) async {
    var results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
          calendarType: CalendarDatePicker2Type.range,
          selectedRangeDayTextStyle: TextStyle(color: bgBlue),
          okButtonTextStyle:
              TextStyle(color: bgBlue, fontWeight: FontWeight.w600),
          cancelButtonTextStyle:
              TextStyle(color: bgRed, fontWeight: FontWeight.w600)),
      dialogSize: Size(325.w, 400.h),
      borderRadius: BorderRadius.circular(15),
    );
    if (results != null) {
      if (results.length == 2) {
        firstValueDate = results[0];
        customFirstDate.value = results[0];
        endValueDate = results[1];
        customLastDate.value = results[1];
      } else if (results.length == 1) {
        CustomToast.showErrorToast(
            context, 'Tolong pilih rentang waktu awal dan akhir');
      } else {
        CustomToast.showErrorToast(
            context, 'Tolong pilih rentang waktu awal dan akhir');
      }
    }
  }

  Rxn<DateTime> customFirstDate = Rxn<DateTime>();
  Rxn<DateTime> customLastDate = Rxn<DateTime>();
  DateTime? firstValueDate;
  DateTime? endValueDate;
  //conditional filter date
  void onFilterDate(context) {
    if (selectedValue.value == 1) {
      firstValueDate = DateTime(2022);
      endValueDate = DateTime(2024);
    } else if (selectedValue.value == 2) {
      firstValueDate = DateTime.now();
      endValueDate = DateTime.now().add(Duration(days: 7));
    } else if (selectedValue.value == 3) {
      firstValueDate = DateTime.now();
      endValueDate = DateTime.now().add(Duration(days: 30));
    } else if (selectedValue.value == 4) {
    } else {}
    queryList();
  }

  Future<void> queryList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Toast.showErrorToastWithoutContext('Tidak ada koneksi internet');
    } else {
      try {
        Query query = FirebaseFirestore.instance.collection('event');

        if (firstValueDate != null && endValueDate != null) {
          query = query.where('createdDate', isLessThanOrEqualTo: endValueDate);
          query = query.where('createdDate',
              isGreaterThanOrEqualTo: firstValueDate);
          query = query.orderBy('createdDate');

          DateFormat formatter = DateFormat('MM-dd');
          String formattedStartDate = formatter.format(firstValueDate!);
          String formattedEndDate = formatter.format(endValueDate!);
          filterDate.value = '$formattedStartDate - $formattedEndDate';
          if (firstValueDate == DateTime(2022)) {
            filterDate.value = 'Semua Waktu';
          }
          print('jalan');
        }
        final QuerySnapshot snapshot = await query.get();

        final List<EventModel> fetchedEvents = snapshot.docs
            .map((doc) =>
                EventModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        filteredEventList.assignAll(fetchedEvents);

        if (fetchedEvents.isNotEmpty) {
          change(null, status: RxStatus.success());
        } else {
          print('data kosong');
          eventList.clear();
        }
      } catch (e) {
        Toast.showErrorToastWithoutContext('No internet Connection');
      }
      change(null, status: RxStatus.success());
    }
  }

  Future<void> takeDate(context) async {
    final selectedDates = await showDateRangePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green, // Ganti warna sesuai kebutuhan
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (selectedDates != null) {
      selectedDate.value = selectedDates;
      firstDateSelected = selectedDates.start;
      endDateSelected = selectedDates.end;
      queryDate(endDate: endDateSelected, startDate: firstDateSelected);
    }
  }

  late DateTimeRange selectedDatesValue;

  late DateTime firstDateSelected;
  late DateTime endDateSelected;

  final RxList<LocationModel> allCity = <LocationModel>[].obs;
  final RxList<LocationModel> selectedCity = <LocationModel>[].obs;

  List<SelectItem<String>> get cityOption {
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
    change(null, status: RxStatus.loading());
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
    change(null, status: RxStatus.success());
  }

  //formatted date
  String getFormattedDate(Timestamp date) {
    initializeDateFormatting('id_ID', null);
    final dateFormat = DateFormat.yMMMMd('id_ID');
    final timeFormat = DateFormat.Hm('id_ID');
    final formattedDate = dateFormat.format(date.toDate());
    final formattedTime = timeFormat.format(date.toDate());

    return '$formattedDate $formattedTime';
  }

  //total liked

  final RxList<String> likedEventList = <String>[].obs;

  Future<void> fetchLikedEventsFromFirestore() async {
    try {
      // Ambil data dari Firestore

      String? userUid = await SharedPreferenceHelper.getUserUid();
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .get();

      // Ambil array likedEvent dari data snapshot

      List<dynamic> likedEventArray = snapshot['likedEvents'];

      // Konversi dan masukkan ke dalam RxList
      likedEventList.assignAll(likedEventArray.cast<String>());
    } catch (e) {
      print('Error fetching liked events: $e');
    }
  }

  Future<void> dislikeEvent(String documentId) async {
    DocumentReference scheduleDocRef = FirebaseFirestore.instance
        .collection('events')
        .doc('events')
        .collection('eventList')
        .doc(documentId);
    String? userUid = await SharedPreferenceHelper.getUserUid();

    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(userUid);

    await userDoc.update({
      'likedEvents': FieldValue.arrayRemove([documentId]),
    });

    await scheduleDocRef.update({
      'totalLiked': FieldValue.increment(-1),
    });
  }

  Future<void> likeEvent(String documentId) async {
    DocumentReference scheduleDocRef = FirebaseFirestore.instance
        .collection('events')
        .doc('events')
        .collection('eventList')
        .doc(documentId);

    String? userUid = await SharedPreferenceHelper.getUserUid();

    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(userUid);

    await userDoc.update({
      'likedEvents': FieldValue.arrayUnion([documentId]),
    });

    await scheduleDocRef.update({
      'totalLiked': FieldValue.increment(1),
    });
  }
}
