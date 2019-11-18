import 'package:baas_study/dao/banner_dao.dart';
import 'package:baas_study/dao/home_course_dao.dart';
import 'package:baas_study/model/banner_model.dart';
import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/course_card.dart';
import 'package:baas_study/widget/course_discount_card.dart';
import 'package:baas_study/widget/home_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<Banners> _listBanner = [];
  List<CourseModel> _listDiscountCourse = [];
  List<CourseModel> _listNewestCourse = [];
  List<CourseModel> _listRecommendCourse = [];
  double appBarAlpha = 0;

  @override
  void initState() {
    super.initState();
    _loadBanner();
    _loadCourse();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    EdgeInsetsGeometry padding = EdgeInsets.fromLTRB(16, 10, 16, 10);
    return Scaffold(
      /// 使用Stack布局固定AppBar位置
      /// 数组index越大在越上面层
      body: Stack(
        children: <Widget>[
          /// 移除顶部区域padding
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              /// 监听滚动事件
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollNotification &&
                    scrollNotification.depth == 0) {
                  /// 滚动且是列表滚动的时候
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return null;
              },
              child: ListView(
                children: <Widget>[
                  /// Banner轮播图
                  _banner,

                  /// 限时抢购课程
                  Padding(
                    padding: padding,
                    child: Column(
                      children: <Widget>[
                        HomeTitleWidget(
                          text: '限时优惠',
                          icon: Icons.access_time,
                          colors: Color(0xffff976a),
                        ),
                        _discountCourse,
                      ],
                    ),
                  ),

                  /// 最新课程
                  Padding(
                    padding: padding,
                    child: Column(
                      children: <Widget>[
                        /// 最新课程
                        HomeTitleWidget(
                          text: '最新课程',
                          icon: Icons.fiber_new,
                          colors: Color(0xff07c160),
                        ),
                        _newestCourse,
                      ],
                    ),
                  ),

                  /// 热门课程
                  Padding(
                    padding: padding,
                    child: Column(
                      children: <Widget>[
                        HomeTitleWidget(
                          text: '热门课程',
                          icon: Icons.whatshot,
                          colors: Color(0xffee0a24),
                        ),
                        _recommendCourse,
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          /// 自定义AppBar
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

  @override
  bool get wantKeepAlive => true;

  /// 滚动事件触发
  /// 改变AppBar透明度
  _onScroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0)
      alpha = 0;
    else if (alpha > 1) alpha = 1;
    setState(() {
      appBarAlpha = alpha;
    });
  }

  /// 加载banner
  _loadBanner() {
    BannerDao.fetch().then((result) {
      setState(() {
        _listBanner = result.banners;
      });
    });
  }

  /// Banner轮播图
  Widget get _banner {
    return Container(
      height: 210,
      child: Swiper(
        itemCount: _listBanner.length,
        autoplay: true,
        itemBuilder: (BuildContext context, index) {
          return Image.network(
            '${HttpUtil.URL_PREFIX}${_listBanner[index].image}',
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  /// 加载课程
  _loadCourse() {
    HomeCourseDao.fetch().then((result) {
      _listDiscountCourse = result.discount;
      _listNewestCourse = result.newest;
      _listRecommendCourse = result.recommend;
    });
  }

  /// 限时抢购课程
  Widget get _discountCourse {
    List<Widget> courseDiscountCardList = [];
    _listDiscountCourse.forEach((item) {
      courseDiscountCardList.add(CourseDiscountCard(
        id: item.id,
        imageUrl: '${HttpUtil.URL_PREFIX}${item.imageUrl}',
        name: item.name,
        price: item.price,
        discount: item.discount / 100,
        applyCount: item.apply,
      ));
    });
    return Container(
      height: 240,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: courseDiscountCardList,
      ),
    );
  }

  /// 最新课程
  Widget get _newestCourse {
    List<Widget> courseNewestCardList = [];
    _listNewestCourse.forEach((item) {
      courseNewestCardList.add(
        CourseCard(
          id: item.id,
          imageUrl: '${HttpUtil.URL_PREFIX}${item.imageUrl}',
          name: item.name,
          description: item.description,
          price: item.price,
          applyCount: item.apply,
          rate: item.rate,
        ),
      );
    });
    return Column(children: courseNewestCardList);
  }

  /// 热门课程
  Widget get _recommendCourse {
    List<Widget> courseRecommendCardList = [];
    _listRecommendCourse.forEach((item) {
      courseRecommendCardList.add(
        CourseCard(
          id: item.id,
          imageUrl: '${HttpUtil.URL_PREFIX}${item.imageUrl}',
          name: item.name,
          description: item.description,
          price: item.price,
          applyCount: item.apply,
          rate: item.rate,
        ),
      );
    });
    return Column(children: courseRecommendCardList);
  }
}
