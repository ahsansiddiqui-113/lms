import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lms/model/userModal.dart';

import '../views/home.dart';

class Account {
  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    createAccount(email: email, password: password);
    await storeUserData(name: name, email: email, password: password);
    Navigator.pop(context);
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await getUserData();
        EasyLoading.dismiss();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.code);
      EasyLoading.dismiss();
    }
  }

  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.code);
      EasyLoading.dismiss();
      print(e.code);
    }
  }

  Future<void> storeUserData({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "name": name,
        "email": email,
        "profile_image":
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
      });
      await FirebaseAuth.instance.signOut();
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.code);
      EasyLoading.dismiss();
      print(e.code);
    }
  }

  Future<void> getUserData() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        UserList.users.clear();
        UserList.users.add(UserModal.fromSnapshot(value));
      });
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.code);
      EasyLoading.dismiss();
    }
  }
}
