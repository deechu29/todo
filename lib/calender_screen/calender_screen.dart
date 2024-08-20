// import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/constants/color_constants.dart';
// import 'package:todo/utils/constants/color_constants.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    //   var onDateChanged;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.MAINBLACK,
        body: Column(
          children: [
            SizedBox(
              height: 100,
              child: DatePicker(
                DateTime.now(),
                dateTextStyle: TextStyle(
                  color: ColorConstants.MAINWHITE,
                ),
                dayTextStyle: TextStyle(color: ColorConstants.RED),
                monthTextStyle: TextStyle(color: ColorConstants.MAINWHITE),
                selectionColor: Colors.blue,
                selectedTextColor: ColorConstants.MAINWHITE,
                initialSelectedDate: DateTime.now(),
                onDateChange: (selectedDate) {},
              ),
            )

            // CalendarDatePicker(
            //     onDisplayedMonthChanged: (value) {
            //       setState(() {});
            //     },
            //     currentDate: onDateChanged,
            //     initialCalendarMode: DatePickerMode.year,
            //     initialDate: DateTime(2024),
            //     firstDate: DateTime(2002),
            //     lastDate: DateTime(2050),
            //     onDateChanged: onDateChanged)
          ],
        ),
      ),
    );
  }
}
