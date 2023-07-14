import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lms/model/course_model.dart';
import 'package:lms/widgets/coursetile.dart';

class DeleteCourseFromCategory extends StatefulWidget {
  final String categoryName;
  const DeleteCourseFromCategory({super.key, required this.categoryName});

  @override
  State<DeleteCourseFromCategory> createState() =>
      _DeleteCourseFromCategoryState();
}

class _DeleteCourseFromCategoryState extends State<DeleteCourseFromCategory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Courses")
              .doc("v1")
              .collection(widget.categoryName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data!.docs.length == 0) {
                return Center(
                  child: Text("No Courses in This Category"),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs;
                  var course = CourseModel.fromSnapshot(data[index]);
                  return InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Are You Sure to Delete This Course"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("No")),
                            TextButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("Courses")
                                      .doc("v1")
                                      .collection(widget.categoryName)
                                      .doc(course.id)
                                      .delete();
                                  Navigator.pop(context);
                                },
                                child: Text("Yes")),
                          ],
                        ),
                      );
                    },
                    child: CourseTile(
                        imageURL: course.courseThumbnail,
                        title: course.name,
                        courseURL: course.courseLink,
                        successRate: "0"),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
