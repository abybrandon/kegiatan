import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtest/module/event/model/event_model.dart';

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
  final String locationName;
  final String locationAddress;
  final EventDate eventDate;
  final List<ContentEvent>? content;
  final List<dynamic> rulesEvent;
  final List<dynamic> rundown;
  final TicketEvent ticketEvent;

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
    required this.locationName,
    required this.locationAddress,
    required this.eventDate,
    this.content,
    this.rulesEvent = const [],
    this.rundown = const [],
    required this.ticketEvent,
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
    final city = json['city']['name'] ?? '';
    final organizerEvent = json['organizerEvent']['name'] ?? '';
    final createdDate = json['createdDate'] ?? '';
    final deskripsi = json['deskripsi'] ?? '';
    final guestStart = json['guestStart'] ?? [''];
    final eventPict = json['eventPict'] ?? [];
    final GeoPoint geoPoint = json['locationName']['coordinateLocation'] ?? '';
    final latitude = geoPoint.latitude;
    final longitude = geoPoint.longitude;
    final locationName = json['locationName']['name'] ?? '';
    final locationAddress = json['locationName']['address'] ?? '';
    final eventDate = EventDate.fromJson(
      json['eventDate'],
    );
    final content = (json['content'] as List)
        .map((item) => ContentEvent.fromJson(item))
        .toList();
    final rulesEvent = json['rules'];
    final rundown = json['rundown'];
    final ticketEvent = TicketEvent.fromJson(json['ticket']);
    ;

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
        longitude: longitude,
        locationName: locationName,
        locationAddress: locationAddress,
        eventDate: eventDate,
        content: content,
        rulesEvent: rulesEvent,
        rundown: rundown,
        ticketEvent: ticketEvent);
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
    final locationName = json['locaitonName']['name'] ?? '';
    final locationAddress = json['locationName']['address'] ?? '';
    final eventDate = EventDate.fromJson(json['eventDate']);
    final content = (json['content'] as List)
        .map((item) => ContentEvent.fromJson(item))
        .toList();
    final rulesEvent = json['rules'];
    final rundown = json['rundown'];

    final ticketEvent = TicketEvent.fromJson(json['ticket']);

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
        longitude: longitude,
        locationName: locationName,
        locationAddress: locationAddress,
        eventDate: eventDate,
        content: content,
        rulesEvent: rulesEvent,
        rundown: rundown,
        ticketEvent: ticketEvent);
  }
}

class ContentEvent {
  String detail;
  String name;
  String pict;

  ContentEvent({required this.detail, required this.name, required this.pict});

  factory ContentEvent.fromJson(Map<String, dynamic> json) {
    return ContentEvent(
        detail: json['detail'], name: json['name'], pict: json['pict']);
  }
}

class TicketEvent {
  String? link;
  String? price;

  TicketEvent({
    required this.link,
    required this.price,
  });

  factory TicketEvent.fromJson(Map<String, dynamic> json) {
    return TicketEvent(
      link: json['link'] ?? '',
      price: json['price'] ?? "",
    );
  }
}
