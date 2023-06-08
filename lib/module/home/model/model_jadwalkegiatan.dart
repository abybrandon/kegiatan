import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JadwalKegiatan {
  final String tryValue1;
  final String tryValue2;
  final String id;
  final Timestamp createdDate;
  JadwalKegiatan(this.tryValue1, this.tryValue2, this.id, this.createdDate);

  factory JadwalKegiatan.fromJson(Map<String, dynamic> json) {
    final tryValue1 = json['try'] ?? '';
    final tryValue2 = json['try2'] ?? '';
    final id = json['id'];
    final createdDate = json['createdDate'] ?? '';
    return JadwalKegiatan(tryValue1, tryValue2, id, createdDate);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'try': tryValue1,
      'try2': tryValue2,
      'createdDate': createdDate
    };
  }
}
