import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

Widget customRadioButton2(List<String> labels, List<dynamic> values,
    {Function storeValue}) {
  return CustomRadioButton(
    unSelectedColor: Colors.white,
    buttonLables: labels,
    buttonValues: values,
    radioButtonValue: (value) => storeValue(value),
    selectedColor: Colors.blue,
    //absoluteZeroSpacing: true,
    width: 80,
  );
}
