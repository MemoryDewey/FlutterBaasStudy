import 'package:flutter/material.dart';

class BorderDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final bool cancel;
  final void Function() confirmPress;

  const BorderDialog({
    Key key,
    this.title,
    this.content,
    this.cancel = true,
    this.confirmPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(16),
      contentPadding: EdgeInsets.all(0),
      title: Text(title, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(height: 0, color: Colors.grey),
          content,
          Divider(height: 0, color: Colors.grey),
          InkWell(
            onTap: cancel ? () {
              Navigator.of(context).pop();
            } : confirmPress,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                cancel ? '取消' : '确定',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
