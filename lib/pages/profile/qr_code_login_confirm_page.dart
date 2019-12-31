import 'package:baas_study/dao/passport_dao.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QrCodeLoginConfirmPage extends StatefulWidget {
  final String uuid;

  const QrCodeLoginConfirmPage({
    Key key,
    @required this.uuid,
  }) : super(key: key);

  @override
  _QrCodeLoginConfirmPageState createState() => _QrCodeLoginConfirmPageState();
}

class _QrCodeLoginConfirmPageState extends State<QrCodeLoginConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '扫码登录'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/qr_code_login.png',
            width: 200,
            fit: BoxFit.contain,
          ),
          Text('正在尝试电脑浏览器登录'),
          Text('请确认是否本人操作'),
          SizedBox(width: double.infinity, height: 20),
          CupertinoButton(
            child: Text('确认登录'),
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 0,horizontal: 80),
            onPressed: () {
              _qrCodeLogin(widget.uuid);
            },
          ),
          SizedBox(height: 20),
          GestureDetector(
            child: Text('取消'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future<Null> _qrCodeLogin(String uuid) async {
    try {
      await PassportDao.qrCodeLogin(uuid);
      Navigator.pop(context);
    } catch (e) {
      print('QrCodeLoginError:$e');
    }
  }
}
