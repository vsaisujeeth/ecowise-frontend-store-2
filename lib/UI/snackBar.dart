import 'package:flutter/material.dart';


snackBar(BuildContext context, String text, Color color, {int sec = 2}) {
  var snackBar = SnackBar(
    content: Text(text),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: sec),
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}