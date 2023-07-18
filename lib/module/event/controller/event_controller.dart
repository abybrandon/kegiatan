import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:newtest/module/event/model/event_model.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../../widget/toast.dart';

class EventController extends GetxController with StateMixin {
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('event');

  @override
  void onInit() {
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
