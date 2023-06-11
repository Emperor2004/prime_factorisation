import 'package:flutter/material.dart';

// Class to show error in a fancy way when the input is wrong
Widget errorTextWidget(String errorText) {
  if (errorText != "") {
    return Text(
      errorText,
      style: const TextStyle(
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15, fontStyle: FontStyle.italic),
    );
  }
  return Container();
}
