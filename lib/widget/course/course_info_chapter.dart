import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_info_model.dart';
import 'package:flutter/material.dart';

class CourseInfoChapterHeader extends StatelessWidget {
  final bool isLive;

  const CourseInfoChapterHeader({Key key, this.isLive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Text('授课方式：'),
            _iconText(iconData: Icons.tv, text: '视频'),
            SizedBox(width: 10),
            Offstage(
              offstage: !isLive,
              child: _iconText(iconData: Icons.live_tv, text: '直播'),
            )
          ],
        ),
      ),
    );
  }

  Widget _iconText({IconData iconData, String text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(iconData, size: 20),
        SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}

class CourseInfoChapter extends StatefulWidget {
  final bool isLive;
  final int courseID;
  final void Function(String video) onChange;

  const CourseInfoChapter({
    Key key,
    this.isLive = false,
    @required this.courseID,
    this.onChange,
  }) : super(key: key);

  @override
  _CourseInfoChapterState createState() => _CourseInfoChapterState();
}

class _CourseInfoChapterState extends State<CourseInfoChapter>
    with AutomaticKeepAliveClientMixin {
  List<_ExpansionTileModel> _expansion = [];

  @override
  void initState() {
    super.initState();
    _getVideoList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Material(
          color: Theme.of(context).cardColor,
          child: ChapterExpansion(
            name: _expansion[index].name,
            tile: _expansion[index].children,
            onTap: widget.onChange,
          ),
        ),
        childCount: _expansion.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<Null> _getVideoList() async {
    try {
      if (widget.isLive) {
        LiveModel model = await CourseDao.getLiveInfo(widget.courseID);
        if (mounted) {
          setState(() {
            _expansion.add(_ExpansionTileModel(name: '直播课程', children: [
              _TileModel(
                icon: Icons.live_tv,
                title: model.live ? model.title : '暂无直播',
                subTitle: model.live ? model.state ? '直播中' : '未开播' : '该课程暂无直播',
                url: model.streamName,
              )
            ]));
          });
        }
      }
      ChapterInfoModel model = await CourseDao.getChapterInfo(widget.courseID);
      List<ChapterModel> chapters = model.data;
      if (mounted)
        setState(() {
          chapters.forEach((chapter) {
            _expansion.add(_ExpansionTileModel(
                name: chapter.name,
                children: chapter.video.map((video) {
                  return _TileModel(
                    icon: Icons.play_circle_filled,
                    title: video.name,
                    subTitle: '${video.duration}分钟',
                    url: video.url,
                  );
                }).toList()));
          });
        });
    } catch (e) {
      print(e);
    }
  }
}

class _ExpansionTileModel {
  String name;
  List<_TileModel> children;

  _ExpansionTileModel({this.name, this.children});
}

class _TileModel {
  String title;
  IconData icon;
  String subTitle;
  String url;

  _TileModel({this.title, this.icon, this.subTitle, this.url});
}

class ChapterExpansion extends StatefulWidget {
  final String name;
  final List<_TileModel> tile;
  final void Function(String url) onTap;

  const ChapterExpansion({
    Key key,
    this.name,
    this.tile,
    this.onTap,
  }) : super(key: key);

  @override
  _ChapterExpansionState createState() => _ChapterExpansionState();
}

class _ChapterExpansionState extends State<ChapterExpansion> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(widget.name),
          onTap: () {
            setState(() {
              _hidden = !_hidden;
            });
          },
          trailing: Icon(
            _hidden ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
            size: 32,
          ),
        ),
        Offstage(
          offstage: _hidden,
          child: Column(
            children: widget.tile.map((item) {
              return ListTile(
                leading: Icon(item.icon, size: 32),
                title: Text(item.title),
                subtitle: Text(item.subTitle),
                onTap: () {
                  widget.onTap(item.url);
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
