import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/multi_select/multi_select.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newtest/widget/toast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../datasource/create_costume_datasource.dart';
import '../model/category_costume_model.dart';
import '../model/costume_model.dart';

class CreateCostumeController extends GetxController with StateMixin {
  FirestoreCollections firestoreCollections = FirestoreCollections();

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
      final QuerySnapshot snapshot =
          await firestoreCollections.listBrandCollection.get();

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
      final QuerySnapshot snapshot =
          await firestoreCollections.listCategoryCollection.get();

      final List<CategoryModel> fetchedData = snapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      allCategoryCostume.value = fetchedData;
    } catch (error) {
      print(error.toString());
    }
  }

  //list charackter name

  final RxList<CategoryModel> allCharackterName = <CategoryModel>[].obs;

  List<SelectItem<CategoryModel>> get charackterOption {
    return allCharackterName.map(
      (data) {
        return SelectItem(label: data.name, value: data);
      },
    ).toList();
  }

  Future<void> getCharackterName() async {
    try {
      final QuerySnapshot snapshot =
          await firestoreCollections.listCharackterNameCollection.get();

      final List<CategoryModel> fetchedData = snapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      allCharackterName.value = fetchedData;
    } catch (error) {
      print(error.toString());
    }
  }

  //list charackter origin
  final RxList<CategoryModel> allCharackterOrigin = <CategoryModel>[].obs;

  List<SelectItem<CategoryModel>> get chacarckterOriginOption {
    return allCharackterOrigin.map(
      (data) {
        return SelectItem(label: data.name, value: data);
      },
    ).toList();
  }

  Future<void> getCharackterCostume() async {
    try {
      final QuerySnapshot snapshot =
          await firestoreCollections.listCharackterCollection.get();

      final List<CategoryModel> fetchedData = snapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      allCharackterOrigin.value = fetchedData;
    } catch (error) {
      print(error.toString());
    }
  }

  void fetchAll() async {
    try {
      await Future.wait(
        [
          getBrandCostume(),
          getCategoryCostume(),
          getCharackterCostume(),
          getCharackterName()
        ],
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

  Rx<CategoryModel?> selectedCharackterName = Rx<CategoryModel?>(null);

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

  Future<void> createData() async {
    change(null, status: RxStatus.loading());
    try {
      final newDoc = firestoreCollections.costumeListCollection.doc();
       List<String> fotoKegiatanUrls = [];

      if (photoList.isNotEmpty) {
        fotoKegiatanUrls = await uploadImagesToFirebaseStorage(photoList);
      }

      final newCostumeRentData = ModelCostume(
          id: newDoc.id,
          nameCostume: nameCostumeController.text,
          charackterOrigin: selectedCharackter.value!,
          charackterName: selectedCharackterName.value!,
          categoryCostume:
              selectedCategory.map((element) => element.name).toList(),
          brandCostume: selectedBrand.value!,
          genderCostume: genderCostumeValue,
          availSize: sizeAvail,
          createdDate: Timestamp.now(),
          detailCostume: controlelrDetail.text,
          owner: {'nameOwner': 'mazuyaShiro'},
          status: true,
          locationName: 'Kota Jakarta',
          priceRent: {'rentPrice' : controllerPrice.text, 'rentDay' : 3 },
          listPhotoCostume: fotoKegiatanUrls
          );

      await newDoc.set(newCostumeRentData.toJson());

      Toast.showSuccessToastWithoutContext('Success');
    } catch (e) {
      print(e.toString());
      Toast.showErrorToastWithoutContext('error');
    }
    change(null, status: RxStatus.success());
  }

  String get genderCostumeValue {
    if (maleOnChecked.value && !femaleOnChecked.value) {
      return "Male";
    } else if (!maleOnChecked.value && femaleOnChecked.value) {
      return "Female";
    } else if (maleOnChecked.value && femaleOnChecked.value) {
      return "Universal";
    } else {
      return "No Gender";
    }
  }

  List<String> get sizeAvail {
    List<String> availableSizes = [];

    if (sizeSonChecked.value) {
      availableSizes.add("S");
    }

    if (sizeMonChecked.value) {
      availableSizes.add("M");
    }

    if (sizeLonChecked.value) {
      availableSizes.add("L");
    }

    if (sizeXLonChecked.value) {
      availableSizes.add("XL");
    }

    return availableSizes;
  }

  Future<List<String>> uploadImagesToFirebaseStorage(
      List<File> imageFiles) async {
    List<String> downloadURLs = [];
    try {
      for (var imageFile in imageFiles) {
        final fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '_.jpg';
        final destination = 'costume_rent_images/$fileName';
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(imageFile);
        String downloadURL = await ref.getDownloadURL();
        downloadURLs.add(downloadURL);
      }
      return downloadURLs;
    } catch (e) {
      print('gagal upload gambar: $e');
      return [];
    }
  }
}
