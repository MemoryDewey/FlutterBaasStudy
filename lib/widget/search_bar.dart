import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final String defaultText;

  const SearchBar({Key key, this.defaultText}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    if(widget.defaultText!=null){
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
