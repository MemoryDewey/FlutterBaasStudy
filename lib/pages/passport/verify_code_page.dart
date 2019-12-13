import 'package:baas_study/dao/passport_dao.dart';
import 'package:baas_study/model/passport_model.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/utils/token_util.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/passport/passport_widget.dart';
import 'package:baas_study/widget/passport/verify_code_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyCodePage extends StatefulWidget {
  final String phone;

  const VerifyCodePage({Key key, this.phone = ''}) : super(key: key);

  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    String showPhone = widget.phone.substring(0, 3) +
        ' ' +
        widget.phone.substring(3, 7) +
        ' ' +
        widget.phone.substring(7, 11);
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: '短信验证码'),
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(height: 0, color: Colors.grey),
          Container(
            padding: EdgeInsets.all(28),
            child: Text(
              '输入短信验证码',
              style: TextStyle(fontSize: 36),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 28),
            child: Text(
              '短信验证码已发送至$showPhone',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ),

          /// 验证码输入框
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            child: VerificationCodeInput(
              codeLength: 6,
              textSize: 40,
              letterSpace: 30,
              inputBorder: CustomUnderlineInputBorder(
                textLength: 6,
                letterSpace: 30,
                textSize: 40,
                borderSide: BorderSide(color: Colors.black26, width: 2),
              ),
              onEditComplete: (code) async {
                bool isRightCode = await verifyCodeLogin(code);
                if (isRightCode) Navigator.pop(context);
                return isRightCode;
              },
            ),
          ),

          /// 倒计时重新发送
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: CountDownTimer(
              autoStart: true,
              onTap: _sendVerifyCode
            ),
          )
        ],
      ),
    );
  }

  /// 验证码登录
  Future<bool> verifyCodeLogin(String code) async {
    try {
      LoginModel model = await PassportDao.verifyCodeLogin(
        phone: widget.phone,
        code: code,
      );
      String token = model.token ?? null;
      TokenUtil.set(token);
      _userProvider.saveUser(model.info);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 发送验证码
  Future<Null> _sendVerifyCode() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      ResponseNormalModel res = await PassportDao.sendShortMsgCode(
        option: 'login',
        phone: widget.phone,
      );
      if (res.code == 1000) {
        print(res.msg);
      }
    } catch (e) {
      print(e);
    }
  }
}
