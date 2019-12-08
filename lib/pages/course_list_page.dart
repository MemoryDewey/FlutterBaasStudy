import 'package:baas_study/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';

class SortCondition {
  String name;
  bool isSelected;

  SortCondition({this.name, this.isSelected});
}

class CourseListPage extends StatefulWidget {
  final bool hideLeft;
  final String keyWord;

  const CourseListPage({
    Key key,
    this.hideLeft,
    this.keyWord,
  }) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  List<String> _dropdownHeaderItems = ['课程类型', '默认排序', '全部分类'];
  List<SortCondition> _filterConditions = [];
  List<SortCondition> _sortConditions = [];
  SortCondition _selectFilterCondition;
  SortCondition _selectSortCondition;
  GZXDropdownMenuController _controller = GZXDropdownMenuController();
  GlobalKey _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    /// 课程类型
    _filterConditions.add(SortCondition(name: '课程类型', isSelected: true));
    _filterConditions.add(SortCondition(name: '免费课程', isSelected: false));
    _filterConditions.add(SortCondition(name: '付费课程', isSelected: false));
    _filterConditions.add(SortCondition(name: '直播课程', isSelected: false));
    _filterConditions.add(SortCondition(name: '录播课程', isSelected: false));

    /// 课程排序
    _sortConditions.add(SortCondition(name: '默认排序',isSelected: true));
    _sortConditions.add(SortCondition(name: '好评最高',isSelected: false));
    _sortConditions.add(SortCondition(name: '人气最高',isSelected: false));
    _sortConditions.add(SortCondition(name: '价格最高',isSelected: false));
    _sortConditions.add(SortCondition(name: '价格最低',isSelected: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(elevation: 0),
        preferredSize: Size.fromHeight(0),
      ),
      body: Stack(
        key: _stackKey,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x66000000), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SearchBar(
                  hideLeft: widget.hideLeft,
                  defaultText: widget.keyWord,
                  hint: '搜索课程',
                  leftButtonClick: () {
                    Navigator.pop(context);
                  },
                  onChanged: _onTextChange,
                ),
              ),
              Divider(height: 0, color: Colors.grey),
              GZXDropDownHeader(
                height: 45,
                style: TextStyle(color: Color(0xff666666), fontSize: 16),
                dropDownStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
                items: [
                  GZXDropDownHeaderItem(_dropdownHeaderItems[0]),
                  GZXDropDownHeaderItem(_dropdownHeaderItems[1]),
                  GZXDropDownHeaderItem(_dropdownHeaderItems[2]),
                ],
                controller: _controller,
                stackKey: _stackKey,
              ),
            ],
          ),
          GZXDropDownMenu(
            controller: _controller,
            animationMilliseconds: 250,
            menus: [
              GZXDropdownMenuBuilder(
                dropDownHeight: 40.0 * _filterConditions.length,
                dropDownWidget:
                    _buildConditionListWidget(_filterConditions, (value) {
                  _selectFilterCondition = value;
                  _dropdownHeaderItems[0] = _selectFilterCondition.name;
                  _controller.hide();
                  setState(() {});
                }),
              ),
              GZXDropdownMenuBuilder(
                dropDownHeight: 40.0 * _sortConditions.length,
                dropDownWidget:
                _buildConditionListWidget(_sortConditions, (value) {
                  _selectSortCondition = value;
                  _dropdownHeaderItems[1] = _selectSortCondition.name;
                  _controller.hide();
                  setState(() {});
                }),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _dropdownMenu({
    @required String dropdownValue,
    @required List<String> dropdownItems,
    @required void Function(String) onChanged,
  }) {
    return Align(
      alignment: Alignment.topCenter,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        underline: Container(),
        items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildConditionListWidget(
      items, void itemOnTap(SortCondition sortCondition)) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0),
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
//            color: Colors.blue,
            height: 40,
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
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                ),
                goodsSortCondition.isSelected
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
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

  _onTextChange(text) {}
}
