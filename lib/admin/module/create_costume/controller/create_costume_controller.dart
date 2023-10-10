import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/multi_select/multi_select.dart';
import 'package:image_picker/image_picker.dart';

import '../model/category_costume_model.dart';

class CreateCostumeController extends GetxController with StateMixin {
  final CollectionReference listBrandCollection = FirebaseFirestore.instance
      .collection('costume')
      .doc('brand')
      .collection('list_brand');

  final CollectionReference listCategoryCollection = FirebaseFirestore.instance
      .collection('costume')
      .doc('category')
      .collection('list_category');

  final CollectionReference listCharackterCollection = FirebaseFirestore
      .instance
      .collection('costume')
      .doc('charackter')
      .collection('charackter_origin');

  final CollectionReference listCostumeCollection = FirebaseFirestore.instance
      .collection('costume')
      .doc('costume')
      .collection('list_costume');

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    fetchAll();
    super.onInit();
  }
  //data
  //list brand

  final RxList<CategoryModel> allBrandCostume = <CategoryModel>[].obs;

  List<SelectItem<CategoryModel>> get brandOption {
    return allBrandCostume.map(
      (data) {
        return SelectItem(label: data.name, value: data);
      },
    ).toList();
  }

  Future<void> getBrandCostume() async {
    try {
      final QuerySnapshot snapshot = await listBrandCollection.get();

      final List<CategoryModel> fetchedData = snapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      allBrandCostume.value = fetchedData;
    } catch (error) {
      print(error.toString());
    }
  }

  //list category
  final RxList<CategoryModel> allCategoryCostume = <CategoryModel>[].obs;

  List<SelectItem<CategoryModel>> get categoryOption {
    return allCategoryCostume.map(
      (data) {
        return SelectItem(label: data.name, value: data);
      },
    ).toList();
  }

  Future<void> getCategoryCostume() async {
    try {
      final QuerySnapshot snapshot = await listCategoryCollection.get();

      final List<CategoryModel> fetchedData = snapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      allCategoryCostume.value = fetchedData;
    } catch (error) {
      print(error.toString());
    }
  }

  //list charackter origin
  final RxList<CategoryModel> allCharackterCostume = <CategoryModel>[].obs;

  List<SelectItem<CategoryModel>> get chacarckterOption {
    return allCharackterCostume.map(
      (data) {
        return SelectItem(label: data.name, value: data);
      },
    ).toList();
  }

  Future<void> getCharackterCostume() async {
    try {
      final QuerySnapshot snapshot = await listCharackterCollection.get();

      final List<CategoryModel> fetchedData = snapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      allCharackterCostume.value = fetchedData;
    } catch (error) {
      print(error.toString());
    }
  }

  void fetchAll() async {
    try {
      await Future.wait(
        [getBrandCostume(), getCategoryCostume(), getCharackterCostume()],
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

  // post data

  //textfield
  final nameCostumeController = TextEditingController();
  final controlelrDetail = TextEditingController();
  final controllerPrice = TextEditingController();

  //Size
  RxBool sizeSonChecked = false.obs;
  RxBool sizeMonChecked = false.obs;
  RxBool sizeLonChecked = false.obs;
  RxBool sizeXLonChecked = false.obs;

  //gender
  RxBool maleOnChecked = false.obs;
  RxBool femaleOnChecked = false.obs;

  //selected variable
  Rx<CategoryModel?> selectedCharackter = Rx<CategoryModel?>(null);

  final RxList<CategoryModel> selectedCategory = <CategoryModel>[].obs;

  Rx<CategoryModel?> selectedBrand = Rx<CategoryModel?>(null);

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
