import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String label;

  RoundButton({Key key, this.label, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 140,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 12),
        elevation: 0,
        color: Theme.of(context).primaryColor,
        disabledColor: Colors.blue.shade200,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: _onPressed,
        child: Text(label),
      ),
    );
  }
}
