import 'package:division/division.dart';
import 'package:esra/bloc/authenticationBloc/authentication.dart';
import 'package:esra/bloc/manageChildrenBloc/mangeChildren.dart';
import 'package:esra/styles.dart';
import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:esra/localization/language_constants.dart';

Widget appDrawer(BuildContext context, double appBarHeight) {
  double topMargin = appBarHeight + MediaQuery.of(context).padding.top;
  return Parent(
    style: ParentStyle()..margin(top: topMargin),
    child: Drawer(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              BlocBuilder<ManagechildrenBloc, ManagechildrenState>(
                builder: (context, state) {
                  return ListTile(
                    leading: Image(
                      image: AssetImage(AppIcons.child),
                      width: 24,
                    ),
                    title: Text(getTranslated(context, "CHILDREN_TITLE")),
                    trailing: Txt(
                      state.childrenList.length.toString(),
                      style: AppStyles.badgeStyle,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('/children');
                    },
                  );
                },
              ),
              Divider(color: AppStyles.lightBlue),
              ListTile(
                leading: Image(
                  image: AssetImage(AppIcons.analyze),
                  width: 24,
                ),
                title: Text(getTranslated(context, 'EVALUATE_TITLE')),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/evaluate');
                },
              ),
              Divider(color: AppStyles.lightBlue),
              ListTile(
                leading: Image(
                  image: AssetImage(AppIcons.faq),
                  width: 24,
                ),
                title: Text(getTranslated(context, "FAQ_TITLE")),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/FAQ');
                },
              ),
              Divider(color: AppStyles.lightBlue),
              ListTile(
                leading: Image(
                  image: AssetImage(AppIcons.faq),
                  width: 24,
                ),
                title: Text(getTranslated(context, "SETTINGS")),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/settings');
                },
              ),
              Divider(color: AppStyles.lightBlue),
              ListTile(
                leading: Image(
                  image: AssetImage(AppIcons.logOut),
                  width: 24,
                ),
                title: Text(getTranslated(context, 'LOGOUT_TITLE')),
                onTap: () {
                  Navigator.pop(context); // remove the drawer
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              ),
              Divider(color: AppStyles.lightBlue),
            ],
          ),
          Parent(
            style: ParentStyle()
              ..alignment.bottomCenter()
              ..padding(bottom: 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage(AppIllustrations.drawer),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
