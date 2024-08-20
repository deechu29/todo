import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/utils/constants/color_constants.dart';
import 'package:todo/view/login_screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.MAINBLACK,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                //  Scaffold.of(context).openDrawer();
                Drawer(
                  child: Container(
                    color: ColorConstants.MAINBLACK,
                    child: ListView(
                      children: [
                        DrawerHeader(
                          child: Column(
                            children: [
                              Text(
                                "H E L L O",
                                style: TextStyle(
                                    color: ColorConstants.MAINWHITE,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.home, color: ColorConstants.MAINWHITE),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: Text(
                            "Home",
                            style: TextStyle(
                                color: ColorConstants.MAINWHITE, fontSize: 20),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.share,
                            color: ColorConstants.MAINWHITE,
                          ),
                          title: Text(
                            "Tell Friends",
                            style: TextStyle(
                                color: ColorConstants.MAINWHITE, fontSize: 20),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.settings,
                            color: ColorConstants.MAINWHITE,
                          ),
                          title: Text(
                            "Settings",
                            style: TextStyle(
                                color: ColorConstants.MAINWHITE, fontSize: 20),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.power_settings_new_rounded,
                            color: ColorConstants.MAINWHITE,
                          ),
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.clear(); // Clears all keys
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          title: Text(
                            "LogOut",
                            style: TextStyle(
                                color: ColorConstants.MAINWHITE, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.filter_list,
                color: ColorConstants.MAINWHITE,
              )),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                Drawer(
                  child: Container(
                    child: ListView(
                      children: [
                        DrawerHeader(
                            child: Column(
                          children: [
                            Text('Drawer Header'),
                          ],
                        ))
                      ],
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                  backgroundImage: AssetImage(
                      "asset/image/pexels-moh-adbelghaffar-771742 (1).jpg")),
            ),
          ],
          backgroundColor: ColorConstants.MAINBLACK,
          title: Text(
            "Index",
            style: TextStyle(color: ColorConstants.MAINWHITE),
          ),
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: Text(
                  "Logout",
                  strutStyle: StrutStyle(),
                )),
          ],
        ));
  }
}
