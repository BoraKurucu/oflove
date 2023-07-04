class UserModel {
  final String? id;
  final String email;

  const UserModel({this.id, required this.email});

  toJson() {
    return {
      "Email": email,
    };
  }
}
