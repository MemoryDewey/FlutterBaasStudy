import 'package:flutter/material.dart';

class BorderDialog extends StatelessWidget {
  final String title;
  final Widget content;

  const BorderDialog({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 24),
      title: Text(title, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(height: 0.5, color: Colors.grey),
          content,
          Divider(height: 0.5, color: Colors.grey),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('buttonText'),
          onPressed: () {

          },
        ),
      ],
    );
  }
}
