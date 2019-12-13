import 'package:flutter/material.dart';
import '../skeleton.dart';

class CourseCardSkeletonItem extends StatelessWidget {
  final int index;

  CourseCardSkeletonItem({this.index: 0});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: SkeletonDecoration(isDark: isDark),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 18,
                  child: Container(
                    decoration: SkeletonDecoration(isDark: isDark),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: SkeletonDecoration(isDark: isDark),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 14,
                      child: Container(
                        decoration: SkeletonDecoration(isDark: isDark),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        height: 14,
                        width: double.infinity,
                        child: Container(
                          decoration: SkeletonDecoration(isDark: isDark),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
