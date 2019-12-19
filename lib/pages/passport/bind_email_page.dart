import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class BindEmailPage extends StatefulWidget {
  @override
  _BindEmailPageState createState() => _BindEmailPageState();
}

class _BindEmailPageState extends State<BindEmailPage> {
  TextEditingController _mailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '绑定邮箱',
        tailTitle: '提交',
        tailOnTap: (){

        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _mailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: '请输入绑定的邮箱号'
              ),
            ),
            TextFormField(
              controller: _codeController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: '请输入邮箱验证码'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
