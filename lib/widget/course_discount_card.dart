import 'package:flutter/material.dart';

/// 限时抢购课程卡片
class CourseDiscountCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String name;
  final double price;
  final double discount;
  final int applyCount;

  const CourseDiscountCard(
      {Key key,
      @required this.id,
      this.imageUrl =
          'http://47.102.97.205/images/banner/d932a253b1edcb8728f97a71248381b0.jpg',
      this.name = ' (东华大学BaaS区块链实验室)区块链入门课程 ',
      this.price = 1000,
      this.discount = 1,
      this.applyCount = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: EdgeInsets.only(right: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
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
              child: Row(
                children: <Widget>[
                  Text(
                    '￥ $price',
                    style: TextStyle(color: Color(0xffee0a24)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
