import 'package:flutter/material.dart';

class GridNav extends StatelessWidget {
  final double height;
  final double width;
  final List<Widget> children;

  const GridNav({
    Key key,
    @required this.height,
    @required this.width,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Theme.of(context).cardColor,
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: width / 3 / height,
        children: children,
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final void Function() onTab;

  const GridItem({
    Key key,
    this.icon,
    this.text,
    this.iconColor,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
