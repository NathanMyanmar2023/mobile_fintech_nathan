// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class AppAds {
//   static bannerAds(BuildContext context) {
//     return Builder(builder: (ctx) {
//       final BannerAd myBanner = BannerAd(
//         adUnitId: 'ca-app-pub-3940256099942544/6300978111',
//         request: const AdRequest(),
//         listener: const BannerAdListener(),
//         size: AdSize.banner,
//       );
//       myBanner.load();
//       return Container(
//         alignment: Alignment.center,
//         width: myBanner.size.width.toDouble(),
//         height: myBanner.size.height.toDouble(),
//         child: AdWidget(
//           ad: myBanner,
//           key: Key(myBanner.hashCode.toString()),
//         ),
//       );
//     });
//   }
// }