import 'package:flutter/material.dart';

import 'package:todo/utils/app_session.dart';
import 'package:todo/view/add_screen/add_screen.dart';

import 'package:todo/view/splash_screen/splash_screen.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox(AppSessions.NOTEBOX);
  runApp(MyApp());
}

class Hive {
  static openBox(String notebox) {}

  static initFlutter() {}

  static box(String notebox) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: );
  }
}
