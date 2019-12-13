import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class CourseInfoPage extends StatefulWidget {
  @override
  _CourseInfoPageState createState() => _CourseInfoPageState();
}

class _CourseInfoPageState extends State<CourseInfoPage> {
  IjkMediaController controller = IjkMediaController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        //'http://1300082196.vod2.myqcloud.com/5b1a5ea8vodtranscq1300082196/5eb444555285890794790702851/v.f40.mp4'
      ),
    );
  }
}
