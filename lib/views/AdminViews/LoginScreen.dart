import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms/views/LoginView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/account.dart';
import '../SignUpView.dart';
import 'AdminHome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String adminEmail = "";
  late String adminPassword = "";
  @override
  void initState() {
    // TODO: implement initState
    getAdminCredentials();
    super.initState();
  }

  void getAdminCredentials() async {
    var _prefs = await SharedPreferences.getInstance();

    setState(() {
      adminEmail = _prefs.getString("adminEmail")!;
      adminPassword = _prefs.getString("adminPassword")!;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/intro.svg",
                      height: 250,
                      width: 250,
                    ),
                    const Text(
                      "Admin Login",
                      style: TextStyle(fontSize: 24, color: Color(0xff2e2e42)),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field cannot be Empty";
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, right: 8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field cannot be Empty";
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () async {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ));
                        },
                        child: Text(
                          "Client Login",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (_emailController.text == adminEmail) {
                      if (_passwordController.text == adminPassword) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminHome(),
                            ));
                      } else {
                        print(adminPassword);
                        print(_passwordController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Wrong Password")));
                      }
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Wrong Email")));
                    }
                  },
                  child: Container(
                    height: 65,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                )),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have any account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpView(),
                            ));
                      },
                      child: Text("Sign Up"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
