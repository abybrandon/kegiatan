import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtest/local_storage/local_storage_helper.dart';
import 'package:newtest/local_storage/user_model.dart';
import 'package:newtest/widget/toast.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import '../datasource/create_commun_datasource.dart';
import '../model/community_model.dart';

class CreateCommunAdminController extends GetxController with StateMixin {
  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<CreateCommunAdminController>();
    super.onClose();
  }

  CommunityCollections firestoreCollections = CommunityCollections();
  final Rx<File?> image = Rx<File?>(null);

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  void clearImage() {
    image.value = null;
  }

  //textfield
  final nameCommunityController = TextEditingController();
  final nameLocationController = TextEditingController();
  final nameSloganController = TextEditingController();
  final nameBioContactController = TextEditingController();
  final facebookLinkController = TextEditingController();
  final instagramLinkController = TextEditingController();

  //upload data

  Future<void> createData() async {
    change(null, status: RxStatus.loading());

    try {
      UserData? dataUser = await SharedPreferenceHelper.getUserData();
      if (dataUser != null) {
        final newDoc = firestoreCollections.communityCollection.doc();
        String communityPict = '';

        if (image.value != null) {
          communityPict = await uploadImageToFirebaseStorage(image.value!);
        }

        final newCommunityData = CommunityModel(
            id: newDoc.id,
            communityBio: nameBioContactController.text,
            communityName: nameCommunityController.text,
            communityPicture: communityPict,
            communitySlogan: nameSloganController.text,
            communitySocialMedia: CommunitySocialMedia(
                facebookLink: facebookLinkController.text,
                instagramLink: instagramLinkController.text),
            createdDate: Timestamp.now(),
            updatedAt: Timestamp.now(),
            followers: 0,
            post: 0,
            ownerCommunity:
                OwnerCommunity(id: dataUser!.id, userName: dataUser.username),
                location: {'location' : {
                  'coordinateLocation' : GeoPoint(67.890, 12.345)
                }}
                );

        await newDoc.set(newCommunityData.toJson());

        Toast.showSuccessToastWithoutContext('Success');
      } else {
        Toast.showErrorToastWithoutContext('Something Error');
      }
    } catch (e) {
      print(e.toString());
      Toast.showErrorToastWithoutContext('Error');
    }
    change(null, status: RxStatus.success());
  }

  //upload image
  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_.jpg';
      final destination = 'community_image/$fileName';
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(imageFile);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Gagal mengunggah gambar: $e');
      return '';
    }
  }
}
