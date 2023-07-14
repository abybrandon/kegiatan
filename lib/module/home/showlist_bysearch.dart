import 'dart:convert';

import 'package:newtest/module/home/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Showlistcontorller extends GetxController {
  final RxList<JadwalKegiatan> jadwalList = <JadwalKegiatan>[].obs;

  TextEditingController controllerText = TextEditingController();

  void search() {
    fetchData(controllerText.text);
  }

  Future<void> fetchData(String searchkeyword) async {
    final CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('event');
    try {
      final QuerySnapshot snapshot = await eventCollection
          .where('eventName',
              isGreaterThanOrEqualTo: searchkeyword,
              isLessThanOrEqualTo: '$searchkeyword\uf8ff')
          .orderBy(
            'eventName',
            descending: false,
          )
          // .where('city', isEqualTo: 'Jakarta')
          // .where('createdDate', isEqualTo: DateTime(1990))
          .get();
      final List<JadwalKegiatan> fetchedEvents = snapshot.docs
          .map((doc) =>
              JadwalKegiatan.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      jadwalList.value = fetchedEvents;

      for (var event in fetchedEvents) {
        print(event.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData('');
  }
}

class Showlistrange extends StatelessWidget {
  Showlistrange({super.key});
  final Showlistcontorller controller = Get.put(Showlistcontorller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('showlist by range'),
        actions: [
          InkWell(
            child: Icon(Icons.refresh),
            onTap: () {
              controller.fetchData('');
            },
          )
        ],
      ),
      body: Column(children: [
        TextField(
          controller: controller.controllerText,
          onChanged: (value) => controller.search(),
        ),
        Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.jadwalList.length,
                  itemBuilder: (context, index) {
                    final data = controller.jadwalList[index];
                    return ListTile(
                      title: Text(data.id),
                      subtitle: Text(data.createdDate.toString()),
                      leading: Text(data.tryValue1),
                    );
                  },
                )))
      ]),
    );
  }
}
