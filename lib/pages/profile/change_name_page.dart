import 'package:baas_study/dao/profile_dao.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNamePage extends StatefulWidget {
  final bool isNickname;

  const ChangeNamePage({Key key, @required this.isNickname}) : super(key: key);

  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  final TextEditingController _controller = TextEditingController();
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isNickname ? '修改昵称' : '修改姓名',
        tailTitle: '保存',
        tailOnTap: () {
          _saveName(widget.isNickname);
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TextField(
                controller: _controller,
                maxLength: 15,
                decoration: InputDecoration(
                  hintText: '请输入新${widget.isNickname ? '昵称' : '姓名'}',
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                size: 16,
              ),
              onPressed: () {
                WidgetsBinding.instance
                    .addPostFrameCallback((callback) => _controller.clear());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _saveName(bool isNickname) async {
    try {
      if (isNickname && _userProvider.user.nickname != _controller.text) {
        BotToast.showLoading();
        ResponseNormalModel model =
            await ProfileDao.changeProfile({'nickname': _controller.text});
        if (model.code == 1000) {
          _userProvider.user.nickname = _controller.text;
          _userProvider.saveUser(_userProvider.user);
        }
        BotToast.showText(text: '修改成功');
      } else if (_userProvider.user.sex != _controller.text) {
        BotToast.showLoading();
        ResponseNormalModel model =
            await ProfileDao.changeProfile({'name': _controller.text});
        if (model.code == 1000) {
          _userProvider.user.realName = _controller.text;
          _userProvider.saveUser(_userProvider.user);
        }
        BotToast.showText(text: '修改成功');
      }
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.pop(context);
    } catch (e) {}
    BotToast.closeAllLoading();
  }
}
