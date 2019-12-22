import 'package:baas_study/icons/font_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePhoneIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Icon(
        FontIcons.safety_setting,
        size: 100,
        color: Colors.lightBlue,
      ),
    );
  }
}

class ChangePhoneNextButton extends StatelessWidget {
  final void Function() onPressed;

  const ChangePhoneNextButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: CupertinoButton(
        child: Text('下一步'),
        color: Colors.lightBlue,
        padding: EdgeInsets.symmetric(vertical: 0),
        onPressed: onPressed,
      ),
    );
  }
}

