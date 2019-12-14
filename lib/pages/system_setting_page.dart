import 'package:baas_study/pages/passport/login_page.dart';
import 'package:baas_study/pages/profile/profile_setting_page.dart';
import 'package:baas_study/providers/dark_mode_provider.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/utils/cache_util.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/utils/token_util.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/custom_list_tile.dart';
import 'package:bot_toast/bot_toast.dart';
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
  bool _darkValue;
  String _cacheSize;

  @override
  void initState() {
    super.initState();
    _getCacheSize();
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _darkModeModel = Provider.of<DarkModeProvider>(context);
    _darkValue = _darkModeModel.darkMode == DarkModel.auto;
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
                  onTap: () {
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
                trailingTitle: _cacheSize,
                onTap: _clearCache,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  leading: Text('夜间模式跟随系统'),
                  trailing: CupertinoSwitch(
                    value: _darkValue,
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

  Future<Null> _getCacheSize() async {
    String size = await CacheUtil.loadCache();
    setState(() {
      _cacheSize = size;
    });
  }

  Future<Null> _clearCache() async {
    BotToast.showLoading();
    bool res = await CacheUtil.clearCache();
    BotToast.closeAllLoading();
    BotToast.showText(text: res ? '清理成功' : '清理失败');
    await _getCacheSize();
  }
}
