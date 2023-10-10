
class CostumeRentModel {
  final String id;
  final String nameCostume;
  final int priceRent;
  final int dayRent;
  final String brandCostume;
  final List<dynamic> pictcostume;
  CostumeRentModel(
      {required this.nameCostume,
      required this.priceRent,
      required this.id,
      required this.brandCostume,
      required this.dayRent,
      required this.pictcostume});

  factory CostumeRentModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final nameCostume = json['name_costume'] ?? '';
    final priceRent = json['price_rent'] ?? '';
    final dayRent = json['day_rent'] ?? '';
    final brandCostume = json['brand_costume'] ?? '';
    final pictCostume = json['pict_costume'] ?? '';

    return CostumeRentModel(
        id: id,
        brandCostume: brandCostume,
        dayRent: dayRent,
        nameCostume: nameCostume,
        pictcostume: pictCostume,
        priceRent: priceRent);
  }
}



class CostumeRentPagination{
  final String name;
  final String id;
  CostumeRentPagination({required this.name, required this.id});

  
  factory CostumeRentPagination.fromJson(Map<String, dynamic> json) {

    return CostumeRentPagination(
    name: json['name'] ,
id: json['id']
    );
  }
}