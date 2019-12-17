import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String tailTitle;
  final Icon tailIcon;
  final void Function() tailOnTap;

  const CustomAppBar({
    Key key,
    @required this.title,
    this.tailTitle,
    this.tailOnTap,
    this.tailIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    if (tailTitle != null)
      actions.add(FlatButton(
        onPressed: tailOnTap,
        child: Text(tailTitle),
      ));
    else if (tailIcon != null)
      actions.add(FlatButton(
        onPressed: tailOnTap,
        child: tailIcon,
      ));

    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios),
      ),
      title: Text(title, style: TextStyle(fontSize: 18)),
      actions: actions,
      centerTitle: true,
      textTheme: Theme.of(context).textTheme,
      elevation: 0.5,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
