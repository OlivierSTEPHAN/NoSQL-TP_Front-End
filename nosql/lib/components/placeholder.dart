import 'package:flutter/material.dart';

Container placeHolder(double height, double width) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey,
    ),
    margin: EdgeInsets.all(5),
  );
}
