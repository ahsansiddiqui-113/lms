import 'package:cloud_firestore/cloud_firestore.dart';

class ArtList {
  static List<ArtWorkModel> allArtList = [];
  static List<ArtWorkModel> currentUserArtList = [];
}

class ArtWorkModel {
  String id;
  String author;
  String artWorkUrl;
  int likes;

  ArtWorkModel(
      {required this.id,
      required this.author,
      required this.artWorkUrl,
      required this.likes});

  static ArtWorkModel fromSnapshot(DocumentSnapshot snapshot) {
    return ArtWorkModel(
        id: snapshot["id"],
        author: snapshot["author"],
        artWorkUrl: snapshot["artWorkUrl"],
        likes: snapshot["likes"]);
  }
}
