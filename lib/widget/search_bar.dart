import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

/// 顶部搜索框
class SearchBar extends StatefulWidget {
  final bool enable;
  final bool hideLeft;
  final SearchBarType searchBarType;
  final String hint;
  final String defaultText;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final TextEditingController controller;

  const SearchBar({
    Key key,
    this.defaultText = '',
    this.enable = true,
    this.hideLeft,
    this.searchBarType = SearchBarType.normal,
    this.hint,
    this.leftButtonClick,
    this.rightButtonClick,
    this.speakClick,
    this.inputBoxClick,
    this.onChanged,
    this.controller,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  Color _homeColor;
  Color _primaryColor;
  Color _fillColor;
  Color _searchBarColor;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.defaultText != null) {
      setState(() {
        _controller = widget.controller ?? TextEditingController();
        _controller.text = widget.defaultText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    _homeColor = themeData.cardColor;
    _primaryColor =
        themeData.brightness == Brightness.dark ? Colors.white : Colors.black54;
    _fillColor = themeData.inputDecorationTheme.fillColor;
    _searchBarColor = themeData.appBarTheme.color;
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch()
        : _genHomeSearch();
  }

  _size(double size) {
    return AutoSizeUtil.size(size);
  }

  _font(double fontSize) {
    return AutoSizeUtil.font(fontSize);
  }

  /// 搜索页搜索框
  _genNormalSearch() {
    return Container(
      color: _searchBarColor,
      padding: EdgeInsets.fromLTRB(_size(6), _size(10), _size(10), _size(10)),
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              padding: EdgeInsets.only(right: _size(6)),
              child: widget?.hideLeft ?? false
                  ? null
                  : Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                      size: _size(16),
                    ),
            ),
            widget.leftButtonClick,
          ),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
            Container(
              padding: EdgeInsets.only(
                top: _size(3),
                bottom: _size(3),
                left: _size(10),
              ),
              child: Text(
                '搜索',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: _font(16),
                ),
              ),
            ),
            widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  /// 首页搜索框
  _genHomeSearch() {
    return Container(
      margin: EdgeInsets.fromLTRB(_size(6), _size(10), _size(10), _size(10)),
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              padding: EdgeInsets.only(right: _size(5)),
              child: Row(
                children: <Widget>[
                  Text(
                    '课程',
                    style: TextStyle(
                      color: _homeFontColor(),
                      fontSize: _font(16),
                    ),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: _homeFontColor(),
                    size: _size(22),
                  )
                ],
              ),
            ),
            widget.leftButtonClick,
          ),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
            Container(
              padding: EdgeInsets.only(left: _size(10)),
              child: Icon(
                Icons.playlist_play,
                color: _homeFontColor(),
                size: _size(28),
              ),
            ),
            widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  /// 输入框左边和右边的内容
  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  /// 输入框
  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home)
      inputBoxColor = _homeColor;
    else
      inputBoxColor = _fillColor;
    return Container(
      height: _size(30),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: _size(10)),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(_size(15)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: _size(5)),
            child: Icon(
              FontIcons.search,
              size: _size(15),
              color: widget.searchBarType == SearchBarType.normal
                  ? Color(0xffa9a9a9)
                  : Colors.blue,
            ),
          ),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normal
                ? TextField(
                    controller: _controller,
                    onChanged: _onChanged,
                    onSubmitted: _onSubmitted,
                    autofocus: false,
                    style: TextStyle(
                      fontSize: _font(15),
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(
                        _size(5),
                        0,
                        _size(5),
                        0,
                      ),
                      border: InputBorder.none,
                      hintText: widget.hint ?? '',
                      hintStyle: TextStyle(fontSize: _font(15)),
                    ),
                    textInputAction: TextInputAction.search,
                  )
                : _wrapTap(
                    Container(
                      child: Text(
                        widget.defaultText,
                        style: TextStyle(
                          fontSize: _font(15),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    widget.inputBoxClick,
                  ),
          ),
          !showClear
              ? _wrapTap(
                  Icon(
                    Icons.mic_none,
                    size: _size(22),
                    color: widget.searchBarType == SearchBarType.normal
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  widget.speakClick)
              : _wrapTap(
                  Icon(
                    Icons.clear,
                    size: _size(22),
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                }),
        ],
      ),
    );
  }

  /// 输入内容改变
  _onChanged(String text) {
    if (text.length > 0)
      setState(() {
        showClear = true;
      });
    else
      setState(() {
        showClear = false;
      });
    if (widget.onChanged != null) widget.onChanged(text);
  }

  /// 输入内容提交
  _onSubmitted(String text) {
    if (text.length > 0 && widget.onSubmitted != null) widget.onSubmitted(text);
  }

  // 首页背景色
  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? _primaryColor
        : Colors.white;
  }
}
