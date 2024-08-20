import 'dart:io';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/app_session.dart';

import 'package:todo/utils/constants/color_constants.dart';

import 'package:todo/view/home_screen/widget/taskcard.dart';
import 'package:todo/view/login_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => itemaddscreen();
}

class itemaddscreen extends State<HomeScreen> {
  List<String> dates = [
    "On Going",
    "Completed",
  ];
  String? dropValue;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  DatePickerController datepick = DatePickerController();
  var noteBox = Hive.box(AppSessions.NOTEBOX);
  List noteKeys = [];
  File? selectedImageFile;
  int checkCount = 0;
  bool onChecked = false;
  bool important = false;

  @override
  void initState() {
    noteKeys = noteBox.keys.toList();
    _updateCheckCount();
    setState(() {});
    super.initState();
  }

  void _updateCheckCount() {
    setState(() {
      checkCount = noteBox.values
          .where((task) => task['status'] == 'Completed')
          .toList()
          .length;
    });
  }

  @override
  Widget build(BuildContext context) {
    var profile;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(
          height: 50,
          width: 380,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: FloatingActionButton(
            backgroundColor: ColorConstants.TEXTFIELD_GREY,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add new task",
                  style:
                      TextStyle(color: ColorConstants.MAINWHITE, fontSize: 18),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.add,
                  color: ColorConstants.MAINWHITE,
                )
              ],
            ),
            onPressed: () {
              title.clear();
              date.clear();
              description.clear();
              time.clear();
              important = false;
              _customBottomSheet(context);
            },
          ),
        ),
        backgroundColor: ColorConstants.GREY,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (context) {
              return IconButton(
                  onPressed: () {
                    2;
                  },
                  icon: Icon(
                    Icons.grid_view,
                    color: ColorConstants.MAINWHITE,
                  ));
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.task_alt_outlined,
                color: ColorConstants.MAINWHITE,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "To-do",
                style: TextStyle(color: ColorConstants.MAINWHITE, fontSize: 25),
              )
            ],
          ),
          actions: [
            Icon(
              Icons.search,
              color: ColorConstants.MAINWHITE,
            )
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: ColorConstants.TEXTFIELD_GREY,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Text(
                        "H E L L O",
                        style: TextStyle(
                            color: ColorConstants.MAINWHITE, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: ColorConstants.MAINWHITE,
                  ),
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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Divider(
                color: ColorConstants.MAINWHITE,
              ),
              SizedBox(
                  height: 100,
                  child: DatePicker(
                      onDateChange: (selectedDate) {},
                      monthTextStyle:
                          TextStyle(color: ColorConstants.MAINWHITE),
                      dateTextStyle: TextStyle(color: ColorConstants.MAINWHITE),
                      dayTextStyle: TextStyle(color: ColorConstants.MAINWHITE),
                      selectionColor: ColorConstants.MAINBLACK,
                      initialSelectedDate: DateTime.now(),
                      selectedTextColor: ColorConstants.MAINWHITE,
                      DateTime.now())),
              Divider(
                color: ColorConstants.MAINBLACK,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "Your Tasks",
                    style: TextStyle(
                        color: ColorConstants.MAINWHITE, fontSize: 18),
                  ),
                  SizedBox(
                    width: 19,
                  ),
                  Spacer(),
                  Container(
                    color: ColorConstants.GREY,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      var currentNote = noteBox.get(noteKeys[index]);
                      return Dismissible(
                          resizeDuration: Duration(seconds: 2),
                          key: Key(noteKeys[index].toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            noteBox.delete(noteKeys[index]);
                            noteKeys = noteBox.keys.toList();
                            _updateCheckCount();
                            setState(() {});
                          },
                          background: Container(
                            color: ColorConstants.MAINWHITE,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.delete,
                                  color: ColorConstants.RED,
                                ),
                              ),
                            ),
                          ),
                          secondaryBackground: Container(
                            color: ColorConstants.MAINWHITE,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                // child: Icon(
                                //   Icons.delete,
                                //   color: ColorConstants.red,
                                // ),
                              ),
                            ),
                          ),
                          child: TaskCard(
                            isCompleted: currentNote['status'] == 'Completed',
                            onEdit: () {
                              title.text = currentNote['title'];
                              description.text = currentNote['desc'];
                              date.text = currentNote['date'];
                              time.text = currentNote['time'] ?? "";
                              important = currentNote['imp'];

                              _customBottomSheet(context,
                                  isEdit: true, itemIndex: index);
                            },
                            onDelete: () {
                              noteBox.delete(noteKeys[index]);
                              noteKeys = noteBox.keys.toList();
                              _updateCheckCount();
                              setState(() {});
                            },
                            onCheckboxChanged: (p0) {
                              setState(() {
                                if (p0!) {
                                  checkCount++;
                                } else {
                                  checkCount--;
                                }
                              });

                              var updatedNote = currentNote;
                              updatedNote['status'] =
                                  p0! ? 'Completed' : 'On Going';
                              noteBox.put(noteKeys[index], updatedNote);
                            },
                            title: currentNote['title'],
                            date: currentNote['date'],
                            des: currentNote['desc'],
                            time: currentNote['time'] ?? "",
                            isImportant: currentNote['imp'],
                          ));
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: noteKeys.length),
              )
            ],
          ),
        ),
      ),
    );
  }

  _customBottomSheet(BuildContext context,
          {bool isEdit = false, int? itemIndex}) =>
      showModalBottomSheet(
        backgroundColor: ColorConstants.BUTTON,
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "New Task",
                    style: TextStyle(
                        color: ColorConstants.MAINWHITE,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: ColorConstants.MAINWHITE,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task Title",
                        style: TextStyle(
                            color: ColorConstants.MAINWHITE,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(
                          hintText: "Add a title..",
                          hintStyle:
                              TextStyle(color: ColorConstants.TEXTFIELD_GREY),
                          fillColor: ColorConstants.MAINWHITE,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            color: ColorConstants.MAINWHITE,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: description,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Add a description..",
                          hintStyle:
                              TextStyle(color: ColorConstants.TEXTFIELD_GREY),
                          fillColor: ColorConstants.MAINWHITE,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Important",
                            style: TextStyle(
                                color: ColorConstants.MAINWHITE,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          StatefulBuilder(
                            builder: (context, setState) => Checkbox(
                              checkColor: ColorConstants.MAINBLACK,
                              fillColor: WidgetStatePropertyAll(
                                  ColorConstants.MAINWHITE),
                              value: important,
                              onChanged: (value) {
                                setState(() {
                                  important = value!;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Date",
                        style: TextStyle(
                            color: ColorConstants.MAINWHITE,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: date,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "dd/mm/yy",
                          hintStyle: TextStyle(color: ColorConstants.GREY),
                          fillColor: ColorConstants.MAINWHITE,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: InkWell(
                            onTap: () async {
                              var selectedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now());
                              if (selectedDate != null) {
                                date.text = DateFormat("dd,MMMM,y")
                                    .format(selectedDate);
                              }
                            },
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color: ColorConstants.TEXTFIELD_GREY,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Time",
                        style: TextStyle(
                            color: ColorConstants.MAINWHITE,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: time,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "hh:mm",
                          hintStyle:
                              TextStyle(color: ColorConstants.TEXTFIELD_GREY),
                          fillColor: ColorConstants.MAINWHITE,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: InkWell(
                            onTap: () async {
                              var selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (selectedTime != null) {
                                time.text = selectedTime.format(context);
                              }
                            },
                            child: Icon(
                              Icons.timer,
                              color: ColorConstants.GREY,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 15),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: ColorConstants.MAINWHITE),
                          ),
                          decoration: BoxDecoration(
                              color: ColorConstants.GREY,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          isEdit
                              ? noteBox.put(noteKeys[itemIndex!], {
                                  "title": title.text,
                                  "date": date.text,
                                  "desc": description.text,
                                  "time": time.text,
                                  "imp": important,
                                })
                              : noteBox.add({
                                  // to add new note to hive storage
                                  "title": title.text,
                                  "date": date.text,
                                  "desc": description.text,
                                  "time": time.text,
                                  "imp": important,
                                });
                          noteKeys = noteBox.keys.toList();
                          // to update the keylist after adding a note
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: Text(
                            isEdit ? "Update" : "Create",
                            style: TextStyle(
                                color: ColorConstants.MAINWHITE,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          decoration: BoxDecoration(
                              color: ColorConstants.BOTTOM_GREY,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
