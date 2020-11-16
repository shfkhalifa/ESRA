///
/// Written by Younss Ait Mou (younss.aitmou@gmail.com)
/// On April 13, 2020
///
/// Home Page
///
import 'package:esra/components/button.dart';
import 'package:esra/components/drawer/drawer.dart';
import 'package:esra/models/child.dart';
import 'package:esra/models/prediction.dart';
import 'package:esra/styles.dart';
import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/manageChildrenBloc/mangeChildren.dart';

class HomePage extends StatelessWidget {
  AppBar appBar = AppBar(
    backgroundColor: AppStyles.darkBlue,
    title: Text(Strings.APP_TITLE),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: appDrawer(context, appBar.preferredSize.height),
      body: BlocBuilder<ManagechildrenBloc, ManagechildrenState>(
        builder: (context, state) {
          if (state.childrenList != null && state.childrenList.length > 0) {
            List<Child> children = state.childrenList;
            List<Widget> historyList = [];
            for (int i = 0; i < children.length; i++) {
              Child child = children[i];
              if (child.predictions != null && child.predictions.isNotEmpty) {
                historyList.add(Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    child.name[0].toUpperCase() + child.name.substring(1),
                    //style: Theme.of(context).textTheme.headline6,
                  ),
                ));
                for (int j = 0; j < child.predictions.length; j++) {
                  Prediction cPrediction = child.predictions[j];
                  historyList.add(
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Image(
                        width: 32,
                        image: AssetImage(cPrediction.label == "positive"
                            ? AppIcons.happy_128
                            : AppIcons.sad_128),
                      ),
                      title: Text(cPrediction.label),
                      subtitle: Text(cPrediction.score.toString() + "%"),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/childDetails", arguments: child);
                      },
                    ),
                  );
                }
              }
            }
            if (historyList.isNotEmpty)
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  itemCount: historyList.length,
                  itemBuilder: (context, index) {
                    return historyList[index];
                  },
                  separatorBuilder: (contex, index) {
                    return Divider();
                  },
                ),
              );
            else
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 48.0, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      Strings.WELCOME_MSG,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppStyles.darkBlue,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image(
                      image: AssetImage(AppIllustrations.faq_1),
                    ),
                    RoundButton(
                      label: Strings.EVALUATE_DRAWING_BTN,
                      onPressed: () {
                        Navigator.of(context).pushNamed("/evaluate");
                      },
                    ),
                  ],
                ),
              );
          } else
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 48.0, horizontal: 20.0),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage(AppIllustrations.addChild),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          Strings.HOME_NO_CHILDREN_MESSAGE,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),
                        RoundButton(
                          label: Strings.ADD_CHILD_BTN_LABEL,
                          onPressed: () {
                            Navigator.of(context).pushNamed("/addChild");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
        },
      ),
    );
  }
}
