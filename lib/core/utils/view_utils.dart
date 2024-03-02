import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:flutter/material.dart';

InputDecoration primaryTextFormFieldDecoration({
  String labelText = '',
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: textInputBorderColor, width: 0.5),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.5),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    labelText: labelText,
    labelStyle: TextStyle(color: textInputBorderColor),
    filled: true,
    fillColor: backgroundColor,
  );
}

InputDecoration searchTextFieldDecoration({
  String labelText = '',
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: textInputBorderColor, width: 0.5),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.5),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),

    labelText: labelText,
    labelStyle: TextStyle(color: textInputBorderColor),
    filled: true,
    fillColor: backgroundColor,
    prefixIcon: Image.asset("assets/images/search.png", width: 24, height: 24)
  );
}

