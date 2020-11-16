import 'package:division/division.dart';
import 'package:flutter/material.dart';

class AppStyles {
  ///
  /// Application Colors
  ///
  static Color darkBlue = Color(0XFF1E1656);
  static Color blue = Color(0XFF006CE1);
  static Color lightBlue = Color(0XFF0088CE);
  static Color dimedBlue = Color(0XFF5BC6EB);
  static Color green = Color(0XFF0BCC64);
  static Color red = Color(0XFFDC2323);
  static Color gray = Color(0XFF808080);
  static Color lightGray = Color(0xFFD1D1D1);

  ///
  /// Common Components
  ///
  // static TxtStyle buttonStyle = TxtStyle()
  //   ..textColor(Colors.white)
  //   ..background.color(Colors.blue)
  //   ..padding(vertical: 12, horizontal: 16)
  //   ..borderRadius(all: 24)
  //   ..textAlign.center()
  //   ..ripple(true);
  static TxtStyle badgeStyle = TxtStyle()
    ..background.color(Colors.blue)
    ..fontSize(12)
    ..textColor(Colors.white)
    ..padding(vertical: 4, horizontal: 12)
    ..borderRadius(all: 14);

  static ParentStyle dropDownStyle = ParentStyle()
    ..alignment.center()
    ..margin(horizontal: 64, vertical: 24)
    ..padding(horizontal: 24, vertical: 8)
    ..borderRadius(all: 5)
    ..background.color(Colors.black12);
}

class AppIcons {
  static String analyze = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Analyse.png";
  static String calendar = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Calendar.png";
  static String child = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Child.png";
  static String comment = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Comment.png";
  static String email = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Email.png";
  static String faq = "assets/images/icons/icons_16x16/ESRA_APP_Icons_FAQ.png";
  static String gender = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Gender.png";
  static String info = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Info.png";
  static String logOut = "assets/images/icons/icons_16x16/ESRA_APP_Icons_LogOut.png";
  static String name = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Name.png";
  static String password = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Password.png";
  static String relevant = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Relevant.png";
  static String year = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Year.png";
  // 16x16
  static String boy_16 = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Boy.png";
  static String camera_16 = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Camera.png";
  static String girl_16 = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Girl.png";
  static String happy_16 = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Happy.png";
  static String image_16 = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Image.png";
  static String joy_16 = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Joy.png";
  static String sad_16 = "assets/images/icons/icons_16x16/ESRA_APP_Icons_Sad.png";
  // 128x128
  static String boy_128 = "assets/images/icons/icons_128x128/ESRA_APP_Icons_Boy.png";
  static String camera_128 = "assets/images/icons/icons_128x128/ESRA_APP_Icons_Camera.png";
  static String girl_128 = "assets/images/icons/icons_128x128/ESRA_APP_Icons_Girl.png";
  static String happy_128 = "assets/images/icons/icons_128x128/ESRA_APP_Icons_Happy.png";
  static String image_128 = "assets/images/icons/icons_128x128/ESRA_APP_Icons_Image.png";
  static String joy_128 = "assets/images/icons/icons_128x128/ESRA_APP_Icons_Joy.png";
  static String sad_128 = "assets/images/icons/icons_128x128/ESRA_APP_Icons_Sad.png";
}

class AppIllustrations {
  static String drawer = "assets/images/illustrations/illustration_03.png";
  static String addChild = "assets/images/illustrations/illustration_04.png";
  static String saveChild = "assets/images/illustrations/illustration_06.png";
  static String addDrawing = "assets/images/illustrations/illustration_02.png";
  static String faq_1 = "assets/images/illustrations/illustration_01.png";
  static String faq_2 = "assets/images/illustrations/illustration_05.png";
}

class AppLogos {
  static const String logo_icon = "assets/images/logo/ESRA_logo_icon.png";
  static const String logo_icon_text = "assets/images/logo/ESRA_logo_full.png";
  static const String logo_acronym = "assets/images/logo/ESRA_logo_acronym.png";
}
