import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'course_card.dart';
import 'course_discount_card.dart';

class HomeCourseWidget {
  /// 横排
  Widget rowCard(List<CourseModel> course) {
    return Container(
      height: AutoSizeUtil.size(240),
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
