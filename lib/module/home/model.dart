import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JadwalKegiatan {
  final String tryValue1;
  final String tryValue2;
  final String id;
  final Timestamp createdDate;
  JadwalKegiatan(this.tryValue1, this.tryValue2, this.id, this.createdDate);

  factory JadwalKegiatan.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final tryValue1 = json['eventName'] ?? '';
    final tryValue2 = json['city'] ?? '';
    final createdDate = json['createdDate'] ?? '';
    return JadwalKegiatan(tryValue1, tryValue2, id, createdDate);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventName': tryValue1,
      'city': tryValue2,
      'createdDate': createdDate
    };
  }
}
