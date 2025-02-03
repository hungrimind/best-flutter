class User {
  User({this.id, required this.name, required this.uid, required this.isAdmin});

  final int? id;
  final String name;
  final String uid;
  final int isAdmin;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String,
      uid: json['uid'] as String,
      isAdmin: (json['admin'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'uid': uid,
      'admin': isAdmin,
    };
  }
}
