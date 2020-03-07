import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_manage_model.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/pages/course/course_comment_page.dart';
import 'package:baas_study/pages/course/course_info_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/confirm_dialog.dart';
import 'package:baas_study/widget/course/course_card.dart';
import 'package:baas_study/widget/course/course_card_skeleton.dart';
import 'package:baas_study/widget/list_empty.dart';
import 'package:baas_study/widget/skeleton.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserCoursePage extends StatefulWidget {
  @override
  _UserCoursePageState createState() => _UserCoursePageState();
}

class _UserCoursePageState extends State<UserCoursePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _UserCourseTabView(),
          _BalanceCourseTabView(),
          _BstCourseTabView(),
        ],
      ),
    );
  }

  /// appbar tabBar
  Widget _appBar() => AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text('课程管理', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: '全部课程'),
            Tab(text: '余额购买'),
            Tab(text: 'BST购买'),
          ],
        ),
      );
}

/// 全部课程 TabView
class _UserCourseTabView extends StatefulWidget {
  @override
  __UserCourseTabViewState createState() => __UserCourseTabViewState();
}

class __UserCourseTabViewState extends State<_UserCourseTabView>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshUserController = RefreshController();
  List<UserCoursesModel> _courses = [];
  int _userCoursesCurrent = 0;
  int _userCoursesPage = 1;
  bool _loadComplete = false;

  @override
  void initState() {
    super.initState();
    _onUserCourseLoading();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _loadComplete
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
                    dateTime: _courses[index].time,
                    courseName: _courses[index].name,
                    price: '￥${_courses[index].price}',
                    state: '报名成功',
                    isFree: _courses[index].price == 0,
                    bottom: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CourseManageCard.cardBottomBtn(
                          text: '评价课程',
                          textColor: Colors.white,
                          buttonColor: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              SlideRoute(
                                CourseCommentPage(
                                  id: _courses[index].id,
                                ),
                              ),
                            );
                          },
                        ),
                        Offstage(
                          offstage: _courses[index].price > 0,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: CourseManageCard.cardBottomBtn(
                              text: '取消报名',
                              textColor: Colors.white,
                              buttonColor: Colors.deepOrange,
                              onPressed: () {
                                showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (dialogContext) {
                                      return ConfirmDialog(
                                        title: '取消报名',
                                        content: Text(
                                          '您确定要取消报名吗？',
                                          style: TextStyle(height: 1),
                                        ),
                                        confirmPress: () {
                                          _cancelCourse(
                                            _courses[index].id,
                                          );
                                        },
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRoute(
                          CourseInfoPage(id: _courses[index].id),
                        ),
                      );
                    },
                  ),
                ),
                onLoading: _onUserCourseLoading,
              )
        : Padding(
            padding: EdgeInsets.only(top: 16),
            child: SkeletonList(
              builder: (context, index) => CourseMngCardSkeletonItem(),
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;

  void _onUserCourseLoading() async {
    setState(() {
      _userCoursesCurrent += 1;
    });
    if (_userCoursesCurrent > _userCoursesPage)
      _refreshUserController.loadNoData();
    else {
      List<UserCoursesModel> course = await _getUserCourse();
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

  Future<List<UserCoursesModel>> _getUserCourse() async {
    try {
      CourseManageModel model =
          await CourseDao.getUserCourse(_userCoursesCurrent);
      setState(() {
        _userCoursesPage = model.pageSum;
      });
      return model.courses;
    } catch (e) {
      return null;
    }
  }

  Future<Null> _cancelCourse(int courseId) async {
    try {
      ResponseNormalModel res = await CourseDao.cancelFreeCourse(courseId);
      if (res.code == 1000) {
        BotToast.showText(text: res.msg ?? '取消报名成功');
        _courses.clear();
        setState(() {
          _userCoursesCurrent = 0;
        });
        _onUserCourseLoading();
      }
    } catch (e) {
      print(e);
    }
  }
}

/// 余额购买 TabView
class _BalanceCourseTabView extends StatefulWidget {
  @override
  __BalanceCourseTabViewState createState() => __BalanceCourseTabViewState();
}

class __BalanceCourseTabViewState extends State<_BalanceCourseTabView>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshBalanceController = RefreshController();
  List<BalanceCoursesModel> _courses = [];
  int _balanceCoursesCurrent = 0;
  int _balanceCoursesPage = 1;
  bool _loadComplete = false;

  @override
  void initState() {
    super.initState();
    _onBalanceCourseLoading();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _loadComplete
        ? _courses.length == 0
            ? ListEmptyWidget()
            : SmartRefresher(
                controller: _refreshBalanceController,
                enablePullUp: true,
                enablePullDown: false,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 16),
                  itemCount: _courses.length,
                  itemBuilder: (context, index) => CourseManageCard(
                    imageUrl: HttpUtil.getImage(
                        _courses[index].image),
                    dateTime: _courses[index].time,
                    courseName: _courses[index].name,
                    price: '￥${_courses[index].amount}',
                    state: '购买成功',
                    isFree: false,
                    bottom: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CourseManageCard.cardBottomBtn(
                          text: '评价课程',
                          textColor: Colors.white,
                          buttonColor: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              SlideRoute(
                                CourseCommentPage(
                                  id: _courses[index].productId,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRoute(
                          CourseInfoPage(id: _courses[index].productId),
                        ),
                      );
                    },
                  ),
                ),
                onLoading: _onBalanceCourseLoading,
              )
        : Padding(
            padding: EdgeInsets.only(top: 16),
            child: SkeletonList(
              builder: (context, index) => CourseMngCardSkeletonItem(),
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;

  void _onBalanceCourseLoading() async {
    setState(() {
      _balanceCoursesCurrent += 1;
    });
    if (_balanceCoursesCurrent > _balanceCoursesPage)
      _refreshBalanceController.loadNoData();
    else {
      List<BalanceCoursesModel> course = await _getBalanceCourse();
      if (course == null)
        _refreshBalanceController.loadFailed();
      else {
        setState(() {
          _loadComplete = true;
          _courses.addAll(course);
        });
        _refreshBalanceController.loadComplete();
      }
    }
  }

  Future<List<BalanceCoursesModel>> _getBalanceCourse() async {
    try {
      CourseManageModel model =
          await CourseDao.getBalanceCourse(_balanceCoursesCurrent);
      setState(() {
        _balanceCoursesPage = model.pageSum;
      });
      return model.courses;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

/// BST购买 TabView
class _BstCourseTabView extends StatefulWidget {
  @override
  __BstCourseTabViewState createState() => __BstCourseTabViewState();
}

class __BstCourseTabViewState extends State<_BstCourseTabView>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshBstController = RefreshController();
  List<BstCoursesModel> _courses = [];
  int _bstCoursesCurrent = 0;
  int _bstCoursesPage = 1;
  bool _loadComplete = false;

  @override
  void initState() {
    super.initState();
    _onBstCourseLoading();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _loadComplete
        ? _courses.length == 0
            ? ListEmptyWidget()
            : SmartRefresher(
                controller: _refreshBstController,
                enablePullUp: true,
                enablePullDown: false,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 16),
                  itemCount: _courses.length,
                  itemBuilder: (context, index) => CourseManageCard(
                    imageUrl: HttpUtil.getImage(
                        _courses[index].image),
                    dateTime: _courses[index].time,
                    courseName: _courses[index].name,
                    price: '${_courses[index].amount} BST',
                    state: '报名成功',
                    isFree: false,
                    bottom: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CourseManageCard.cardBottomBtn(
                          text: '复制交易ID',
                          textColor: Colors.white,
                          buttonColor: Colors.greenAccent,
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: _courses[index].txHash ?? ''));
                            BotToast.showText(text: '已复制');
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRoute(
                          CourseInfoPage(id: _courses[index].productId),
                        ),
                      );
                    },
                  ),
                ),
                onLoading: _onBstCourseLoading,
              )
        : Padding(
            padding: EdgeInsets.only(top: 16),
            child: SkeletonList(
              builder: (context, index) => CourseMngCardSkeletonItem(),
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;

  void _onBstCourseLoading() async {
    setState(() {
      _bstCoursesCurrent += 1;
    });
    if (_bstCoursesCurrent > _bstCoursesPage)
      _refreshBstController.loadNoData();
    else {
      List<BstCoursesModel> course = await _getBstCourse();
      if (course == null)
        _refreshBstController.loadFailed();
      else {
        setState(() {
          _loadComplete = true;
          _courses.addAll(course);
        });
        _refreshBstController.loadComplete();
      }
    }
  }

  Future<List<BstCoursesModel>> _getBstCourse() async {
    try {
      CourseManageModel model =
          await CourseDao.getBstCourse(_bstCoursesCurrent);
      setState(() {
        _bstCoursesPage = model.pageSum;
      });
      return model.courses;
    } catch (e) {
      return null;
    }
  }
}
