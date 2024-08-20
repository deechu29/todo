import 'package:flutter/material.dart';
import 'package:todo/utils/constants/color_constants.dart';
import 'package:todo/utils/constants/image_constants.dart';
import 'package:todo/view/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
  
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then(
      (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.MAINBLACK,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageConstants.LOGO_PNG),
            SizedBox(height: 10),
            Text(
              "TODO",
              style: TextStyle(
                  fontSize: 40,
                  color: ColorConstants.MAINWHITE,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
