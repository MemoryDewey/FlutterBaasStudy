import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:flutter/material.dart';

/// 自定义封装ListGroup
class ListTileGroup extends StatelessWidget {
  final List<Widget> children;
  final double top;
  final double bottom;
  final Color color;

  const ListTileGroup({
    Key key,
    this.top = 0,
    this.bottom = 0,
    @required this.children,
    this.color,
  })  : assert(children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 自定义分割线
    final Divider divider = Divider(
      height: 0.5,
      indent: 16,
      color: Colors.grey,
    );
    List<Widget> dividerTile = List.from(children);
    if (dividerTile.length > 1) {
      for (int i = 1; i < dividerTile.length; i++) {
        dividerTile.insert(i, divider);
        i++;
      }
    }
    return Container(
      color: color,
      margin: EdgeInsets.only(top: top, bottom: bottom),
      child: Column(
        children: dividerTile,
      ),
    );
  }
}

/// 自定义封装 ListTile
class ListTileCustom extends StatelessWidget {
  final IconData leading;
  final String leadingTitle;
  final Color color;
  final String trailingTitle;
  final void Function() onTab;

  const ListTileCustom({
    Key key,
    this.leading,
    @required this.leadingTitle,
    this.color,
    this.trailingTitle,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: ListTile(
        leading: leading != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(leading, color: color),
                  Container(
                    margin: EdgeInsets.only(left: AutoSize.size(16)),
                    child: Text(
                      leadingTitle,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: AutoSize.font(17)),
                    ),
                  )
                ],
              )
            : Text(leadingTitle),
        trailing: trailingTitle == null
            ? Icon(
                Icons.arrow_forward_ios,
                size: AutoSize.size(18),
                color: Color(0xff969799),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: AutoSize.size(15)),
                    child: Text(
                      trailingTitle,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AutoSize.font(14),
                        color: Color(0xff969799),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: AutoSize.size(18),
                    color: Color(0xff969799),
                  ),
                ],
              ),
        onTap: onTab,
      ),
    );
  }
}
