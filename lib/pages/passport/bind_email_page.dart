import 'package:baas_study/dao/passport_dao.dart';
import 'package:baas_study/model/passport_model.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/passport/passport_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BindEmailPage extends StatefulWidget {
  @override
  _BindEmailPageState createState() => _BindEmailPageState();
}

class _BindEmailPageState extends State<BindEmailPage> {
  TextEditingController _mailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  FocusNode _secondNode = FocusNode();
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: '绑定邮箱',
        tailTitle: '提交',
        tailOnTap: _bindEmail,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _mailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp('[@.a-zA-Z0-9_-]'),
                )
              ],
              decoration: InputDecoration(
                hintText: '请输入绑定的邮箱号',
                border: InputBorder.none,
                fillColor: Theme.of(context).cardColor,
                filled: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text(
                    '邮箱    ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_secondNode);
              },
            ),
            Divider(height: 0, color: Colors.grey),
            TextFormField(
              controller: _codeController,
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp('[a-zA-Z0-9]'),
                ),
                LengthLimitingTextInputFormatter(6),
              ],
              focusNode: _secondNode,
              decoration: InputDecoration(
                hintText: '请输入邮箱验证码',
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
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: CountDownTimer(
                    onTap: _sendVerifyCode,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _sendVerifyCode() async {
    try {
      await PassportDao.sendMailCode(email: _mailController.text);
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _bindEmail() async {
    try {
      EmailModel res = await PassportDao.bindEmail(
        email: _mailController.text,
        code: _codeController.text,
      );
      if (res != null) {
        BotToast.showText(text: res.msg);
        _userProvider.user.email = res.email;
        _userProvider.saveUser(_userProvider.user);
        FocusScope.of(context).requestFocus();
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }
}
