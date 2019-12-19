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

/// 路由动画 上下切换
class SlideTopRoute extends PageRouteBuilder {
  final Widget widget;

  SlideTopRoute(this.widget)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position:
                Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
                    .animate(CurvedAnimation(
                        parent: animation, curve: Curves.fastOutSlowIn)),
            child: child,
          ),
        );
}
