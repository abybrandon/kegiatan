import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widget/toast.dart';
import '../model/event_detail_model.dart';

class DetailEventController extends GetxController with StateMixin {

  final RxBool isAppBarVisible = false.obs;

  final CollectionReference eventCollection = FirebaseFirestore.instance
      .collection('events')
      .doc('events')
      .collection('eventList');

  final Rx<EventDetailModel?> eventDetail = Rx<EventDetailModel?>(null);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //data
  String nameEvent = '';
  String organizerEvent = '';
  String city = '';
  String deskripsi = '';
  List<String> listPict = [];
  List<String> listGuestStart = [];
  double latitudeLoc = 0;
  double longitudeLoc = 0;

  List<String> getImages() {
    int desiredLength = 3;

    String placeholderImage =
        'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/uploads%2FnoPhoto.png?alt=media&token=727f17d6-63c3-45e3-948f-d54d6c96b2eb&_gl=1*1nyzdex*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5Nzc2ODE3OC41MS4xLjE2OTc3Njg5MzguMzIuMC4w';

    if (listPict.length < desiredLength) {
      int additionalImagesCount = desiredLength - listPict.length;

      for (int i = 0; i < additionalImagesCount; i++) {
        listPict.add(placeholderImage);
      }
    }

    return listPict;
  }

  Future<void> fetchEventDetailById(String id) async {
    change(null, status: RxStatus.loading());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Toast.showErrorToastWithoutContext('Tidak ada koneksi internet');
    } else {
      try {
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection('events')
            .doc('events')
            .collection('eventList')
            .doc(id)
            .get();
        if (snapshot.exists) {
          final eventData = EventDetailModel.fromJson(snapshot.data()!);

          eventDetail.value = eventData;
          nameEvent = eventData.eventName;
          city = eventData.city;
          organizerEvent = eventData.organizerEvent;
          deskripsi = eventData.deskripsi;
          listPict = eventData.eventPict.map((e) => e.toString()).toList();
          listGuestStart =
              eventData.guestStart.map((e) => e.toString()).toList();
          latitudeLoc = eventData.latitude;
          longitudeLoc = eventData.longitude;
          checkEventSaved(eventDetail.value);
        } else {
          print('Dokumen tidak ditemukan');
        }
      } catch (e) {
        // Handle error jika terjadi
        print(e.toString());
      }
    }

    change(null, status: RxStatus.success());
  }

  //map

  void openMapsSheet(context) async {
    try {
      final coords = Coords(latitudeLoc, longitudeLoc);
      final title = "Mall Taman Anngrek";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showDirections(
                          destination: coords,
                          destinationTitle: title,
                          directionsMode: DirectionsMode.driving,
                        ),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                        title: Text(map.mapName),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    getSavedEventList();
    fetchEventDetailById(Get.parameters["id"]!);
    super.onInit();
  }

  //local storgage

  // List<EventDetailModel> savedEventList = [];

  Future<void> saveDetailEvent(EventDetailModel? eventDetailModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedEventList2.add(eventDetailModel!);

    // Konversi setiap objek EventDetailModel menjadi map JSON
    List<Map<String, dynamic>> savedEventListMap =
        savedEventList2.map((e) => e.toJson()).toList();

    // Konversi setiap map menjadi JSON string
    List<String> savedEventListJson =
        savedEventListMap.map((e) => jsonEncode(e)).toList();

    // Simpan list JSON string ke dalam SharedPreferences
    prefs.setStringList('savedEventList', savedEventListJson);
    checkEventSaved(eventDetail.value);
  }

  Future<void> deleteDetailEvent(EventDetailModel? eventDetailModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Hapus objek EventDetailModel dari savedEventList
    savedEventList2
        .removeWhere((element) => element.id == eventDetailModel?.id);

    // Konversi setiap objek EventDetailModel menjadi map JSON
    List<Map<String, dynamic>> savedEventListMap =
        savedEventList2.map((e) => e.toJson()).toList();

    // Konversi setiap map menjadi JSON string
    List<String> savedEventListJson =
        savedEventListMap.map((e) => jsonEncode(e)).toList();

    // Simpan list JSON string ke dalam SharedPreferences
    prefs.setStringList('savedEventList', savedEventListJson);
    checkEventSaved(eventDetail.value);
  }

  List<Map<String, dynamic>> myListMap = [
    {'name': 'John', 'age': 25},
    {'name': 'Alice', 'age': 30},
    {'name': 'Bob', 'age': 28},
  ];

  void saveListMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = myListMap.map((map) => json.encode(map)).toList();
    prefs.setStringList('myListMapKey', jsonList);
  }

  //delete event

  // Future<void> deleteDetailEvent(EventDetailModel? eventDetailModel) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   savedEventList.remove(eventDetailModel);
  //   List<String> savedEventListJson =
  //       savedEventList.map((event) => json.encode(event.toJson())).toList();
  //   prefs.setStringList('savedEventList', savedEventListJson);
  //   checkEventSaved(eventDetail.value);
  // }

  //cek detail saved
  RxBool isEventSaved = false.obs;

  void checkEventSaved(EventDetailModel? eventDetailModel) {
    isEventSaved.value = savedEventList2
        .any((savedEvent) => savedEvent.id == eventDetailModel?.id);
  }

  //get data
  // Future<void> loadEventSaved() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? savedEventListJson = prefs.getStringList("savedEventList");
  //   if (savedEventListJson != null) {
  //     List<EventDetailModel> loadedEvents = savedEventListJson.map((json) {
  //       final eventMap = jsonDecode(json);
  //       return EventDetailModel.fromJsonPref(eventMap);
  //     }).toList();
  //     print(loadedEvents);
  //     savedEventList.assignAll(loadedEvents);
  //   }
  // }
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
    print(savedEventList2.map((element) => element.id));
    return savedEventList;
  }

  //tabbar

  RxInt selectedButton = 0.obs;

  //appbar

  final RxBool isSearching = false.obs;
}
