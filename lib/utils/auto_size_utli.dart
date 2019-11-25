import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoSizeUtil {
  static double size(double size) {
    return ScreenUtil.getInstance().setWidth(size * 2);
  }

  static double font(double fontSize) {
    return ScreenUtil.getInstance().setSp(fontSize * 2);
  }
}
