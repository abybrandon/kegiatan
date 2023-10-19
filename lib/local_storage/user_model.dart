class UserData {
  final String id;
  final String username;
  final String role;

  UserData({
    required this.id,
    required this.username,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'role': role,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      username: json['username'],
      role: json['role'],
    );
  }
}