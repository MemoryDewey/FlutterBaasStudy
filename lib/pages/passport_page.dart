import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _pswController = TextEditingController();
  bool _showPsw = false;
  bool _showClear = false;
  FocusNode _secondFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color fontColor = themeData.brightness == Brightness.light
        ? Colors.black87
        : Colors.white;
    return Scaffold(
      appBar: _appBar(fontColor),
      backgroundColor: themeData.appBarTheme.color,
      body: Padding(
        padding: EdgeInsets.only(
          left: _size(16),
          right: _size(16),
        ),
        child: Column(
          children: <Widget>[
            Text(
              '账号登录',
              style: TextStyle(
                color: fontColor,
                fontSize: AutoSize.font(24),
              ),
            ),
            _accountLoginForm,
            Padding(
              padding: EdgeInsets.only(
                left: _size(20),
                right: _size(20),
                bottom: _size(10),
              ),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: null,
                  child: Text('登录'),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('手机短信登录'),
                  Text('忘记密码'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _appBar(fontColor) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: _size(16)),
          child: Center(
            child: Text(
              '注册',
              style: TextStyle(
                color: fontColor,
                fontSize: AutoSize.font(16),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget get _accountLoginForm {
    return Padding(
      padding: EdgeInsets.all(_size(20)),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _accountController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '手机号/邮箱',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          /// 保证在组件build的第一帧时才去触发取消清空内容
                          WidgetsBinding.instance.addPostFrameCallback(
                                  (_) => _accountController.clear());
                          _onChange('');
                        });
                      },
                      child: Offstage(
                        offstage: !_showClear,
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  onChanged: _onChange,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_secondFocusNode);
                  },
                ),
                TextFormField(
                  controller: _pswController,
                  focusNode: _secondFocusNode,
                  obscureText: !_showPsw,
                  decoration: InputDecoration(
                    hintText: '密码',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPsw = !_showPsw;
                        });
                      },
                      child: _showPsw
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _size(double size) {
    return AutoSize.size(size);
  }

  _onChange(String text) {
    if (text.length > 0)
      setState(() {
        _showClear = true;
      });
    else
      setState(() {
        _showClear = false;
      });
  }
}
