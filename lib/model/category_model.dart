import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryList {
  static List<CategoryModel> categoryList = [];
}

class CategoryModel {
  final String imageURL;
  final String categoryName;
  final Color color;

  CategoryModel(
      {required this.imageURL,
      required this.categoryName,
      required this.color});

  static CategoryModel fromSnapshot(DocumentSnapshot snapshot) {
    return CategoryModel(
        imageURL: snapshot["imageURL"],
        categoryName: snapshot["name"],
        color: Color(int.parse(snapshot["color"])));
  }
}
