import 'package:flutter/material.dart';

class IntroWidget {
  static TextStyle normalTextStyle(Color color) => TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w100,
      );

  static TextStyle boldTextStyle(Color color) => TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  static Widget h2Title({String title}) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          overflow: TextOverflow.ellipsis,
        ),
      );

  static Widget section({int index, Color color, List<TextSpan> children}) {
    TextStyle style = TextStyle(
      color: color,
      fontSize: 18,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 24, top: 6, right: 24),
      child: RichText(
        text: TextSpan(
          text: index != null ? '$index . ' : '',
          style: style,
          children: children ?? [],
        ),
      ),
    );
  }
}
