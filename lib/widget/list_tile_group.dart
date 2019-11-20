import 'package:flutter/material.dart';

class ListTileGroup extends StatelessWidget {
  final List<Widget> children;
  final double top;
  final double bottom;
  final Color color;

  const ListTileGroup({
    Key key,
    this.top = 0,
    this.bottom = 0,
    this.children,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      margin: EdgeInsets.only(top: top, bottom: bottom),
      child: Column(
        children: children,
      ),
    );
  }
}
