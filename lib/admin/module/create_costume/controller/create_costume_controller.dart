import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/multi_select/multi_select.dart';
import 'package:newtest/widget/toast.dart';
import 'package:image_picker/image_picker.dart';

import '../model/category_costume_model.dart';

class CreateCostumeController extends GetxController with StateMixin {
  final CollectionReference costumeColection = FirebaseFirestore.instance
      .collection('costume')
      .doc('costume_rent')
      .collection('category_costume');

  //textfield
  final nameArtist = TextEditingController();

    final RxList<CategoryCostumeModel> allCategoryCostume =
      <CategoryCostumeModel>[].obs;

    List<SelectItem<String>> get categoryOption {
      
    return allCategoryCostume.map(
      (data) {
        return SelectItem(label: data.name, value: data.name);
      },
    ).toList();
  }

 Future<void> getCategoryCostume() async {

    try {
      final QuerySnapshot snapshot = await costumeColection.get();

      final List<CategoryCostumeModel> fethedLocation = snapshot.docs
          .map((doc) =>
              CategoryCostumeModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      allCategoryCostume.value = fethedLocation;
      print('terpanggil');
    } catch (error) {
      print(error.toString());
    }

  }

  //Size
  RxBool sizeSonChecked = false.obs;
  RxBool sizeMonChecked = false.obs;
  RxBool sizeLonChecked = false.obs;
  RxBool sizeXLonChecked = false.obs;
  

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    getCategoryCostume();
    super.onInit();
  }

  RxList<File> photoList = <File>[].obs;

  Future<void> getImageGalery() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      photoList.value =
          pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
    }
  }
}
