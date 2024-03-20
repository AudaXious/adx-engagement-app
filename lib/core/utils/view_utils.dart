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
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondaryColor, width: 0.5),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: textInputBorderColor, width: 0.5),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
    ),
    labelText: labelText,
    labelStyle: TextStyle(color: textInputBorderColor),
    filled: true,
    fillColor: backgroundColor,
  );
}

InputDecoration primaryTextFieldWithPrefixIconDecoration({
  String labelText = '',
  String prefixIcon = '',
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: textInputBorderColor, width: 0.3),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: textInputBorderColor, width: 0.5),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: textInputBorderColor, width: 0.3),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    ),

    labelText: labelText,
    labelStyle: TextStyle(color: textInputBorderColor),
    filled: true,
    fillColor: backgroundColor,
    prefixIcon: Image.asset(prefixIcon, width: 20, height: 20)
  );
}

