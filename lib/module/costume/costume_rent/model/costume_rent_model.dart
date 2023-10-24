import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtest/admin/module/create_costume/model/category_costume_model.dart';

class ModelCostume {
  final String id;
  final String nameCostume;
  final CategoryModel charackterOrigin;
  final bool status;
  final List<String> categoryCostume;
  final String locationName;
  final Map<String, dynamic> priceRent;
  final List<String> listPhotoCostume;

  ModelCostume({
    required this.id,
    required this.nameCostume,
    required this.charackterOrigin,
    required this.status,
    required this.categoryCostume,
    required this.locationName,
    required this.priceRent,
    required this.listPhotoCostume,
  });


  factory ModelCostume.fromJson(Map<String, dynamic> json) {
    return ModelCostume(
      id: json['id'],
      nameCostume: json['nameCostume'],
      charackterOrigin: CategoryModel.fromJson(json['charackterOrigin']),
      status: json['status'],
      categoryCostume: List<String>.from(json['categoryCostume']),
      locationName: json['locationName'],
      priceRent: Map<String, dynamic>.from(json['priceRent']),
      listPhotoCostume: List<String>.from(json['listPhotoCostume']),
    );
  }
}
