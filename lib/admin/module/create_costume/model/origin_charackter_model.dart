class CharackterOrigin{
  final String name;
  CharackterOrigin({
    required this.name
  });

  factory CharackterOrigin.fromJson(Map<String, dynamic> json) {
   
    return CharackterOrigin(
      name: json['name']
    );
  }
}