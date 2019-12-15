import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LatestBrowseCoursePage extends StatefulWidget {
  @override
  _LatestBrowseCoursePageState createState() => _LatestBrowseCoursePageState();
}

class _LatestBrowseCoursePageState extends State<LatestBrowseCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '最近在学'),
      body: Container(),
    );
  }
}
