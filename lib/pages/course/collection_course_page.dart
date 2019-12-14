import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_manage_model.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course/course_card.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CollectionCoursePage extends StatefulWidget {
  @override
  _CollectionCoursePageState createState() => _CollectionCoursePageState();
}

class _CollectionCoursePageState extends State<CollectionCoursePage> {
  bool _editAble = false;
  List<CollectionCoursesModel> _courses = [];

  @override
  void initState() {
    super.initState();
    _getAllCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '收藏',
        tailTitle: _editAble ? '取消' : '管理',
        tailOnTap: () {
          setState(() {
            _editAble = !_editAble;
          });
        },
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: List.generate(
            _courses.length,
            (index) => CourseSimpleCard(
              image: HttpUtil.getImage(_courses[index].courseImage),
              name: _courses[index].courseName,
              count: _courses[index].applyCount,
              price: _courses[index].price,
            ),
          ),
        ).toList(),
      ),
    );
  }

  Future<Null> _getAllCourse() async {
    try {
      List<CollectionCoursesModel> list = await CourseDao.getAllCollections();
      setState(() {
        _courses = list;
      });
    } catch (e) {
      return e;
    }
  }
}
