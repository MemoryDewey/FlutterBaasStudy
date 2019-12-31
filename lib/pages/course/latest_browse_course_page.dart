import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_manage_model.dart';
import 'package:baas_study/pages/course/course_info_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course/course_card.dart';
import 'package:baas_study/widget/course/course_card_skeleton.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/list_empty.dart';
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
    List<Widget> sliverWidget = [];
    if (_loadComplete) {
      sliverWidget.add(SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => CourseSimpleCard(
                  image: HttpUtil.getImage(_courses[index].courseImage),
                  name: _courses[index].courseName,
                  count: _courses[index].applyCount,
                  price: _courses[index].price,
                  onTap: () {
                    Navigator.push(
                      context,
                      SlideRoute(
                        CourseInfoPage(courseID: _courses[index].courseID),
                      ),
                    );
                  },
                ),
            childCount: _courses.length),
      ));
      if (_courses.length > 0)
        sliverWidget.add(SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              '只展示最近在学的10门课程',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ));
      else
        sliverWidget.add(SliverToBoxAdapter(
          child: ListEmptyWidget(),
        ));
    } else
      sliverWidget.add(SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => CourseSimpleSkeletonItem(),
        ),
      ));
    return Scaffold(
      appBar: CustomAppBar(title: '最近在学'),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: sliverWidget,
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
