import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 骨架屏
class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final bool isCircle;

  const SkeletonBox({
    Key key,
    this.width,
    this.height,
    this.isCircle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Divider.createBorderSide(context, width: 0.7);
    return Container(
      width: width,
      height: height,
      decoration: SkeletonDecoration(isCircle: isCircle, isDark: isDark),
    );
  }
}

/// 骨架屏 元素背景 形状及颜色
class SkeletonDecoration extends BoxDecoration {
  SkeletonDecoration({
    isCircle: false,
    isDark: false,
  }) : super(
          color: !isDark ? Colors.grey[350] : Colors.grey[700],
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        );
}

/// 骨架屏 底部边框
class BottomBorderDecoration extends BoxDecoration {
  BottomBorderDecoration()
      : super(border: Border(bottom: BorderSide(width: 0.3)));
}

//// 骨架屏列表
class SkeletonList extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final int length;
  final IndexedWidgetBuilder builder;

  const SkeletonList({
    Key key,
    this.padding = const EdgeInsets.all(7),
    this.length = 6,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        period: Duration(milliseconds: 1200),
        baseColor: isDark ? Colors.grey[700] : Colors.grey[350],
        highlightColor: isDark ? Colors.grey[500] : Colors.grey[200],
        child: Padding(
          padding: padding,
          child: Column(
            children: List.generate(length, (index) => builder(context, index)),
          ),
        ),
      ),
    );
  }
}

/// 骨架屏Container
class SkeletonContainer extends StatelessWidget {
  final Widget child;

  const SkeletonContainer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      period: Duration(milliseconds: 1200),
      baseColor: isDark ? Colors.grey[700] : Colors.grey[350],
      highlightColor: isDark ? Colors.grey[500] : Colors.grey[200],
      child: child,
    );
  }
}

