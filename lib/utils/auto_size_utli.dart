import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoSizeUtil {
  static double width = 785.4;
  static double height = 1635;

  static num size(num number) {
    return ScreenUtil.getInstance().setWidth(number);
  }
}
