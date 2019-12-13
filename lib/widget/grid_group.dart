import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridNav extends StatelessWidget {
  final double height;
  final List<Widget> children;

  const GridNav({
    Key key,
    @required this.height,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Theme.of(context).cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children,
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String text;
  final double fontSize;
  final bool selected;
  final void Function() onTab;

  const GridItem({
    Key key,
    this.icon,
    this.iconColor,
    this.iconSize = 36,
    this.text,
    this.fontSize = 14,
    this.selected = false,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: RawMaterialButton(
        child: selected
            ? Container(
                width: iconSize * 1.8,
                height: iconSize * 1.8,
                decoration:
                    BoxDecoration(color: iconColor, shape: BoxShape.circle),
                child: _item(context),
              )
            : _item(context),
        onPressed: onTab,
      ),
    );
  }

  Widget _item(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: iconSize,
          color: selected ? Colors.white : iconColor,
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: selected ? Colors.white : IconTheme.of(context).color,
            ),
          ),
        )
      ],
    );
  }
}

