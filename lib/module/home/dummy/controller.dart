// import 'dart:io';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:newtest/module/home/city.dart';
// import 'package:newtest/module/home/model.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math';
// import 'package:image_picker/image_picker.dart';
// import 'package:newtest/widget/toast.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// class JadwalKegiatanController extends GetxController {
//   final CollectionReference eventCollection =
//       FirebaseFirestore.instance.collection('event');
//   final TextEditingController controller = TextEditingController();
//   final TextEditingController controller1 = TextEditingController();
//   final RxList<JadwalKegiatan> jadwalList = <JadwalKegiatan>[].obs;

//   final RxList<JadwalKegiatan> dateList = <JadwalKegiatan>[].obs;

//   Rx<File?> image = Rx<File?>(null);
//   RxList<File> photoList = <File>[].obs;

//   Future<void> getImageGalery() async {
//     final picker = ImagePicker();
//     final pickedImages = await picker.pickMultiImage();
//     if (pickedImages != null) {
//       photoList.value =
//           pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
//     }
//   }

//   Rxn<DateTime> selectedDate = Rxn<DateTime>();

//   Future<void> getDate(context) async {
//     final DateTime? pickerDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(1990),
//         lastDate: DateTime(2024));
//     if (pickerDate != null && selectedDate != pickerDate) {
//       selectedDate.value = pickerDate;
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       Toast.showErrorToastWithoutContext('Tidak ada koneksi internet');
//     }
//     try {
//       final QuerySnapshot snapshot = await eventCollection.get();
//       final List<JadwalKegiatan> fetchedEvents = snapshot.docs
//           .map((doc) =>
//               JadwalKegiatan.fromJson(doc.data() as Map<String, dynamic>))
//           .toList();
//       jadwalList.value = fetchedEvents;
//     } catch (error) {}
//   }

//   Future<List<String>> uploadImagesToFirebaseStorage(
//       List<File> imageFiles) async {
//     List<String> downloadURLs = [];
//     try {
//       for (var imageFile in imageFiles) {
//         final fileName =
//             DateTime.now().millisecondsSinceEpoch.toString() + '_.jpg';
//         final destination = 'event_images/$fileName';
//         firebase_storage.Reference ref =
//             firebase_storage.FirebaseStorage.instance.ref().child(destination);
//         await ref.putFile(imageFile);
//         String downloadURL = await ref.getDownloadURL();
//         downloadURLs.add(downloadURL);
//       }
//       return downloadURLs;
//     } catch (e) {
//       print('gagal upload gambar: $e');
//       return [];
//     }
//   }

//   Future<void> createJadwalKegiatanwithfoto(String tryValue, String try2Value,
//       DateTime? date, List<File> imageFiles) async {
//     try {
//       if (tryValue.isNotEmpty && try2Value.isNotEmpty) {
//         final newDoc = eventCollection.doc();

//         final createdDate = date != null ? Timestamp.fromDate(date) : null;
//         List<String> fotoKegiatanUrls = [];

//         if (imageFiles.isNotEmpty) {
//           // Upload gambar ke Firebase Storage dan dapatkan URL-nya
//           fotoKegiatanUrls = await uploadImagesToFirebaseStorage(imageFiles);
//         }

//         final newJadwalKegiatan = JadwalKegiatan(
//           tryValue1: tryValue,
//           tryValue2: try2Value,
//           id: newDoc.id,
//           createdDate: createdDate as Timestamp,
//           fotoKegiatanUrls: fotoKegiatanUrls,
//         );

//         await newDoc.set(newJadwalKegiatan.toJson());
//         print('data berhasil upload');
//         // Refresh the list after creating the new JadwalKegiatan
//         await fetchData();
//       }
//     } catch (e) {
//       // Handle error
//       print(e.toString());
//     }
//   }

//   Future<void> createJadwalKegiatan(
//       String tryValue, String try2Value, DateTime? date) async {
//     try {
//       if (tryValue.isNotEmpty && try2Value.isNotEmpty) {
//         final newDoc = eventCollection.doc();

