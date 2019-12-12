import 'dart:async';

import 'package:flutter/material.dart';

/// Passport模块顶部Panel
class PassportTopPanel extends StatelessWidget {
  final Color color;

  const PassportTopPanel({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        height: 220,
        color: color,
      ),
    );
  }
}

/// PassportPanel底部弧形效果
class BottomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50);

    var p1 = Offset(size.width / 2, size.height);
    var p2 = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    path.lineTo(size.width, size.height - 50);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

/// Passport模块展示Logo
class PassportLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/login_logo.png',
      width: 280,
      height: 100,
      fit: BoxFit.fitHeight,
      colorBlendMode: BlendMode.srcIn,
    );
  }
}

/// Passport模块表单容器
class PassportFormContainer extends StatelessWidget {
  final Widget child;

  const PassportFormContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(),
        color: Theme.of(context).cardColor,
        shadows: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withAlpha(20),
            offset: Offset(1.0, 1.0),
            blurRadius: 10,
            spreadRadius: 3,
          )
        ],
      ),
      child: child,
    );
  }
}

/// 登录按钮
class PassportBtn extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const PassportBtn({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(110),
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
        disabledColor: Color(0xff999999),
        disabledTextColor: Colors.white,
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

/// 底部文字链接
class PassportBottomText extends StatelessWidget {
  final String text;
  final void Function() onTab;

  const PassportBottomText({
    Key key,
    this.text,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTab,
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ),
    );
  }
}

class CountDownTimer extends StatefulWidget {
  final int startSeconds;
  final String verifyStr;
  final Function onTapCallback;
  final void Function() onTap;
  final TextStyle enableTextStyle, disableTextStyle;
  final bool autoStart;

  const CountDownTimer({
    Key key,
    this.startSeconds = 90,
    this.verifyStr,
    this.onTapCallback,
    this.enableTextStyle = const TextStyle(fontSize: 14, color: Colors.blue),
    this.disableTextStyle = const TextStyle(
      fontSize: 16,
      color: const Color(0xff999999),
    ),
    this.autoStart = false,
    this.onTap,
  }) : super(key: key);

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Timer _timer;
  int _seconds;
  bool _enable = true;
  TextStyle _inkWellStyle;

  String _verifyStr;

  @override
  void initState() {
    super.initState();
    _verifyStr = '获取验证码';
    _seconds = widget.startSeconds;
    _inkWellStyle = widget.enableTextStyle;
    if (widget.autoStart) _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        '$_verifyStr',
        textAlign: TextAlign.right,
        style: _inkWellStyle,
      ),
      onTap:
          (_enable && (_seconds == widget.startSeconds)) ? (){
            _startTimer();
            widget.onTap();
          } : null,
    );
  }

  /// 开始倒计时
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = widget.startSeconds;
        _verifyStr = '重新发送';
        _enable = true;
        _inkWellStyle = widget.enableTextStyle;
        setState(() {});
        return;
      }

      _enable = false;
      _inkWellStyle = widget.disableTextStyle;
      _seconds--;
      _verifyStr = '$_seconds秒后重新发送';
      setState(() {});
      if (widget.onTapCallback != null) widget.onTapCallback(timer);
    });
  }

  /// 取消定时器
  void _cancelTimer() {
    _timer?.cancel();
  }
}
