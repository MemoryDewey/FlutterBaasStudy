import 'package:flutter/material.dart';

class GradeStar extends StatelessWidget {
  final double score;
  final int total;

  const GradeStar({Key key, @required this.score, @required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: _getGradeStar(score, total));
  }

  List<Widget> _getGradeStar(double score, int total) {
    List<Widget> _list = List<Widget>();
    for (int i = 0; i < total; i++) {
      double factor = (score - i);
      if (factor >= 1)
        factor = 1.0;
      else if (factor < 0) factor = 0;
      Stack stack = Stack(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.topLeft,
              widthFactor: factor,
              child: Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
          )
        ],
      );
      _list.add(stack);
    }
    return _list;
  }
}
