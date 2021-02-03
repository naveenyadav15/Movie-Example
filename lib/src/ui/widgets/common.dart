import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_provider/src/utils/variable.dart';
import 'package:shimmer/shimmer.dart';

class MPText extends StatelessWidget {
  MPText({
    @required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.maxLines = 1,
    this.decoration,
    this.textAlign = TextAlign.center,
    this.color,
    this.fontStyle = FontStyle.normal,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final int maxLines;
  final TextDecoration decoration;
  final TextAlign textAlign;
  final Color color;
  final FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationThickness: 2,
        fontStyle: fontStyle,
      ),
      textAlign: textAlign,
    );
  }
}

Widget cacheImage(
  String url, {
  Widget errorWidget = const Icon(Icons.error),
  double height,
  double width,
  BoxFit boxFit = BoxFit.fill,
}) {
  print("imgUrl: $url");
  height = cHeight;
  width = cWidth;

  return CachedNetworkImage(
    imageUrl: url,
    // "http://via.placeholder.com/350x150",
    // fit: boxFit,
    progressIndicatorBuilder: (context, url, downloadProgress) => Container(
      height: height,
      width: width,
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            height: 100,
            width: 200,
            color: Colors.white,
          )),
    ),
    // CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) => errorWidget,
    //  Icon(Icons.error),
  );
  // Image.network(url);
}
