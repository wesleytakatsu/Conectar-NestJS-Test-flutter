class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? photoURL;
  final bool? isGoogleUser;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.createdAt,
    this.updatedAt,
    this.photoURL,
    this.isGoogleUser,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'user',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      photoURL: json['photoURL'],
      isGoogleUser: json['isGoogleUser'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'photoURL': photoURL,
      'isGoogleUser': isGoogleUser,
    };
  }
}