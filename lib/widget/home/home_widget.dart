import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:flutter/material.dart';
import '../course/course_card.dart';

class HomeCourseWidget {
  /// 横排
  static Widget rowCard(List<CourseModel> course) {
    return Container(
      height: 265,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: course.length,
        itemBuilder: (BuildContext context, int index) => CourseDiscountCard(
          id: course[index].id,
          imageUrl: HttpUtil.getImage(course[index].imageUrl),
          name: course[index].name,
          price: course[index].price,
          discount: course[index].discount / 100,
          applyCount: course[index].apply,
        ),
      ),
    );
  }

  /// 竖排
  static Widget columnCard(List<CourseModel> course) {
    List<Widget> result = [];
    course.forEach((item) {
      result.add(
        CourseCard(
          id: item.id,
          imageUrl: HttpUtil.getImage(item.imageUrl),
          name: item.name,
          description: item.description,
          price: item.price,
          applyCount: item.apply,
          rate: item.rate,
        ),
      );
    });
    return Column(
      children: result,
    );
  }
}

class HomeTitleWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color colors;

  const HomeTitleWidget({Key key, this.text, this.icon, this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 21,
            color: colors,
          ),
        ),
        Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
