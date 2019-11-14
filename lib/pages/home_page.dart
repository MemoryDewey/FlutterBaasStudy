import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listBannerUrl = [
    'http://47.102.97.205/images/course-cover/9bc1873da8cdaab9a72f0d5fc6fb242a.jpg',
    'http://47.102.97.205/images/course-cover/6fac3bea49ac0bb07af8cc2f95c49cd1.jpg',
    'http://47.102.97.205/images/banner/9ecc3b5d322fc7bb81c740aff510d1cc.jpeg'
  ];
  double appBarAlpha = 0;

  // 滚动事件触发
  // 改变AppBar透明度
  void _onScroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0)
      alpha = 0;
    else if (alpha > 1) alpha = 1;
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用Stack布局固定AppBar位置
      // 数组index越大在越上面层
      body: Stack(
        children: <Widget>[
          // 移除顶部区域padding
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              // 监听滚动事件
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollNotification &&
                    scrollNotification.depth == 0) {
                  // 滚动且是列表滚动的时候
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  // Banner轮播图
                  Container(
                    height: 210,
                    child: Swiper(
                      itemCount: _listBannerUrl.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, index) {
                        return Image.network(
                          _listBannerUrl[index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Container(
                    height: 800,
                    child: Text('test'),
                  )
                ],
              ),
            ),
          ),
          // 自定义AppBar
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
