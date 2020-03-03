import 'package:baas_study/dao/passport_dao.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/passport/change_phone_widget.dart';
import 'package:baas_study/widget/passport/passport_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChangePhoneStepTwoPage extends StatefulWidget {
  @override
  _ChangePhoneStepTwoPageState createState() => _ChangePhoneStepTwoPageState();
}

class _ChangePhoneStepTwoPageState extends State<ChangePhoneStepTwoPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  FocusNode _secondNode = FocusNode();
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: '更换绑定手机'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ChangePhoneIconWidget(),
          Text(
            '请输入您需要绑定的新手机号码',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              WhitelistingTextInputFormatter(
                RegExp('[0-9]'),
              )
            ],
            decoration: InputDecoration(
              hintText: '请输入新手机号',
              border: InputBorder.none,
              fillColor: Theme.of(context).cardColor,
              filled: true,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  '手机号',
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
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter(
                RegExp('[0-9]'),
              ),
              LengthLimitingTextInputFormatter(6),
            ],
            focusNode: _secondNode,
            decoration: InputDecoration(
              hintText: '请输入手机验证码',
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
                child: CountDownTimer(onTap: _sendMsgCode),
              ),
            ),
            onEditingComplete: _changeMobile,
          ),
          SizedBox(height: 20),
          ChangePhoneNextButton(
            onPressed: _changeMobile,
          )
        ],
      ),
    );
  }

  Future<Null> _sendMsgCode() async {
    try {
      ResponseNormalModel res = await PassportDao.sendShortMsgCode(
        phone: _phoneController.text,
        option: 'change',
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
        data: {
          "account": _phoneController.text,
          "verify": _codeController.text,
        },
        step: 1,
      );
      if (res != null) {
        _userProvider.user.mobile = res;
        _userProvider.saveUser(_userProvider.user);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }
}
