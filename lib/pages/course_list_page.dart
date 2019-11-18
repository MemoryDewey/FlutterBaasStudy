import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseListPage extends StatefulWidget {
  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CachedNetworkImage(
          width: 100,
          imageUrl: "http://47.102.97.205/images/banner/136e1016d0eefccd1c54e9309cd56065.jpg",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.image),
        ),
      ),
    );
  }
}
