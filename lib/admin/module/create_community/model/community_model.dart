import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityModel {
  final String id;
  final String communityPicture;
  final String communityName;
  final String communitySlogan;
  final String communityBio;
  final CommunitySocialMedia communitySocialMedia;
  final OwnerCommunity ownerCommunity;
  final Timestamp createdDate;
  final Timestamp updatedAt;
  final int post;
  final int followers;
  final Map<String,dynamic> location;

  CommunityModel(
      {required this.id,
      required this.communityBio,
      required this.communityName,
      required this.communityPicture,
      required this.communitySlogan,
      required this.communitySocialMedia,
      required this.ownerCommunity,
      required this.createdDate,
      required this.updatedAt,
      required this.post,
      required this.followers,
      required this.location,
      });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
        id: json['id'],
        communityBio: json['bio'],
        communityName: json['name'],
        communityPicture: json['picture'],
        communitySlogan: json['slogan'],
        communitySocialMedia:
            CommunitySocialMedia.fromJson(json['socialMedia']),
        createdDate: json['createdDate'],
        ownerCommunity: OwnerCommunity.fromJson(json['owner']),
        updatedAt: json['updatedAt']
        ,followers: json['followers'],
        post: json['post'],
        location: json['location']
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bio': communityBio,
      'name': communityName,
      'picture': communityPicture,
      'slogan': communitySlogan,
      'socialMedia': communitySocialMedia.toJson(),
      'createdDate': createdDate,
      'owner': ownerCommunity.toJson(),
      'updatedAt': updatedAt,
      'followers' : followers,
      'post' : post,
      'location': location,
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
        instagramLink: json['instagramLink']);
  }
}

class OwnerCommunity {
  final String id;
  final String userName;

  OwnerCommunity({required this.id, required this.userName});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': userName,
    };
  }

  factory OwnerCommunity.fromJson(Map<String, dynamic> json) {
    return OwnerCommunity(id: json['id'], userName: json['username']);
  }
}
