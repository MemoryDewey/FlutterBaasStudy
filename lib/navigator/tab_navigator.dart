import 'package:baas_study/pages/course_list_page.dart';
import 'package:baas_study/pages/home_page.dart';
import 'package:baas_study/pages/profile_page.dart';
import 'package:baas_study/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  Brightness homeBrightness = Brightness.light;

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: 785.4,
      height: 1635,
    )..init(context);
    /*print(MediaQuery.of(context).size);*/
    return Scaffold(
      // 页面
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(), // 首页
          SearchPage(), //搜索页
          CourseListPage(), // 课程列表页
          ProfilePage(), // 个人信息页
        ],
      ),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // 点击改变页面
        onTap: (index) {
          _setHomeBrightness(index);
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          // 首页
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _defaultColor),
            activeIcon: Icon(Icons.home, color: _activeColor),
            title: Text(
              '首页',
              style: TextStyle(
                color: _currentIndex != 0 ? _defaultColor : _activeColor,
              ),
            ),
          ),
          // 搜索页
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _defaultColor),
            activeIcon: Icon(Icons.search, color: _activeColor),
            title: Text(
              '搜索',
              style: TextStyle(
                color: _currentIndex != 1 ? _defaultColor : _activeColor,
              ),
            ),
          ),
          // 课程列表
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books, color: _defaultColor),
            activeIcon: Icon(Icons.library_books, color: _activeColor),
            title: Text(
              '课程',
              style: TextStyle(
                color: _currentIndex != 2 ? _defaultColor : _activeColor,
              ),
            ),
          ),
          // 个人信息
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _defaultColor),
            activeIcon: Icon(Icons.account_circle, color: _activeColor),
            title: Text(
              '我的',
              style: TextStyle(
                color: _currentIndex != 3 ? _defaultColor : _activeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 切换至首页时需要根据情况改变statusBar颜色
  _setHomeBrightness(index) {
    if (index == 0) {
      if (HomePage.getBarLight()) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      }
    }
  }
}
