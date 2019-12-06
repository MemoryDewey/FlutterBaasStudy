import 'package:baas_study/pages/login_page.dart';
import 'package:baas_study/pages/profile/profile_setting_page.dart';
import 'package:baas_study/providers/dark_mode_provider.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/utils/token_util.dart';
import 'package:baas_study/widgets/custom_app_bar.dart';
import 'package:baas_study/widgets/custom_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemSettingPage extends StatefulWidget {
  @override
  _SystemSettingPageState createState() => _SystemSettingPageState();
}

class _SystemSettingPageState extends State<SystemSettingPage> {
  UserProvider _userProvider;
  DarkModeProvider _darkModeModel;
  bool darkValue;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _darkModeModel = Provider.of<DarkModeProvider>(context);
    darkValue = _darkModeModel.darkMode == DarkModel.auto;
    return Scaffold(
      appBar: CustomAppBar(title: '设置'),
      body: ListView(
        children: <Widget>[
          Offstage(
            offstage: !_userProvider.hasUser,
            child: ListTileGroup(
              top: 15,
              children: <Widget>[
                ListTileCustom(
                  leadingTitle: '账号资料',
                  onTab: () {
                    Navigator.push(context, SlideRoute(ProfileSetting()));
                  },
                ),
                ListTileCustom(
                  leadingTitle: '手机',
                  trailingTitle: '更换手机',
                ),
                ListTileCustom(
                  leadingTitle: '邮箱',
                  trailingTitle: '去绑定',
                ),
                ListTileCustom(
                  leadingTitle: '修改账户密码',
                ),
              ],
            ),
          ),
          ListTileGroup(
            top: 15,
            bottom: 15,
            children: <Widget>[
              ListTileCustom(
                leadingTitle: '清除缓存',
                trailingTitle: '20MB',
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  leading: Text('夜间模式跟随系统'),
                  trailing: CupertinoSwitch(
                    value: darkValue,
                    activeColor: Colors.lightBlue,
                    onChanged: (value) {
                      changeDarkMode();
                    },
                  ),
                  onTap: changeDarkMode,
                ),
              ),
            ],
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text(
                _userProvider.hasUser ? '退出登录' : '登录',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                if (_userProvider.hasUser) {
                  _userProvider.clearUser();
                  TokenUtil.remove();
                  HttpUtil.clear();
                  Navigator.pop(context);
                } else
                  Navigator.push(context, SlideTopRoute(LoginPage()));
              },
            ),
          ),
        ],
      ),
    );
  }

  void changeDarkMode() {
    /// 夜间模式是否跟随系统
    bool auto = _darkModeModel.darkMode == DarkModel.auto;
    _darkModeModel.changeMode(auto ? DarkModel.off : DarkModel.auto);
  }
}
