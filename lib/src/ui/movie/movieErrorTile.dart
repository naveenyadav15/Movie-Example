import 'package:flutter/material.dart';


class MovieErrorTile extends StatelessWidget {
  const MovieErrorTile(this.backgroundColor, this.errorMessage);
  final Color backgroundColor;
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("Error: "+errorMessage),
          ),
        ),
      ),
    );
  }
}
