
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nathan_app/objects/history/invest_profit_history_ob.dart';
import '../../../bloc/shopping/category_bloc.dart';
import '../../../helpers/response_ob.dart';
import '../../../objects/shopping/category_view_ob.dart';
import '../../../resources/colors.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/nathan_text_view.dart';
import '../../Ads_test/ad_helper.dart';
import '../../Ads_test/test_ads_view.dart';
import 'brands_screen.dart';

class CategoryScreen extends StatefulWidget {
  final bool isMain;
  const CategoryScreen({Key? key,this.isMain = false}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final _categoryBloc = CategoryBloc();
  late Stream<ResponseOb> _categoryStream;
  List<CategoryViewData> categoryViewList = [];

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _categoryStream = _categoryBloc.categoryStream();
    _categoryStream.listen((ResponseOb resp) {
      print("rese ${resp.loadPostState}");
      if (resp.success) {
        setState(() {
          categoryViewList = (resp.data as CategoryViewOb).data ?? [];
        });
      } else {}
    });

    _categoryBloc.getCategoryList();
  }

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

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


  var imageUrl = "https://images.unsplash.com/photo-1554080353-a576cf803bda?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGhvdG98ZW58MHx8MHx8fDA%3D";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(widget.isMain ? 60 : 0),
          child: AppBarTitleView(
            text: AppLocalizations.of(context)!.category,
          ),),
      body: categoryViewList.isEmpty ?
      Center(
              child: Text(
                    AppLocalizations.of(context)!.no_more_data,),
            ) :
      SingleChildScrollView(
        child: ListView.builder(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            itemCount: categoryViewList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (co) =>
                        BrandsScreen(categoryId: categoryViewList[index].id ?? 0,)
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      color: topColors.withOpacity(0.3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NathanTextView(
                                  text: categoryViewList[index].name,
                                  color: colorBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                Container(
                                  width: double.tryParse("${categoryViewList[index].name!.length * 8}"), //MediaQuery.of(context).size.width * 0.2,
                                  height: 2,
                                  color: colorPrimary,
                                  margin: const EdgeInsets.only(top: 3),
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: colorSeconary.withOpacity(0.3),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: CachedNetworkImage(
                              imageUrl: categoryViewList[index].photo ?? imageUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                index % 4 == 0 ? _isBannerAdReady ? getAd() : const SizedBox() : const SizedBox(),
                // index%2 == 1 ? _isBannerAdReady ?
                // bannerAdWidget(): const SizedBox() : const SizedBox(),
              ],
            )),
      ),
    );
  }

  Widget bannerAdWidget() {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        child: AdWidget(ad: _bannerAd),
        width: _bannerAd.size.width.toDouble(),
        height: 100.0,
        alignment: Alignment.center,
      ),
    );
  }

  Widget getAd() {
    BannerAdListener bannerAdListener = BannerAdListener(
        onAdWillDismissScreen: (ad){
      ad.dispose();
    }, onAdClosed: (ad) {
      debugPrint("Ad Got Closed");
    });
    BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid ? "ca-app-pub-8463236560007525/3314380628" : "ca-app-pub-8463236560007525/3314380628",
      listener: bannerAdListener,
      request: const AdRequest(),
    );
    bannerAd.load();
    return SizedBox(
      height: 100,
      child: AdWidget(ad: bannerAd,),
    );
  }
}
