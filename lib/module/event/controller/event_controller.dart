import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:newtest/module/event/model/event_model.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../../widget/multi_select/multi_select.dart';
import '../../../widget/toast.dart';
import '../../home/city.dart';

class EventController extends GetxController with StateMixin {
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('event');

  final CollectionReference locationColection =
      FirebaseFirestore.instance.collection('location');

  @override
  void onInit() {
    fetchAll();
    fetchData();
    super.onInit();
  }

  //listEvent
  RxList<EventModel> eventList = <EventModel>[].obs;

  //fetch data
  Future<void> fetchData() async {
    change(null, status: RxStatus.loading());
    try {
      final QuerySnapshot snapshot =
          await eventCollection.orderBy('createdDate', descending: true).get();
      final List<EventModel> fetchedEvents = snapshot.docs
          .map((doc) => EventModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      eventList.value = fetchedEvents;
      filteredEventList.assignAll(eventList);
    } catch (error) {
      Toast.showErrorToastWithoutContext('Error Get Data');
      print(error.toString());
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
  Rxn<DateTimeRange> selectedDate = Rxn<DateTimeRange>();
  RxString filterDate = 'Semua Tanggal'.obs;

  Future<void> queryDate({DateTime? startDate, DateTime? endDate}) async {
    change(null, status: RxStatus.loading());
    try {
      Query query = FirebaseFirestore.instance.collection('event');

      if (startDate != null && endDate != null) {
        // Filter tanggal
        query = query.where('createdDate', isGreaterThanOrEqualTo: startDate);
        query = query.where('createdDate', isLessThanOrEqualTo: endDate);
        query = query.orderBy('createdDate');
        query = query.where('city', whereIn: ['Karawang', 'Bogor']);
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
      queryDate(endDate: endDateSelected, startDate: firstDateSelected);
    }
  }

  late DateTimeRange selectedDatesValue;

  late DateTime firstDateSelected;
  late DateTime endDateSelected;

  //fetch city data
  void fetchAll() async {
    try {
      await Future.wait(
        [getLocation()],
        eagerError: true,
      ).then(
        (_) {
          change(
            null,
            status: RxStatus.success(),
          );
        },
      );
    } on Exception {
      change(null, status: RxStatus.error());
    }
  }

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
}
