import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:baas_study/dao/wallet_dao.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BalanceRechargePage extends StatefulWidget {
  @override
  _BalanceRechargePageState createState() => _BalanceRechargePageState();
}

class _BalanceRechargePageState extends State<BalanceRechargePage> {
  List<int> _rechargeItem = [10, 20, 50, 100, 200, 500];
  int _chooseItem = 50;
  TextEditingController _controller = TextEditingController();
  bool _getBstValueSuccess = false;
  double _bstValue = 0;

  @override
  void initState() {
    super.initState();
    _getBstValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '课程币充值'),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: AspectRatio(
              aspectRatio: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/recharge.png'),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [BoxShadow(color: Theme.of(context).cardColor)],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('可用余额', style: TextStyle(fontSize: 24)),
                    SizedBox(height: 10),
                    Consumer<UserProvider>(
                      builder: (context, provider, child) => RichText(
                          text: TextSpan(
                              text: provider.balance,
                              style: TextStyle(
                                fontSize: 36,
                                color: Color(0xff7493f8),
                              ),
                              children: <TextSpan>[
                            TextSpan(
                              text: '课程币',
                              style: TextStyle(
                                fontSize: 24,
                                color: Color(0xff7493f8),
                              ),
                            ),
                          ])),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                (builder, index) {
                  Color btnColor = _rechargeItem[index] != _chooseItem
                      ? Theme.of(context).cardColor
                      : Color(0xff7493f8);
                  Color textColor = _rechargeItem[index] != _chooseItem
                      ? IconTheme.of(context).color
                      : Colors.white;
                  return CupertinoButton(
                    color: btnColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: '${_rechargeItem[index]}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 30,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' 课程币',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          '${_getPrice(_rechargeItem[index])} BST',
                          style: TextStyle(
                              fontSize: 16,
                              color: _rechargeItem[index] != _chooseItem
                                  ? Color(0xff757575)
                                  : Colors.white),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        _chooseItem = _rechargeItem[index];
                      });
                    },
                  );
                },
                childCount: _rechargeItem.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLengthEnforced: true,
                decoration: InputDecoration(
                  hintText: '自定义课程币数量（1-5000）',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                autovalidate: true,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[1-9]\d*")),
                  LengthLimitingTextInputFormatter(4)
                ],
                validator: (value) {
                  if (value.isEmpty) return null;
                  if (int.parse(value) > 5000) return '单笔至多充值5000个课程币';
                  return null;
                },
                onTap: () {
                  setState(() {
                    setState(() {
                      _chooseItem = 0;
                    });
                  });
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _chooseItem = int.parse(value);
                    });
                  }
                },
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 40,
        margin: EdgeInsets.only(left: 12, bottom: 12, right: 12),
        child: CupertinoButton(
          child: Text(
            _chooseItem == 0 ? '确认支付' : '确认支付 ${_getPrice(_chooseItem)} BST',
          ),
          color: Color(0xff7493f8),
          padding: EdgeInsets.only(top: 0, bottom: 0),
          pressedOpacity: 0.9,
          onPressed:
              _getBstValueSuccess && _chooseItem != 0 && _chooseItem < 5000
                  ? _recharge
                  : null,
        ),
      ),
    );
  }

  String _getPrice(int price) {
    return (price / _bstValue).toStringAsFixed(2);
  }

  Future<Null> _getBstValue() async {
    try {
      double value = await WalletDao.getBstValue();
      setState(() {
        _bstValue = value;
        _getBstValueSuccess = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        _getBstValueSuccess = false;
      });
    }
  }

  Future<Null> _recharge() async {
    try {
      await WalletDao.sendRechargeReq(amount: _chooseItem);
      SocketIOManager manager = SocketIOManager();
      SocketIO socket = await manager.createInstance(
        SocketOptions(HttpUtil.URL_PREFIX),
      );
      socket.connect();
      socket.emit('recharge', []);
      socket.on('rechargeMessage', (data) {
        if (data['status'] == 1) {
          BotToast.showText(text: data['msg']);
          Navigator.pop(context);
        } else
          BotToast.showText(text: data['msg']);
      });
      BotToast.closeAllLoading();
    } catch (e) {
      print(e);
      BotToast.closeAllLoading();
    }
  }
}
