import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/toast.dart';

class CreateArtistAdminController extends GetxController with StateMixin {
  final CollectionReference artistCollection = FirebaseFirestore.instance
      .collection('events')
      .doc('events')
      .collection('artist');

  //textfield
  final nameArtist = TextEditingController();

  Future<void> createaArtist() async {
    change(null, status: RxStatus.loading());
    try {
      final newDoc = artistCollection.doc();

      await newDoc.set({'id': newDoc.id, 'nameArtist': nameArtist.text});

      Toast.showSuccessToastWithoutContext('Success');
    } catch (e) {
      // Handle error
      print(e.toString());
    }
    nameArtist.clear();
    change(null, status: RxStatus.success());
  }

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }
}
