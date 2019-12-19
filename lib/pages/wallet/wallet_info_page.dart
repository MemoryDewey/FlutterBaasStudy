import 'package:baas_study/dao/wallet_dao.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/confirm_dialog.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletInfoPage extends StatefulWidget {
  @override
  _WalletInfoPageState createState() => _WalletInfoPageState();
}

class _WalletInfoPageState extends State<WalletInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '钱包信息',
        tailTitle: '解除绑定',
        tailOnTap: () async{
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => ConfirmDialog(
              title: '解除绑定',
              content: Text('确定要解除BST钱包绑定吗？'),
              confirmPress: () async {
                _unbindWallet();
                Navigator.pop(context, true);
              },
            ),
          );
          //Navigator.pop(context, true);
        },
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: AspectRatio(
          aspectRatio: 0.9,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Consumer<UserProvider>(
              builder: (context, provider, child) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: ExtendedImage.network(
                      HttpUtil.getImage(provider.user.avatarUrl),
                      width: 56,
                      height: 56,
                      cache: true,
                    ),
                  ),
                  Text(provider.user.nickname),
                  QrImage(
                    data: provider.user.bstAddress,
                    version: QrVersions.auto,
                    backgroundColor: Colors.white,
                    size: 170,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      provider.user.bstAddress,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  CupertinoButton(
                    child: Text('点击复制钱包账号'),
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: provider.user.bstAddress),
                      );
                      BotToast.showText(text: '已复制钱包账号');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _unbindWallet() async {
    try {
     await WalletDao.unbindWallet();
    } catch (e) {
      print(e);
    }
  }
}
