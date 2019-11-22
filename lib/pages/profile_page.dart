import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/model/dark_mode_model.dart';
import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:baas_study/widget/list_tail_custom.dart';
import 'package:baas_study/widget/list_tile_group.dart';
import 'package:flutter/cupertino.dart';
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
  DarkModeModel _darkModeModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _darkModeModel = Provider.of<DarkModeModel>(context);
    ThemeData themeData = Theme.of(context);
    _cardColor = themeData.cardColor;
    _appBarColor = themeData.appBarTheme.color;

    return Scaffold(
        appBar: _appBar,
        body: Container(
          child: ListView(
            children: <Widget>[
              _info,
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
    return AutoSizeUtil.size(size);
  }

  _font(double fonSize) {
    return AutoSizeUtil.font(fonSize);
  }

  /// appBar
  Widget get _appBar {
    return PreferredSize(
      preferredSize: Size.fromHeight(_size(45)),
      child: AppBar(
        elevation: 0,
        actions: <Widget>[
          Offstage(
            offstage: _darkModeModel.darkMode == 2,
            child: Padding(
              padding: EdgeInsets.only(right: _size(16)),
              child: GestureDetector(
                onTap: () {
                  _darkModeModel
                      .changeMode(_darkModeModel.darkMode == 1 ? 0 : 1);
                },
                child: Icon(
                  _darkModeModel.darkMode == 1
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

  /// 头像信息
  Widget get _info {
    return Container(
      padding: EdgeInsets.only(bottom: _size(16), left: _size(16)),
      color: _appBarColor,
      child: Row(
        children: <Widget>[
          /// 未登录时占位组件
          Container(
            width: _size(64),
            height: _size(64),
            decoration: BoxDecoration(
              color: Color(0xff999999),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                FontIcons.user,
                size: _size(40),
                color: Colors.white,
              ),
            ),
          ),

          /// 成功登录后的头像
          /*CircleAvatar(
            radius: _size(32),
            child: Container(

            ),
          ),*/
          Container(
            padding: EdgeInsets.only(left: _size(20)),
            constraints: BoxConstraints(maxWidth: _size(270)),
            child: Text(
              '登录 / 注册',
              style: TextStyle(fontSize: AutoSizeUtil.font(25)),
              overflow: TextOverflow.ellipsis,
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
              Text('-----------------最近在学课程（未实现）---------------------'),
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
            _darkModeModel.changeMode(_darkModeModel.darkMode == 2 ? 0 : 2);
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
}
