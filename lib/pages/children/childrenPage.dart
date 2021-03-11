import 'package:division/division.dart';
import 'package:esra/bloc/manageChildrenBloc/mangeChildren.dart';
import 'package:esra/models/child.dart';
import 'package:esra/styles.dart';

///
/// By Younss Ait Mou
///

import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esra/localization/language_constants.dart';

class ChildrenPage extends StatelessWidget {
  const ChildrenPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyles.darkBlue,
          title: Text(getTranslated(context, "CHILDREN_LIST_PAGE_TITLE")),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('/addChild');
              },
            )
          ],
        ),
        body: BlocBuilder<ManagechildrenBloc, ManagechildrenState>(
          builder: (context, state) {
            if (state.childrenList != null && state.childrenList.length > 0) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: GridView.builder(
                  itemCount: state.childrenList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24),
                  itemBuilder: (BuildContext context, int index) {
                    int age;
                    Child child = state.childrenList[index];
                    if (child.dob != null) {
                      DateTime _dateTime = DateTime.parse(child.dob);
                      age = DateTime.fromMillisecondsSinceEpoch(DateTime.now()
                                  .difference(_dateTime)
                                  .inMilliseconds)
                              .year -
                          1970;
                    }
                    return Parent(
                      gesture: Gestures()
                        ..onTap(
                          () {
                            Navigator.of(context)
                                .pushNamed('/childDetails', arguments: child);
                          },
                        ),
                      style: ParentStyle()
                        ..background.color(AppStyles.dimedBlue)
                        ..borderRadius(all: 15)
                        ..alignmentContent.center()
                        ..ripple(true),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image(
                            width: 64,
                            image: AssetImage(child.gender == 'boy'
                                ? AppIcons.boy_128
                                : AppIcons.girl_128),
                          ),
                          SizedBox(height: 14),
                          Txt(
                            '${child.name[0].toUpperCase()}${child.name.substring(1).toLowerCase()}' +
                                '${(age != null) ? '\n $age years' : ' '}',
                            style: TxtStyle()
                              ..bold()
                              ..textColor(AppStyles.darkBlue)
                              ..textAlign.center(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            return Center(
                child: Text(getTranslated(context, "NO_CHILD_MESSAGE")));
          },
        ));
  }
}
