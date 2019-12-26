import 'package:baas_study/widget/skeleton.dart';
import 'package:flutter/material.dart';

class CourseInfoDetailSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SkeletonContainer(
                child: Container(
                  height: 32,
                  decoration: SkeletonDecoration(isDark: isDark),
                ),
              ),
              SizedBox(height: 8),
              SkeletonContainer(
                child: Container(
                  height: 24,
                  decoration: SkeletonDecoration(isDark: isDark),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1),
        Container(
          padding: EdgeInsets.all(16),
          color: Theme.of(context).cardColor,
          child: Column(
            children: <Widget>[
              _titleSkeleton(isDark),
              SizedBox(height: 10),
              SkeletonContainer(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 48,
                      width: 48,
                      decoration: SkeletonDecoration(
                        isDark: isDark,
                        isCircle: true,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 32,
                        decoration: SkeletonDecoration(isDark: isDark),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              _titleSkeleton(isDark),
              SizedBox(height: 10),
              SkeletonContainer(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: SkeletonDecoration(isDark: isDark),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _titleSkeleton(bool isDark) => SkeletonContainer(
        child: Row(
          children: <Widget>[
            Container(
              height: 32,
              width: 32,
              decoration: SkeletonDecoration(),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 24,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ),
          ],
        ),
      );
}
