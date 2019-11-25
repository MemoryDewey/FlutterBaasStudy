import 'package:baas_study/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SEARCH_BAR_DEFAULT_TEXT = '区块链 以太坊 智能合约';
const SEARCH_HISTORY_KEY = 'searchHistory';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String keyWord;
  final String hint;

  const SearchPage({
    Key key,
    this.hideLeft,
    this.keyWord,
    this.hint,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SharedPreferences _sharedPreferences;
  Set<String> _searchHistory;
  String _searchContent;

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
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SearchBar(
                hideLeft: widget.hideLeft,
                defaultText: widget.keyWord,
                hint: widget.hint ?? SEARCH_BAR_DEFAULT_TEXT,
                leftButtonClick: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.pop(context);
                },
                rightButtonClick: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  _search(_searchContent);
                },
                onChanged: (text) {
                  setState(() {
                    _searchContent = text;
                  });
                },
                onSubmitted: (text) {
                  _search(text);
                },
              ),
            ),
            Expanded(
              flex: 1,
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

  /// appBar Widget
  Widget get _appBar {
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: AppBar(elevation: 0),
    );
  }

  /// 本地搜索记录Widget
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
          onTap: () {
            _removeHistory(all: true);
          },
        ),
      );
    return history;
  }

  /// 搜索
  _search(String searchContent) {
    searchContent ??= '';
    if (searchContent.length > 0) _addHistory(searchContent);
  }

  /// 获取本地搜索记录
  _getHistory() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory =
          _sharedPreferences.getStringList(SEARCH_HISTORY_KEY)?.toSet();
      _searchHistory ??= <String>[].toSet();
    });
  }

  /// 添加本地搜索记录
  _addHistory(String search) async {
    setState(() {
      _searchHistory.add(search);
    });
    await _sharedPreferences.setStringList(
        SEARCH_HISTORY_KEY, _searchHistory.toList());
  }

  /// 清除本地搜索记录
  _removeHistory({bool all = false, String search}) async {
    if (all) {
      await _sharedPreferences.remove(SEARCH_HISTORY_KEY);
      setState(() {
        _searchHistory.clear();
      });
    } else {
      setState(() {
        _searchHistory.remove(search);
      });
      await _sharedPreferences.setStringList(
          SEARCH_HISTORY_KEY, _searchHistory.toList());
    }
  }
}
