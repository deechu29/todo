import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo/utils/constants/color_constants.dart';
import 'package:todo/view/add_screen/add_screen.dart';

import 'package:todo/view/home_screen/home_screen.dart';
// import 'package:todo/view/bottomnav_screen/bottomnav_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // GlobalKey<FormState> passwordkey = GlobalKey<FormState>();
  late final SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    login();
  }

  login() async {
    prefs = await SharedPreferences.getInstance();
    bool? islogin = await prefs.getBool('login') ?? false;
    if (islogin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => itemaddscreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.MAINBLACK,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text("Login",
                    style: TextStyle(
                        fontSize: 32,
                        color: ColorConstants.MAINWHITE,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 50,
                ),
                Text("Username",
                    style: TextStyle(
                      color: ColorConstants.MAINWHITE,
                    )),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    } else if (value.contains("@")) {
                      return null;
                    } else {
                      return 'Please enter a valid username';
                    }
                  },
                  //  key: usernamekey,
                  controller: usernamecontroller,
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ColorConstants.RED)),
                      hintText: "Enter your Username",
                      hintStyle: TextStyle(color: ColorConstants.GREY),
                      focusColor: ColorConstants.MAINWHITE,
                      fillColor: ColorConstants.TEXTFIELD_GREY,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("password",
                    style: TextStyle(
                      color: ColorConstants.MAINWHITE,
                    )),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // key: passwordkey,
                  validator: (value) {
                    if (value != null && value.length >= 8) {
                      return null;
                    } else {
                      return "password must be at least 8 characters ";
                    }
                  },
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ColorConstants.RED)),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: ColorConstants.GREY),
                      focusColor: ColorConstants.MAINWHITE,
                      fillColor: ColorConstants.TEXTFIELD_GREY,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),

                SizedBox(
                  height: 69,
                ),
                InkWell(
                  onTap: () async {
                    await prefs.setString('user', usernamecontroller.text);
                    await prefs.setString('pass', passwordcontroller.text);
                    await prefs.setBool('login', true);
                    if (formkey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    } else {
                      print("not validated");
                    }

                    // if (usernamekey.currentState!.validate()) {
                    //   {}
                    // }
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.BUTTON),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: ColorConstants.MAINWHITE),
                      ),
                    ),
                  ),
                ),

                // child: TextButton(
                //     style: ButtonStyle(
                //         padding: WidgetStatePropertyAll(
                //             EdgeInsets.symmetric(horizontal: 30)),
                //         backgroundColor:
                //             WidgetStatePropertyAll(ColorConstants.BUTTON)),
                //     onPressed: () {},
                //     child: Text(
                //       "Login",
                //       style: TextStyle(color: ColorConstants.MAINWHITE),
                //     )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
