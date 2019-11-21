import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:flutter/material.dart';

/// 自定义封装 ListTile
class ListTileCustom extends StatelessWidget {
  final IconData leading;
  final String leadingTitle;
  final Color color;
  final String trailingTitle;

  const ListTileCustom({
    Key key,
    this.leading,
    this.leadingTitle,
    this.color,
    this.trailingTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: AutoSizeUtil.size(16)),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(leading, color: color),
          Container(
            margin: EdgeInsets.only(left: AutoSizeUtil.size(16)),
            child: Text(
              leadingTitle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: AutoSizeUtil.font(17)),
            ),
          )
        ],
      ),
      trailing: trailingTitle == null
          ? Icon(
              Icons.arrow_forward_ios,
              size: AutoSizeUtil.size(18),
              color: Color(0xff969799),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  trailingTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AutoSizeUtil.font(14),
                    color: Color(0xff969799),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: AutoSizeUtil.size(18),
                  color: Color(0xff969799),
                ),
              ],
            ),
    );
  }
}
