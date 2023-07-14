import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:lms/model/userModal.dart';
import 'package:nanoid/nanoid.dart';

class AddArtWork extends StatefulWidget {
  const AddArtWork({super.key});

  @override
  State<AddArtWork> createState() => _AddArtWorkState();
}

class _AddArtWorkState extends State<AddArtWork> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Your ArtWork"),
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
                                            content:
                                                Text("No Image Selected")));
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
                                            content:
                                                Text("No Image Selected")));
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
                                ? NetworkImage(
                                    "https://w7.pngwing.com/pngs/972/334/png-transparent-computer-icons-add-logo-desktop-wallpaper-add-thumbnail.png")
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
                child: Text("Add"),
                onPressed: () async {
                  EasyLoading.show();
                  var id = nanoid();
                  var imgRef =
                      FirebaseStorage.instance.ref().child("artworks/${id}");
                  await imgRef.putFile(_image!);
                  await imgRef.getDownloadURL().then((value) async {
                    await FirebaseFirestore.instance
                        .collection("artworks")
                        .doc(id)
                        .set({
                      "id": id,
                      "author": UserList.users.first.name,
                      "artWorkUrl": value,
                      "likes": 0
                    });
                  });
                  EasyLoading.showSuccess("Done");
                  EasyLoading.dismiss();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
