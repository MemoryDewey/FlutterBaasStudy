import 'package:baas_study/dao/invite_dao.dart';
import 'package:baas_study/model/invite_model.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/list_empty.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InviteListPage extends StatefulWidget {
  @override
  _InviteListPageState createState() => _InviteListPageState();
}

class _InviteListPageState extends State<InviteListPage> {
  List<InviteListModel> _invites = [];
  int _inviteSum = 0;
  RefreshController _refreshController = RefreshController();
  int _current = 0;
  int _pageSum = 1;
  bool _loadComplete = false;

  @override
  void initState() {
    super.initState();
    _onLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '邀请列表'),
      body: Column(
        children: <Widget>[
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff4bb0ff), Color(0xff6149f6)],
              ),
            ),
            child: Text(
              '成功邀请 $_inviteSum 人',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: _invites.length == 0 && _loadComplete
                ? ListEmptyWidget()
                : SmartRefresher(
                    controller: _refreshController,
                    enablePullUp: true,
                    enablePullDown: false,
                    child: ListView.builder(
                      itemCount: _invites.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: index != _invites.length - 1
                                ? Border(
                                    bottom: BorderSide(
                                        width: 0.5, color: Colors.grey),
                                  )
                                : Border(),
                          ),
                          child: ListTile(
                            title: Text(_invites[index].invitedUser.nickname),
                            subtitle: Text(_invites[index].invitedUser.phone),
                            trailing: Text(_invites[index].inviteTime),
                          ),
                        );
                      },
                    ),
                    onLoading: _onLoading,
                  ),
          )
        ],
      ),
    );
  }

  void _onLoading() async {
    setState(() {
      _current += 1;
    });
    if (_current > _pageSum) {
      _refreshController.loadNoData();
    } else {
      List<InviteListModel> list = await _getInviteList();
      if (list == null)
        _refreshController.loadFailed();
      else {
        setState(() {
          _invites.addAll(list);
        });
        _refreshController.loadComplete();
      }
    }
  }

  Future<List<InviteListModel>> _getInviteList() async {
    try {
      InviteResultModel result = await InviteDao.getInviteList(_current);
      setState(() {
        _inviteSum = result.count;
        _pageSum = result.pageSum;
        _loadComplete = true;
      });
      return result.invites;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
