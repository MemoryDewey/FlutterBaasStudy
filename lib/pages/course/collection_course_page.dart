import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_manage_model.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course/course_card.dart';
import 'package:baas_study/widget/course/course_card_skeleton.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/skeleton.dart';
import 'package:flutter/material.dart';

class CollectionCoursePage extends StatefulWidget {
  @override
  _CollectionCoursePageState createState() => _CollectionCoursePageState();
}

class _CollectionCoursePageState extends State<CollectionCoursePage> {
  List<CollectionCoursesModel> _courses = [];

  /// 可编辑状态
  bool _editAble = false;

  /// 当前有选中的项
  int _selectedSum = 0;

  /// 全选
  bool _selectAll = false;

  /// 数据加载完成
  bool _loadComplete = false;

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
        tailOnTap: _loadComplete
            ? () {
                setState(() {
                  _editAble = !_editAble;
                  if (_selectedSum > 0) {
                    _selectAll = false;
                    _selectedSum = 0;
                    _selectAllCard();
                  }
                });
              }
            : null,
      ),
      body: _loadComplete
          ? ListView.builder(
              itemCount: _courses.length,
              itemBuilder: (context, index) => CourseSimpleCard(
                image: HttpUtil.getImage(_courses[index].courseImage),
                name: _courses[index].courseName,
                count: _courses[index].applyCount,
                price: _courses[index].price,
                editable: _editAble,
                selected: _courses[index].selected,
                onTap: () {
                  if (_editAble) {
                    setState(() {
                      _courses[index].selected = !_courses[index].selected;
                      _courses[index].selected
                          ? _selectedSum++
                          : _selectedSum--;
                    });
                  }
                },
                onSelected: (value) {
                  setState(() {
                    _courses[index].selected = value;
                    value ? _selectedSum++ : _selectedSum--;
                  });
                },
              ),
            )
          : SkeletonList(
              builder: (context, index) => CourseSimpleSkeletonItem(),
            ),
      bottomNavigationBar: Offstage(
        offstage: !_editAble,
        child: BottomAppBar(
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _selectAll = !_selectAll;
                          _selectedSum = _selectAll ? _courses.length : 0;
                        });
                        _selectAllCard();
                      },
                      child: Text(_selectAll ? '取消全选' : '全选'),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: FlatButton(
                      onPressed: _selectedSum != 0
                          ? () {
                              _deleteCourse();
                              setState(() {
                                _editAble = false;
                                _selectAll = false;
                                _selectedSum = 0;
                              });
                              _selectAllCard();
                            }
                          : null,
                      child: Text(
                        _selectedSum != 0 ? '删除($_selectedSum)' : '删除',
                        style: TextStyle(
                          color: _selectedSum != 0
                              ? Colors.deepOrange
                              : Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 全选 / 取消全选
  void _selectAllCard() {
    setState(() {
      _courses.forEach((item) {
        item.selected = _selectAll;
      });
    });
  }

  Future<Null> _getAllCourse() async {
    try {
      List<CollectionCoursesModel> list = await CourseDao.getAllCollections();
      setState(() {
        _courses = list;
        _loadComplete = true;
      });
    } catch (e) {
      return e;
    }
  }

  Future<Null> _deleteCourse() async {
    try {
      List<int> deleteCourse = [];
      _courses.forEach((item) {
        if (item.selected) deleteCourse.add(item.courseID);
      });

      /// 删除课程
      await CourseDao.deleteCollections(deleteCourse);

      /// 如果删除成功则从courses中移除被删除的课程
      deleteCourse.forEach((item) {
        setState(() {
          _courses.removeWhere((course) {
            return course.courseID == item;
          });
        });
      });
    } catch (e) {}
  }
}
