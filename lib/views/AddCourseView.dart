import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nanoid/nanoid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AddCourseView extends StatefulWidget {
  const AddCourseView({super.key});

  @override
  State<AddCourseView> createState() => _AddCourseViewState();
}

class _AddCourseViewState extends State<AddCourseView> {
  String videoId = "";
  var _titleController = TextEditingController();
  var _linkController = TextEditingController();
  var _descriptionContoller = TextEditingController();
  var thumbnailUrl = "";
  var categoryName = "";
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem> categoryList = <DropdownMenuItem>[
    DropdownMenuItem(
      child: Text("Acrylic Paint"),
      value: "Acrylic Paint",
    ),
    DropdownMenuItem(
      child: Text("WaterColor Art"),
      value: "WaterColor Art",
    ),
    DropdownMenuItem(
      child: Text("Gouche Painting"),
      value: "Gouche Painting",
    ),
    DropdownMenuItem(
      child: Text("Paper Craft"),
      value: "Paper Craft",
    ),
    DropdownMenuItem(
      child: Text("Sculpture & Modelling"),
      value: "Sculpture & Modelling",
    ),
    DropdownMenuItem(
      child: Text("HardBoard Craft"),
      value: "HardBoard Craft",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Course"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  thumbnailUrl == ""
                      ? SizedBox()
                      : Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(thumbnailUrl)),
                          ),
                        ),
                  !(thumbnailUrl == "")
                      ? const SizedBox(
                          height: 12,
                        )
                      : SizedBox(),
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Field cannot be Empty";
                      }
                      return null;
                    },
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Course Name",
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Field cannot be Empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Select Category"),
                    items: categoryList,
                    onChanged: (value) {
                      setState(() {
                        categoryName = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Field cannot be Empty";
                      }
                      return null;
                    },
                    controller: _linkController,
                    onChanged: (value) {
                      try {
                        videoId = YoutubePlayer.convertUrlToId(value)!;
                        setState(() {
                          thumbnailUrl =
                              "https://img.youtube.com/vi/$videoId/0.jpg";
                        });
                      } catch (e) {
                        setState(() {
                          thumbnailUrl = "";
                        });
                        print(e);
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Course Link",
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 20,
                    validator: (value) {
                      if (value == null) {
                        return "Field cannot be Empty";
                      }
                      return null;
                    },
                    controller: _descriptionContoller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Course Description",
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (thumbnailUrl == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Course Link Invalid")));
                          } else {
                            EasyLoading.show();
                            addCourse(
                                    name: _titleController.text,
                                    category: categoryName,
                                    courseLink: _linkController.text,
                                    courseDescription:
                                        _descriptionContoller.text,
                                    courseThumbnail: thumbnailUrl)
                                .then((value) {
                              EasyLoading.showSuccess("Course Added");
                              _descriptionContoller.clear();
                              _linkController.clear();
                              _titleController.clear();
                              thumbnailUrl = "";
                              categoryName = "";
                              setState(() {});
                            });
                          }
                        }
                      },
                      child: Text("Add")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionContoller.clear();
    _linkController.clear();
    _titleController.clear();
    super.dispose();
  }

  Future<void> addCourse({
    required String name,
    required String category,
    required String courseLink,
    required String courseDescription,
    required String courseThumbnail,
  }) async {
    var id = nanoid();
    await FirebaseFirestore.instance
        .collection("Courses")
        .doc("v1")
        .collection(category)
        .doc(id)
        .set({
      "id": id,
      "name": name,
      "category": category,
      "courseLink": courseLink,
      "courseThumbnail": courseThumbnail,
      "courseDescription": courseDescription,
      "quizId": id
    });
  }
}
