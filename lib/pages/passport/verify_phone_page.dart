import 'package:baas_study/dao/passport_dao.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/pages/passport/change_password_page.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/passport/change_phone_widget.dart';
import 'package:baas_study/pages/passport/change_phone_step_two_page.dart';
import 'package:baas_study/widget/passport/passport_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VerifyPhonePage extends StatefulWidget {
  final String title;
  final String option;

  const VerifyPhonePage({Key key, this.title, this.option}) : super(key: key);

  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ChangePhoneIconWidget(),
          Text(
            '为了您的账户安全，需要验证您的手机',
            style: TextStyle(fontSize: 16),
          ),
          Consumer<UserProvider>(
            builder: (context, provider, child) => Text(
              provider.user.mobile,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp('[0-9]'),
                ),
                LengthLimitingTextInputFormatter(6),
              ],
              decoration: InputDecoration(
                hintText: '请输入验证码',
                border: InputBorder.none,
                fillColor: Theme.of(context).cardColor,
                filled: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text(
                    '验证码',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.grey)),
                  ),
                  child: CountDownTimer(
                    onTap: _sendMsgCode,
                  ),
                ),
              ),
            ),
          ),
          ChangePhoneNextButton(
            onPressed: widget.option == 'change' ? _changeMobile : _resetPsw,
          ),
        ],
      ),
    );
  }

  Future<Null> _sendMsgCode() async {
    try {
      ResponseNormalModel res = await PassportDao.sendShortMsgCode(
        option: widget.option,
      );
      if (res.code == 1000) {
        print(res.msg);
        BotToast.showText(text: res.msg);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _changeMobile() async {
    try {
      String res = await PassportDao.changeMobile(
        data: {"verify": _controller.text},
        step: 0,
      );
      if (res != null)
        Navigator.pushReplacement(
          context,
          SlideRoute(
            ChangePhoneStepTwoPage(),
          ),
        );
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _resetPsw() async {
    try {
      String res = await PassportDao.changePsw(
        data: {"verify": _controller.text},
        step: 0,
      );
      if (res != null)
        Navigator.pushReplacement(
          context,
          SlideRoute(
            ChangePasswordPage(),
          ),
        );
    } catch (e) {
      print(e);
    }
  }
}
