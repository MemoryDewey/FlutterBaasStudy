import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widgets/custom_app_bar.dart';
import 'package:baas_study/widgets/custom_list_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSetting extends StatefulWidget {
  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  static const Map<String, String> _sex = {'M': '男', 'F': '女', 'S': '保密'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '个人中心'),
      body: Consumer<UserProvider>(
        builder: (context, userInfo, child) => ListView(
          children: <Widget>[
            ListTileGroup(
              color: Theme.of(context).cardColor,
              top: 15,
              bottom: 15,
              children: <Widget>[
                avatarListTile(
                  avatarUrl: HttpUtil.getImage(userInfo.user.avatarUrl),
                ),
                ListTileCustom(
                  leadingTitle: '昵称',
                  trailingTitle: userInfo.user.nickname,
                ),
                ListTileCustom(
                  leadingTitle: '姓名',
                  trailingTitle: userInfo.user.realName,
                ),
                ListTileCustom(
                  leadingTitle: '性别',
                  trailingTitle: _sex[userInfo.user.sex],
                )
              ],
            ),
            ListTileGroup(
              color: Theme.of(context).cardColor,
              children: <Widget>[
                ListTileCustom(
                  leadingTitle: '手机',
                  trailingTitle: '更换手机',
                ),
                ListTileCustom(
                  leadingTitle: '邮箱',
                  trailingTitle: '去绑定',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget avatarListTile({String avatarUrl, void Function() onTab}) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Text('头像'),
        onTap: onTab,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: CachedNetworkImage(
                width: 56,
                height: 56,
                imageUrl: avatarUrl,
                errorWidget: (context, url, error) => Icon(FontIcons.user),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Color(0xff969799),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
