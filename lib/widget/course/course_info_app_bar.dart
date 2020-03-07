import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_video_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:screen/screen.dart';

class CourseVideoAppBar extends StatefulWidget {
  final bool isApply;
  final bool load;
  final bool isCollection;
  final int courseId;
  final String title;
  final void Function() rightClick;
  final void Function() applyClick;
  final IjkMediaController controller;

  const CourseVideoAppBar({
    Key key,
    @required this.isApply,
    @required this.load,
    this.isCollection = false,
    @required this.courseId,
    this.rightClick,
    this.title,
    this.controller,
    this.applyClick,
  }) : super(key: key);

  @override
  _CourseVideoAppBarState createState() => _CourseVideoAppBarState();
}

class _CourseVideoAppBarState extends State<CourseVideoAppBar> {
  @override
  void initState() {
    super.initState();
    Screen.keepOn(true);
    _getFirstVideo();
  }

  @override
  void dispose() {
    Screen.keepOn(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0.5,
      centerTitle: true,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppBarTheme.of(context).color
          : Colors.blue,
      title: Text(widget.title),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: widget.rightClick,
            child: Icon(
              widget.isCollection ? Icons.favorite : Icons.favorite_border,
              color: widget.isCollection ? Colors.pink : Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
      expandedHeight: MediaQuery.of(context).size.width / 16 * 9,
      flexibleSpace: FlexibleSpaceBar(
        background: widget.isApply
            ? IjkPlayer(
                mediaController: widget.controller,
                controllerWidgetBuilder: (mediaController) {
                  return DefaultIJKControllerWidget(
                    controller: mediaController,
                    doubleTapPlay: true,
                    volumeType: VolumeType.media,
                  );
                },
              )
            : Container(
                color: Colors.black,
                child: Center(
                  child: Offstage(
                    offstage: !widget.load,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '需要先报名该课程才能观看该视频哦',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        CupertinoButton(
                          color: Colors.blue,
                          padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16,
                          ),
                          child: Text('报名课程'),
                          onPressed: widget.applyClick,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<Null> _getFirstVideo() async {
    try {
      VideoFirstModel model = await CourseDao.getFirstVideo(widget.courseId);
      if (model.video != null) {
        await widget.controller.setDataSource(
          DataSource.network(model.video.mediaUrl),
          autoPlay: false,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
