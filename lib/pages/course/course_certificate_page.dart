import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/certificate_model.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course/course_card.dart';
import 'package:baas_study/widget/course/course_card_skeleton.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/list_empty.dart';
import 'package:baas_study/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CertificatePage extends StatefulWidget {
  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  RefreshController _refreshUserController = RefreshController();
  List<Certificate> _courses;
  int _coursesCurrent;
  int _coursesPage;
  bool _loadComplete;

  @override
  void initState() {
    super.initState();
    _initData();
    _onCourseLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '我的证书'),
      body: _loadComplete
          ? _courses.length == 0
              ? ListEmptyWidget()
              : SmartRefresher(
                  controller: _refreshUserController,
                  enablePullUp: true,
                  enablePullDown: false,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 16),
                    itemCount: _courses.length,
                    itemBuilder: (context, index) => CourseManageCard(
                      imageUrl: HttpUtil.getImage(
                          _courses[index].courseImage),
                      dateTime: '${_courses[index].time} ',
                      courseName: _courses[index].courseName,
                      state: '请前往PC端下载证书',
                      bottom: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '证书编号: ${_courses[index].id}',
                              style: TextStyle(
                                color: Color(0xffee0a24),
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  onLoading: _onCourseLoading,
                )
          : Padding(
              padding: EdgeInsets.only(top: 16),
              child: SkeletonList(
                builder: (context, index) => CourseMngCardSkeletonItem(),
              ),
            ),
    );
  }

  void _initData() {
    _courses = [];
    _coursesCurrent = 0;
    _coursesPage = 1;
    _loadComplete = false;
  }

  void _onCourseLoading() async {
    setState(() {
      _coursesCurrent += 1;
    });
    if (_coursesCurrent > _coursesPage)
      _refreshUserController.loadNoData();
    else {
      List<Certificate> course = await _getCourse();
      if (course == null)
        _refreshUserController.loadFailed();
      else {
        setState(() {
          _loadComplete = true;
          _courses.addAll(course);
        });
        _refreshUserController.loadComplete();
      }
    }
  }

  Future<List<Certificate>> _getCourse() async {
    try {
      CertificateModel model = await CourseDao.getCertificate(_coursesCurrent);
      setState(() {
        _coursesPage = model.pageSum;
      });
      return model.certificates;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
