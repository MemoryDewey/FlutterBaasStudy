import 'package:baas_study/icons/font_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class WalletCardWidget extends StatefulWidget {
  final void Function(int index) onChanged;

  const WalletCardWidget({Key key, this.onChanged}) : super(key: key);

  @override
  _WalletCardWidgetState createState() => _WalletCardWidgetState();
}

class _WalletCardWidgetState extends State<WalletCardWidget> {
  final List<_WalletCardModel> _walletCardList = [
    _WalletCardModel(
      image: 'assets/images/wallet_card_balance.png',
      icon: FontIcons.coin,
      name: '课程币',
    ),
    _WalletCardModel(
      image: 'assets/images/wallet_card_bst.png',
      icon: FontIcons.bst_coin,
      name: 'B S T',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      height: 200,
      color: Theme.of(context).cardColor,
      child: Swiper(
        itemBuilder: (context, index) {
          return WalletCard(
            assetImagePath: _walletCardList[index].image,
            iconData: _walletCardList[index].icon,
            name: _walletCardList[index].name,
          );
        },
        itemCount: 2,
        viewportFraction: 0.75,
        scale: 0.8,
        loop: false,
        duration: 500,
        onIndexChanged: widget.onChanged,
      ),
    );
  }
}


class _WalletCardModel {
  final String image;
  final IconData icon;
  final String name;

  _WalletCardModel({this.image, this.icon, this.name});
}

class WalletCard extends StatelessWidget {
  final String assetImagePath;
  final IconData iconData;
  final String name;

  const WalletCard({
    Key key,
    this.assetImagePath,
    this.iconData,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetImagePath),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                iconData,
                size: 48,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
