import 'package:baas_study/dao/comment_dao.dart';
import 'package:baas_study/model/comment_model.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course/course_comment_card.dart';
import 'package:baas_study/widget/course/course_comment_skeleton.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/list_empty.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CourseCommentListPage extends StatefulWidget {
  final double rate;
  final int id;

  const CourseCommentListPage({
    Key key,
    this.rate = 1,
    this.id,
  }) : super(key: key);

  @override
  _CourseCommentListPageState createState() => _CourseCommentListPageState();
}

class _CourseCommentListPageState extends State<CourseCommentListPage> {
  List<String> _choose = ['全部', '好评', '中评', '差评'];
  String _selected = '';
  CommentCount _count;

  /// 评论列表相关
  List<CommentModel> _comments = [];
  RefreshController _controller = RefreshController();
  bool _loadComplete = false;
  int _filter = 0;
  int _current = 0;
  int _page = 1;
  int _pageEach = 5;

  @override
  void initState() {
    super.initState();
    _getCommentCount();
    _onLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '评论列表'),
      body: Container(
        color: Theme.of(context).cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                '好评度 ${widget.rate * 100}%',
                style: TextStyle(color: Colors.blueAccent, fontSize: 20),
              ),
            ),
            Wrap(
              children: _choose
                  .map((choice) => Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: ChoiceChip(
                          label: Text(choice),
                          labelStyle: TextStyle(
                            color: _selected == choice
                                ? Colors.white
                                : IconTheme.of(context).color,
                          ),
                          selectedColor: Colors.blueAccent,
                          labelPadding: EdgeInsets.symmetric(horizontal: 10),
                          onSelected: (value) {
                            if (value) {
                              setState(() {
                                _selected = choice;
                                _filter = _choose.indexOf(choice);
                              });
                              _onChange();
                            }
                          },
                          selected: _selected == choice,
                        ),
                      ))
                  .toList(),
            ),
            Expanded(
              child: _loadComplete
                  ? _comments.length == 0
                      ? ListEmptyWidget()
                      : SmartRefresher(
                          controller: _controller,
                          enablePullUp: true,
                          enablePullDown: false,
                          child: ListView.builder(
                            itemBuilder: (context, index) => CourseCommentCard(
                              name: _comments[index].user,
                              avatar:
                                  HttpUtil.getImage(_comments[index].avatar),
                              content: _comments[index].content,
                              time: _comments[index].time,
                              rate: _comments[index].star,
                            ),
                            itemCount: _comments.length,
                          ),
                          onLoading: _onLoading,
                        )
                  : ListView.builder(
                      itemBuilder: (context, index) => CourseCommentSkeleton(),
                      itemCount: 6,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCount(int count) {
    return count > 99 ? "99+" : count.toString();
  }

  Future<Null> _getCommentCount() async {
    try {
      CommentCountModel comment = await CommentDao.getCount(widget.id);
      setState(() {
        _count = comment.count;
        _pageEach = comment.pageSize;
        _page = _calcPage(_count.all);
        _choose[0] = '全部(${_formatCount(_count.all)})';
        _selected = _choose[0];
        _choose[1] = '好评(${_formatCount(_count.good)})';
        _choose[2] = '中评(${_formatCount(_count.mid)})';
        _choose[3] = '差评(${_formatCount(_count.bad)})';
      });
    } catch (e) {
      print('commentCountError:$e');
    }
  }

  Future<List<CommentModel>> _getCommentList() async {
    try {
      CommentListModel list = await CommentDao.getCommentList(
        id: widget.id,
        filter: _filter,
        page: _current,
      );
      return list.comments;
    } catch (e) {
      print('commentError:$e');
      return null;
    }
  }

  void _onLoading() async {
    setState(() {
      _current += 1;
    });
    if (_current > _page)
      _controller.loadNoData();
    else {
      List<CommentModel> comments = await _getCommentList();
      if (comments == null)
        _controller.loadFailed();
      else {
        setState(() {
          _loadComplete = true;
          _comments.addAll(comments);
        });
        _controller.loadComplete();
      }
    }
  }

  void _onChange() async {
    setState(() {
      _comments.clear();
      _current = 0;
      switch (_filter) {
        case 0:
          _page = _calcPage(_count.all);
          break;
        case 1:
          _page = _calcPage(_count.good);
          break;
        case 2:
          _page = _calcPage(_count.mid);
          break;
        case 3:
          _page = _calcPage(_count.bad);
          break;
        default:
          _page = 0;
      }
    });
    _onLoading();
  }

  int _calcPage(int pageNum) {
    return pageNum % _pageEach == 0
        ? pageNum ~/ _pageEach
        : (pageNum ~/ _pageEach) + 1;
  }
}
