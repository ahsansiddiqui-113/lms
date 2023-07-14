import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lms/model/category_model.dart';

import '../model/course_model.dart';
import 'package:http/http.dart' as http;

class Course {
  List<CourseModel> course = [];

  List<String> categories = [
    "Acrylic Paint",
    "WaterColor Art",
    "Gouche Painting",
    "Paper Craft",
    "Sculpture & Modelling",
    "HardBoard Craft",
  ];

  Future<void> getAllCourses() async {
    await getACourses();
    await getGCourses();
    await getHCourses();
    await getPCourses();
    await getSCourses();
    await getWCourses();
    CourseList.courses.clear();
    if (CourseList.goucheCourses.length == 0) {
      CourseList.courses.add(CourseList.arcrylicCourse[0]);
      CourseList.courses.add(CourseList.hardBoardCraftCourses[0]);
      CourseList.courses.add(CourseList.sculptureCourse[0]);
      CourseList.courses.add(CourseList.paperCourses[0]);
      CourseList.courses.add(CourseList.wetPaintCourses[0]);
    } else if (CourseList.arcrylicCourse.length == 0) {
      CourseList.courses.add(CourseList.goucheCourses[0]);
      CourseList.courses.add(CourseList.hardBoardCraftCourses[0]);
      CourseList.courses.add(CourseList.sculptureCourse[0]);
      CourseList.courses.add(CourseList.paperCourses[0]);
      CourseList.courses.add(CourseList.wetPaintCourses[0]);
    } else if (CourseList.hardBoardCraftCourses.length == 0) {
      CourseList.courses.add(CourseList.arcrylicCourse[0]);
      CourseList.courses.add(CourseList.goucheCourses[0]);
      CourseList.courses.add(CourseList.sculptureCourse[0]);
      CourseList.courses.add(CourseList.paperCourses[0]);
      CourseList.courses.add(CourseList.wetPaintCourses[0]);
    } else if (CourseList.paperCourses.length == 0) {
      CourseList.courses.add(CourseList.arcrylicCourse[0]);
      CourseList.courses.add(CourseList.goucheCourses[0]);
      CourseList.courses.add(CourseList.hardBoardCraftCourses[0]);
      CourseList.courses.add(CourseList.sculptureCourse[0]);
      CourseList.courses.add(CourseList.wetPaintCourses[0]);
    } else if (CourseList.sculptureCourse.length == 0) {
      CourseList.courses.add(CourseList.arcrylicCourse[0]);
      CourseList.courses.add(CourseList.goucheCourses[0]);
      CourseList.courses.add(CourseList.hardBoardCraftCourses[0]);
      CourseList.courses.add(CourseList.paperCourses[0]);
      CourseList.courses.add(CourseList.wetPaintCourses[0]);
    } else {
      CourseList.courses.add(CourseList.arcrylicCourse[0]);
      CourseList.courses.add(CourseList.goucheCourses[0]);
      CourseList.courses.add(CourseList.hardBoardCraftCourses[0]);
      CourseList.courses.add(CourseList.sculptureCourse[0]);
      CourseList.courses.add(CourseList.paperCourses[0]);
    }
  }

  Future<void> getACourses() async {
    CourseList.arcrylicCourse.clear();
    await FirebaseFirestore.instance
        .collection("Courses")
        .doc("v1")
        .collection(categories[0])
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        CourseList.arcrylicCourse.add(CourseModel.fromSnapshot(value.docs[i]));
      }
    });
  }

  Future<void> getWCourses() async {
    CourseList.wetPaintCourses.clear();
    await FirebaseFirestore.instance
        .collection("Courses")
        .doc("v1")
        .collection(categories[1])
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        CourseList.wetPaintCourses.add(CourseModel.fromSnapshot(value.docs[i]));
      }
    });
  }

  Future<void> getGCourses() async {
    CourseList.goucheCourses.clear();
    await FirebaseFirestore.instance
        .collection("Courses")
        .doc("v1")
        .collection(categories[2])
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        CourseList.goucheCourses.add(CourseModel.fromSnapshot(value.docs[i]));
      }
    });
  }

  Future<void> getPCourses() async {
    CourseList.paperCourses.clear();
    await FirebaseFirestore.instance
        .collection("Courses")
        .doc("v1")
        .collection(categories[3])
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        CourseList.paperCourses.add(CourseModel.fromSnapshot(value.docs[i]));
      }
    });
  }

  Future<void> getSCourses() async {
    CourseList.sculptureCourse.clear();
    await FirebaseFirestore.instance
        .collection("Courses")
        .doc("v1")
        .collection(categories[3])
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        CourseList.sculptureCourse.add(CourseModel.fromSnapshot(value.docs[i]));
      }
    });
  }

  Future<void> getHCourses() async {
    CourseList.hardBoardCraftCourses.clear();
    await FirebaseFirestore.instance
        .collection("Courses")
        .doc("v1")
        .collection(categories[5])
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        CourseList.hardBoardCraftCourses
            .add(CourseModel.fromSnapshot(value.docs[i]));
      }
    });
  }

  Future<void> getCategory() async {
    await FirebaseFirestore.instance.collection("category").get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        CategoryList.categoryList
            .add(CategoryModel.fromSnapshot(value.docs[i]));
      }
    });
  }
}

class CategoryCourse {}
