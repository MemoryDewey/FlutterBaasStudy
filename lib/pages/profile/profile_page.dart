import 'package:baas_study/dao/passport_dao.dart';
import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/model/profile_model.dart';
import 'package:baas_study/pages/login_page.dart';
import 'package:baas_study/pages/profile/profile_setting_page.dart';
import 'package:baas_study/pages/profile/qr_code_scan_page.dart';
import 'package:baas_study/pages/system_setting_page.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/providers/dark_mode_provider.dart';
import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/utils/token_util.dart';
import 'package:baas_study/widgets/custom_list_tile.dart';
import 'package:baas_study/widgets/grid_group.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _darkModeModel = Provider.of<DarkModeProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: _appBar,
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: false,
        header: ClassicHeader(
          idleText: '下拉刷新',
          idleIcon: Icon(Icons.expand_more),
          releaseText: '放开刷新 •••',
          refreshingText: '加载中',
          completeText: '已刷新',
        ),
        child: ListView(
          children: <Widget>[
            Consumer<UserProvider>(
              builder: (context, userInfo, child) => _UserInfo(
                backgroundColor: themeData.appBarTheme.color,
                isLogin: userInfo.hasUser,
                onTab: _jumpToLoginOrInfo,
                nickname: userInfo.user?.nickname,
                avatarUrl: userInfo.hasUser
                    ? HttpUtil.getImage(userInfo.user.avatarUrl)
                    : null,
              ),
            ),
            Divider(height: 0, color: Colors.grey),
            _gridGroup,
            _studyInfoList,
            _balanceInfoList,
            _accountInfoList,
          ],
        ),
        onRefresh: _onRefresh,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  /// appBar
  Widget get _appBar {
    return PreferredSize(
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
  }

  /// Grid布局导航
  Widget get _gridGroup {
    return GridNav(
      height: 90,
      children: <Widget>[
        GridItem(
          icon: FontIcons.note,
          text: '课程',
          iconColor: Color(0xff3f98eb),
          onTab: () {
            print('课程');
          },
        ),
        GridItem(
          icon: FontIcons.wallet,
          text: '钱包',
          iconColor: Color(0xffff5a00),
          onTab: () {
            print('钱包');
          },
        ),
        GridItem(
          icon: Icons.favorite,
          text: '收藏',
          iconColor: Color(0xffff2121),
          onTab: () {
            print('收藏');
          },
        )
      ],
    );
  }

  /// 最近在学 - 我的考试 ListTile
  Widget get _studyInfoList {
    return ListTileGroup(
      top: 20,
      children: <Widget>[
        ListTileCustom(
          leading: FontIcons.time,
          leadingTitle: '最近在学',
          color: Color(0xff3f98eb),
        ),
        ListTileCustom(
          leading: FontIcons.paper,
          leadingTitle: '我的考试',
          color: Color(0xffff2121),
        ),
      ],
    );
  }

  /// 账户余额 ListTile
  Widget get _balanceInfoList {
    return ListTileGroup(
      top: 20,
      bottom: 20,
      children: <Widget>[
        ListTileCustom(
          leading: FontIcons.coin,
          leadingTitle: '账户余额',
          trailingTitle: '10045.6',
          color: Color(0xffffdf0c),
        ),
      ],
    );
  }

  /// 邀请好友 - 反馈建议 - 设置 ListTile
  Widget get _accountInfoList {
    return ListTileGroup(
      children: <Widget>[
        ListTileCustom(
          leading: FontIcons.invite,
          leadingTitle: '邀请好友',
          color: Color(0xffff2121),
        ),
        ListTileCustom(
          leading: FontIcons.feedback,
          leadingTitle: '反馈建议',
          color: Color(0xff00f6d0),
        ),
        ListTileCustom(
          leading: Icons.settings,
          leadingTitle: '系统设置',
          color: Color(0xff3f98eb),
          onTab: () {
            Navigator.push(context, SlideRoute(SystemSettingPage()));
          },
        ),
      ],
    );
  }

  /// 跳转到登录页或个人信息页
  void _jumpToLoginOrInfo() {
    _userProvider.hasUser
        ? Navigator.push(context, SlideRoute(ProfileSetting()))
        : Navigator.push(context, SlideTopRoute(LoginPage()));
    /*Navigator.push(context, route)*/
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
  final void Function() onTab;

  const _UserInfo({
    Key key,
    @required this.backgroundColor,
    @required this.isLogin,
    this.nickname,
    this.avatarUrl,
    @required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        padding: EdgeInsets.all(16),
        color: backgroundColor,
        child: Row(
          children: <Widget>[
            isLogin
                ? ClipOval(
                    child: CachedNetworkImage(
                      width: AutoSize.size(64),
                      height: AutoSize.size(64),
                      imageUrl: avatarUrl,
                      errorWidget: (context, url, error) =>
                          Icon(FontIcons.user),
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
