import 'package:baas_study/icons/font_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            FontIcons.empty,
            size: 80,
          ),
          SizedBox(height: 20),
          Text('什么都没有哦', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
