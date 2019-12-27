import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_manage_model.dart';
import 'package:baas_study/pages/course/exam_info_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course/course_card.dart';
import 'package:baas_study/widget/course/course_card_skeleton.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/list_empty.dart';
import 'package:baas_study/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExamCoursePage extends StatefulWidget {
  @override
  _ExamCoursePageState createState() => _ExamCoursePageState();
}

class _ExamCoursePageState extends State<ExamCoursePage> {
  static const Map<int, String> _EXAM_STATE = {
    -1: '未参加',
    0: '未开始',
    1: '进行中',
    2: '已完成',
  };
  RefreshController _refreshUserController = RefreshController();
  List<ExamCoursesModel> _courses;
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
      appBar: CustomAppBar(title: '我的考试列表'),
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
                      imageUrl: HttpUtil.getImage(_courses[index].image),
                      dateTime:
                          '${_courses[index].startTime} - ${_courses[index].endTime}',
                      courseName: _courses[index].courseName,
                      state: _EXAM_STATE[_courses[index].state],
                      bottom: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '成绩: ${_courses[index].score}',
                              style: TextStyle(
                                color: Color(0xffee0a24),
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () async {
                        var refresh = await Navigator.push(
                          context,
                          SlideRoute(ExamInfoPage(
                            courseID: _courses[index].courseID,
                          )),
                        );
                        if (refresh ?? false) {
                          _initData();
                          _onCourseLoading();
                        }
                      },
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
      List<ExamCoursesModel> course = await _getCourse();
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

  Future<List<ExamCoursesModel>> _getCourse() async {
    try {
      CourseManageModel model = await CourseDao.getExamCourse(_coursesCurrent);
      setState(() {
        _coursesPage = model.pageSum;
      });
      return model.courses;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
