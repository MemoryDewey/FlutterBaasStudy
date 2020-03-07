import 'package:baas_study/dao/comment_dao.dart';
import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/comment_model.dart';
import 'package:baas_study/model/course_info_model.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/pages/course/course_comment_list_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/widget/confirm_dialog.dart';
import 'package:baas_study/widget/course/course_info_app_bar.dart';
import 'package:baas_study/widget/course/course_info_chapter.dart';
import 'package:baas_study/widget/course/course_info_comment.dart';
import 'package:baas_study/widget/course/course_info_detail.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class CourseInfoPage extends StatefulWidget {
  final int id;

  const CourseInfoPage({Key key, @required this.id}) : super(key: key);

  @override
  _CourseInfoPageState createState() => _CourseInfoPageState();
}

class _CourseInfoPageState extends State<CourseInfoPage> {
  bool _isApply = false;
  bool _loadComplete = false;
  bool _isCollection = false;
  CourseInfoDetailModel _courseInfoDetail;
  bool _infoLoaded = false;
  int _commentCount = 0;
  IjkMediaController _videoController = IjkMediaController();
  List<String> _tabs = <String>['详情', '目录', '评论'];

  @override
  void initState() {
    super.initState();
    _checkApply();
    _getInfoDetail();
    _getCommentCount();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) => <Widget>[
            CourseVideoAppBar(
              controller: _videoController,
              title: (_courseInfoDetail?.course?.info?.name) ?? '',
              isApply: _isApply,
              load: _loadComplete,
              isCollection: _isCollection,
              courseId: widget.id,
              rightClick: _courseCollect,
              applyClick: _courseInfoDetail?.course?.info?.price == 0
                  ? _applyFreeCourse
                  : () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialogContext) => ConfirmDialog(
                          title: '购买课程',
                          content: Text(
                            '确认花费${_courseInfoDetail?.course?.info?.price}'+
                            '课程币购买该课程吗？',
                          ),
                          confirmPress: _buyCourse,
                        ),
                      );
                    },
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyTabBarDelegate(
                child: TabBar(
                  tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: _tabs
                .map((tab) => Builder(
                      builder: (context) => CustomScrollView(
                        /// key保证唯一性
                        key: PageStorageKey<String>(tab),
                        slivers: _tabsWidget(_tabs.indexOf(tab)),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> _tabsWidget(int index) {
    switch (index) {
      case 0:
        return [
          CourseInfoDetail(
            infoDetail: _courseInfoDetail?.course,
            loadComplete: _infoLoaded,
          )
        ];
      case 1:
        bool isLive = _courseInfoDetail.course.info.form == 'L';
        return [
          CourseInfoChapterHeader(
            isLive: isLive,
          ),
          CourseInfoChapter(
            isLive: isLive,
            courseID: widget.id,
            onChange: _isApply
                ? (url) async {
                    await _videoController.setDataSource(
                      DataSource.network(url),
                      autoPlay: false,
                    );
                  }
                : null,
          )
        ];
      case 2:
        return [
          CourseInfoCommentHeader(
            rate: _courseInfoDetail?.course?.info?.rate ?? 0.0,
            count: _commentCount,
            isApply: _isApply,
            courseID: widget.id,
          ),
          CourseInfoComment(courseID: widget.id),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      SlideRoute(
                        CourseCommentListPage(
                          rate: _courseInfoDetail?.course?.info?.rate ?? 0.0,
                          id: widget.id,
                        ),
                      ),
                    );
                  },
                  child: Text('查看全部'),
                ),
              ),
            ),
          )
        ];
      default:
        return [SliverToBoxAdapter(child: Container())];
    }
  }

  Future<Null> _checkApply() async {
    try {
      bool apply = await CourseDao.checkCourseApply(widget.id);
      setState(() {
        _isApply = apply;
        _loadComplete = true;
      });
    } catch (e) {
      print('checkApplyError:$e');
      setState(() {
        _isApply = false;
      });
    }
  }

  Future<Null> _getInfoDetail() async {
    try {
      CourseInfoDetailModel model =
          await CourseDao.getInfoDetail(widget.id);
      if (model != null) {
        setState(() {
          _courseInfoDetail = model;
          _isCollection = model?.collection;
          _infoLoaded = true;
        });
      }
    } catch (e) {
      print('infoDetailError:$e');
    }
  }

  Future<Null> _courseCollect() async {
    try {
      ResponseNormalModel model =
          await CourseDao.courseCollect(widget.id, _isCollection ? 0 : 1);
      if (model.code == 1000) {
        BotToast.showText(text: model.msg);
        setState(() {
          _isCollection = !_isCollection;
        });
      }
    } catch (e) {
      print('collectError:$e');
    }
  }

  Future<Null> _getCommentCount() async {
    try {
      CommentCountModel comment = await CommentDao.getCount(widget.id);
      setState(() {
        _commentCount = comment.count.all;
        _tabs[2] = '${_tabs[2]}($_commentCount)';
      });
    } catch (e) {
      print('commentCountError:$e');
    }
  }

  Future<Null> _applyFreeCourse() async {
    try {
      CourseApplyModel apply = await CourseDao.applyFree(widget.id);
      if (apply != null) {
        BotToast.showText(text: apply.msg);
        setState(() {
          _isApply = true;
          _courseInfoDetail.course.info.apply = apply.apply;
        });
      }
    } catch (e) {
      print('applyFreeError:$e');
    }
  }

  Future<Null> _buyCourse() async {
    CourseApplyModel apply = await CourseDao.buyCourse(widget.id);
    if (apply != null) {
      BotToast.showText(text: apply.msg);
      setState(() {
        _isApply = true;
        _courseInfoDetail.course.info.apply = apply.apply;
      });
    }
  }
}

/// 粘性布局 TabBar
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  _StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
      ),
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
