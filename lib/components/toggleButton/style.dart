import 'package:division/division.dart';
import 'package:flutter/material.dart';

class ToggleButtonStyles {
  static ParentStyle rootStyle = ParentStyle()
    ..margin(vertical: 35, horizontal: 0)
    ..background.rgba(0, 0, 0, 0.45)
    ..borderRadius(all: 23)
    ..padding(all: 3);

  static ParentStyle Function(int) selectorStyle = (int selectedItem) => ParentStyle()
    ..background.color(Colors.white)
    ..height(40)
    ..width(120)
    ..animate(100)
    ..alignment.centerRight(selectedItem == 1)
    ..alignment.centerLeft(selectedItem == 0)
    ..borderRadius(all: 20);

  static TxtStyle itemStyle = TxtStyle()
    ..bold()
    ..borderRadius(all: 20)
    ..height(40)
    ..width(120)
    ..alignmentContent.center();

  static TxtStyle activeItemStyle = itemStyle.clone()..textColor(Colors.black);
  static TxtStyle inactiveItemStyle = itemStyle.clone()..textColor(Colors.white);
}
