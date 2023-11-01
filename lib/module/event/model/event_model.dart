import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String eventName;
  final String city;
  final String id;
  final List<dynamic> eventPict;
  final Timestamp createdDate;
  final EventDate eventDate;

  EventModel(
      {required this.eventName,
      required this.city,
      required this.id,
      required this.createdDate,
      required this.eventPict,
      required this.eventDate});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final eventName = json['eventName'] ?? '';
    final city = json['city']['name'] ?? '';
    final createdDate = json['createdDate'] ?? '';
    final eventPict = json['eventPict'] ?? '';
    final eventDate = EventDate.fromJson(json['eventDate']);
    return EventModel(
        eventName: eventName,
        city: city,
        id: id,
        createdDate: createdDate,
        eventPict: eventPict,
        eventDate: eventDate);
  }
}

class EventDate {
  final Timestamp? endDate;
  final Timestamp startDate;
  final String time;

  EventDate({this.endDate, required this.startDate, required this.time});
  factory EventDate.fromJson(Map<String, dynamic> json) {
    return EventDate(
        endDate: json['endDate'],
        startDate: json['startDate'],
        time: json['time']);
  }
}
