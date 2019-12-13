import 'package:baas_study/widget/course/course_manage_card.dart';
import 'package:flutter/material.dart';

class UserCoursePage extends StatefulWidget {
  @override
  _UserCoursePageState createState() => _UserCoursePageState();
}

class _UserCoursePageState extends State<UserCoursePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(top: 16),
            children: <Widget>[
              CourseManageCard(imageUrl: ''),
              CourseManageCard(imageUrl: ''),
              CourseManageCard(imageUrl: ''),
              CourseManageCard(imageUrl: ''),
            ],
          ),
          Text('TabsView 2'),
          Text('TabsView 3'),
        ],
      ),
    );
  }

  Widget _appBar() => AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text('课程管理', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: '全部课程'),
            Tab(text: '余额购买'),
            Tab(text: 'BST购买'),
          ],
        ),
      );
}
