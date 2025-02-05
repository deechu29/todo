import 'package:flutter/material.dart';

import 'package:todo/utils/constants/color_constants.dart';



class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.title,
    required this.date,
    required this.des,
    this.onDelete,
    this.onEdit,
    this.isCompleted = false,
    this.onCheckboxChanged,
    required this.time,
    this.isImportant = false,
  });
  final String title, date, des, time;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final bool isCompleted;
  final bool isImportant;

  final void Function(bool?)? onCheckboxChanged;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  List noteKeys = [];

  bool onChecked = false;
  @override
  void initState() {
    super.initState();
    onChecked = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.title),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        widget.onDelete?.call();
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorConstants.GREY),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  checkColor: ColorConstants.MAINBLACK,
                  fillColor: WidgetStatePropertyAll(ColorConstants.MAINWHITE),
                  value: onChecked,
                  onChanged: (value) {
                    setState(() {
                      onChecked = value!;
                    });
                    widget.onCheckboxChanged?.call(value);
                  },
                ),
                widget.isImportant
                    ? Icon(
                        Icons.star,
                        color: ColorConstants.TEXTFIELD_GREY,
                      )
                    : Text(""),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: ColorConstants.MAINWHITE),
                  ),
                ),
                Spacer(),
                TextButton(
                    onPressed: widget.onEdit,
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          color: ColorConstants.MAINWHITE, fontSize: 16),
                    )),
                IconButton(
                  onPressed: widget.onDelete,
                  icon: Icon(
                    Icons.delete,
                    color: ColorConstants.MAINWHITE,
                  ),
                ),
              ],
            ),
            Text(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              widget.des,
              style: TextStyle(color: ColorConstants.MAINWHITE),
            ),
            Divider(
              color: ColorConstants.MAINWHITE,
            ),
            Row(
              children: [
                Text(
                  widget.date,
                  style:
                      TextStyle(color: ColorConstants.MAINWHITE, fontSize: 18),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.time,
                  style:
                      TextStyle(color: ColorConstants.MAINWHITE, fontSize: 18),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    //share text
                    Share.share(
                        '${widget.title} \n ${widget.des} \n ${widget.date} \n ${widget.time}');
                  },
                  icon: Icon(
                    Icons.share,
                    color: ColorConstants.MAINWHITE,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

mixin noteBox {
}

class Share {
  static void share(String s) {}
}

class NOTEBOX {
}
