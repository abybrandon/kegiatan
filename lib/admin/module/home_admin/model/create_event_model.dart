import 'package:cloud_firestore/cloud_firestore.dart';

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
