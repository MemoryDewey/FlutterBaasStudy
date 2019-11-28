import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'course_card.dart';

class HomeCourseWidget {
  /// 横排
  Widget rowCard(List<CourseModel> course) {
    return Container(
      height: AutoSize.size(240),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: course.length,
        itemBuilder: (BuildContext context, int index) => CourseDiscountCard(
          id: course[index].id,
          imageUrl: '${HttpUtil.URL_PREFIX}${course[index].imageUrl}',
          name: course[index].name,
          price: course[index].price,
          discount: course[index].discount / 100,
          applyCount: course[index].apply,
        ),
      ),
    );
  }

  /// 竖排
  Widget columnCard(List<CourseModel> course) {
    List<Widget> result = [];
    course.forEach((item) {
      result.add(
        CourseCard(
          id: item.id,
          imageUrl: '${HttpUtil.URL_PREFIX}${item.imageUrl}',
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
    return Container(
      margin: EdgeInsets.fromLTRB(0, AutoSize.size(10), 0, AutoSize.size(10)),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: AutoSize.size(25),
            color: colors,
          ),
          Padding(
            padding: EdgeInsets.only(left: AutoSize.size(10)),
            child: Text(
              text,
              style: TextStyle(
                color: colors,
                fontSize: AutoSize.font(20),
              ),
            ),
          )
        ],
      ),
    );
  }
}