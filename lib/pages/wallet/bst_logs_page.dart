import 'package:baas_study/dao/wallet_dao.dart';
import 'package:baas_study/model/wallet_model.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/list_empty.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BstLogsPage extends StatefulWidget {
  @override
  _BstLogsPageState createState() => _BstLogsPageState();
}

class _BstLogsPageState extends State<BstLogsPage> {
  RefreshController _refreshController = RefreshController();
  int _pageCurrent = 0;
  int _pageSum = 1;
  List<BstLogsModel> _logs = [];
  bool _loadComplete = false;
  static const Map<String, String> _STATUS = {
    'Course': '购买课程',
    'Expend': '课程币兑换',
    'Recharge': '课程币充值',
  };

  @override
  void initState() {
    super.initState();
    _onLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '余额明细'),
      body: _logs.length == 0 && _loadComplete
          ? ListEmptyWidget()
          : SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: _onLoading,
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    border: index != _logs.length - 1
                        ? Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.5),
                          )
                        : Border(),
                  ),
                  child: Material(
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      title: Text(_STATUS[_logs[index].productType]),
                      subtitle: Text(
                        _logs[index].txHash,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${_logs[index].productType == 'Expend' ? '+' : '-'}${_logs[index].amount}',
                            style: TextStyle(
                              color: _logs[index].productType == 'Expend'
                                  ? Colors.lightBlue
                                  : Colors.redAccent,
                            ),
                          ),
                          Text(
                            _logs[index].time,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      onLongPress: () {
                        Clipboard.setData(
                            ClipboardData(text: _logs[index].txHash));
                        BotToast.showText(text: '已复制区块号');
                      },
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void _onLoading() async {
    setState(() {
      _pageCurrent += 1;
    });
    if (_pageCurrent > _pageSum) {
      _refreshController.loadNoData();
    } else {
      List<BstLogsModel> list = await _getBalanceLogs();
      if (list == null)
        _refreshController.loadFailed();
      else {
        setState(() {
          _logs.addAll(list);
        });
        _refreshController.loadComplete();
      }
    }
  }

  Future<List<BstLogsModel>> _getBalanceLogs() async {
    try {
      WalletLogsModel logsModel = await WalletDao.getBstLogs(_pageCurrent);
      setState(() {
        _pageSum = logsModel.pageSum;
        _loadComplete = true;
      });
      return logsModel.logs;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
