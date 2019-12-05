import 'dart:io';
import 'package:baas_study/dao/profile_dao.dart';
import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/model/profile_model.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widgets/border_dialog.dart';
import 'package:baas_study/widgets/custom_app_bar.dart';
import 'package:baas_study/widgets/custom_list_tile.dart';
import 'package:baas_study/widgets/grid_group.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileSetting extends StatefulWidget {
  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  static const Map<String, String> _sexMap = {'M': '男', 'F': '女', 'S': '保密'};
  String _sex;
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
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
                      builder: (dialogContext) {
                        return _SexGrid(sex: _sex);
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
                    ).then((time) {
                      if (time != null) _setBirthday(time);
                    });
                  },
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
          onTab: () async {
            File image =
                await ImagePicker.pickImage(source: ImageSource.camera);
            _cropImage(image);
          },
        ),
        GridItem(
          icon: Icons.photo,
          text: '相册',
          iconColor: Color(0xff8bc24a),
          iconSize: 40,
          onTab: () async {
            File image =
                await ImagePicker.pickImage(source: ImageSource.gallery);
            _cropImage(image);
          },
        ),
        GridItem(
          icon: Icons.account_box,
          text: '默认',
          iconColor: Color(0xff3f98eb),
          iconSize: 40,
          onTab: () {
            _setDefaultAvatar();
          },
        )
      ],
    );
  }

  /// 更换头像为默认头像
  Future<Null> _setDefaultAvatar() async {
    Navigator.of(context).pop();
    try {
      BotToast.showLoading();
      AvatarModel avatarModel = await ProfileDao.setDefaultAvatar();
      if (avatarModel.code == 1000) {
        UserProvider userProvider = Provider.of<UserProvider>(context);
        userProvider.user.avatarUrl = avatarModel.avatarUrl;
        userProvider.saveUser(userProvider.user);
      }
    } catch (e) {}
    BotToast.closeAllLoading();
  }

  /// 裁剪头像并上传
  Future<Null> _cropImage(File file) async {
    File cropFile = await ImageCropper.cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: '裁剪',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
    );
    if (cropFile != null) {
      Navigator.of(context).pop();
      try {
        BotToast.showLoading();
        AvatarModel avatarModel = await ProfileDao.uploadAvatar(cropFile);
        if (avatarModel.code == 1000) {
          _userProvider.user.avatarUrl = avatarModel.avatarUrl;
          _userProvider.saveUser(_userProvider.user);
        }
      } catch (e) {
        //print(e);
      }
      BotToast.closeAllLoading();
    }
  }

  /// 修改生日
  Future<Null> _setBirthday(DateTime dateTime) async {
    try {
      BotToast.showLoading();
      ResponseNormalModel model = await ProfileDao.changeProfile({
        'birthday': dateTime.toIso8601String(),
      });
      if (model.code == 1000) {
        String month = dateTime.month > 9
            ? dateTime.month.toString()
            : '0${dateTime.month}';
        String day =
            dateTime.day > 9 ? dateTime.day.toString() : '0${dateTime.day}';
        _userProvider.user.birthday = '${dateTime.year}-$month-$day';
        _userProvider.saveUser(_userProvider.user);
      }
    } catch (e) {
      //print(e);
    }
    BotToast.closeAllLoading();
  }
}

/// 性别选择Dialog需使用StatefulWidget来改变选择状态
class _SexGrid extends StatefulWidget {
  final String sex;

  const _SexGrid({Key key, this.sex}) : super(key: key);

  @override
  __SexGridState createState() => __SexGridState();
}

class __SexGridState extends State<_SexGrid> {
  String sex;
  UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    sex = widget.sex;
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return BorderDialog(
      title: '性别选择',
      content: GridNav(
        height: 90,
        children: <Widget>[
          GridItem(
            icon: FontIcons.male,
            text: '男',
            iconColor: Color(0xff3f98eb),
            iconSize: 40,
            selected: sex == 'M',
            onTab: () {
              setState(() {
                sex = 'M';
              });
            },
          ),
          GridItem(
            icon: FontIcons.question,
            text: '保密',
            iconColor: Color(0xff8bc24a),
            iconSize: 40,
            selected: sex == 'S',
            onTab: () {
              setState(() {
                sex = 'S';
              });
            },
          ),
          GridItem(
            icon: FontIcons.female,
            text: '女',
            iconColor: Color(0xfffa7298),
            iconSize: 40,
            selected: sex == 'F',
            onTab: () {
              setState(() {
                sex = 'F';
              });
            },
          )
        ],
      ),
      cancel: false,
      confirmPress: () {
        _setSex();
      },
    );
  }

  Future<Null> _setSex() async {
    Navigator.of(context).pop();
    try {
      BotToast.showLoading();
      ResponseNormalModel model = await ProfileDao.changeProfile({'sex': sex});
      if (model.code == 1000) {
        _userProvider.user.sex = sex;
        _userProvider.saveUser(_userProvider.user);
      }
    } catch (e) {
      //print(e);
    }
    BotToast.closeAllLoading();
  }
}
