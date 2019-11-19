import 'package:baas_study/utils/auto_size_utli.dart';
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
      margin: EdgeInsets.fromLTRB(
        0,
        AutoSizeUtil.size(10),
        0,
        AutoSizeUtil.size(10),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: AutoSizeUtil.size(25),
            color: colors,
          ),
          Padding(
            padding: EdgeInsets.only(left: AutoSizeUtil.size(10)),
            child: Text(
              text,
              style: TextStyle(
                color: colors,
                fontSize: AutoSizeUtil.font(20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
