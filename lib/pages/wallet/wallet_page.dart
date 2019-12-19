import 'package:baas_study/dao/wallet_dao.dart';
import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/model/wallet_model.dart';
import 'package:baas_study/pages/wallet/balance_detail_page.dart';
import 'package:baas_study/pages/wallet/balance_recharge_page.dart';
import 'package:baas_study/pages/wallet/bst_logs_page.dart';
import 'package:baas_study/pages/wallet/change_wallet_page.dart';
import 'package:baas_study/pages/wallet/wallet_info_page.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/list_empty.dart';
import 'package:baas_study/widget/wallet/wallet_card_widget.dart';
import 'package:baas_study/widget/wallet/wallet_wiget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int _selectedCardIndex = 0;
  int _selectedOptions = 0;
  String _bstBalance = '0';
  UserProvider _userProvider;
  bool _loadComplete = false;
  bool _loadError = false;

  /// 交易记录
  List<BalanceLogsModel> _logs = [];
  bool _logsLoadComplete = false;

  @override
  void initState() {
    super.initState();
    _getBalance();
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: '我的钱包'),
      body: _loadComplete
          ? CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: WalletCardWidget(
                    onChanged: (index) {
                      setState(() {
                        _selectedCardIndex = index;
                      });
                    },
                  ),
                ),
                SliverToBoxAdapter(child: Divider(height: 0.5)),
                SliverToBoxAdapter(
                  child: Consumer<UserProvider>(
                    builder: (context, provider, child) => WalletBalanceWidget(
                      balance: _selectedCardIndex == 0
                          ? provider.balance
                          : _bstBalance == "-1" ? "0.00" : _bstBalance,
                      buttonText: _selectedCardIndex == 0 ? '充值' : '刷新',
                      buttonPress: () {
                        if (_selectedCardIndex == 0)
                          Navigator.push(
                            context,
                            SlideRoute(BalanceRechargePage()),
                          );
                        else
                          _refreshWallet();
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: _optionsBar()),
                _selectedOptions == 0
                    ? SliverToBoxAdapter(child: _walletMng())
                    : _logs.length == 0 && _logsLoadComplete
                        ? SliverToBoxAdapter(child: _payLogsEmpty())
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => _payLogs(index),
                              childCount: _logs.length,
                            ),
                          ),
                SliverToBoxAdapter(
                  child: Offstage(
                      offstage: _selectedOptions == 0 || _logs.length == 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlideRoute(BalanceDetailPage()),
                            );
                          },
                          child: Text(
                            '查看更多',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                ),
              ],
            )
          : Center(
              child: _loadError
                  ? RichText(
                      text: TextSpan(
                          text: '加载失败，',
                          style: TextStyle(color: IconTheme.of(context).color),
                          children: <TextSpan>[
                            TextSpan(
                              text: '重新加载',
                              style: TextStyle(color: Colors.blueAccent),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _getBalance,
                            )
                          ]),
                    )
                  : Text('加载中请稍等'),
            ),
    );
  }

  /// TabBar
  Widget _optionsBar() => Padding(
        padding: EdgeInsets.only(top: 40, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedOptions = 0;
                });
              },
              child: Text(
                '钱包管理',
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedOptions == 0 ? Colors.lightBlue : Colors.grey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_logs.isEmpty) _getBalanceLogs();
                setState(() {
                  _selectedOptions = 1;
                });
              },
              child: Text(
                '交易记录',
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedOptions == 1 ? Colors.lightBlue : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );

  /// 钱包管理
  Widget _walletMng() => Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _bstBalance == '-1'
              ? <Widget>[
                  WalletIconText(
                    iconData: Icons.add_box,
                    iconText: '绑定账号',
                    onTap: () async {
                      var needRefresh = await Navigator.push(
                        context,
                        SlideRoute(
                          ChangeWalletPage(
                            isAdd: true,
                          ),
                        ),
                      );
                      if (needRefresh != null) await _refreshWallet();
                    },
                  ),
                ]
              : <Widget>[
                  WalletIconText(
                    iconData: FontIcons.wallet,
                    iconText: '钱包信息',
                    onTap: () async {
                      var needRefresh = await Navigator.push(
                        context,
                        SlideRoute(WalletInfoPage()),
                      );
                      if (needRefresh != null) await _refreshWallet();
                    },
                  ),
                  WalletIconText(
                    iconData: Icons.repeat,
                    iconText: '更换钱包',
                    onTap: () async {
                      var needRefresh = await Navigator.push(
                        context,
                        SlideRoute(
                          ChangeWalletPage(
                            isAdd: false,
                          ),
                        ),
                      );
                      if (needRefresh != null) await _refreshWallet();
                    },
                  ),
                  WalletIconText(
                    iconData: FontIcons.bst_orders,
                    iconText: 'BST账单',
                    onTap: () {
                      Navigator.push(context, SlideRoute(BstLogsPage()));
                    },
                  ),
                ],
        ),
      );

  /// 交易记录
  Widget _payLogs(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Material(
        color: Theme.of(context).cardColor,
        child: ListTile(
          title: Text(
            _logs[index].details,
          ),
          subtitle: Text(_logs[index].time),
          trailing: Text(
            '${_logs[index].type == 'Income' ? '+' : '-'}${_logs[index].amount}',
            style: TextStyle(
              color: _logs[index].type == 'Income'
                  ? Colors.lightBlue
                  : Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }

  /// 交易记录为空
  Widget _payLogsEmpty() => Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        height: 150,
        child: ListEmptyWidget(),
      );

  Future<Null> _getBalance() async {
    try {
      await WalletDao.refreshWallet();
      WalletModel wallet = await WalletDao.getWalletInfo();
      _userProvider.saveWalletInfo(wallet.balance);
      BstBalanceModel model = await WalletDao.getBstBalance(false);
      setState(() {
        _bstBalance = model.balance;
        _loadComplete = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loadComplete = false;
      });
    }
  }

  Future<Null> _refreshWallet() async {
    try {
      BotToast.showLoading();
      await WalletDao.refreshWallet();
      WalletModel wallet = await WalletDao.getWalletInfo();
      _userProvider.saveWalletInfo(wallet.balance);
      BstBalanceModel model = await WalletDao.getBstBalance(true);
      setState(() {
        _bstBalance = model.balance;
      });
      BotToast.closeAllLoading();
      BotToast.showText(text: '已更新钱包数据');
    } catch (e) {
      print(e);
      BotToast.closeAllLoading();
      BotToast.showText(text: '获取数据失败');
    }
  }

  Future<Null> _getBalanceLogs() async {
    try {
      WalletLogsModel logsModel = await WalletDao.getBalanceLogs(1);
      setState(() {
        _loadComplete = true;
        _logs = logsModel.logs;
      });
    } catch (e) {
      print(e);
    }
  }
}
