import 'package:baas_study/widget/grade_star.dart';
import 'package:flutter/material.dart';

class CourseCommentCard extends StatelessWidget {
  final String name;
  final String avatar;
  final String content;
  final String time;
  final int rate;

  const CourseCommentCard({
    Key key,
    this.name,
    this.avatar,
    this.content,
    this.time,
    this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: ClipOval(
              child: Image.network(avatar),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 140,
                  child: Text(name, overflow: TextOverflow.ellipsis),
                ),
                GradeStar(score: rate.toDouble(), total: 5),
              ],
            ),
            subtitle: Text(time),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(content),
          ),
          Divider(height: 0.1),
        ],
      ),
    );
  }
}
