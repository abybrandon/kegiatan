import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityModel {
  final String id;
  final String communityPicture;
  final String communityName;
  final String communitySlogan;
  final String communityBio;
  final CommunitySocialMedia communitySocialMedia;
  final Timestamp createdDate;

  CommunityModel(
      {required this.id,
      required this.communityBio,
      required this.communityName,
      required this.communityPicture,
      required this.communitySlogan,
      required this.communitySocialMedia,
      required this.createdDate});

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
        id: json['id'],
        communityBio: json['communityBio'],
        communityName: json['communityName'],
        communityPicture: json['communityPicture'],
        communitySlogan: json['communitySlogan'],
        communitySocialMedia: json['communitySocialMedia'],
        createdDate: json['createdDate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'communityBio': communityBio,
      'communityName': communityName,
      'communityPicture': communityPicture,
      'communitySlogan': communitySlogan,
      'communitySocialMedia': communitySocialMedia.toJson(),
      'createdDate' : createdDate
    };
  }
}

class CommunitySocialMedia {
  final String facebookLink;
  final String instagramLink;

  CommunitySocialMedia(
      {required this.facebookLink, required this.instagramLink});

  Map<String, dynamic> toJson() {
    return {
      'facebookLink': facebookLink,
      'instagramLink': instagramLink,
    };
  }

  factory CommunitySocialMedia.fromJson(Map<String, dynamic> json) {
    return CommunitySocialMedia(
        facebookLink: json['facebookLink'],
        instagramLink: json['facebookLink']);
  }
}
