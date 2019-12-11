import 'package:baas_study/model/course_model.dart';
import 'package:flutter/material.dart';

class SortCondition {
  String name;
  bool isSelected;
  int value;

  SortCondition({this.name, this.isSelected, this.value});
}

class SystemTypeCondition {
  String name;
  int systemId;
  int typeId;

  SystemTypeCondition(this.name, this.systemId, this.typeId);
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

class CourseTypeConditionList extends StatefulWidget {
  final void Function(SystemTypeCondition condition) itemOnTap;
  final List<CourseSystemModel> systemModel;

  const CourseTypeConditionList({
    Key key,
    this.itemOnTap,
    this.systemModel,
  }) : super(key: key);

  @override
  _CourseTypeConditionListState createState() =>
      _CourseTypeConditionListState();
}

class _CourseTypeConditionListState extends State<CourseTypeConditionList> {
  int _selectFirstLevelIndex = 0;
  int _selectSecondLevelIndex = -1;
  int _selectFirstTempIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color firstLevelColor = Theme.of(context).brightness == Brightness.dark
        ? Color(0xff11161a)
        : Color(0xffe1e1e1);
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          child: ListView(
            children: widget.systemModel.map((item) {
              int index = widget.systemModel.indexOf(item);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectFirstLevelIndex = index;
                    if (_selectFirstLevelIndex == 0) {
                      _selectFirstTempIndex = 0;
                      widget.itemOnTap(SystemTypeCondition('全部课程', 0, 0));
                    }
                  });
                },
                child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  color: _selectFirstLevelIndex == index
                      ? Theme.of(context).cardColor
                      : firstLevelColor,
                  child: Text(
                    item.systemName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _selectFirstLevelIndex == index
                          ? Colors.blue
                          : IconTheme.of(context).color,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).cardColor,
                width: 0,
              ),
            ),
            child: _selectFirstLevelIndex == 0
                ? Container()
                : ListView(
                    children: widget
                        .systemModel[_selectFirstLevelIndex].courseTypes
                        .map((item) {
                      int index = widget
                          .systemModel[_selectFirstLevelIndex].courseTypes
                          .indexOf(item);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectSecondLevelIndex = index;
                            _selectFirstTempIndex = _selectFirstLevelIndex;
                            widget.itemOnTap(SystemTypeCondition(
                              item.typeName,
                              widget
                                  .systemModel[_selectFirstLevelIndex].systemID,
                              item.typeID,
                            ));
                          });
                        },
                        child: Container(
                          height: 45,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Text(
                                  item.typeName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: _selectSecondLevelIndex == index &&
                                            _selectFirstLevelIndex ==
                                                _selectFirstTempIndex
                                        ? Colors.blue
                                        : Theme.of(context)
                                            .textTheme
                                            .title
                                            .color,
                                  ),
                                ),
                              ),
                              _selectSecondLevelIndex == index &&
                                      _selectFirstLevelIndex ==
                                          _selectFirstTempIndex
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
                    }).toList(),
                  ),
          ),
        )
      ],
    );
  }
}
