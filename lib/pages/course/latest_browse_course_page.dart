import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_manage_model.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course/course_card.dart';
import 'package:baas_study/widget/course/course_card_skeleton.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/skeleton.dart';
import 'package:flutter/material.dart';

class LatestBrowseCoursePage extends StatefulWidget {
  @override
  _LatestBrowseCoursePageState createState() => _LatestBrowseCoursePageState();
}

class _LatestBrowseCoursePageState extends State<LatestBrowseCoursePage> {
  List<SimpleCoursesModel> _courses = [];
  bool _loadComplete = false;

  @override
  void initState() {
    super.initState();
    _getLatestBrowseCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '最近在学'),
      body: _loadComplete
          ? ListView.builder(
              itemCount: _courses.length,
              itemBuilder: (context, index) => CourseSimpleCard(
                image: HttpUtil.getImage(_courses[index].courseImage),
                name: _courses[index].courseName,
                count: _courses[index].applyCount,
                price: _courses[index].price,
              ),
            )
          : SkeletonList(
              builder: (context, index) => CourseSimpleSkeletonItem(),
            ),
    );
  }

  Future<Null> _getLatestBrowseCourse() async {
    try {
      List<SimpleCoursesModel> courses = await CourseDao.getBrowseCourse();
      setState(() {
        _courses = courses;
        _loadComplete = true;
      });
    } catch (e) {}
  }
}
