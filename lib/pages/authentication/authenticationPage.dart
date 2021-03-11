import 'package:esra/components/registerWidget/registerWidget.dart';
import 'package:esra/components/toggleButton/toggleButton.dart';
import 'package:esra/pages/authentication/style.dart';
import 'package:flutter/material.dart';
import 'package:division/division.dart';

import 'package:esra/components/loginWidget/loginWidget.dart';
//import 'package:esra/utils/constants.dart';
import 'package:esra/localization/language_constants.dart';

import '../../styles.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage(AppLogos.logo_icon_text),
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ToggleButton(
                items: [
                  getTranslated(context, "LOGIN_BTN_TEXT"),
                  getTranslated(context, "REGISTER_BTN_TEXT")
                ],
                onItemSelected: (selectedIndex) {
                  setState(() {
                    _selectedTab = selectedIndex;
                  });
                },
              ),
            ),
            Parent(
              style: authenticationCardsStyle,
              child: _selectedTab == 0 ? LoginWidget() : RegisterWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
