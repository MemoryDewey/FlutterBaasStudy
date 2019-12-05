import 'package:baas_study/pages/profile/profile_setting.dart';
import 'package:baas_study/providers/dark_mode_provider.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/utils/token_util.dart';
import 'package:baas_study/widgets/custom_app_bar.dart';
import 'package:baas_study/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemSettingPage extends StatefulWidget {
  @override
  _SystemSettingPageState createState() => _SystemSettingPageState();
}

class _SystemSettingPageState extends State<SystemSettingPage> {
  UserProvider _userProvider;
  DarkModeProvider _darkModeModel;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _darkModeModel = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: '设置'),
      body: ListView(
        children: <Widget>[
          ListTileGroup(
            top: 15,
            bottom: 15,
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
          ListTileGroup(
            bottom: 15,
            children: <Widget>[
              ListTileCustom(
                leadingTitle: '清除缓存',
                trailingTitle: '20MB',
              ),
              ListTileCustom(
                leadingTitle: '夜间模式',
                onTab: (){
                  _darkModeModel.changeMode(
                    _darkModeModel.darkMode == DarkModel.auto
                        ? DarkModel.off
                        : DarkModel.auto,
                  );
                },
              ),
            ],
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text(
                '退出登录',
                textAlign: TextAlign.center,
              ),
              onTap: (){
                _userProvider.clearUser();
                TokenUtil.remove();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
