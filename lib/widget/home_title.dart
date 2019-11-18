import 'package:flutter/material.dart';

class HomeTitleWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color colors;

  const HomeTitleWidget({Key key, this.text, this.icon, this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 25,
            color: colors,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                color: colors,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
