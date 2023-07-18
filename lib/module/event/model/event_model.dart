import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String eventName;
  final String city;
  final String id;
  final Timestamp createdDate;
  EventModel(this.eventName, this.city, this.id, this.createdDate);

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final eventName = json['eventName'] ?? '';
    final city = json['city'] ?? '';
    final createdDate = json['createdDate'] ?? '';
    return EventModel(eventName, city, id, createdDate);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventName': eventName,
      'city': city,
      'createdDate': createdDate
    };
  }
}