//         final createdDate = date != null ? Timestamp.fromDate(date) : null;
//         final newJadwalKegiatan = JadwalKegiatan(
//             tryValue1: tryValue,
//             tryValue2: try2Value,
//             id: newDoc.id,
//             createdDate: createdDate as Timestamp);
//         await newDoc
//             .set(newJadwalKegiatan.toJson())
//             .then((value) => print('data berhasil upload'));
//         // Refresh the list after creating the new JadwalKegiatan
//         await fetchData();
//       }
//     } catch (e) {
//       // Handle error
//       print('gagal upload');
//     }
//   }

//   Future<void> createLocation(String city, String province) async {
//     try {
//       final CollectionReference eventCollectionLocaiton =
//           FirebaseFirestore.instance.collection('location');
//       final newDoc = eventCollectionLocaiton.doc();

//       final newJadwalKegiatan = LocationModel(city, province, newDoc.id);
//       await newDoc.set(newJadwalKegiatan.toJson()).then(
//           (value) => Toast.showErrorToastWithoutContext('Berhasil Upload'));
//       // Refresh the list after creating the new JadwalKegiatan
//       await fetchData();
//     } catch (e) {
//       // Handle error
//       print('gagal upload');
//     }
//   }
//   // Future<void> fetchJadwalKegiatan() async {
//   //   try {
//   //     final QuerySnapshot snapshot = await _firestore.collection('event').get();
//   //     final List<JadwalKegiatan> jadwalList = snapshot.docs.map((doc) {
//   //       final data = doc.data() as Map<String, dynamic>;
//   //       return JadwalKegiatan(data['try'], data['try2']);
//   //     }).toList();
//   //     update();
//   //     jadwalKegiatanList.assignAll(jadwalList);
//   //   } catch (error) {
//   //     print(error);
//   //   }
//   // }

//   RxList<File> selectedImages = RxList<File>([]);

//   Future<void> pickImages() async {
//     final picker = ImagePicker();
//     final pickedImages = await picker.pickMultiImage(imageQuality: 80);

//     if (pickedImages != null) {
//       selectedImages.value =
//           pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
//     }
//   }

//   Future<List<String>> uploadImages() async {
//     List<String> downloadURLs = [];

//     for (int i = 0; i < selectedImages.length; i++) {
//       final image = selectedImages[i];
//       final fileName =
//           DateTime.now().millisecondsSinceEpoch.toString() + '_$i.jpg';
//       final destination = 'event_images/$fileName';

//       try {
//         // Upload image to Firebase Storage
//         final storageRef =
//             firebase_storage.FirebaseStorage.instance.ref().child(destination);
//         await storageRef.putFile(image);

//         // Get download URL of uploaded image
//         final downloadURL = await storageRef.getDownloadURL();
//         downloadURLs.add(downloadURL);
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to upload image $i');
//         return [];
//       }
//     }

//     return downloadURLs;
//   }

//   Future<void> saveEvent(
//       List<String> downloadURLs, String tryValue, String try2Value,
//       {DateTime? date}) async {
//     try {
//       // Save download URLs to Firestore
//       if (tryValue.isNotEmpty && try2Value.isNotEmpty) {
//         final newDoc = eventCollection.doc();

//         final createdDate = date != null ? Timestamp.fromDate(date) : null;
//         final newJadwalKegiatan = JadwalKegiatan(
//             tryValue1: tryValue,
//             tryValue2: try2Value,
//             id: newDoc.id,
//             createdDate: createdDate as Timestamp);
//         await newDoc
//             .set(newJadwalKegiatan.toJson())
//             .then((value) => print('data berhasil upload'));
//         // Refresh the list after creating the new JadwalKegiatan
//         final eventRef = FirebaseFirestore.instance.collection('event').doc();
//         await eventRef.set({
//           'foto_event': downloadURLs,
//         });
//         await fetchData();
//       }

//       Toast.showSuccessToastWithoutContext('SuksesUpload');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create event');
//     }
//   }
// }
