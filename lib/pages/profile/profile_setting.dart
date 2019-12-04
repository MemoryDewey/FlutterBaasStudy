import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widgets/border_dialog.dart';
import 'package:baas_study/widgets/custom_app_bar.dart';
import 'package:baas_study/widgets/custom_list_tile.dart';
import 'package:baas_study/widgets/grid_group.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSetting extends StatefulWidget {
  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  static const Map<String, String> _sexMap = {'M': '男', 'F': '女', 'S': '保密'};
  String _sex;

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
                _avatarListTile(
                    avatarUrl: HttpUtil.getImage(userInfo.user.avatarUrl),
                    onTab: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext dialogContext) {
                          return BorderDialog(
                            title: '头像选择',
                            content: _avatarGrid,
                          );
                        },
                      );
                    }),
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
                  trailingTitle: _sexMap[userInfo.user.sex],
                  onTab: () {
                    setState(() {
                      _sex = userInfo.user.sex;
                    });
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext dialogContext) {
                        return BorderDialog(
                          title: '性别选择',
                          content: _sexGrid,
                          cancel: false,
                          confirmPress: () {},
                        );
                      },
                    );
                  },
                ),
                ListTileCustom(
                  leadingTitle: '生日',
                  trailingTitle: userInfo.user.birthday,
                  onTab: () {
                    DateTime birthday = userInfo.user.birthday == null
                        ? DateTime.now()
                        : DateTime.parse(userInfo.user.birthday);
                    showDatePicker(
                      context: context,
                      initialDate: birthday,
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                  },
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

  /// 头像 ListTile
  Widget _avatarListTile({String avatarUrl, void Function() onTab}) {
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

  /// 头像 DialogGrid
  Widget get _avatarGrid {
    return GridNav(
      height: 90,
      children: <Widget>[
        GridItem(
          icon: Icons.camera_alt,
          text: '拍照',
          iconColor: Color(0xfffa7298),
          iconSize: 40,
          onTab: () {},
        ),
        GridItem(
          icon: Icons.photo,
          text: '相册',
          iconColor: Color(0xff8bc24a),
          iconSize: 40,
          onTab: () {},
        ),
        GridItem(
          icon: Icons.account_box,
          text: '默认',
          iconColor: Color(0xff3f98eb),
          iconSize: 40,
          onTab: () {},
        )
      ],
    );
  }

  /// 性别 DialogGrid
  Widget get _sexGrid {
    return GridNav(
      height: 90,
      children: <Widget>[
        GridItem(
          icon: FontIcons.male,
          text: '男',
          iconColor: Color(0xff3f98eb),
          iconSize: 40,
          selected: _sex == 'M',
          onTab: () {
            setState(() {
              _sex = 'M';
            });
          },
        ),
        GridItem(
          icon: FontIcons.question,
          text: '保密',
          iconColor: Color(0xff8bc24a),
          iconSize: 40,
          selected: _sex == 'S',
          onTab: () {
            setState(() {
              _sex = 'S';
            });
          },
        ),
        GridItem(
          icon: FontIcons.female,
          text: '女',
          iconColor: Color(0xfffa7298),
          iconSize: 40,
          selected: _sex == 'F',
          onTab: () {
            setState(() {
              _sex = 'F';
            });
            print(_sex);
          },
        )
      ],
    );
  }
}
