class LocationModel {
  final String city;
  final String province;
  final String id;
  LocationModel(this.city, this.province, this.id);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final city = json['city'] ?? '';
    final province = json['province'] ?? '';
    return LocationModel(
      city,
      province,
      id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'province': province,
    };
  }
}
