import 'package:baas_study/utils/auto_size_utli.dart';
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
      height: AutoSizeUtil.size(90),
      margin: EdgeInsets.only(bottom: AutoSizeUtil.size(16)),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: AutoSizeUtil.size(10)),
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    errorWidget: (context, url, error) => Icon(Icons.image),
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: AutoSizeUtil.font(16),
                        color: Color(0xff333333),
                        height: 1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  child: Text(
                    description,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: AutoSizeUtil.font(14),
                      color: Color(0xff666666),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$applyCount人报名 | 好评${(rate * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: AutoSizeUtil.font(14),
                        color: Color(0xff999999),
                      ),
                    ),
                    Text(
                      price == 0 ? '免费' : '￥$price',
                      style: TextStyle(
                        fontSize: AutoSizeUtil.font(14),
                        color:
                            price == 0 ? Color(0xff07c160) : Color(0xffee0a24),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
