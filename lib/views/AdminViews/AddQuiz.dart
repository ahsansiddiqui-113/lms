import 'package:flutter/material.dart';
import 'package:lms/model/category_model.dart';
import 'package:lms/model/course_model.dart';
import 'package:lms/views/AdminViews/AddQuizToCourse.dart';
import 'package:lms/views/AdminViews/ShowCourses.dart';

class AddQuizView extends StatefulWidget {
  const AddQuizView({super.key});

  @override
  State<AddQuizView> createState() => _AddQuizViewState();
}

class _AddQuizViewState extends State<AddQuizView> {
  @override
  Widget build(BuildContext context) {
    List<CourseModel> courses = [];

    void setCourses(String name) {
      if (name == "Acrylic Paint") {
        setState(() {
          courses = CourseList.arcrylicCourse;
        });
      } else if (name == "WaterColor Art") {
        setState(() {
          courses = CourseList.wetPaintCourses;
        });
      } else if (name == "Gouche Painting") {
        setState(() {
          courses = CourseList.goucheCourses;
        });
      } else if (name == "Paper Craft") {
        setState(() {
          courses = CourseList.paperCourses;
        });
      } else if (name == "Sculpture & Modelling") {
        setState(() {
          courses = CourseList.sculptureCourse;
        });
      } else {
        setState(() {
          courses = CourseList.hardBoardCraftCourses;
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Add Quiz")),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: CategoryList.categoryList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setCourses(CategoryList.categoryList[index].categoryName);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddQuizToCourse(
                          category: CategoryList.categoryList[index],
                          courses: courses),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child:
                          Text(CategoryList.categoryList[index].categoryName),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
