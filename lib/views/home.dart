import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms/model/userModal.dart';
import 'package:lms/views/AdminViews/ShowCourses.dart';
import 'package:lms/views/ArtWorks.dart';
import 'package:lms/views/CourseViewer.dart';
import 'package:lms/views/FavouriteView.dart';
import 'package:lms/views/LoginView.dart';
import '/widgets/coursetile.dart';

import '../helper/course.dart';
import '../model/category_model.dart';
import '../model/course_model.dart';
import '../widgets/categorytile.dart';
import 'AddCourseView.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<CourseModel> courses = [];

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCourse();
  }

  getCourse() async {
    Course courseClass = Course();
    await courseClass.getCategory();
    await courseClass.getAllCourses();

    setState(() {
      _loading = false;
    });
  }

  List<CourseModel> course = [];

  void setCourses(String name) {
    if (name == "Acrylic Paint") {
      setState(() {
        course = CourseList.arcrylicCourse;
      });
    } else if (name == "WaterColor Art") {
      setState(() {
        course = CourseList.wetPaintCourses;
      });
    } else if (name == "Gouche Painting") {
      setState(() {
        course = CourseList.goucheCourses;
      });
    } else if (name == "Paper Craft") {
      setState(() {
        course = CourseList.paperCourses;
      });
    } else if (name == "Sculpture & Modelling") {
      setState(() {
        course = CourseList.sculptureCourse;
      });
    } else {
      setState(() {
        course = CourseList.hardBoardCraftCourses;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFFFFFF),
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello " + UserList.users.first.name,
                      style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Color(0XFF747474),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Find your Free Courses",
                      style: GoogleFonts.notoSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff232323)),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavouriteView(),
                        ));
                  },
                  child: SvgPicture.asset(
                    "assets/love.svg",
                    color: Color(0xff99CAE1),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ));
                    },
                    icon: Icon(Icons.person))
              ],
            ),
          ),
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: SpinKitWave(
                  color: Color(0xff99CAE1),
                  size: 30.0,
                ),
              ),
              ////categories
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Category",
                        style: GoogleFonts.notoSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff232323)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 40,
                      ),
                      width: double.infinity,
                      height: 200,
                      child: ListView.builder(
                          itemCount: CategoryList.categoryList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, int index) {
                            return CategoryTile(
                              onTap: () {
                                setCourses(CategoryList
                                    .categoryList[index].categoryName);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShowCourses(
                                          course:
                                              CategoryList.categoryList[index],
                                          courses: course),
                                    ));
                              },
                              imageURL:
                                  CategoryList.categoryList[index].imageURL,
                              color: CategoryList.categoryList[index].color,
                              categoryName:
                                  CategoryList.categoryList[index].categoryName,
                            );
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Courses",
                        style: GoogleFonts.notoSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff232323)),
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          itemCount: CourseList.courses.length,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, int i) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CourseViewer(
                                          course: CourseList.courses[i]),
                                    ));
                              },
                              child: CourseTile(
                                imageURL: CourseList.courses[i].courseThumbnail,
                                title: CourseList.courses[i].name,
                                courseURL: CourseList.courses[i].courseLink,
                                successRate:
                                    CourseList.courses[i].courseDescription,
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
