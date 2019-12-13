import 'package:flutter/material.dart';

class CourseManageCard extends StatelessWidget {
  final String dateTime;
  final String status;
  final String imageUrl;
  final String price;
  final bool isFree;
  final Widget bottom;

  const CourseManageCard({
    Key key,
    this.dateTime,
    this.status,
    @required this.imageUrl,
    this.price,
    this.isFree = true,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 12),
        margin: EdgeInsets.only(bottom: 16),
        color: Theme.of(context).cardColor,
        height: 180,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '2018-11-11 11:11:11',
                  style: TextStyle(
                      color: IconTheme.of(context).color, fontSize: 18),
                ),
                Text(
                  '购买成功',
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: 100,
              child: Row(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '标题标题标题标题标题标题标题标题标题标题标题标题题标题',
                          style: TextStyle(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        price != null
                            ? Text(
                                '免费',
                                style: TextStyle(
                                  color: isFree
                                      ? Color(0xff07c160)
                                      : Color(0xffee0a24),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 0, color: Colors.grey)
          ],
        ));
  }
}
