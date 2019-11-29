import 'package:baas_study/dao/profile_dao.dart';
import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/model/profile_model.dart';
import 'package:baas_study/pages/passport_page.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/providers/dark_mode_provider.dart';
import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widgets/list_tail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  Color _cardColor;
  Color _appBarColor;
  DarkModeProvider _darkModeModel;
  bool _isLogin = false;

  @override
  void initState() {
    _getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _darkModeModel = Provider.of<DarkModeProvider>(context);
    ThemeData themeData = Theme.of(context);
    _cardColor = themeData.cardColor;
    _appBarColor = themeData.appBarTheme.color;
    return Scaffold(
        appBar: _appBar,
        body: Container(
          child: ListView(
            children: <Widget>[
              Consumer<UserProvider>(
                builder: (context, userInfo, child) => _UserInfo(
                  backgroundColor: _appBarColor,
                  isLogin: userInfo.hasUser,
                  onTab: _jumpToLogin,
                  nickname: userInfo.user?.nickname,
                  avatarUrl:
                      '${HttpUtil.URL_PREFIX}${userInfo.user?.avatarUrl}',
                ),
              ),
              Divider(height: 0),
              _gradGroup,
              _studyInfoList,
              _balanceInfoList,
              _accountInfoList,
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;

  _size(double size) {
    return AutoSize.size(size);
  }

  _font(double fonSize) {
    return AutoSize.font(fonSize);
  }

  /// appBar
  Widget get _appBar {
    return PreferredSize(
      preferredSize: Size.fromHeight(_size(45)),
      child: AppBar(
        elevation: 0,
        actions: <Widget>[
          Offstage(
            offstage: _darkModeModel.darkMode == DarkModel.auto,
            child: Padding(
              padding: EdgeInsets.only(right: _size(16)),
              child: GestureDetector(
                onTap: () {
                  _darkModeModel.changeMode(
                      _darkModeModel.darkMode == DarkModel.on
                          ? DarkModel.off
                          : DarkModel.on);
                },
                child: Icon(
                  _darkModeModel.darkMode == DarkModel.on
                      ? FontIcons.light_mode
                      : FontIcons.dark_mode,
                  size: _size(22),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: _size(16)),
            child: Icon(
              FontIcons.scan,
              size: _size(22),
            ),
          )
        ],
      ),
    );
  }

  /// Grad布局导航
  Widget get _gradGroup {
    return Container(
      height: _size(90),
      color: _cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _gradItem(
            icon: FontIcons.note,
            text: '课程',
            color: Color(0xff3f98eb),
          ),
          _gradItem(
            icon: FontIcons.wallet,
            text: '钱包',
            color: Color(0xffff5a00),
          ),
          _gradItem(
            icon: Icons.favorite,
            text: '收藏',
            color: Color(0xffff2121),
          )
        ],
      ),
    );
  }

  /// 最近在学 - 我的考试 ListTile
  Widget get _studyInfoList {
    return ListTileGroup(
      color: _cardColor,
      top: _size(10),
      children: <Widget>[
        ListTileCustom(
          leading: FontIcons.time,
          leadingTitle: '最近在学',
          color: Color(0xff3f98eb),
        ),
        Container(
          height: _size(75),
          padding: EdgeInsets.symmetric(horizontal: _size(16)),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Text(
                  '-------------------------最近在学课程（未实现）-------------------------'),
            ],
          ),
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
      color: _cardColor,
      top: _size(10),
      bottom: _size(10),
      children: <Widget>[
        ListTileCustom(
          leading: FontIcons.coin,
          leadingTitle: '账户余额',
          color: Color(0xffffdf0c),
        ),
      ],
    );
  }

  /// 邀请好友 - 反馈建议 - 设置 ListTile
  Widget get _accountInfoList {
    return ListTileGroup(
      color: _cardColor,
      children: <Widget>[
        ListTileCustom(
          leading: FontIcons.invite,
          leadingTitle: '邀请好友',
          color: Color(0xffff2121),
        ),
        Divider(height: 0, indent: _size(16)),
        ListTileCustom(
            leading: FontIcons.feedback,
            leadingTitle: '反馈建议',
            color: Color(0xff00f6d0)),
        Divider(height: 0, indent: _size(16)),
        GestureDetector(
          onTap: () {
            _darkModeModel.changeMode(_darkModeModel.darkMode == DarkModel.auto
                ? DarkModel.off
                : DarkModel.auto);
          },
          child: ListTileCustom(
            leading: Icons.settings,
            leadingTitle: '系统设置',
            color: Color(0xff3f98eb),
          ),
        )
      ],
    );
  }

  /// GradItem
  _gradItem({IconData icon, String text, Color color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: _size(32),
          color: color,
        ),
        Container(
          margin: EdgeInsets.only(top: _size(5)),
          child: Text(text, style: TextStyle(fontSize: _font(14))),
        )
      ],
    );
  }

  /// 跳转到登录页
  _jumpToLogin() {
    Navigator.push(context, SlideRoute(LoginPage()));
  }

  /// 获取个人信息
  Future<Null> _getInfo() async {
    try {
      ProfileModel model = await ProfileDao.checkLogin();
      setState(() {
        _isLogin = model.code == 1000;
      });
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
        padding: EdgeInsets.only(
          bottom: AutoSize.size(16),
          left: AutoSize.size(16),
        ),
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
