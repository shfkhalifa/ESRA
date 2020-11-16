import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EsraErrorWidget extends StatelessWidget {
  final String errorMsg;
  const EsraErrorWidget({Key key, @required this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Parent(
        style: ParentStyle()
          ..margin(all: 64)
          ..padding(all: 24)
          ..alignment.center(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.exclamationTriangle,
              size: 52,
              color: Colors.red.shade300,
            ),
            SizedBox(
              height: 24,
            ),
            Txt(
              errorMsg,
              style: TxtStyle()
                ..textColor(Colors.red.shade300)
                ..textAlign.center(),
            ),
          ],
        ),
      ),
    );
  }
}
