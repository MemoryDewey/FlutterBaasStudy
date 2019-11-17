import 'package:baas_study/dao/banner_dao.dart';
import 'package:baas_study/dao/home_course_dao.dart';
import 'package:baas_study/widget/course_discount_card.dart';
import 'package:baas_study/widget/home_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _listBannerUrl = [];
  double appBarAlpha = 0;

  // 滚动事件触发
  // 改变AppBar透明度
  _onScroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0)
      alpha = 0;
    else if (alpha > 1) alpha = 1;
    setState(() {
      appBarAlpha = alpha;
    });
  }

  // 加载banner
  _loadBanner() {
    BannerDao.fetch().then((result) {
      result.banners.forEach((item) {
        setState(() {
          _listBannerUrl.add('http://47.102.97.205${item.image}');
        });
      });
    });
  }

  // 加载课程
  _loadCourse() {
    HomeCourseDao.fetch().then((result) {
      result.discount.forEach((item){
        print(item.courseName);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadBanner();
    _loadCourse();
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
                return null;
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
                  // 首页课程内容
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: Container(
                      height: 800,
                      child: ListView(
                        children: <Widget>[
                          // 标题
                          HomeTitleWidget(
                            text: '限时优惠',
                            icon: Icons.access_time,
                            colors: Color(0xffff976a),
                          ),
                          // 限时抢购课程
                          Container(
                            height: 220,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                CourseDiscountCard(id: 1),
                                CourseDiscountCard(id: 1),
                                CourseDiscountCard(id: 1),
                                CourseDiscountCard(id: 1),
                                CourseDiscountCard(id: 1)
                              ],
                            ),
                          ),
                          HomeTitleWidget(
                            text: '最新课程',
                            icon: Icons.fiber_new,
                            colors: Color(0xff07c160),
                          ),
                          HomeTitleWidget(
                            text: '热门课程',
                            icon: Icons.whatshot,
                            colors: Color(0xffee0a24),
                          ),
                        ],
                      ),
                    ),
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
