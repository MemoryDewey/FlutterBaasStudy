import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

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
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      padding: EdgeInsets.fromLTRB(_size(6), _size(5), _size(10), _size(5)),
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              child: widget?.hideLeft ?? false
                  ? null
                  : Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                      size: _size(26),
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
              padding:
                  EdgeInsets.fromLTRB(_size(10), _size(5), _size(10), _size(5)),
              child: Text(
                '搜索',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: _font(17),
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
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              padding:
                  EdgeInsets.fromLTRB(_size(6), _size(5), _size(5), _size(5)),
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
              padding:
                  EdgeInsets.fromLTRB(_size(10), _size(5), _size(10), _size(5)),
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
      inputBoxColor = Colors.white;
    else
      inputBoxColor = Color(0xffededed);
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(_size(10), 0, _size(10), 0),
      decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
            widget.searchBarType == SearchBarType.normal ? _size(5) : _size(15),
          )),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: _size(20),
            color: widget.searchBarType == SearchBarType.normal
                ? Color(0xffa9a9a9)
                : Colors.blue,
          ),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normal
                ? TextField(
                    controller: _controller,
                    onChanged: _onChanged,
                    autofocus: true,
                    style: TextStyle(
                      fontSize: _font(18),
                      color: Colors.black,
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
                      hintStyle: TextStyle(
                        fontSize: _font(15),
                      ),
                    ),
                  )
                : _wrapTap(
                    Container(
                      child: Text(
                        widget.defaultText,
                        style: TextStyle(
                          fontSize: _font(13),
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

  // 首页背景色
  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
