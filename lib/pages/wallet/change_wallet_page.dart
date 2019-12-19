import 'package:baas_study/dao/wallet_dao.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/model/wallet_model.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';
import 'package:flutter/material.dart';

class ChangeWalletPage extends StatefulWidget {
  final bool isAdd;

  const ChangeWalletPage({Key key, @required this.isAdd}) : super(key: key);

  @override
  _ChangeWalletPageState createState() => _ChangeWalletPageState();
}

class _ChangeWalletPageState extends State<ChangeWalletPage> {
  TextEditingController _controller = TextEditingController();
  String _pubKey = "";

  @override
  void initState() {
    super.initState();
    _getPubKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isAdd ? '绑定BST账号' : '更换BST账号',
        tailTitle: '保存',
        tailOnTap: _saveAddress,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.url,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: '请输入钱包密钥',
                  helperMaxLines: 2,
                  helperText: '每个用户只能绑定一个钱包，只有绑定钱包后才能进行购买课程操作',
                ),
                onEditingComplete: _saveAddress,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                size: 16,
              ),
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback(
                  (callback) => _controller.clear(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _saveAddress() async {
    FocusScope.of(context).requestFocus(FocusNode());
    encrypt.RSAKeyParser parser = encrypt.RSAKeyParser();
    RSAPublicKey publicKey = parser.parse(_pubKey);
    final encryption = encrypt.Encrypter(encrypt.RSA(
      publicKey: publicKey,
      encoding: encrypt.RSAEncoding.OAEP,
    ));
    String result = encryption.encrypt(_controller.text).base64;
    _addBstAddress(result);
  }

  Future<Null> _getPubKey() async {
    try {
      WalletPubKeyModel model = await WalletDao.getPubKey();
      setState(() {
        _pubKey = model.key;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _addBstAddress(String encryptStr) async {
    try {
      ResponseNormalModel model =
          await WalletDao.addBstAddress(address: encryptStr);
      if (model?.code == 1000) Navigator.pop(context, true);
    } catch (e) {
      print(e);
    }
  }
}
