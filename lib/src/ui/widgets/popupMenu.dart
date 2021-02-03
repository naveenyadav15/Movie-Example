import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common.dart';

class PopupMenuCheck extends StatefulWidget {
  final Function updateYearFunc;
  PopupMenuCheck({
    @required this.updateYearFunc,
    Key key,
  }) : super(key: key);
  @override
  _PopupMenuCheckState createState() => _PopupMenuCheckState();
}

class _PopupMenuCheckState extends State<PopupMenuCheck> {
  List<String> years = [];
  void _select(CustomPopupMenu choice) {
    setState(() {
      choice.onPressed();
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 2020; i > 1970; i--) {
      years.add(i.toString());
    }
    print("years are: $years");
    choices = years
        .map((e) => CustomPopupMenu(
            color: Colors.black,
            title: e,
            onPressed: () => widget.updateYearFunc(e)))
        .toList();
  }

  List<CustomPopupMenu> choices = [];
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CustomPopupMenu>(
      elevation: 3.2,
      onCanceled: () {
        print('Sort by year cancelled');
      },
      tooltip: 'Sort',
      icon: Icon(
        CupertinoIcons.ellipsis_vertical,
        color: Colors.white,
      ),
      onSelected: _select,
      itemBuilder: (BuildContext context) {
        return choices.map((choice) {
          return PopupMenuItem(
            value: choice,
            child: MPText(
              text: choice.title,
              color: choice.color,
            ),
          );
        }).toList();
      },
    );
  }
}

class CustomPopupMenu {
  CustomPopupMenu({
    this.title,
    this.onPressed,
    this.color = Colors.black,
  });
  String title;
  Function onPressed;
  Color color;
}
