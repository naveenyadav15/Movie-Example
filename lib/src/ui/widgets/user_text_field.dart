import 'package:flutter/material.dart';
import 'package:movie_provider/src/utils/variable.dart';

class UserTextField extends StatelessWidget {
  final titleLabel;
  final maxLength;
  final icon;
  final controller;
  final inputType;
  final prefix;
  bool autofocus;
  Function validator;
  UserTextField({
    @required this.titleLabel,
    @required this.maxLength,
    @required this.icon,
    @required this.controller,
    @required this.inputType,
    this.prefix,
    this.autofocus = false,
    @required this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) => validator(val),
        autofocus: autofocus,
        maxLength: maxLength,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: cHeight * 0.015, // 12
            horizontal: cWidth * 0.041666667,
          ),
          prefix: prefix,
          labelText: titleLabel,
          suffixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
