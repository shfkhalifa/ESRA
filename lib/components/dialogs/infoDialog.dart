import 'package:esra/localization/language_constants.dart';
import 'package:flutter/material.dart';

Future<void> infoDialog(BuildContext context, String title, String body) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: <Widget>[
            Icon(
              Icons.check,
              color: Colors.green,
            ),
            SizedBox(width: 14),
            Text(
              title,
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(body),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
