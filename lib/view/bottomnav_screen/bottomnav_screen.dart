// import 'package:flutter/material.dart';
// import 'package:todo/calender_screen/calender_screen.dart';
// import 'package:todo/utils/constants/color_constants.dart';
// import 'package:todo/view/add_screen/add_screen.dart';
// import 'package:todo/view/home_screen/home_screen.dart';


// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   int selectedindex = 0;
//   List<Widget> myScreen = [HomeScreen(), CalenderScreen(), AddScreen()];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: myScreen[selectedindex],
//       backgroundColor: ColorConstants.MAINBLACK,
//       bottomNavigationBar: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BottomNavigationBar(
//             backgroundColor: ColorConstants.BOTTOM_GREY,
//             selectedItemColor: Colors.white,
//             unselectedItemColor: Colors.white.withOpacity(0.7),
//             type: BottomNavigationBarType.fixed,
//             onTap: (value) {
//               selectedindex = value;
//               setState(() {});
//             },
//             currentIndex: selectedindex,
//             items: [
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//               BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.calendar_month_rounded,
//                   ),
//                   label: "Calendar"),
//               BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
//             ]),
//       ),
//     );
//   }
// }
