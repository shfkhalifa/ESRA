import 'dart:io';

import 'package:division/division.dart';
//import 'package:esra/utils/constants.dart';
import 'package:path/path.dart' as path;
import 'package:esra/utils/emoCategories.dart';
import 'package:flutter/material.dart';
import 'package:esra/localization/language_constants.dart';

class PredictionResultWidget extends StatelessWidget {
  final String label;
  final double score;
  final File image;
  final Function(bool) onDismiss;
  PredictionResultWidget(
      {Key key, this.label, this.score, this.image, this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(
    //     '\n\n got the following label and score inside PredictionResultWidget $label, $score');
    EmoCategories emo = EmoCategories();

    String hmBasefile = path.basename(image.path);
    hmBasefile = 'hm_' + hmBasefile;
    String imageDir = path.dirname(image.path);

    String hmPath = '$imageDir/$hmBasefile';
    return Container(
      child: Parent(
        style: ParentStyle()..margin(all: 14),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (image != null)
              //   Parent(
              //     style: ParentStyle()
              //       ..background.image(path: image.path, fit: BoxFit.cover)
              //       ..height(200),
              //     child: Container(),
              //   ),

              if (image == null)
                CircleAvatar(
                  radius: 100.0,
                  backgroundColor: Color(0xffffffff),
                )
              else
                Parent(
                  // style: ParentStyle()
                  //   ..background.image(path: hmPath, fit: BoxFit.contain)
                  //   ..height(350),
                  child: Container(
                    height: 350.0,
                    // width: 120.0,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new FileImage(File(hmPath)),
                        fit: BoxFit.cover,
                      ),
                      // borderRadius:
                      //     new BorderRadius.all(const Radius.circular(90.0)),
                    ),
                  ),
                ),

              Parent(
                style: ParentStyle()..margin(vertical: 14),
                child: ListTile(
                  leading: emo.getEmoIcon(label, score * 100),
                  title: Txt(
                    emo.getEmoLabel(label, score * 100, context),
                    style: TxtStyle()
                      ..textColor(
                          label == "negative" ? Colors.red : Colors.green),
                  ),
                  subtitle: Text(emo.getLabelDetailText(label, score, context)),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    textColor: Colors.red,
                    child: Text(getTranslated(context, "DISMISS_BTN")),
                    onPressed: () {
                      // Dismiss the current prediction, shouldSave = false
                      onDismiss(false);
                    },
                  ),
                  FlatButton(
                    child: Text(getTranslated(context, "SAVE_BTN")),
                    onPressed: () {
                      onDismiss(true);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
