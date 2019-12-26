import 'package:baas_study/widget/skeleton.dart';
import 'package:flutter/material.dart';

class CourseCommentSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: SkeletonContainer(
              child: Container(
                height: 64,
                width: 64,
                decoration: SkeletonDecoration(isCircle: true, isDark: isDark),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SkeletonContainer(
                  child: Container(
                    height: 18,
                    width: 140,
                    decoration: SkeletonDecoration(isDark: isDark),
                  ),
                ),
                SkeletonContainer(
                  child: Container(
                    height: 20,
                    width: 100,
                    decoration: SkeletonDecoration(isDark: isDark),
                  ),
                ),
              ],
            ),
            subtitle: SkeletonContainer(
              child: Container(
                height: 16,
                decoration: SkeletonDecoration(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
            child: SkeletonContainer(
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: SkeletonDecoration(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
