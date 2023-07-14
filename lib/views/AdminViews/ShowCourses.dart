import 'package:flutter/material.dart';
import 'package:lms/model/category_model.dart';
import 'package:lms/model/course_model.dart';
import 'package:lms/views/CourseViewer.dart';
import 'package:lms/widgets/coursetile.dart';

class ShowCourses extends StatefulWidget {
  final CategoryModel course;
  final List<CourseModel> courses;
  const ShowCourses({super.key, required this.course, required this.courses});

  @override
  State<ShowCourses> createState() => _ShowCoursesState();
}

class _ShowCoursesState extends State<ShowCourses> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.course.categoryName)),
        body: ListView.builder(
          itemCount: widget.courses.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CourseViewer(course: widget.courses[index]),
                    ));
              },
              child: CourseTile(
                  imageURL: widget.courses[index].courseThumbnail,
                  title: widget.courses[index].name,
                  courseURL: widget.courses[index].courseLink,
                  successRate: "0"),
            );
          },
        ),
      ),
    );
  }
}
