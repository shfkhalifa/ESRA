import 'package:division/division.dart';
import 'package:flutter/material.dart';

class ChildDetailsStyle {
  static ParentStyle headerStyle = ParentStyle()
    ..alignmentContent.center()
    ..padding(vertical: 24, horizontal: 12);
  static TxtStyle emotionStateInfo = TxtStyle()
    ..textColor(Colors.white)
    ..borderRadius(all: 24)
    ..background.color(Colors.green)
    ..alignment.bottomCenter()
    ..margin(bottom: 24)
    ..padding(vertical: 14, horizontal: 24);
}
