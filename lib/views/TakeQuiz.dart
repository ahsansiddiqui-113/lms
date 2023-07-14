import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/helper/SaveImage.dart';
import 'package:lms/views/PreviewCertificate.dart';
import 'package:path_provider/path_provider.dart';
import '../model/course_model.dart';
import 'package:http/http.dart' as http;

class TakeQuiz extends StatefulWidget {
  final CourseModel course;
  const TakeQuiz({super.key, required this.course});

  @override
  State<TakeQuiz> createState() => _TakeQuizState();
}

class _TakeQuizState extends State<TakeQuiz> {
  File? _image;
  String Url = "";
  @override
  void initState() {
    getartUrl();
    super.initState();
  }

  void getartUrl() async {
    try {
      var quizUrl = await FirebaseFirestore.instance
          .collection("quizes")
          .doc(widget.course.quizId)
          .get();
      setState(() {
        Url = quizUrl["imageUrl"];
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("No Quiz Found For the this Course"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"))
          ],
        ),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () async {
                                var image = await ImagePicker.platform
                                    .getImageFromSource(
                                        source: ImageSource.camera);

                                if (image == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("No Image Selected")));
                                } else {
                                  setState(() {
                                    _image = File(image.path);
                                  });
                                }
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.camera,
                                size: 60,
                              )),
                          const SizedBox(
                            height: 24,
                          ),
                          IconButton(
                              onPressed: () async {
                                var image = await ImagePicker.platform
                                    .getImageFromSource(
                                        source: ImageSource.gallery);
                                if (image == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("No Image Selected")));
                                } else {
                                  setState(() {
                                    _image = File(image.path);
                                  });
                                }
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.portrait,
                                size: 60,
                              ))
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _image == null
                              ? NetworkImage(Url)
                              : FileImage(_image!) as ImageProvider),
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              child: Text("Check"),
              onPressed: () async {
                EasyLoading.show();
                var quizUrl = await FirebaseFirestore.instance
                    .collection("quizes")
                    .doc(widget.course.quizId)
                    .get();
                if (quizUrl.exists && _image != null) {
                  var fileSaver = SaveFile();
                  var imageUrl = quizUrl["imageUrl"];
                  var response = await get(Uri.parse(imageUrl)); // <--2
                  File file = await fileSaver.saveImage(imageUrl);
                  var request = http.MultipartRequest(
                      'POST',
                      Uri.parse(
                          'https://pacific-forest-92471.herokuapp.com/score'));
                  request.files.add(await http.MultipartFile.fromPath(
                      'image_one', _image!.path));
                  request.files.add(await http.MultipartFile.fromPath(
                      'image_two', file.path));
                  http.StreamedResponse resp = await request.send();

                  if (response.statusCode == 200) {
                    var respData = await resp.stream.bytesToString();
                    var decodedData = jsonDecode(respData);
                    var confidence = decodedData["confidence"] as double;

                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Quiz Result"),
                              actions: [
                                confidence > 0.5
                                    ? TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PreviewCertificate(
                                                  courseName:
                                                      widget.course.name,
                                                ),
                                              ));
                                        },
                                        child: Text("Generate Certificate"))
                                    : SizedBox(),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ok")),
                              ],
                              content: Text("Your Art Simililarity: " +
                                  (confidence * 100).toString() +
                                  "%"),
                            ));
                  }
                } else {
                  //print(resp.reasonPhrase);
                }

                EasyLoading.showSuccess("Done");
                EasyLoading.dismiss();
              },
            )
          ],
        ),
      ),
    ));
  }
}
