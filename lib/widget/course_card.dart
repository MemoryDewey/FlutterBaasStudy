import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CourseCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final num rate;
  final num price;
  final num applyCount;

  const CourseCard({
    Key key,
    @required this.id,
    @required this.imageUrl,
    this.name = '',
    this.description = '',
    this.rate,
    this.price,
    this.applyCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 144,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.image),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Text(
                        name,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff333333)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Text(
                        description,
                        maxLines: 2,
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff666666)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$applyCount人报名 | 好评${(rate * 100).toStringAsFixed(0)}%',
                      style: TextStyle(fontSize: 14, color: Color(0xff999999)),
                    ),
                    Text(
                      '￥$price',
                      style: TextStyle(fontSize: 14, color: Color(0xff999999)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
