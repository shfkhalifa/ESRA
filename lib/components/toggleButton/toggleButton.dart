import 'package:division/division.dart';
import 'package:esra/components/toggleButton/style.dart';
import 'package:esra/pages/authentication/style.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final Function(int selectedTab) onItemSelected;
  final List<String> items;
  ToggleButton({Key key, @required this.onItemSelected, @required this.items})
      : super(key: key);

  @override
  _TobbleButtonState createState() => _TobbleButtonState();
}

class _TobbleButtonState extends State<ToggleButton> {
  int _selectedItem;
  List<String> get _items => widget.items;

  @override
  void initState() {
    _selectedItem = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ToggleButtonStyles.rootStyle,
      child: Stack(
        children: [
          //tab selector
          Parent(
            style: ToggleButtonStyles.selectorStyle(_selectedItem),
            child: Container(),
          ),
          // labels row
          Parent(
            style: ParentStyle()..height(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildTabs(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    List<Widget> itemsWidgets = [];
    _items.forEach((item) {
      itemsWidgets.add(
        Txt(
          item,
          style: _selectedItem == _items.indexOf(item)
              ? ToggleButtonStyles.activeItemStyle
              : ToggleButtonStyles.inactiveItemStyle,
          gesture: Gestures()
            ..onTap(() {
              setState(() {
                _selectedItem = _items.indexOf(item);
              });
              widget.onItemSelected(_items.indexOf(item));
            }),
        ),
      );
    });

    return itemsWidgets;
  }
}
