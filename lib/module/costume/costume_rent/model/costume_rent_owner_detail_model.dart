import 'package:newtest/admin/module/create_costume/model/category_costume_model.dart';

class CostumeRentOwnerDetailModel {
  final CategoryModel city;
  final String name;
  final String linkFb;
  final String linkInstagram;
  final String pictOwner;
  final String rulesRent;
  CostumeRentOwnerDetailModel(
      {required this.city,
      required this.linkFb,
      required this.linkInstagram,
      required this.name,
      required this.pictOwner,
      required this.rulesRent});

  factory CostumeRentOwnerDetailModel.fromJson(Map<String, dynamic> json) {
    return CostumeRentOwnerDetailModel(
        city: CategoryModel.fromJson(json['city']),
        linkFb: json['facebook'],
        linkInstagram: json['instagram'],
        name: json['name'],
        pictOwner: json['pict'],
        rulesRent: json['rules']);
  }

  Map<String, dynamic> toJson() {
    return {
      'facebook': linkFb,
      'instagram': linkInstagram,
      'name': name,
      'pict': pictOwner,
      'rules': rulesRent,
    };
  }
}
