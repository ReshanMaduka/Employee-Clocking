import 'package:flutter/material.dart';

class Lesson {
  final String date;
  final String title;
  final String level;
  final double indicatorValue;
  final int price;
  final String content;

  Lesson(
      {@required this.title,
      @required this.level,
      @required this.indicatorValue,
      @required this.price,
      @required this.content,
      @required this.date});
}
