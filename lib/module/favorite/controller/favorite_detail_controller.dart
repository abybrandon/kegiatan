import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../event/model/event_detail_model.dart';

class FavoriteDetailController extends GetxController with StateMixin {
  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    getSavedEventList();
    super.onInit();
  }

  Rx<EventDetailModel?> savedEventList2 = Rx<EventDetailModel?>(null);

  Future<EventDetailModel> getSavedEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedEventListJson = prefs.getStringList('savedEventList');

    // Konversi list JSON string menjadi list map string dynamic
    List<Map<String, dynamic>> savedEventListMap = savedEventListJson!
        .map((jsonString) => jsonDecode(jsonString) as Map<String, dynamic>)
        .toList();

    // Konversi setiap map menjadi objek EventDetailModel
    List<EventDetailModel> savedEventList = savedEventListMap
        .map((jsonMap) => EventDetailModel.fromJsonPref(jsonMap))
        .toList();
    final detailSavedEvent = savedEventList
        .firstWhere((element) => element.id == Get.parameters['id']);

    savedEventList2.value = detailSavedEvent;
    change(null, status: RxStatus.success());
    return detailSavedEvent;
  }
}
