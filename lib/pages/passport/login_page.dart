import 'dart:async';
import 'package:baas_study/dao/passport_dao.dart';
import 'package:baas_study/dao/wallet_dao.dart';
import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/model/passport_model.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/model/wallet_model.dart';
import 'package:baas_study/pages/passport/verify_code_page.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/theme/passport_theme.dart';
import 'package:baas_study/utils/token_util.dart';
import 'package:baas_study/widget/passport/passport_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// 控制表单
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _pswController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _showPsw = false;
  bool _showClear = false;
  Color _textColor;

  /// 使用账号密码登录
  bool _accountLogin = true;

  /// 第二个输入框焦点
  FocusNode _secondFocusNode = FocusNode();
  final RegExp _mobile = RegExp(r'^[1]([3-9])[0-9]{9}$');
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    _userProvider = Provider.of<UserProvider>(context);
    setState(() {
      _textColor = themeData.brightness == Brightness.light
          ? Colors.black87
          : Colors.white;
    });
    PassportTheme pstTheme = PassportTheme(themeData.brightness);
    return Scaffold(
      appBar: _appBar(pstTheme.topColor),
      backgroundColor: pstTheme.backgroundColor,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                PassportTopPanel(color: pstTheme.topColor),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      PassportLogo(),
                      PassportFormContainer(
                        child: Column(
                          children: <Widget>[
                            Text(
                              _accountLogin ? '账号登录' : '短信登录',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 24,
                              ),
                            ),
                            _accountLoginForm,
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: PassportBtn(
                                text: _accountLogin ? '登录' : '发送验证码',
                                onPressed: () {
                                  _accountLogin ? _login() : _sendVerifyCode();
                                },
                              ),
                            ),
                            _bottomText,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 自定义appBar
  Widget _appBar(Color backgroundColor) {
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
        },
      ),
    );
  }

  /// 表单
  Widget get _accountLoginForm {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _accountLogin
                  ? Column(
                      children: <Widget>[
                        _accountInput,
                        SizedBox(height: 10),
                        _pswInput
                      ],
                    )
                  : _phoneInput,
            ),
          ],
        ),
      ),
    );
  }

  /// 账号登录输入框
  Widget get _accountInput {
    return TextFormField(
      controller: _accountController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: TextStyle(textBaseline: TextBaseline.alphabetic),
      maxLength: 50,
      decoration: InputDecoration(
        hintText: '手机号/邮箱',
        counter: Container(),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              /// 保证在组件build的第一帧时才去触发取消清空内容
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _accountController.clear());
              _showClear = false;
            });
          },
          child: Offstage(
            offstage: !_showClear,
            child: Icon(Icons.close),
          ),
        ),
      ),
      onChanged: (text) {
        if (text.length > 0)
          setState(() {
            _showClear = true;
          });
        else
          setState(() {
            _showClear = false;
          });
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_secondFocusNode);
      },
      validator: (value) {
        RegExp mailExp = new RegExp(
          r"(\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14})",
        );
        RegExp phoneExp = new RegExp(
          r"0?(13|14|15|17|18|19)[0-9]{9}",
        );
        bool isValid = mailExp.hasMatch(value) || phoneExp.hasMatch(value);
        return isValid ? null : '请输入正确的账号';
      },
    );
  }

  /// 密码输入框
  Widget get _pswInput {
    return TextFormField(
      controller: _pswController,
      focusNode: _secondFocusNode,
      obscureText: !_showPsw,
      style: TextStyle(textBaseline: TextBaseline.alphabetic),
      keyboardType: TextInputType.visiblePassword,
      maxLength: 16,
      decoration: InputDecoration(
        hintText: '密码',
        counter: Container(),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPsw = !_showPsw;
            });
          },
          child: _showPsw ? Icon(Icons.visibility) : Icon(FontIcons.visibility_off),
        ),
      ),
      validator: (value) {
        return value.isEmpty ? '请输入密码' : null;
      },
      onEditingComplete: _login,
    );
  }

  /// 手机号码输入框
  Widget get _phoneInput {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]"))
      ],
      style: TextStyle(textBaseline: TextBaseline.alphabetic),
      maxLength: 11,
      decoration: InputDecoration(
        hintText: '短信登录仅限中国大陆用户',
        helperText: '*首次登录手机号将在验证后生成新账号',
        counter: SizedBox(),
        prefixIcon: Container(
          height: 20,
          width: 20,
          child: Center(
            child: Text(
              '+86',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20,
                color: _textColor,
              ),
            ),
          ),
        ),
      ),
      validator: (value) {
        return _mobile.hasMatch(value) ? null : '请输入正确的手机号';
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_secondFocusNode);
        _sendVerifyCode();
      },
    );
  }

  /// bottom文字按钮
  Widget get _bottomText {
    return PassportBottomText(
      text: _accountLogin ? '手机短信登录' : '用户名密码登录',
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          _accountLogin = !_accountLogin;
        });
      },
    );
  }

  /// 登录
  Future<Null> _login() async {
    try {
      if (_formKey.currentState.validate()) {
        FocusScope.of(context).requestFocus(FocusNode());
        LoginModel pswLoginModel = await PassportDao.pswLogin(
          account: _accountController.text,
          psw: _pswController.text,
        );
        String token = pswLoginModel.token ?? null;
        TokenUtil.set(token);
        _userProvider.saveUser(pswLoginModel.info);
        WalletModel wallet = await WalletDao.getWalletInfo();
        _userProvider.saveWalletInfo(wallet.balance);
        Navigator.pop(context);
      }
    } catch (e) {}
  }

  /// 发送验证码
  Future<Null> _sendVerifyCode() async {
    try {
      if (_formKey.currentState.validate()) {
        FocusScope.of(context).requestFocus(FocusNode());
        ResponseNormalModel res = await PassportDao.sendShortMsgCode(
          option: 'login',
          phone: _phoneController.text,
        );
        if (res.code == 1000) {
          print(res.msg);
          Navigator.pushReplacement(
              context,
              SlideRoute(
                VerifyCodePage(
                  phone: _phoneController.text,
                ),
              ));
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
