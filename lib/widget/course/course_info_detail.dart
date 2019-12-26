import 'dart:async';
import 'package:baas_study/model/course_info_model.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course/course_info_skeleton.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseInfoDetail extends StatefulWidget {
  final InfoDetailModel infoDetail;
  final bool loadComplete;

  const CourseInfoDetail({
    Key key,
    @required this.infoDetail,
    this.loadComplete = false,
  }) : super(key: key);

  @override
  _CourseInfoDetailState createState() => _CourseInfoDetailState();
}

class _CourseInfoDetailState extends State<CourseInfoDetail>
    with AutomaticKeepAliveClientMixin {
  Timer _timer;
  _CountDownTime _countDownTime = _CountDownTime(0, 0, 0, 0);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SliverToBoxAdapter(
      child: widget.loadComplete
          ? Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.infoDetail.info.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${widget.infoDetail.info.apply}人已报名',
                            style:
                                TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '好评${(widget.infoDetail.info.rate * 100).toDouble().floor()}%',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Offstage(
                            offstage: widget.infoDetail.info.discount != null,
                            child: Text(
                              widget.infoDetail.info.price == 0
                                  ? '免费'
                                  : '￥${widget.infoDetail.info.price}',
                              style: TextStyle(color: Colors.amber),
                            ),
                          )
                        ],
                      ),
                      widget.infoDetail.info.discount != null
                          ? Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffe92758),
                                    Color(0xffff9569)
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      text:
                                          '￥${calculatePrice(widget.infoDetail.info.price, widget.infoDetail.info.discount)} ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        height: 1,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '${widget.infoDetail.info.price}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            height: 1,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '距结束 ${_countDownTime.day} 天' +
                                        ' ${_timeFormat(_countDownTime.hour)} :' +
                                        ' ${_timeFormat(_countDownTime.minute)} :' +
                                        ' ${_timeFormat(_countDownTime.second)}',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Divider(height: 1),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: <Widget>[
                      _textIcon(iconData: Icons.assignment_ind, text: '授课教师'),
                      SizedBox(height: 16),
                      ListTile(
                        leading: ClipOval(
                          child: Image.network(
                            HttpUtil.getImage(
                              widget
                                  .infoDetail.details.userInformation.avatarUrl,
                            ),
                          ),
                        ),
                        title: Text(
                          widget.infoDetail.details.userInformation.nickname,
                        ),
                        contentPadding: EdgeInsets.all(0),
                      ),
                      SizedBox(height: 16),
                      _textIcon(iconData: Icons.widgets, text: '课程详情'),
                      SizedBox(height: 16),
                      Text(widget.infoDetail.details.detail),
                      widget.infoDetail.details.cover != null
                          ? ExtendedImage.network(
                              HttpUtil.getImage(
                                  widget.infoDetail.details.cover),
                              cache: true,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            )
          : CourseInfoDetailSkeleton(),
    );
  }

  Widget _textIcon({String text, IconData iconData}) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          color: Colors.blue,
          size: 32,
        ),
        SizedBox(width: 16),
        Text(text, style: TextStyle(fontSize: 20)),
      ],
    );
  }

  String _timeFormat(int param) {
    return param < 10 ? '0$param' : '$param';
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      DateTime end = DateTime(2020, 1, 1);
      if (now.isBefore(end)) {
        Duration diff = end.difference(now);
        setState(() {
          _countDownTime = _CountDownTime(
            diff.inDays,
            diff.inHours % 24,
            diff.inMinutes % (24 * 60) % 60,
            diff.inSeconds % (24 * 60 * 60) % 60,
          );
        });
      } else {
        setState(() {
          _countDownTime = _CountDownTime(0, 0, 0, 0);
        });
        _timer.cancel();
      }
    });
  }

  String calculatePrice(int price, int discount) {
    return (price * discount / 100).toStringAsFixed(2);
  }
}

class _CountDownTime {
  int day;
  int hour;
  int minute;
  int second;

  _CountDownTime(this.day, this.hour, this.minute, this.second);
}
