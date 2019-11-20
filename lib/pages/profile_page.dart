import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/utils/auto_size_utli.dart';
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
          child: Column(
            children: <Widget>[
              _info,
              Divider(
                height: 0,
              ),
              _gradItem,
              Text('222'),
              Text('333'),
              Text('444'),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;

  _size(double size) {
    return AutoSizeUtil.size(size);
  }

  Widget get _appBar {
    return PreferredSize(
      child: AppBar(
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: _size(20)),
            child: Icon(
              FontIcons.moon,
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

  Widget get _info {
    return Container(
      padding: EdgeInsets.only(bottom: _size(20)),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: _size(40),
            child: Icon(Icons.account_circle, size: _size(80)),
          ),
          /*Icon(
            Icons.account_circle,
            size: _size(80),
            color: Color(0x85000000),
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

  Widget get _gradItem {
    return Container(
      height: 80,
      color: Colors.white,
      child: GridView.count(
        crossAxisCount: 3,
        children: <Widget>[Text('aaaa'), Text('bbbb'), Text('cccc')],
      ),
    );
  }
}
