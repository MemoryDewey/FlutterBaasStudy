import 'package:baas_study/icons/font_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WalletIconText extends StatelessWidget {
  final IconData iconData;
  final String iconText;
  final void Function() onTap;

  const WalletIconText({
    Key key,
    this.iconData,
    this.iconText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  iconData,
                  size: 30,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Text(iconText)
          ],
        ),
      ),
    );
  }
}

class WalletBalanceWidget extends StatefulWidget {
  final String balance;
  final String buttonText;
  final void Function() buttonPress;

  const WalletBalanceWidget({
    Key key,
    this.balance,
    this.buttonText,
    this.buttonPress,
  }) : super(key: key);

  @override
  _WalletBalanceWidgetState createState() => _WalletBalanceWidgetState();
}

class _WalletBalanceWidgetState extends State<WalletBalanceWidget> {
  bool _showBalance = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Container(
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.only(top: 20, bottom: 40),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '余额',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showBalance = !_showBalance;
                      });
                    },
                    child: Icon(
                      _showBalance
                          ? Icons.visibility
                          : FontIcons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Text(
                _showBalance ? widget.balance : '*****',
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -20,
          child: CupertinoButton(
            child: Text(widget.buttonText),
            color: Colors.red,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
            onPressed: widget.buttonPress,
          ),
        ),
      ],
    );
  }
}
