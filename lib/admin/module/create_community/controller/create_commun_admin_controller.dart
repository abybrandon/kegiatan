import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:newtest/widget/toast.dart';

import 'package:image_picker/image_picker.dart';

class CreateCommunAdminController extends GetxController with StateMixin {
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

  void addToFireBase(
    String locationName,
    double latitude,
    double longitude,
  ) {
    // Mengambil referensi koleksi "lokasi"
    CollectionReference newDoc =
        FirebaseFirestore.instance.collection('location');

    final dataId = FirebaseFirestore.instance.collection('location').doc();

    // Membuat objek Lokasi dengan GeoPoint
    Lokasi lokasi = Lokasi(
      id: dataId.id,
      locationName: locationName,
      coordinateLocation: GeoPoint(latitude, longitude),
    );

    // Mengonversi objek Lokasi menjadi Map
    Map<String, dynamic> data = lokasi.toMap();

    // Menambahkan data ke koleksi "lokasi"
    newDoc.add(data).then((value) {
      print(
          "Data berhasil ditambahkan ke Firebase Firestore dengan ID: ${value.id}");
    }).catchError((error) {
      print("Terjadi kesalahan: $error");
    });
  }
}

class Lokasi {
  String id;
  String locationName;
  GeoPoint coordinateLocation;

  Lokasi({
    required this.id,
    required this.locationName,
    required this.coordinateLocation,
  });

  // Buat method untuk mengonversi objek Lokasi menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'locationName': locationName,
      'coordinateLocation': coordinateLocation,
    };
  }

  // Buat factory method untuk membuat objek Lokasi dari Map
  factory Lokasi.fromMap(Map<String, dynamic> map) {
    return Lokasi(
      id: map['id'],
      locationName: map['locationName'],
      coordinateLocation: map['coordinateLocation'],
    );
  }
}
