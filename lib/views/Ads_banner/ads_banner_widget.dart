import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_helper.dart';

class AdsBannerWidget extends StatefulWidget {
  final double paddingTop;
  final double paddingbottom;
  const AdsBannerWidget({Key? key, this.paddingTop = 15, this.paddingbottom = 15}) : super(key: key);

  @override
  State<AdsBannerWidget> createState() => _AdsBannerWidgetState();
}

class _AdsBannerWidgetState extends State<AdsBannerWidget> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  @override
  void initState() {
    _loadBannerAd();
    super.initState();
  }
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
            print("Well ADS");
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
          print("ADS error $err");
        },
      ),
    );

    _bannerAd.load();
    print("_isBannerAdReady $_isBannerAdReady");
  }
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => _isBannerAdReady ? Padding(
        padding: EdgeInsets.only(top: widget.paddingTop, bottom: widget.paddingbottom),
        child: Container(
          child: AdWidget(ad: _bannerAd),
          width: _bannerAd.size.width.toDouble(),
          height: 50.0,
          alignment: Alignment.center,
        ),
      ) : const SizedBox(),
    );
  }
}
