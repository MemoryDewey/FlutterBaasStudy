import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_model.dart';
import 'package:flutter/material.dart';

class SortCondition {
  String name;
  bool isSelected;
  int value;

  SortCondition({this.name, this.isSelected, this.value});
}

class CourseConditionList extends StatelessWidget {
  final List<SortCondition> items;
  final void Function(SortCondition sortCondition) itemOnTap;

  const CourseConditionList({
    Key key,
    this.items,
    this.itemOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0, color: Colors.grey),
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        SortCondition goodsSortCondition = items[index];
        return GestureDetector(
          onTap: () {
            for (var value in items) {
              value.isSelected = false;
            }
            goodsSortCondition.isSelected = true;

            itemOnTap(goodsSortCondition);
          },
          child: Container(
            color: Theme.of(context).cardColor,
            height: 45,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    goodsSortCondition.name,
                    style: TextStyle(
                      color: goodsSortCondition.isSelected
                          ? Colors.blue
                          : Theme.of(context).textTheme.title.color,
                    ),
                  ),
                ),
                goodsSortCondition.isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.blue,
                        size: 16,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CourseTypeConditionList extends StatelessWidget {
  final void Function(String selectValue) itemOnTap;
  static List<CourseSystemModel> _systemModel = [
    CourseSystemModel(systemID: -1, systemName: '全部课程')
  ];

  const CourseTypeConditionList({Key key, this.itemOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getSystemType();
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          child: ListView(
            children: _systemModel.map((item){
              //int index = _systemModel.indexOf(item);
              return Container(
                height: 45,
                alignment: Alignment.center,
                child: Text(item.systemName),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Future<Null> _getSystemType() async {
    try {
      List<CourseSystemModel> model = await CourseDao.getSystemType();
      _systemModel.addAll(model);
    } catch (e) {}
  }
}
