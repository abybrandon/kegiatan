import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../event/model/event_detail_model.dart';

class FavoriteController extends GetxController with StateMixin {
  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    getSavedEventList();
    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<FavoriteController>();
    super.onClose();
  }

  RxList<EventDetailModel> savedEventList2 = RxList<EventDetailModel>();
  Future<List<EventDetailModel>> getSavedEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedEventListJson = prefs.getStringList('savedEventList');

    if (savedEventListJson == null) {
      return []; // Return empty list if no data found in SharedPreferences
    }

    // Konversi list JSON string menjadi list map string dynamic
    List<Map<String, dynamic>> savedEventListMap = savedEventListJson
        .map((jsonString) => jsonDecode(jsonString) as Map<String, dynamic>)
        .toList();

    // Konversi setiap map menjadi objek EventDetailModel
    List<EventDetailModel> savedEventList = savedEventListMap
        .map((jsonMap) => EventDetailModel.fromJsonPref(jsonMap))
        .toList();

    savedEventList2.value = savedEventList;
    return savedEventList;
  }

  String getFormattedDate(Timestamp date) {
    initializeDateFormatting('id_ID', null);
    final dateFormat = DateFormat.yMMMMd('id_ID');
    final timeFormat = DateFormat.Hm('id_ID');
    final formattedDate = dateFormat.format(date.toDate());
    final formattedTime = timeFormat.format(date.toDate());

    return '$formattedDate $formattedTime';
  }
}
