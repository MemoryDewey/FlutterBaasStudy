import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widgets/course_card.dart';
import 'package:baas_study/widgets/course_condition_list.dart';
import 'package:baas_study/widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  /// 下拉列表相关
  List<String> _dropdownHeaderItems = ['筛选', '综合排序', '全部类型'];
  List<SortCondition> _filterConditions = [];
  List<SortCondition> _sortConditions = [];
  SortCondition _selectFilterCondition;
  SortCondition _selectSortCondition;
  List<CourseSystemModel> _systemModel = [
    CourseSystemModel(systemID: -1, systemName: '全部课程')
  ];
  GZXDropdownMenuController _controller = GZXDropdownMenuController();
  GlobalKey _stackKey = GlobalKey();

  /// 下拉刷新
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  /// 课程
  List<CourseModel> _courses = [];
  int _pageCurrent = 1;
  int _pageSum = 1;
  int _sort = 0;
  int _filter = 0;

  @override
  void initState() {
    super.initState();
    initFilterSort();
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
                  autofocus: false,
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
                color: Theme.of(context).cardColor,
                borderColor: Theme.of(context).cardColor,
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
              Expanded(
                flex: 1,
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropMaterialHeader(),
                  footer: CustomFooter(builder: (context, mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("上拉加载");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("加载失败!点击重试!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("加载更多");
                    } else {
                      body = Text("我也是有底线的");
                    }
                    return Container(
                      height: 40,
                      child: Center(child: body),
                    );
                  }),
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    itemCount: _courses.length,
                    itemBuilder: (context, index) => CourseCard(
                      id: _courses[index].id,
                      imageUrl: HttpUtil.getImage(_courses[index].imageUrl),
                      name: _courses[index].name,
                      description: _courses[index].description,
                      rate: _courses[index].rate,
                      price: _courses[index].price,
                      applyCount: _courses[index].apply,
                    ),
                  ),
                ),
              )
            ],
          ),
          GZXDropDownMenu(
            controller: _controller,
            animationMilliseconds: 250,
            menus: [
              GZXDropdownMenuBuilder(
                dropDownHeight: 40.0 * _filterConditions.length,
                dropDownWidget: CourseConditionList(
                  items: _filterConditions,
                  itemOnTap: (value) {
                    _selectFilterCondition = value;
                    _dropdownHeaderItems[0] = _selectFilterCondition.name;
                    _controller.hide();
                    setState(() {
                      _filter = _selectFilterCondition.value;
                    });
                    _onRefresh();
                  },
                ),
              ),
              GZXDropdownMenuBuilder(
                dropDownHeight: 40.0 * _sortConditions.length,
                dropDownWidget: CourseConditionList(
                  items: _sortConditions,
                  itemOnTap: (value) {
                    _selectSortCondition = value;
                    _dropdownHeaderItems[1] = _selectSortCondition.name;
                    _controller.hide();
                    setState(() {
                      _sort = _selectSortCondition.value;
                    });
                    _onRefresh();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /*Widget _buildSystemTypeWidget(void itemOnTap(String selectValue)) {
    return Container();
  }*/

  /// 初始化 FilterConditions 和 SortConditions
  void initFilterSort() {
    /// 课程类型
    _filterConditions.add(SortCondition(
      name: '筛选',
      isSelected: true,
      value: 0,
    ));
    _filterConditions.add(SortCondition(
      name: '免费课程',
      isSelected: false,
      value: 1,
    ));
    _filterConditions.add(SortCondition(
      name: '付费课程',
      isSelected: false,
      value: 2,
    ));
    _filterConditions.add(SortCondition(
      name: '直播课程',
      isSelected: false,
      value: 3,
    ));
    _filterConditions.add(SortCondition(
      name: '录播课程',
      isSelected: false,
      value: 4,
    ));

    /// 课程排序
    _sortConditions.add(SortCondition(
      name: '综合排序',
      isSelected: true,
      value: 0,
    ));
    _sortConditions.add(SortCondition(
      name: '好评最高',
      isSelected: false,
      value: 1,
    ));
    _sortConditions.add(SortCondition(
      name: '人气最高',
      isSelected: false,
      value: 2,
    ));
    _sortConditions.add(SortCondition(
      name: '价格最高',
      isSelected: false,
      value: 3,
    ));
    _sortConditions.add(SortCondition(
      name: '价格最低',
      isSelected: false,
      value: 4,
    ));
  }

  void _onTextChange(text) {}

  /// 下拉刷新
  void _onRefresh() async {
    int pageSum = await _getPageSum();
    setState(() {
      _pageCurrent = 1;
      _pageSum = pageSum;
    });
    List<CourseModel> course = await _getCourses();
    setState(() {
      _courses = course;
    });
    _refreshController.refreshCompleted();
    _refreshController.resetNoData();
  }

  /// 上拉加载
  void _onLoading() async {
    setState(() {
      _pageCurrent += 1;
    });
    if (_pageCurrent > _pageSum) {
      _refreshController.footerMode.value = LoadStatus.noMore;
    } else {
      List<CourseModel> course = await _getCourses();
      setState(() {
        _courses.addAll(course);
      });
      _refreshController.loadComplete();
    }
  }

  Future<Null> _getSystemType() async {
    try {
      List<CourseSystemModel> model = await CourseDao.getSystemType();
      setState(() {
        _systemModel.addAll(model);
      });
    } catch (e) {}
  }

  /// 获取课程
  Future<List<CourseModel>> _getCourses() async {
    try {
      return await CourseDao.getCourse(data: {
        'page': _pageCurrent,
        'filter': _filter,
        'sort': _sort,
      });
    } catch (e) {
      return [];
    }
  }

  /// 获取下拉加载次数
  Future<int> _getPageSum() async {
    try {
      return await CourseDao.getCoursePage(data: {
        'filter': _filter,
        'sort': _sort,
      });
    } catch (e) {
      return 1;
    }
  }
}
