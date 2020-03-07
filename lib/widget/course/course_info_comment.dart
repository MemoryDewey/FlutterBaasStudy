import 'package:baas_study/dao/comment_dao.dart';
import 'package:baas_study/model/comment_model.dart';
import 'package:baas_study/pages/course/course_comment_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course/course_comment_card.dart';
import 'package:baas_study/widget/course/course_comment_skeleton.dart';
import 'package:baas_study/widget/grade_star.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseInfoCommentHeader extends StatelessWidget {
  final double rate;
  final int count;
  final bool isApply;
  final int courseID;

  const CourseInfoCommentHeader({
    Key key,
    this.rate,
    this.count = 0,
    this.isApply = false,
    @required this.courseID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        color: Theme.of(context).cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              (rate * 10).toStringAsFixed(1),
              style: TextStyle(
                color: Colors.amber,
                fontSize: 40,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GradeStar(score: rate * 5, total: 5),
                Text('共$count条评价'),
              ],
            ),
            CupertinoButton(
              child: Text('评价课程'),
              color: Colors.blueAccent,
              disabledColor: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              borderRadius: BorderRadius.all(Radius.circular(4)),
              onPressed: isApply
                  ? () {
                      Navigator.push(
                        context,
                        SlideRoute(CourseCommentPage(id: courseID)),
                      );
                    }
                  : null,
            )
          ],
        ),
      ),
    );
  }
}

class CourseInfoComment extends StatefulWidget {
  final int courseID;

  const CourseInfoComment({Key key, this.courseID}) : super(key: key);

  @override
  _CourseInfoCommentState createState() => _CourseInfoCommentState();
}

class _CourseInfoCommentState extends State<CourseInfoComment>
    with AutomaticKeepAliveClientMixin {
  List<CommentModel> _comments = [];
  bool _loadComplete = false;

  @override
  void initState() {
    super.initState();
    _getCommentList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _loadComplete
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => CourseCommentCard(
                name: _comments[index].user,
                avatar: HttpUtil.getImage(_comments[index].avatar),
                content: _comments[index].content,
                time: _comments[index].time,
                rate: _comments[index].star,
              ),
              childCount: _comments.length,
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => CourseCommentSkeleton(),
              childCount: 4,
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;

  Future<Null> _getCommentList() async {
    try {
      CommentListModel list =
          await CommentDao.getCommentList(id: widget.courseID);
      setState(() {
        _comments = list.comments;
        _loadComplete = true;
      });
    } catch (e) {
      print('commentError:$e');
    }
  }
}
