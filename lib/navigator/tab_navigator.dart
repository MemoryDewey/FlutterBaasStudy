import 'package:baas_study/pages/course_list_page.dart';
import 'package:baas_study/pages/home_page.dart';
import 'package:baas_study/pages/profile_page.dart';
import 'package:baas_study/pages/search_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabNavigator extends StatefulWidget {
  final int index;

  const TabNavigator({Key key, this.index = 0}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  DateTime _lastPopTime;

  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: 785.4,
      height: 1635,
    )..init(context);

    /// 设置点击两次退出程序
    return WillPopScope(
      child: Scaffold(
        // 页面
        body: PageView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomePage(), // 首页
            SearchPage(hideLeft: true), //搜索页
            CourseListPage(), // 课程列表页
            ProfilePage(), // 个人信息页
          ],
        ),
        // 底部导航栏
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex ?? widget.index,
          // 点击改变页面
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            // 首页
            _barItem(iconData: Icons.home, text: '首页', index: 0),
            // 搜索页
            _barItem(iconData: Icons.search, text: '找课', index: 1),
            // 课程列表
            _barItem(iconData: Icons.library_books, text: '课程', index: 2),
            // 个人信息
            _barItem(iconData: Icons.account_circle, text: '我的', index: 3),
          ],
        ),
      ),
      onWillPop: () async {
        /// 点击返回键操作
        if (_lastPopTime == null ||
            DateTime.now().difference(_lastPopTime) > Duration(seconds: 2)) {
          _lastPopTime = DateTime.now();
          BotToast.showText(text: '再按一次退出');
          return false;
        }
        return true;
      },
    );
  }

  /// BottomNavigationBarItem设计
  BottomNavigationBarItem _barItem({
    @required IconData iconData,
    @required String text,
    @required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: _defaultColor),
      activeIcon: Icon(iconData, color: _activeColor),
      title: Text(
        text,
        style: TextStyle(
          color: _currentIndex != index ? _defaultColor : _activeColor,
        ),
      ),
    );
  }
}
