import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms/model/course_model.dart';
import 'package:lms/views/AddCourseView.dart';
import 'package:lms/views/AdminViews/AddQuiz.dart';
import 'package:lms/views/AdminViews/DeleteCourse.dart';

import '../../helper/course.dart';
import '../../model/category_model.dart';
import '../ArtWorks.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool Loading = false;
  @override
  void initState() {
    // TODO: implement initState
    getCourse();
    super.initState();
  }

  getCourse() async {
    Course courseClass = Course();
    CategoryList.categoryList.clear();
    CourseList.arcrylicCourse.clear();
    CourseList.courses.clear();
    CourseList.goucheCourses.clear();
    CourseList.hardBoardCraftCourses.clear();
    CourseList.paperCourses.clear();
    CourseList.sculptureCourse.clear();
    CourseList.wetPaintCourses.clear();
    await courseClass.getCategory();
    await courseClass.getAllCourses();
    setState(() {
      Loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtWorks(),
                  ));
            },
            child: Center(
              child: Icon(Icons.portrait),
            )),
        appBar: AppBar(
          title: Text("Welcome, Admin"),
        ),
        body: Loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/intro.svg",
                          height: 250,
                          width: 250,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddCourseView(),
                                ));
                          },
                          child: Card(
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(context).primaryColor,
                              child: Center(
                                  child: Text(
                                "Add Course",
                                style: TextStyle(fontSize: 20),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddQuizView(),
                                ));
                          },
                          child: Card(
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(context).primaryColor,
                              child: Center(
                                  child: Text(
                                "Add Quiz",
                                style: TextStyle(fontSize: 20),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeleteCourse(),
                                ));
                          },
                          child: Card(
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(context).primaryColor,
                              child: Center(
                                  child: Text(
                                "Delete Courses",
                                style: TextStyle(fontSize: 20),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
