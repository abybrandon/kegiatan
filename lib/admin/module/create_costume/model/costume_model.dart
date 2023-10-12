import 'package:cloud_firestore/cloud_firestore.dart';

import 'category_costume_model.dart';

class CreateEventModel {
  final String id;
  final String nameEvent;
  final String organizerEvent;
  final String cityEvent;
  final String deskripsi;
  final Timestamp createdDate;
  final Timestamp startDate;
  final Timestamp endDate;
  final List<String>? fotoKegiatanUrls;
  final List<String> guestStart;
  final GeoPoint? location; // Tambahkan field GeoPoint

  CreateEventModel(
      {required this.id,
      required this.nameEvent,
      required this.organizerEvent,
      required this.cityEvent,
      required this.deskripsi,
      required this.createdDate,
      required this.guestStart,
      this.fotoKegiatanUrls,
      this.location,
      required this.startDate,
      required this.endDate});

  // Mengubah toJson() untuk menyertakan data GeoPoint dalam Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventName': nameEvent,
      'organizerEvent': organizerEvent,
      'city': cityEvent,
      'deskripsi': deskripsi,
      'createdDate': endDate,
      'eventPict': fotoKegiatanUrls,
      'guestStart': guestStart,
      'location': location != null
          ? GeoPoint(location!.latitude, location!.longitude)
          : null,
      'startDate': startDate,
      'endDate': endDate
    };
  }
}

class ModelCostume {
  final String id;
  final String nameCostume;
  final CategoryModel charackterOrigin;
  final CategoryModel charackterName;
  final bool status;
  final List<String> categoryCostume;
  final Timestamp createdDate;
  final String locationName;
  final List<String> availSize;
  final CategoryModel brandCostume;
  final String detailCostume;
  final Map<String, dynamic> owner;
  final String genderCostume;
  final Map<String, dynamic> priceRent;
  final List<String> listPhotoCostume;

  ModelCostume({
    required this.id,
    required this.nameCostume,
    required this.charackterOrigin,
    required this.charackterName,
    required this.status,
    required this.categoryCostume,
    required this.createdDate,
    required this.locationName,
    required this.availSize,
    required this.brandCostume,
    required this.detailCostume,
    required this.owner,
    required this.genderCostume,
    required this.priceRent,
    required this.listPhotoCostume,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameCostume': nameCostume,
      'charackterOrigin': charackterOrigin.toJson(),
      'charackterName': charackterName.toJson(),
      'status': status,
      'categoryCostume': categoryCostume,
      'createdDate': createdDate,
      'locationName': locationName,
      'availSize': availSize,
      'brandCostume': brandCostume.toJson(),
      'detailCostume': detailCostume,
      'owner': owner,
      'gender' : genderCostume,
      'priceRent' : priceRent,
      'listPhotoCostume' : listPhotoCostume
    };
  }
}
