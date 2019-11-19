import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoSizeUtil {
  static double size(double number) {
    return ScreenUtil.getInstance().setWidth(number * 2);
  }

  static double font(double fontSize) {
    return ScreenUtil.getInstance().setSp(fontSize * 2);
  }
}
