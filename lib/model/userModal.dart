import 'package:cloud_firestore/cloud_firestore.dart';

class UserList {
  static List<UserModal> users = [];
}

class UserModal {
  final String name;
  final String email;
  final String imageUrl;

  UserModal({required this.name, required this.email, required this.imageUrl});

  static UserModal fromSnapshot(DocumentSnapshot snapshot) {
    return UserModal(
        name: snapshot["name"],
        email: snapshot["email"],
        imageUrl: snapshot["profile_image"]);
  }
}
