import 'package:baas_study/widgets/search_bar.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0),
        ),
        body: Column(
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
            Divider(height: 0),
            Container(
              height: 50,
              color: Theme.of(context).cardColor,
              child: GridView.count(
                crossAxisCount: 3,
                children: <Widget>[
                  _dropdownMenu(
                    dropdownValue: '默认排序',
                    dropdownItems: ['默认排序', '好评最高', '人气最高', '价格最高'],
                    onChanged: (String value){
                      print(value);
                    },
                  ),
                  _dropdownMenu(
                    dropdownValue: '全部课程',
                    dropdownItems: ['全部课程', '好评最高', '人气最高', '价格最高'],
                    onChanged: (String value){
                      print(value);
                    },
                  ),
                  _dropdownMenu(
                    dropdownValue: '课程类型',
                    dropdownItems: ['课程类型', '好评最高', '人气最高', '价格最高'],
                    onChanged: (String value){
                      print(value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
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

  _onTextChange(text) {}
}
