class CategoryModel {
  final String id;
  final String name;

  CategoryModel({
    required this.name,
    required this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
