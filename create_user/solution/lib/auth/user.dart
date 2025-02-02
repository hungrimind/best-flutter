class User {
  User({this.id, required this.name, required this.uid});

  final int? id;
  final String name;
  final String uid;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String,
      uid: json['uid'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'uid': uid,
    };
  }
}
