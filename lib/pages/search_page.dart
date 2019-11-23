import 'package:baas_study/widget/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SEARCH_BAR_DEFAULT_TEXT = '区块链 以太坊 智能合约';
const SEARCH_HISTORY_KEY = 'searchHistory';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SharedPreferences _sharedPreferences;
  Set<String> _searchHistory;
  String _inputText = '';

  @override
  void initState() {
    super.initState();
    _getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar,
        body: Column(
          children: <Widget>[
            SearchBar(
              hint: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
              onChanged: (text) {
                setState(() {
                  _inputText = text;
                });
              },
              rightButtonClick: _search,
            ),
            Expanded(
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: _searchHistoryList,
                ).toList(),
              ),
            )
          ],
        ));
  }

  Widget get _appBar {
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: AppBar(elevation: 0),
    );
  }

  List<Widget> get _searchHistoryList {
    List<Widget> history = [];
    if (_searchHistory != null)
      _searchHistory.forEach((item) {
        history.add(
          ListTile(
            leading: Icon(Icons.history),
            title: Text(item, overflow: TextOverflow.ellipsis),
            trailing: GestureDetector(
              onTap: () {
                _removeHistory(search: item);
              },
              child: Icon(Icons.close),
            ),
          ),
        );
      });
    if (history.isNotEmpty)
      history.add(
        ListTile(
          title: Text('清除搜索记录', textAlign: TextAlign.center),
          onTap: (){
            _removeHistory(all: true);
          },
        ),
      );
    return history;
  }

  _search() {
    _addHistory(_inputText);
  }

  _getHistory() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory =
          _sharedPreferences.getStringList(SEARCH_HISTORY_KEY)?.toSet();
      _searchHistory ??= <String>[].toSet();
    });
  }

  _addHistory(String search) async {
    setState(() {
      _searchHistory.add(search);
    });
    await _sharedPreferences.setStringList(
        SEARCH_HISTORY_KEY, _searchHistory.toList());
  }

  _removeHistory({bool all = false, String search}) async {
    if (all) {
      await _sharedPreferences.remove(SEARCH_HISTORY_KEY);
      setState(() {
        _searchHistory.clear();
      });
    } else {
      await _sharedPreferences.setStringList(
          SEARCH_HISTORY_KEY, _searchHistory.toList());
      setState(() {
        _searchHistory.remove(search);
      });
    }
  }
}
