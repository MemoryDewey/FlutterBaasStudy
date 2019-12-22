import 'package:baas_study/dao/passport_dao.dart';
import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/passport/change_phone_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _controller = TextEditingController();
  bool _showPsw = false;
  int _pswLen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '修改密码'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ChangePhoneIconWidget(),
          Text(
            '请输入新密码',
            style: TextStyle(fontSize: 16),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_showPsw,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp('[a-zA-Z0-9!#\$%&\'*+/=?^_`{|}~,.;":]'),
                ),
                LengthLimitingTextInputFormatter(16),
              ],
              decoration: InputDecoration(
                hintText: '请输入新密码(8-16位)',
                border: InputBorder.none,
                fillColor: Theme.of(context).cardColor,
                filled: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text(
                    '密码',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPsw = !_showPsw;
                    });
                  },
                  child: _showPsw
                      ? Icon(Icons.visibility)
                      : Icon(FontIcons.visibility_off),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _pswLen = value.length;
                });
              },
            ),
          ),
          ChangePhoneNextButton(
            onPressed: _pswLen < 8 ? null : _changePsw,
          )
        ],
      ),
    );
  }

  Future<Null> _changePsw() async {
    try {
      String res = await PassportDao.changePsw(
        data: {"password": _controller.text},
        step: 1,
      );
      if (res != null) {
        BotToast.showText(text: res);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }
}
