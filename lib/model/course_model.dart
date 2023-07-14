import 'package:cloud_firestore/cloud_firestore.dart';

class CourseList {
  static List<CourseModel> courses = [];
  static List<CourseModel> arcrylicCourse = [];
  static List<CourseModel> wetPaintCourses = [];
  static List<CourseModel> goucheCourses = [];
  static List<CourseModel> hardBoardCraftCourses = [];
  static List<CourseModel> sculptureCourse = [];
  static List<CourseModel> paperCourses = [];
}

class CourseModel {
  String id;
  String name;
  String courseThumbnail;
  String courseLink;
  String courseDescription;
  String category;
  String quizId;

  CourseModel(
      {required this.name,
      required this.category,
      required this.courseThumbnail,
      required this.courseDescription,
      required this.courseLink,
      required this.id,
      required this.quizId});

  static CourseModel fromSnapshot(DocumentSnapshot snapshot) {
    return CourseModel(
        name: snapshot["name"],
        quizId: snapshot["quizId"],
        category: snapshot["category"],
        courseDescription: snapshot["courseDescription"],
        courseLink: snapshot["courseLink"],
        courseThumbnail: snapshot["courseThumbnail"],
        id: snapshot["id"]);
  }
}
