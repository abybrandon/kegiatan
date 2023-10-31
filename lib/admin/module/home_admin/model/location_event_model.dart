import 'package:cloud_firestore/cloud_firestore.dart';

class LocationEventModel {
  final String locationName;
  final String id;
  final double latitude;
  final double longitude;
  final String locationCity;

  LocationEventModel(
    this.locationName,
    this.id,
    this.latitude,
    this.longitude,
    this.locationCity,
  );

  factory LocationEventModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final locationName = json['locationName'] ?? '';
    final GeoPoint geoPoint = json['coordinateLocation'];
    final latitude = geoPoint.latitude;
    final longitude = geoPoint.longitude;
    final locationCity = json['locationCity'];
    return LocationEventModel(
        locationName, id, latitude, longitude, locationCity);
  }
}
