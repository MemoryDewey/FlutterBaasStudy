import 'package:baas_study/dao/course_dao.dart';
import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course/course_card_skeleton.dart';
import 'package:baas_study/widget/course/course_card.dart';
import 'package:baas_study/widget/course/course_condition_list.dart';
import 'package:baas_study/widget/search_bar.dart';
import 'package:baas_study/widget/skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 课程页
class CourseListPage extends StatefulWidget {
  final bool hideLeft;
  final String keyWord;

  const CourseListPage({
    Key key,
    this.hideLeft,
    this.keyWord = '',
  }) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  /// DropdownMenu下拉列表相关
  List<String> _dropdownHeaderItems = ['全部类型', '综合排序', '筛选'];
  List<CourseSystemModel> _systemModel = [
    CourseSystemModel(systemID: -1, systemName: '全部课程')
  ];
  List<SortCondition> _filterConditions = [];
  List<SortCondition> _sortConditions = [];
  SortCondition _selectFilterCondition;
  SortCondition _selectSortCondition;

  GZXDropdownMenuController _dropdownController = GZXDropdownMenuController();
  GlobalKey _stackKey = GlobalKey();

  /// 下拉刷新
  RefreshController _refreshController = RefreshController();

  /// 课程
  bool _loadComplete = false;
  List<CourseModel> _courses = [];
  int _pageCurrent = 1;
  int _pageSum = 1;
  int _sort = 0;
  int _filter = 0;
  int _systemId = 0;
  int _typeId = 0;
  String _search = '';
  String _courseSearch = '';
  bool _searchResultShow = true;
  int _searchCount = 0;

  @override
  void initState() {
    super.initState();
    _getSystemType();
    setState(() {
      _search = widget.keyWord;
      _searchResultShow = widget.keyWord.isNotEmpty;
    });
    initFilterSort();
    _onRefresh();
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
              /// 搜索框
              SearchBar(
                hideLeft: widget.hideLeft,
                defaultText: widget.keyWord,
                autofocus: false,
                hint: '搜索课程',
                leftButtonClick: () {
                  Navigator.pop(context);
                },
                onSubmitted: _onSearchSubmit,
                onChanged: (text) {
                  setState(() {
                    _courseSearch = text;
                  });
                },
                rightButtonClick: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _onSearchSubmit(_courseSearch);
                },
              ),

              Divider(height: 0.1, color: Colors.grey),

              /// 下拉菜单
              GZXDropDownHeader(
                height: 45,
                color: AppBarTheme.of(context).color,
                borderColor: AppBarTheme.of(context).color,
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
                controller: _dropdownController,
                stackKey: _stackKey,
              ),

              /// 搜索结果（共找到多少门课）
              Offstage(
                offstage: !_searchResultShow,
                child: Container(
                  height: 45,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xff1d212a)
                      : Color(0xffecf9ff),
                  child: Center(
                    child: Text(
                      '共找到$_searchCount门"$_search"相关课程',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),

              /// 课程列表
              Expanded(
                flex: 1,
                child: _loadComplete
                    ? SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        header: BezierCircleHeader(
                          bezierColor: Theme.of(context).cardColor,
                          circleColor: Theme.of(context).primaryColor,
                        ),
                        footer: CustomFooter(builder: (context, mode) {
                          Widget body;
                          Widget getText(String text) =>
                              Text(text, style: TextStyle(color: Colors.grey));
                          if (mode == LoadStatus.idle) {
                            body = getText('上拉加载');
                          } else if (mode == LoadStatus.loading) {
                            body = CupertinoActivityIndicator();
                          } else if (mode == LoadStatus.failed) {
                            body = getText('加载失败!点击重试!');
                          } else if (mode == LoadStatus.canLoading) {
                            body = getText('加载更多');
                          } else {
                            body = getText('-- 我也是有底线的 --');
                          }
                          return Container(
                            height: 40,
                            child: Center(child: body),
                          );
                        }),
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: _courses.length,
                          itemBuilder: (context, index) => CourseCard(
                            id: _courses[index].id,
                            imageUrl:
                                HttpUtil.getImage(_courses[index].imageUrl),
                            name: _courses[index].name,
                            description: _courses[index].description,
                            rate: _courses[index].rate,
                            price: _courses[index].price,
                            applyCount: _courses[index].apply,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(8),
                        child: SkeletonList(
                          builder: (context, index) => CourseCardSkeletonItem(),
                        ),
                      ),
              )
            ],
          ),

