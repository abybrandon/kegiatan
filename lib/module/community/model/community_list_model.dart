class CommunityListModel {
  final String id;
  final String name;
  final String slogan;
  final String picture;
  final Map<String, dynamic> location;
  CommunityListModel(
      {
        required this.id,
        required this.name,
      required this.picture,
      required this.slogan,
      required this.location});
  factory CommunityListModel.fromJson(Map<String, dynamic> json) {
    return CommunityListModel(
      id: json['id'],
        name: json['name'],
        picture: json['picture'],
        slogan: json['slogan'],
        location: json['location']);
  }
}
