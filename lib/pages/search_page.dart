import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:baas_study/widget/search_bar.dart';
import 'package:flutter/material.dart';

const SEARCH_BAR_DEFAULT_TEXT = '区块链 以太坊 智能合约';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    //ThemeData themeData = Theme.of(context);
    return Scaffold(
        appBar: _appBar,
        body: Column(
          children: <Widget>[
            SearchBar(
              hint: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
            TextField()
          ],
        ));
  }

  Widget get _appBar {
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: AppBar(
        elevation: 0,
      ),
    );
  }

  _size(double size) {
    return AutoSizeUtil.size(size);
  }

  _font(double fonSize) {
    return AutoSizeUtil.font(fonSize);
  }

  _onTextChange(text) {}
}
