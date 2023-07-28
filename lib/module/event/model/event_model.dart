import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String eventName;
  final String city;
  final String id;
  final List<dynamic> eventPict;
  final Timestamp createdDate;
  EventModel(
      {required this.eventName,
      required this.city,
      required this.id,
      required this.createdDate,
      required this.eventPict});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final eventName = json['eventName'] ?? '';
    final city = json['city'] ?? '';
    final createdDate = json['createdDate'] ?? '';
    final eventPict = json['eventPict'] ?? '';
    return EventModel(
        eventName: eventName,
        city: city,
        id: id,
        createdDate: createdDate,
        eventPict: eventPict);
  }
}
