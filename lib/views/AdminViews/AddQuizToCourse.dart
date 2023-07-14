import 'package:flutter/material.dart';
import 'package:lms/model/course_model.dart';
import 'package:lms/views/AdminViews/AddCompetetion.dart';

import '../../model/category_model.dart';
import '../../widgets/coursetile.dart';

class AddQuizToCourse extends StatefulWidget {
  final CategoryModel category;
  final List<CourseModel> courses;
  const AddQuizToCourse({
    super.key,
    required this.category,
    required this.courses,
  });

  @override
  State<AddQuizToCourse> createState() => _AddQuizToCourseState();
}

class _AddQuizToCourseState extends State<AddQuizToCourse> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.category.categoryName)),
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
                          AddCompetetion(courseModel: widget.courses[index]),
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
