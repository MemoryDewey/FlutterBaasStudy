import 'package:flutter/material.dart';

class Router {}

/// 路由动画
class RouterAnimate extends PageRouteBuilder {
  final Widget widget;

  RouterAnimate(
    this.widget,
  ) : super(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
            ) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(-1.0, 0.0),
                  end: Offset(0.0, 0.0),
                ).animate(
                  CurvedAnimation(parent: animation1, curve: Curves.easeIn),
                ),
              );
            });
}
