import 'package:flutter/material.dart';

Container shimmerItem(
    double height, double width, double radius, BuildContext context) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius)),
  );
}
