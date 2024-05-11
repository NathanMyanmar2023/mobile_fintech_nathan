import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

class TestADSView extends StatefulWidget {
  const TestADSView({Key? key}) : super(key: key);

  @override
  State<TestADSView> createState() => _TestADSViewState();
}

class _TestADSViewState extends State<TestADSView> {
  AdRequest? adRequest;
  BannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
    String bannerUnitId = Platform.isAndroid ? "ca-app-pub-8463236560007525/3314380628" : "ca-app-pub-8463236560007525/3314380628";
    adRequest = const AdRequest(
      nonPersonalizedAds: false,
    );
    BannerAdListener bannerAdListener = BannerAdListener(
      onAdClosed: (ad) {
        bannerAd!.load();
      },
      onAdFailedToLoad: (ad, error){
        bannerAd!.load();
    },
    );
    bannerAd = BannerAd(size: AdSize.banner, adUnitId: bannerUnitId, listener: bannerAdListener, request: adRequest!,);
    bannerAd!.load();
  }

  @override
  void dispose() {
    bannerAd!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdWidget(ad: bannerAd!),
    );
  }
}
