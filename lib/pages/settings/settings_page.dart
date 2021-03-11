import 'package:flutter/material.dart';
import 'package:esra/localization/language_constants.dart';
import 'package:esra/main.dart';

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇸🇦", "اَلْعَرَبِيَّةُ‎", "ar"),
    ];
  }
}

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    ESRAApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'SETTINGS')),
      ),
      body: Container(
        child: Center(
            child: DropdownButton<Language>(
          iconSize: 30,
          hint: Text(getTranslated(context, 'CHANGE_LANGUAGE')),
          onChanged: (Language language) {
            _changeLanguage(language);
          },
          items: Language.languageList()
              .map<DropdownMenuItem<Language>>(
                (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[Text(e.name)],
                  ),
                ),
              )
              .toList(),
        )),
      ),
    );
  }
}
