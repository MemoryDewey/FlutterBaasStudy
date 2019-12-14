import 'package:baas_study/dao/passport_dao.dart';
import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/model/profile_model.dart';
import 'package:baas_study/pages/course/user_course_page.dart';
import 'package:baas_study/pages/passport/login_page.dart';
import 'package:baas_study/pages/profile/profile_setting_page.dart';
import 'package:baas_study/pages/profile/qr_code_scan_page.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/providers/dark_mode_provider.dart';
import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/utils/token_util.dart';
import 'package:baas_study/widget/grid_group.dart';
import 'package:baas_study/widget/profile/profile_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  DarkModeProvider _darkModeModel;
  UserProvider _userProvider;
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _darkModeModel = Provider.of<DarkModeProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: _appBar(),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: false,
        header: ClassicHeader(
          idleText: '下拉刷新',
          idleIcon: Icon(Icons.expand_more),
          releaseText: '放开刷新',
          refreshingText: '加载中 •••',
          completeText: '加载完成',
        ),
        child: ListView(
          children: <Widget>[
            Consumer<UserProvider>(
              builder: (context, userInfo, child) => _UserInfo(
                backgroundColor: themeData.appBarTheme.color,
                isLogin: userInfo.hasUser,
                onTap: () {
                  _jumpToLoginOrOther(ProfileSetting());
                },
                nickname: userInfo.user?.nickname,
                avatarUrl: userInfo.hasUser
                    ? HttpUtil.getImage(userInfo.user.avatarUrl)
                    : null,
              ),
            ),
            Divider(height: 0, color: Colors.grey),
            _gridGroup(),
            ProfileStudyList(),
            ProfileBalanceInfo(),
            ProfileAccountInfo(),
          ],
        ),
        onRefresh: _onRefresh,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  /// appBar
  Widget _appBar() => PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
          actions: <Widget>[
            Offstage(
              offstage: _darkModeModel.darkMode == DarkModel.auto,
              child: InkWell(
                  onTap: () {
                    _darkModeModel.changeMode(
                        _darkModeModel.darkMode == DarkModel.on
                            ? DarkModel.off
                            : DarkModel.on);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      _darkModeModel.darkMode == DarkModel.on
                          ? FontIcons.light_mode
                          : FontIcons.dark_mode,
                      size: 22,
                    ),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(SlideTopRoute(QrCodeScanPage()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  FontIcons.scan,
                  size: 22,
                ),
              ),
            )
          ],
        ),
      );

  /// Grid布局导航
  Widget _gridGroup() => GridNav(
        height: 90,
        children: <Widget>[
          GridItem(
            icon: FontIcons.note,
            text: '课程',
            iconColor: Color(0xff3f98eb),
            onTap: () {
              _jumpToLoginOrOther(UserCoursePage());
            },
          ),
          GridItem(
            icon: FontIcons.wallet,
            text: '钱包',
            iconColor: Color(0xffff5a00),
            onTap: () {
              print('钱包');
            },
          ),
          GridItem(
            icon: Icons.favorite,
            text: '收藏',
            iconColor: Color(0xffff2121),
            onTap: () {
              print('收藏');
            },
          )
        ],
      );

  /// 跳转到登录页或其他页
  void _jumpToLoginOrOther(Widget toPage) {
    _userProvider.hasUser
        ? Navigator.push(context, SlideRoute(toPage))
        : Navigator.push(context, SlideTopRoute(LoginPage()));
  }

  void _onRefresh() async {
    await _getInfo();
    _refreshController.refreshCompleted();
  }

  /// 获取个人信息
  Future<Null> _getInfo() async {
    try {
      ProfileModel model = await PassportDao.checkLogin();
      if (model.code != 1000 && _userProvider.hasUser) {
        _userProvider.clearUser();
        TokenUtil.remove();
        HttpUtil.clear();
      } else {
        _userProvider.saveUser(model.info);
      }
    } catch (e) {}
  }
}

class _UserInfo extends StatelessWidget {
  final bool isLogin;
  final Color backgroundColor;
  final String nickname;
  final String avatarUrl;
  final void Function() onTap;

  const _UserInfo({
    Key key,
    @required this.backgroundColor,
    @required this.isLogin,
    this.nickname,
    this.avatarUrl,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        color: backgroundColor,
        child: Row(
          children: <Widget>[
            isLogin
                ? ClipOval(
                    child: ExtendedImage.network(
                      avatarUrl,
                      width: AutoSize.size(64),
                      height: AutoSize.size(64),
                      cache: true,
                    ),
                  )
                : Container(
                    width: AutoSize.size(64),
                    height: AutoSize.size(64),
                    decoration: BoxDecoration(
                      color: Color(0xff999999),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        FontIcons.user,
                        size: AutoSize.size(40),
                        color: Colors.white,
                      ),
                    ),
                  ),
            Expanded(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.only(left: AutoSize.size(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        isLogin ? nickname : '点击登录',
                        style: TextStyle(fontSize: AutoSize.font(24)),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        isLogin ? '点击查看个人主页' : '登录同步数据，学习更安心',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff999999),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
