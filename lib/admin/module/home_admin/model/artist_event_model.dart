class ArtistEventModel {
  final String id;
  final String nameArtist;

  ArtistEventModel({
    required this.id,
    required this.nameArtist,
  });

  factory ArtistEventModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final nameArtist = json['nameArtist'] ?? '';
    return ArtistEventModel(id: id, nameArtist: nameArtist);
  }
}
