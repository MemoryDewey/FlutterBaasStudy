import 'package:baas_study/pages/invite/invite_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/intro_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BalanceIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = IconTheme.of(context).color;
    TextStyle normalStyle = IntroWidget.normalTextStyle(color);
    TextStyle boldStyle = IntroWidget.boldTextStyle(color);
    return Scaffold(
      appBar: CustomAppBar(title: '余额说明'),
      body: ListView(
        children: <Widget>[
          IntroWidget.h2Title(title: '一、什么是余额'),
          IntroWidget.section(
            color: color,
            children: <TextSpan>[
              TextSpan(
                text: '余额是课堂内虚拟货币，可用于直接购买课程。余额的单位是课程币，1课程币等于1人民币。',
                style: normalStyle,
              ),
            ],
          ),
          IntroWidget.h2Title(title: '二、如何使用余额'),
          IntroWidget.section(
            color: color,
            children: <TextSpan>[
              TextSpan(
                text: '余额可在购买课程环节抵扣课程费用。',
                style: normalStyle,
              ),
            ],
          ),
          IntroWidget.h2Title(title: '三、如何获取余额'),
          IntroWidget.section(
            index: 1,
            color: color,
            children: <TextSpan>[
              TextSpan(
                text: '通过',
                style: normalStyle,
              ),
              TextSpan(
                text: ' BST ',
                style: boldStyle,
              ),
              TextSpan(
                text: '购买余额，需要绑定',
                style: normalStyle,
              ),
              TextSpan(
                text: ' BST ',
                style: boldStyle,
              ),
              TextSpan(
                text: '钱包',
                style: normalStyle,
              ),
            ],
          ),
          IntroWidget.section(
            index: 2,
            color: color,
            children: <TextSpan>[
              TextSpan(
                text: '通过',
                style: normalStyle,
              ),
              TextSpan(
                  text: ' 邀请好友注册 ',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 18,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context, SlideRoute(InvitePage()));
                    }),
              TextSpan(text: '获取奖励余额。', style: normalStyle)
            ],
          ),
        ],
      ),
    );
  }
}
