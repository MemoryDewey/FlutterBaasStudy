import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:flutter/material.dart';

class PassBtn extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const PassBtn({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AutoSize.size(4)),
        ),
        padding: EdgeInsets.symmetric(vertical: AutoSize.size(15)),
        disabledColor: Color(0xff999999),
        disabledTextColor: Colors.white,
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(text),
      ),
    );
  }
}

class PassBottomText extends StatelessWidget {
  final String text;
  final void Function() onTab;

  const PassBottomText({Key key, this.text, this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AutoSize.size(10)),
      child: GestureDetector(
        onTap: onTab,
        child: Text(
          text,
          style: TextStyle(
            fontSize: AutoSize.font(16),
          ),
        ),
      ),
    );
  }
}
