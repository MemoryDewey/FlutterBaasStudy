import 'package:baas_study/dao/wallet_dao.dart';
import 'package:baas_study/model/wallet_model.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/list_empty.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BalanceDetailPage extends StatefulWidget {
  @override
  _BalanceDetailPageState createState() => _BalanceDetailPageState();
}

class _BalanceDetailPageState extends State<BalanceDetailPage> {
  RefreshController _refreshController = RefreshController();
  int _pageCurrent = 0;
  int _pageSum = 1;
  List<BalanceLogsModel> _logs = [];
  bool _loadComplete = false;
  static const Map<String, String> _STATUS = {
    'Accept': '交易成功',
    'Reject': '交易失败',
    'Pending': '交易中..',
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
                      title: Text(_logs[index].details),
                      subtitle: Text(_STATUS[_logs[index].status]),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${_logs[index].type == 'Income' ? '+' : '-'}${_logs[index].amount}',
                            style: TextStyle(
                              color: _logs[index].type == 'Income'
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
      List<BalanceLogsModel> list = await _getBalanceLogs();
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

  Future<List<BalanceLogsModel>> _getBalanceLogs() async {
    try {
      WalletLogsModel logsModel = await WalletDao.getBalanceLogs(_pageCurrent);
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
