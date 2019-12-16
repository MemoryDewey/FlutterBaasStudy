import 'dart:ui';
import 'package:baas_study/dao/banner_dao.dart';
import 'package:baas_study/dao/home_course_dao.dart';
import 'package:baas_study/model/banner_model.dart';
import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/model/home_course_model.dart';
import 'package:baas_study/pages/search_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/home/home_widget.dart';
import 'package:baas_study/widget/loading_container.dart';
import 'package:baas_study/widget/search_bar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '区块链 以太坊 智能合约';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<Banners> _listBanner = [];
  List<CourseModel> _listDiscount = [];
  List<CourseModel> _listNewest = [];
  List<CourseModel> _listRecommend = [];
  double _appBarAlpha = 0;
  bool _loading = true;
  static num _paddingTop = MediaQueryData.fromWindow(window).padding.top;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeData themeData = Theme.of(context);
    bool isDark = themeData.brightness == Brightness.dark;
    Color appBarColor = themeData.appBarTheme.color;
    //print(MediaQuery.of(context).size);
    /// 使用AnnotatedRegion来控制AppBar状态栏颜色
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _getAppBarBrightness(isDark),
      child: Scaffold(
        /// 使用Stack布局固定AppBar位置 - 数组index越大在越上面层
        body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
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
                      _onScroll(scrollNotification.metrics.pixels, isDark);
                    }
                    return null;
                  },
                  child: ListView(
                    children: <Widget>[
                      /// Banner轮播图
                      _banner(),
                      SizedBox(height: 10),

                      /// 限时抢购课程
                      _course(
                        text: '限时优惠',
                        icon: Icons.access_time,
                        color: Color(0xffff976a),
                        course: HomeCourseWidget.rowCard(_listDiscount),
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),

                      /// 最新课程
                      _course(
                        text: '最新课程',
                        icon: Icons.fiber_new,
                        color: Color(0xff07c160),
                        course: HomeCourseWidget.columnCard(_listNewest),
                      ),

                      /// 热门课程
                      _course(
                        text: '热门课程',
                        icon: Icons.whatshot,
                        color: Color(0xffee0a24),
                        course: HomeCourseWidget.columnCard(_listRecommend),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              /// 自定义AppBar
              _appBar(appBarColor, isDark),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  /// 滚动事件 - 改变AppBar透明度
  _onScroll(double offset, bool isDark) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0)
      alpha = 0;
    else if (alpha > 1) alpha = 1;
    setState(() {
      _appBarAlpha = alpha;
    });
  }

  /// 跳转到搜索页
  _jumpToSearch() async {
    await Navigator.push(
      context,
      SlideRoute(SearchPage(hint: SEARCH_BAR_DEFAULT_TEXT)),
    );
  }

  /// 获取AppBar图标主题（Dark / Light）
  SystemUiOverlayStyle _getAppBarBrightness(bool isDark) {
    if (isDark) return SystemUiOverlayStyle.light;
    return _appBarAlpha > 0.2
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;
  }

  /// 刷新
  Future<Null> _handleRefresh() async {
    try {
      BannerModel bannerModel = await BannerDao.fetch();
      HomeCourseModel courseModel = await HomeCourseDao.fetch();
      setState(() {
        _listBanner = bannerModel.banners;
        _listDiscount = courseModel.discount;
        _listNewest = courseModel.newest;
        _listRecommend = courseModel.recommend;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  /// appbar
  Widget _appBar(Color appBarColor, bool isDark) => Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              /// appBar渐变背景
              gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(top: _paddingTop),
              decoration: BoxDecoration(
                color: Color.fromARGB(
                  (_appBarAlpha * 255).toInt(),
                  appBarColor.red,
                  appBarColor.green,
                  appBarColor.blue,
                ),
              ),
              child: SearchBar(
                searchBarType: _appBarAlpha > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
                defaultText: SEARCH_BAR_DEFAULT_TEXT,
                inputBoxClick: _jumpToSearch,
                leftButtonClick: _jumpToSearch,
              ),
            ),
          ),
          Container(
            height: _appBarAlpha > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.white12 : Colors.black12,
                  blurRadius: 0.5,
                )
              ],
            ),
          ),
        ],
      );

  /// Banner轮播图
  Widget _banner() => Container(
        height: 225,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Swiper(
            itemCount: _listBanner.length,
            autoplay: true,
            itemBuilder: (BuildContext context, index) {
              return ExtendedImage.network(
                HttpUtil.getImage(_listBanner[index].image),
                cache: true,
                fit: BoxFit.cover,
                loadStateChanged: (ExtendedImageState state) {
                  if (state.extendedImageLoadState == LoadState.loading) {
                    return Image.asset(
                      'assets/images/loading.gif',
                      fit: BoxFit.cover,
                    );
                  }
                  if (state.extendedImageLoadState == LoadState.failed)
                    return null;
                  return ExtendedRawImage(
                    image: state.extendedImageInfo?.image,
                    fit: BoxFit.cover,
                  );
                },
              );
            },
            pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
              activeColor: Colors.blue,
              size: 8,
              activeSize: 8,
            )),
          ),
        ),
      );

  /// 课程
  Widget _course({
    String text,
    IconData icon,
    Color color,
    Widget course,
    EdgeInsetsGeometry padding: const EdgeInsets.all(10),
  }) =>
      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white70
            : Colors.grey[800],
        child: Column(
          children: <Widget>[
            HomeTitleWidget(
              text: text,
              icon: icon,
              colors: color,
            ),
            Divider(height: 0, color: Colors.grey),
            Padding(
              padding: padding,
              child: course,
            )
          ],
        ),
      );
}
