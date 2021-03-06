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

class ChildrenPage extends StatelessWidget {
  const ChildrenPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyles.darkBlue,
          title: Text(Strings.CHILDREN_LIST_PAGE_TITLE),
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
                      crossAxisCount: 2, crossAxisSpacing: 24, mainAxisSpacing: 24),
                  itemBuilder: (BuildContext context, int index) {
                    Child child = state.childrenList[index];
                    return Parent(
                      gesture: Gestures()
                        ..onTap(
                          () {
                            Navigator.of(context).pushNamed('/childDetails', arguments: child);
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
                            image: AssetImage(child.gender == 'boy' ? AppIcons.boy_128 : AppIcons.girl_128),
                          ),
                          SizedBox(height: 14),
                          Txt(
                            '${child.name[0].toUpperCase()}${child.name.substring(1).toLowerCase()}',
                            style: TxtStyle()
                              ..bold()
                              ..textColor(AppStyles.darkBlue),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            return Center(child: Text(Strings.NO_CHILD_MESSAGE));
          },
        ));
  }
}
