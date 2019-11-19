import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 限时抢购课程卡片
class CourseDiscountCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String name;
  final int price;
  final double discount;
  final int applyCount;

  const CourseDiscountCard({
    Key key,
    @required this.id,
    @required this.imageUrl,
    this.name,
    this.price,
    this.discount,
    this.applyCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AutoSizeUtil.size(170),
      margin: EdgeInsets.only(right: AutoSizeUtil.size(10)),
      child: Card(
        elevation: AutoSizeUtil.size(2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AutoSizeUtil.size(5))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                errorWidget: (context, url, error) => Icon(Icons.image),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AutoSizeUtil.size(10)),
              child: Text(
                name,
                style: TextStyle(fontSize: AutoSizeUtil.font(16)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AutoSizeUtil.size(10),
                0,
                AutoSizeUtil.size(10),
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '￥ $price',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xff7d7e80),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '￥ ${(price * discount).toStringAsFixed(2)}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Color(0xffee0a24)),
                      ),
                    ],
                  ),
                  Text(
                    '$applyCount 人已抢',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xff7d7e80)),
                  ),
                  MaterialButton(
                    color: Color(0xffff976a),
                    textColor: Colors.white,
                    minWidth: AutoSizeUtil.size(150),
                    onPressed: () {
                      print('course:$id');
                    },
                    child: Text('马上抢购'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
