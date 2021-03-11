import 'package:division/division.dart';
import 'package:esra/models/faq.dart';
import 'package:esra/styles.dart';
import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:esra/localization/language_constants.dart';

class FAQDetails extends StatelessWidget {
  final Faq faq;
  const FAQDetails({Key key, this.faq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.darkBlue,
        title: Text(getTranslated(context, "FAQ_TITLE")),
      ),
      body: Parent(
        // style: ParentStyle()..width(MediaQuery.of(context).size.width),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
              child: Image(
                image: AssetImage(AppIcons.info),
              ),
            ),
            SingleChildScrollView(
              child: Parent(
                style: ParentStyle()
                  ..width(MediaQuery.of(context).size.width * 0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Faq title
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                        faq.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    // Faq Content
                    Text(
                      faq.content,
                      style: TextStyle(height: 1.5),
                    ),

                    SizedBox(height: 36),
                    // Illustration
                    Image(
                      image: AssetImage(AppIllustrations.faq_2),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
