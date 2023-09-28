class CategoryCostumeModel{
  
  final String name;

  CategoryCostumeModel({
    required this.name
  });

  factory CategoryCostumeModel.fromJson(Map<String, dynamic> json) {
   
    return CategoryCostumeModel(
      name: json['category_name']
    );
  }
}