import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:baas_study/widget/list_tile_group.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print('I have been created!');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: _appBar,
        backgroundColor: Color(0xfff2f2f6),
        body: Container(
          child: ListView(
            children: <Widget>[
              _info,
              Divider(height: 0),
              _gradGroup,
              ListTileGroup(
                color: Colors.white,
                top: _size(10),
                children: <Widget>[
                  Text('222'),
                ],
              ),
              ListTileGroup(
                color: Colors.white,
                top: _size(10),
                bottom: _size(10),
                children: <Widget>[
                  Text('333'),
                  Text('333'),
                  Text('333'),
                ],
              ),
              ListTileGroup(
                color: Colors.white,
                children: <Widget>[
                  Text('444'),
                  Text('444'),
                ],
              ),
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
      child: AppBar(
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: _size(20)),
            child: Icon(
              FontIcons.dark_mode,
              size: _size(22),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: _size(20)),
            child: Icon(
              FontIcons.scan,
              size: _size(22),
            ),
          )
        ],
      ),
      preferredSize: Size.fromHeight(_size(45)),
    );
  }

  /// 头像信息
  Widget get _info {
    return Container(
      padding: EdgeInsets.only(bottom: _size(20), left: _size(20)),
      color: Colors.white,
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
      color: Colors.white,
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

  /// GradItem
  Widget _gradItem({IconData icon, String text, Color color}) {
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
