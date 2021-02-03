import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common.dart';

class MPRButton extends StatelessWidget {
  MPRButton({
    this.title = "MPButton",
    this.height,
    this.width,
    this.onPressed,
    this.colors = const [
      const Color(0xff524f6a),
      const Color(0xff2d2a43),
    ],
    // const [const Color(0xff524f6a), const Color(0xff2d2a43)],
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.textColor = const Color(0xffffc344),
    this.fontStyle = FontStyle.normal,
  });
  final String title;
  final double height;
  final double width;
  final VoidCallback onPressed;
  final List<Color> colors;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1),
              colors: colors,
            ),
          ),
          child: Container(
            constraints: const BoxConstraints(
                minWidth: 88.0,
                minHeight: 36.0), // min sizes for Material buttons
            alignment: Alignment.center,
            child: MPText(
              text: title,
              color: textColor,
              fontStyle: fontStyle,
              fontSize: fontSize,
              fontWeight: fontWeight,
              //  decoration,
            ),
          ),
        ),
      ),
    );
  }
}

class MPRWidgetButton extends StatelessWidget {
  MPRWidgetButton({
    this.title = "MPButton",
    this.height,
    this.width,
    this.onPressed,
    this.colors = const [
      const Color(0xff524f6a),
      const Color(0xff2d2a43),
    ],
    // const [const Color(0xff524f6a), const Color(0xff2d2a43)],
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.textColor = const Color(0xffffc344),
    this.fontStyle = FontStyle.normal,
    @required Widget child,
  });
  final String title;
  final double height;
  final double width;
  final VoidCallback onPressed;
  final List<Color> colors;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final FontStyle fontStyle;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1),
              colors: colors,
            ),
          ),
          child: Container(
            constraints: const BoxConstraints(
                minWidth: 88.0,
                minHeight: 36.0), // min sizes for Material buttons
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MPText(
                  text: title,
                  color: textColor,
                  fontStyle: fontStyle,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  //  decoration,
                ),
                Image.asset(
                  "assets/truecallerLogo.png",
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MPFButton extends StatelessWidget {
  MPFButton({
    this.title = "MPButton",
    this.height,
    this.width,
    this.onPressed,
    this.color = Colors.transparent,
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.textColor = const Color(0xffffc344),
    this.fontStyle = FontStyle.normal,
  });
  final String title;
  final double height;
  final double width;
  final VoidCallback onPressed;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FlatButton(
        onPressed: onPressed,
        color: color,
        child: MPText(
          text: title,
          color: textColor,
          fontStyle: fontStyle,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            // cHeight * 0.03125,
            12,
          ),
        ),
      ),
    );
  }
}

class MPCircularButton extends StatelessWidget {
  MPCircularButton({
    this.title = "MPButton",
    this.height,
    this.width,
    this.onPressed,
    this.colors = const [
      const Color(0xff524f6a),
      const Color(0xff2d2a43),
    ],
    // const [const Color(0xff524f6a), const Color(0xff2d2a43)],
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.textColor = const Color(0xffffc344),
    this.fontStyle = FontStyle.normal,
    @required this.iconData,
    this.iconSize,
  });
  final String title;
  final double height;
  final double width;
  final VoidCallback onPressed;
  final List<Color> colors;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final FontStyle fontStyle;
  final IconData iconData;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.white,
        shape: CircleBorder(),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1),
              colors: colors,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.5, left: 2),
              child: Icon(
                iconData,
                size: 24,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
