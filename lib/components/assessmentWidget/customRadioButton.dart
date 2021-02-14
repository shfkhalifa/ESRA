import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

Widget customRadioButton2(
    List<String> labels, List<dynamic> values, dynamic selectedValue,
    {Function storeValue}) {
  return CustomRadioButton(
    unSelectedColor: Colors.white,
    unSelectedBorderColor: Colors.black12,
    buttonLables: labels,
    buttonValues: values,
    radioButtonValue: (value) => storeValue(value),
    selectedColor: Colors.blue,
    horizontal: true,
    absoluteZeroSpacing: true,
    spacing: 0.2,
    defaultSelected: selectedValue ?? null,
  );
}

Widget customRadioButton(List<String> labels, List<dynamic> values,
    {Function storeValue}) {
  return CustomRadioButton(
    unSelectedColor: Colors.white,
    buttonLables: labels,
    buttonValues: values,
    radioButtonValue: (value) => storeValue(value),
    selectedColor: Colors.blue[700],
    unSelectedBorderColor: Colors.grey,
    selectedBorderColor: Colors.white,
    enableShape: true,
    //absoluteZeroSpacing: true,
    //width: 80,
  );
}
