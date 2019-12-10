import 'package:baas_study/pages/course_list_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/utils/storage_util.dart';
import 'package:baas_study/widgets/search_bar.dart';
import 'package:flutter/material.dart';

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
                rightButtonClick: () {
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
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              _searchResult(item);
            },
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
  void _search(String searchContent) {
    searchContent ??= '';
    if (searchContent.isNotEmpty) _searchResult(searchContent);
    _addHistory(searchContent);
  }

  /// 跳转到搜索结果页
  void _searchResult(String searchContent) {
    Navigator.push(
      context,
      SlideRoute(
        CourseListPage(
          hideLeft: false,
          keyWord: searchContent,
        ),
      ),
    );
  }

  /// 获取本地搜索记录
  void _getHistory() async {
    List<String> listStr = await StorageUtil.getStringList(SEARCH_HISTORY_KEY);
    setState(() {
      _searchHistory = listStr?.toSet();
      _searchHistory ??= <String>[].toSet();
    });
  }

  /// 添加本地搜索记录
  void _addHistory(String search) async {
    setState(() {
      _searchHistory.add(search);
    });
    StorageUtil.set(SEARCH_HISTORY_KEY, _searchHistory.toList());
  }

  /// 清除本地搜索记录
  void _removeHistory({bool all = false, String search}) async {
    if (all) {
      StorageUtil.remove(SEARCH_HISTORY_KEY);
      setState(() {
        _searchHistory.clear();
      });
    } else {
      setState(() {
        _searchHistory.remove(search);
      });
      StorageUtil.set(SEARCH_HISTORY_KEY, _searchHistory.toList());
    }
  }
}
