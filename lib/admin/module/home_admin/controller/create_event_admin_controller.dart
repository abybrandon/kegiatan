import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:newtest/admin/module/home_admin/model/artist_event_model.dart';
import 'package:newtest/widget/toast.dart';

import '../../../../widget/multi_select/multi_select.dart';
import '../model/create_event_model.dart';
import '../model/location_event_model.dart';

class CreateEventAdminController extends GetxController with StateMixin {
  final CollectionReference eventCollection = FirebaseFirestore.instance
      .collection('events')
      .doc('events')
      .collection('eventList');

  final CollectionReference locationEventCollection = FirebaseFirestore.instance
      .collection('events')
      .doc('events')
      .collection('locationEvent');

  final CollectionReference artistEventCollection = FirebaseFirestore.instance
      .collection('events')
      .doc('events')
      .collection('artist');

  //get image
  Rx<File?> image = Rx<File?>(null);
  RxList<File> photoList = <File>[].obs;

  Future<void> getImageGalery() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      photoList.value =
          pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
    }
  }

  //get date
  Future<void> getDateStart(context) async {
    final DateTime? pickerDate = await showDatePicker(
        helpText: 'Select Start Date Event',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2024));
    if (pickerDate != null && selectedDateStartEvent.value != pickerDate) {
      selectedDateStartEvent.value = pickerDate;
      String formattedDate =
          DateFormat('d MMMM yyyy').format(selectedDateStartEvent.value!);
      selectedDateStartText.value = formattedDate;
    }
  }

  RxString selectedDateStartText = ''.obs;
  RxString selectedDateEndText = ''.obs;
  Future<void> getDateEnd(context) async {
    final DateTime? pickerDate = await showDatePicker(
        context: context,
        helpText: 'Select Start Date Event',
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2024));
    if (pickerDate != null && selectedDateEndEvent.value != pickerDate) {
      selectedDateEndEvent.value = pickerDate;
      String formattedDate =
          DateFormat('d MMMM yyyy').format(selectedDateEndEvent.value!);
      selectedDateEndText.value = formattedDate;
    }
  }

  Rxn<DateTime> selectedDateStartEvent = Rxn<DateTime>();
  Rxn<DateTime> selectedDateEndEvent = Rxn<DateTime>();

  //textfield
  final nameEventController = TextEditingController();
  final organizerController = TextEditingController();
  final cityEventController = TextEditingController();
  final deskripsiEventController = TextEditingController();

  //create

  double eventLatitude = 0;
  double eventLongitude = 0;

  Future<void> createEventWithPict(
      {required String nameEevent,
      required String organizerEvent,
      required String cityEvent,
      required String deskripsi,
      DateTime? date,
      DateTime? dateStart,
      DateTime? dateEnd,
      required List<File> imageFiles}) async {
    change(null, status: RxStatus.loading());
    try {
      final newDoc = eventCollection.doc();

      final startDate =
          dateStart != null ? Timestamp.fromDate(dateStart) : null;

      final endDate = dateEnd != null ? Timestamp.fromDate(dateEnd) : null;

      List<String> fotoKegiatanUrls = [];

      if (imageFiles.isNotEmpty) {
        fotoKegiatanUrls = await uploadImagesToFirebaseStorage(imageFiles);
      }

      final newJadwalKegiatan = CreateEventModel(
          nameEvent: nameEevent,
          cityEvent: cityEvent,
          deskripsi: deskripsi,
          organizerEvent: organizerEvent,
          id: newDoc.id,
          createdDate: startDate as Timestamp,
          fotoKegiatanUrls: fotoKegiatanUrls,
          startDate: startDate as Timestamp,
          endDate: endDate as Timestamp,
          location: GeoPoint(
            eventLatitude,
            eventLongitude,
          ),
          guestStart: selectedGuestStart);

      await newDoc.set(newJadwalKegiatan.toJson());

      Toast.showSuccessToastWithoutContext('Success');
    } catch (e) {
      // Handle error
      print(e.toString());
    }
    change(null, status: RxStatus.success());
  }

  Future<List<String>> uploadImagesToFirebaseStorage(
      List<File> imageFiles) async {
    List<String> downloadURLs = [];
    try {
      for (var imageFile in imageFiles) {
        final fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '_.jpg';
        final destination = 'event_images/$fileName';
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

  //Artist

  RxString artistEventName = 'Pilih Artist'.obs;
  RxList<String> selectedGuestStart = <String>[].obs;

  final RxList<ArtistEventModel> allArtistData = <ArtistEventModel>[].obs;
  final RxList<ArtistEventModel> selectedArtist = <ArtistEventModel>[].obs;

  List<SelectItem<String>> get artistOption {
    return allArtistData.map(
      (artist) {
        return SelectItem(label: artist.nameArtist, value: artist.nameArtist);
      },
    ).toList();
  }

  Future<void> getArtistEventModel() async {
    change(null, status: RxStatus.loading());
    try {
      final QuerySnapshot snapshot = await artistEventCollection.get();
      final List<ArtistEventModel> fetchedArtist = snapshot.docs
          .map((doc) =>
              ArtistEventModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      allArtistData.value = fetchedArtist;
    } catch (error) {
      print(error.toString());
    }
    change(null, status: RxStatus.success());
  }

  //location event
  RxString locationEventName = 'Pilih Lokasi Event'.obs;

  final RxList<LocationEventModel> allLocationEvent =
      <LocationEventModel>[].obs;

  final RxList<LocationEventModel> selectedLocation =
      <LocationEventModel>[].obs;
  RxString selectedNameLocaiton = ''.obs;

  List<SelectItem<LocationEventModel>> get locationOption {
    return allLocationEvent.map(
      (location) {
        return SelectItem(label: location.locationName, value: location);
      },
    ).toList();
  }

  Future<void> getLocationEvent() async {
    change(null, status: RxStatus.loading());
    try {
      final QuerySnapshot snapshot = await locationEventCollection.get();
      final List<LocationEventModel> fethedLocation = snapshot.docs
          .map((doc) =>
              LocationEventModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      allLocationEvent.value = fethedLocation;
      
    } catch (error) {
      print(error.toString());
    }
    change(null, status: RxStatus.success());
  }

  @override
  void onInit() {
    getLocationEvent();
    getArtistEventModel();
    super.onInit();
  }
}
