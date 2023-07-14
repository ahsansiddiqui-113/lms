import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms/firebase_options.dart';
import 'package:lms/model/userModal.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/views/home.dart';
import 'views/LoginView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<int, Color> color = {
    50: Color.fromRGBO(254, 124, 151, .1),
    100: Color.fromRGBO(254, 124, 151, .2),
    200: Color.fromRGBO(254, 124, 151, .3),
    300: Color.fromRGBO(254, 124, 151, .4),
    400: Color.fromRGBO(254, 124, 151, .5),
    500: Color.fromRGBO(254, 124, 151, .6),
    600: Color.fromRGBO(254, 124, 151, .7),
    700: Color.fromRGBO(254, 124, 151, .8),
    800: Color.fromRGBO(254, 124, 151, .9),
    900: Color.fromRGBO(254, 124, 151, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
        primaryColor: Color(0xfffe7c96),
        primarySwatch: MaterialColor(0xfffe7c96, color),
      ),
      home: HomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 4)).then((value) async {
      print(value);
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginView(),
            ));
      } else {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) {
          print(value);
          UserList.users.clear();
          UserList.users.add(UserModal.fromSnapshot(value));
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ));
      }
    });
    adminCredential();
    super.initState();
  }

  void adminCredential() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("adminEmail", "admin@courseapp.com");
    prefs.setString("adminPassword", "admia@courseapp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/learn.json',
            ),
            SizedBox(
              height: 36,
            ),
            Text(
              "Find Your Course to stand out",
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: Color(0xff232323),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CircularProgressIndicator(
                color: Color(0xfffe7c96),
              ),
            )
          ],
        ),
      ),
    );
  }
}
