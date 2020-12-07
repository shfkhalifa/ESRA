///
/// By Younss Ait Mou
///

import 'package:flutter/material.dart';
import 'package:esra/pages/pages.dart';

import 'package:esra/models/prediction.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting args that are passed with Navigator.pushNamed
    // example Navigator.pushNamed('/route', arguments: "hello")
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/children':
        return MaterialPageRoute(builder: (_) => ChildrenPage());
      case '/evaluate':
        return MaterialPageRoute(builder: (_) => EvaluatePage());
      case '/FAQ':
        return MaterialPageRoute(builder: (_) => FAQPage());
      case '/FAQDetails':
        final faq = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => FAQDetails(
            faq: faq,
          ),
        );
      case '/authenticate':
        return MaterialPageRoute(builder: (_) => AuthenticationPage());
      case '/verifyPhoneNumber':
        Map<String, String> credentials = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => VerifyPhoneNumber(
                  email: credentials['email'],
                  phoneNumber: credentials['phone'],
                ));
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/addChild':
        return MaterialPageRoute(builder: (_) => AddChildPage());
      case '/resultReview':
        final prediction = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => ResultReviewPage(prediction: prediction));
      case '/childDetails':
        final child = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ChildDetails(
            child: child,
          ),
        );

      default:
    }
  }
}
