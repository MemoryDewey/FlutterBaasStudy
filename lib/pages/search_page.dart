import 'package:baas_study/widget/search_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    print(themeData);
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            SearchBar(
              hideLeft: true,
              defaultText: '哈哈',
              hint: '123',
              leftButtonClick: (){
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
            TextField()
          ],
        )
    );
  }
  _onTextChange(text){

  }
}
