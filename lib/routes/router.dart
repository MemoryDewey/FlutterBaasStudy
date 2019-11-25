import 'package:flutter/material.dart';

/// 路由动画 - 左右切换
class SlideRoute extends PageRouteBuilder {
  final Widget widget;

  SlideRoute(
    this.widget,
  ) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              widget,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                textDirection: TextDirection.rtl,
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
