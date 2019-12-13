import 'package:baas_study/pages/course/course_info_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 课程卡片
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
    return GestureDetector(
      onTap: (){
        Navigator.push(context, SlideRoute(CourseInfoPage()));
      },
      child: Container(
        height: 90,
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
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
                      style: TextStyle(fontSize: 16, height: 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    child: Text(
                      description,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
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
                          fontSize: 14,
                          color: Color(0xff999999),
                        ),
                      ),
                      Text(
                        price == 0 ? '免费' : '￥$price',
                        style: TextStyle(
                          fontSize: 14,
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
      ),
    );
  }
}

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
      width: 170,
      margin: EdgeInsets.only(right: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    errorWidget: (context, url, error) => Icon(Icons.image),
                    fit: BoxFit.cover,
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                name,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '￥$price',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xff7d7e80),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffee0a24))),
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        child: Text(
                          '限时抢购',
                          style: TextStyle(color: Color(0xffee0a24)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '￥${(price * discount).toStringAsFixed(2)}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Color(0xffee0a24)),
                      ),
                      Text(
                        '$applyCount 人已抢',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Color(0xff7d7e80)),
                      ),
                    ],
                  ),
                  MaterialButton(
                    color: Color(0xffff976a),
                    textColor: Colors.white,
                    minWidth: 150,
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
