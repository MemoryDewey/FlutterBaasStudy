import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:baas_study/dao/invite_dao.dart';
import 'package:baas_study/model/invite_model.dart';
import 'package:baas_study/pages/invite/invite_intro_page.dart';
import 'package:baas_study/pages/invite/invite_list_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvitePage extends StatefulWidget {
  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  String _inviteCode = '';
  String _inviteUrl = '';
  GlobalKey _screenShotKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getInviteCode();

    /// 询问保存文件权限
    PermissionHandler().requestPermissions(<PermissionGroup>[
      PermissionGroup.storage,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '邀请好友',
        tailIcon: Icon(Icons.help, color: Colors.blue),
        tailOnTap: () {
          Navigator.push(context, SlideRoute(InviteIntroPage()));
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/invite_image.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// 标题
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '邀请好友领福利',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// 邀请码信息
            Container(
              width: AutoSize.size(320),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '您的邀请码为',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// 邀请码
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: GestureDetector(
                          onLongPress: () {
                            Clipboard.setData(ClipboardData(text: _inviteUrl));
                            BotToast.showText(text: '已复制邀请链接');
                          },
                          child: Text(
                            _inviteCode,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1,
                              color: Color(0xffee0a24),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '长按邀请码复制邀请链接',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: AutoSize.font(18),
                          height: 1,
                        ),
                      ),
                      Divider(height: 30, color: Colors.grey),

                      /// 二维码邀请码
                      GestureDetector(
                        onLongPress: () {
                          _saveQrCode();
                        },
                        child: Container(
                          height: AutoSize.size(160),
                          width: AutoSize.size(160),
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.5),
                          ),
                          child: RepaintBoundary(
                            key: _screenShotKey,
                            child: QrImage(
                              data: _inviteUrl,
                              version: QrVersions.auto,
                              backgroundColor: Colors.white,
                              size: AutoSize.size(130),
                              embeddedImage:
                                  AssetImage('assets/images/app_logo.png'),
                              embeddedImageStyle: QrEmbeddedImageStyle(
                                size:
                                    Size(AutoSize.size(30), AutoSize.size(30)),
                              ),
                              errorStateBuilder: (context, err) => Container(
                                child: Center(
                                  child: Text(
                                    '二维码生成出错了！',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '长按图片即可保存个人专属二维码',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: AutoSize.font(18),
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// 查看邀请记录
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, SlideRoute(InviteListPage()));
                },
                child: Text(
                  '查看邀请记录',
                  style: TextStyle(fontSize: 21, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _getInviteCode() async {
    try {
      InviteCodeModel inviteInfo = await InviteDao.getInviteCode();
      setState(() {
        _inviteCode = inviteInfo.inviteCode;
        _inviteUrl = inviteInfo.inviteUrl;
      });
    } catch (e) {
      print(e);
    }
  }

  /// 保存二维码
  Future<Null> _saveQrCode() async {
    try {
      RenderRepaintBoundary boundary =
          _screenShotKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      BotToast.showText(text: '已保存二维码！');
    } catch (e) {
      print(e);
      BotToast.showText(text: '保存二位码失败！');
    }
  }
}
