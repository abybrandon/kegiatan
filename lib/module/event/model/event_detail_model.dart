import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailModel {
  final String id;
  final String eventName;
  final String city;
  final String organizerEvent;
  final String deskripsi;
  final List<dynamic> guestStart;
  final List<dynamic> eventPict;
  final Timestamp createdDate;
  final double latitude;
  final double longitude;

  EventDetailModel({
    required this.id,
    required this.eventName,
    required this.city,
    required this.organizerEvent,
    required this.deskripsi,
    required this.guestStart,
    required this.createdDate,
    required this.latitude,
    required this.longitude,
    this.eventPict = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventName': eventName,
      'city': city,
      'organizerEvent': organizerEvent,
      'deskripsi': deskripsi,
      'guestStart': guestStart,
      'createdDate': createdDate.seconds, // Menyertakan properti createdDate
      'location': {
        'latitude': latitude, // Menyertakan properti latitude
        'longitude': longitude, // Menyertakan properti longitude
      }, // Menyertakan properti longitude
      'eventPict': eventPict,
    };
  }

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final eventName = json['eventName'] ?? '';
    final city = json['city'] ?? '';
    final organizerEvent = json['organizerEvent'] ?? '';
    final createdDate = json['createdDate'] ?? '';
    final deskripsi = json['deskripsi'] ?? '';
    final guestStart = json['guestStart'] ?? [''];
    final eventPict = json['eventPict'] ?? [];
    final GeoPoint geoPoint = json['location'] ?? '';
    final latitude = geoPoint.latitude;
    final longitude = geoPoint.longitude;

    return EventDetailModel(
        eventName: eventName,
        city: city,
        id: id,
        deskripsi: deskripsi,
        guestStart: guestStart,
        organizerEvent: organizerEvent,
        createdDate: createdDate,
        eventPict: eventPict,
        latitude: latitude,
        longitude: longitude);
  }

  factory EventDetailModel.fromJsonPref(Map<String, dynamic> json) {
    final id = json['id'];
    final eventName = json['eventName'] ?? '';
    final city = json['city'] ?? '';
    final organizerEvent = json['organizerEvent'] ?? '';
    final createdDateInSeconds = json['createdDate'] ?? 0;
    final createdDate =
        Timestamp.fromMillisecondsSinceEpoch(createdDateInSeconds * 1000);
    final deskripsi = json['deskripsi'] ?? '';
    final guestStart = json['guestStart'] ?? [''];
    final eventPict = json['eventPict'] ?? [];
    final Map<String, dynamic> locationJson = json['location'] ?? {};
    final GeoPoint geoPoint = GeoPoint(
      locationJson['latitude'] ?? 0.0,
      locationJson['longitude'] ?? 0.0,
    );
    final latitude = geoPoint.latitude;
    final longitude = geoPoint.longitude;

    return EventDetailModel(
        eventName: eventName,
        city: city,
        id: id,
        deskripsi: deskripsi,
        guestStart: guestStart,
        organizerEvent: organizerEvent,
        createdDate: createdDate,
        eventPict: eventPict,
        latitude: latitude,
        longitude: longitude);
  }
}
