import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:baas_study/widget/intro_widget.dart';
import 'package:flutter/material.dart';

class InviteIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = IconTheme.of(context).color;
    TextStyle normalStyle = IntroWidget.normalTextStyle(color);
    TextStyle boldStyle = IntroWidget.boldTextStyle(color);
    return Scaffold(
      appBar: CustomAppBar(title: '邀请说明'),
      body: ListView(
        children: <Widget>[
          IntroWidget.h1Title(title: '邀请说明'),
          IntroWidget.h2Title(title: '一、如何邀请好友'),
          IntroWidget.section(index: 1, color: color, children: <TextSpan>[
            TextSpan(text: '进入', style: normalStyle),
            TextSpan(text: ' 个人中心 ', style: boldStyle),
            TextSpan(text: '-', style: normalStyle),
            TextSpan(text: ' 邀请好友 ', style: boldStyle),
            TextSpan(text: '界面', style: normalStyle),
          ]),
          IntroWidget.section(index: 2, color: color, children: <TextSpan>[
            TextSpan(text: '长按', style: normalStyle),
            TextSpan(text: ' 我的邀请码 ', style: boldStyle),
            TextSpan(text: '获取邀请链接', style: normalStyle),
          ]),
          IntroWidget.section(index: 3, color: color, children: <TextSpan>[
            TextSpan(text: '或者长按', style: normalStyle),
            TextSpan(text: ' 二维码图片 ', style: boldStyle),
            TextSpan(text: '保存二维码到本地相册', style: normalStyle),
          ]),
          IntroWidget.section(index: 4, color: color, children: <TextSpan>[
            TextSpan(text: '将', style: normalStyle),
            TextSpan(text: ' 邀请链接 ', style: boldStyle),
            TextSpan(text: '或者', style: normalStyle),
            TextSpan(text: ' 邀请二维码 ', style: boldStyle),
            TextSpan(text: '分享给朋友', style: normalStyle),
          ]),
          IntroWidget.h2Title(title: '二、邀请好友的规则有哪些'),
          IntroWidget.section(index: 1, color: color, children: <TextSpan>[
            TextSpan(text: '每个用户能邀请多位好友', style: normalStyle),
          ]),
          IntroWidget.section(index: 2, color: color, children: <TextSpan>[
            TextSpan(text: '每个用户只能接受一位好友的邀请', style: normalStyle),
          ]),
          IntroWidget.h2Title(title: '三、邀请好友的奖励有哪些'),
          IntroWidget.section(index: 1, color: color, children: <TextSpan>[
            TextSpan(
                text: '推荐好友成功注册本学习平台，如果好友购买本平台的课程，推荐者即可获得课程费用的20%作为奖励。',
                style: normalStyle),
          ]),
          IntroWidget.section(index: 2, color: color, children: <TextSpan>[
            TextSpan(
                text: '如果被推荐好友进行 ① 操作，则推荐者可以获得课程费用的5%作为奖励。',
                style: normalStyle),
          ]),
        ],
      ),
    );
  }
}
