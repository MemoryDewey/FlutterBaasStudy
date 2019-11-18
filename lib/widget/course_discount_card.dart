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

  const CourseDiscountCard(
      {Key key,
      @required this.id,
      @required this.imageUrl,
      this.name = '课程',
      this.price = 313,
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
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    minWidth: 150,
                    onPressed: (){
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
