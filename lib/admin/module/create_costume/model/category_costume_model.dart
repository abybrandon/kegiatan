class CategoryModel {
  final String id;
  final String name;
  final int key;

  CategoryModel({required this.name, required this.id, required this.key});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'], name: json['name'], key: json['key']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'key': key,
    };
  }
}
