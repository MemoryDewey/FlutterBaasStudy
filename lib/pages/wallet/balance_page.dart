import 'package:baas_study/icons/font_icon.dart';
import 'package:baas_study/pages/wallet/balance_detail_page.dart';
import 'package:baas_study/pages/wallet/balance_intro_page.dart';
import 'package:baas_study/providers/user_provider.dart';
import 'package:baas_study/routes/router.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatefulWidget {
  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '账户余额',
        tailTitle: '余额明细',
        tailOnTap: () {
          Navigator.push(context, SlideRoute(BalanceDetailPage()));
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Text(
                  '总余额',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontIcons.coin,
                      size: 48,
                      color: Color(0xffdcbb70),
                    ),
                    SizedBox(width: 10),
                    Consumer<UserProvider>(
                      builder: (context, user, child) => Text(
                        user.balance,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 40,
                          height: 1.3,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: RichText(
              text: TextSpan(
                  text: '余额说明',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.lightBlue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context, SlideRoute(BalanceIntroPage()));
                    }),
            ),
          )
        ],
      ),
    );
  }
}