          /// 下拉菜单列表
          GZXDropDownMenu(
            controller: _dropdownController,
            animationMilliseconds: 250,
            menus: [
              GZXDropdownMenuBuilder(
                dropDownHeight: 45.0 * _systemModel.length,
                dropDownWidget: CourseTypeConditionList(
                  systemModel: _systemModel,
                  itemOnTap: (value) {
                    setState(() {
                      _dropdownHeaderItems[0] = value.name;
                      _systemId = value.systemId;
                      _typeId = value.typeId;
                    });
                    _dropdownController.hide();
                    _onRefresh();
                  },
                ),
              ),
              GZXDropdownMenuBuilder(
                dropDownHeight: 45.0 * _sortConditions.length,
                dropDownWidget: CourseConditionList(
                  items: _sortConditions,
                  itemOnTap: (value) {
                    _selectSortCondition = value;
                    _dropdownHeaderItems[1] = _selectSortCondition.name;
                    _dropdownController.hide();
                    setState(() {
                      _sort = _selectSortCondition.value;
                    });
                    _onRefresh();
                  },
                ),
              ),
              GZXDropdownMenuBuilder(
                dropDownHeight: 45.0 * _filterConditions.length,
                dropDownWidget: CourseConditionList(
                  items: _filterConditions,
                  itemOnTap: (value) {
                    _selectFilterCondition = value;
                    _dropdownHeaderItems[2] = _selectFilterCondition.name;
                    _dropdownController.hide();
                    setState(() {
                      _filter = _selectFilterCondition.value;
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

  void _onSearchSubmit(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _search = text;
        _searchResultShow = true;
      });
      _onRefresh();
    }
  }

  /// 下拉刷新
  void _onRefresh() async {
    setState(() {
      _pageCurrent = 1;
    });
    List<CourseModel> course = await _getCourses();
    CoursePageModel coursePage = await _getPage();
    setState(() {
      _pageSum = coursePage.page;
      _searchCount = coursePage.count;
      _courses = course;
      _loadComplete = true;
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

  /// 获取课程
  Future<List<CourseModel>> _getCourses() async {
    try {
      Map<String, dynamic> data = {
        'page': _pageCurrent,
        'filter': _filter,
        'sort': _sort,
      };
      if (_search.isNotEmpty) data['search'] = _search;
      if (_systemId != 0) data['system'] = _systemId;
      if (_typeId != 0) data['type'] = _typeId;
      return await CourseDao.getCourse(data: data);
    } catch (e) {
      return [];
    }
  }

  /// 获取下拉加载次数
  Future<CoursePageModel> _getPage() async {
    try {
      Map<String, dynamic> data = {
        'filter': _filter,
        'sort': _sort,
      };
      if (_search.isNotEmpty) data['search'] = _search;
      if (_systemId != 0) data['system'] = _systemId;
      if (_typeId != 0) data['type'] = _typeId;
      return await CourseDao.getCoursePage(data: data);
    } catch (e) {
      return CoursePageModel(page: 0, count: 0);
    }
  }

  /// 获取所有课程体系及类别
  Future<Null> _getSystemType() async {
    try {
      List<CourseSystemModel> model = await CourseDao.getSystemType();
      setState(() {
        _systemModel.addAll(model);
      });
    } catch (e) {}
  }
}
