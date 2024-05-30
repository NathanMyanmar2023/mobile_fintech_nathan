import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../bloc/gift_card/gift_shop_bloc.dart';
import '../../../objects/gift_card/gift_shop_ob.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/nathan_text_view.dart';
import 'gift_card_detail_screen.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({
    super.key,
  });

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  bool isLoading = true;


  final _giftShopBloc = GiftShopBloc();
  late Stream<ResponseOb> _giftShopStream;
  List<GiftShopData> giftShopList = [];

  @override
  void initState() {
    super.initState();
    _giftShopStream = _giftShopBloc.giftShopStream();
    _giftShopStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          isLoading = false;
          giftShopList = GiftShopOb.fromJson(resp.data).data ?? [];
        });
      } else {}
    });
    _giftShopBloc.getGiftShopList();
  }


  bool isSixMonth = false;
  final scroll_controller = ScrollController();

  Future refersh() async {
    setState(() {
      _giftShopBloc.getGiftShopList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SpinKitFadingFour(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven ? Colors.blue : Colors.grey.shade800,
                ),
              );
            },
          ),
        ),
      );
    } else {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBarTitleView(text: "Gift Card",),
          ),
          body: RefreshIndicator(
            onRefresh: refersh,
            child: giftShopList.isEmpty ?
            Center(
              child: Text(
                AppLocalizations.of(context)!.no_more_data,),
            ) :
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.7),
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 8.0, // spacing between rows
                    crossAxisSpacing: 10.0, // spacing between columns
                  ),
                  padding: EdgeInsets.zero, // padding around the grid
                  itemCount: giftShopList.length, // total number of items
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (giftShopList[index].stockLeft == 0) {
                          context.showSnack("Out of Stock!",
                            Colors.white,
                            Colors.red,
                            Icons.close,
                          );
                        } else if (giftShopList[index].open == 0) {
                          context.showSnack("Gift Card is unavailable!",
                            Colors.white,
                            Colors.red,
                            Icons.close,
                          );
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (co) =>
                              GiftCardDetailScreen(
                                shopCover: "${giftShopList[index].shopCover}",
                                shopProfile: "${giftShopList[index].shopProfile}",
                                shopTag: "${giftShopList[index].tag}",
                                shopName: "${giftShopList[index].shopName}",
                                  isServer: giftShopList[index].isServer == 1 ? true : false,
                              )
                          ));
                        }
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 18.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image:  NetworkImage("${giftShopList[index].shopLogoUrl}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              giftShopList[index].stockLeft == 0 ? Positioned(
                                top: 0,
                                right: 0,
                                bottom: 0,
                                left: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Center(
                                      child: Text("Out of Stock", style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.w600, fontSize: 16.sp)),
                                    )
                                ),
                              ) : const SizedBox(),
                              giftShopList[index].open == 0 ? Positioned(
                                top: 0,
                                right: 0,
                                bottom: 0,
                                left: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Center(
                                      child: Text("Unavailable", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 16.sp)),
                                    )
                                ),
                              ) : const SizedBox(),
                            ],
                          ),
                         const SizedBox(height: 5,),
                          NathanTextView(text: "${giftShopList[index].shopName}", isCenter: true,),
                        ],
                      ),
                    );
                  },
                ),
              )
          ),
        ),
      );
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scroll_controller.dispose();
  }

  String money_format(String amount) {
    double amountDouble = double.parse(amount);
    String formattedAmount = NumberFormat.currency(
      locale: 'en_US',
      decimalDigits: 2,
      symbol: '',
    ).format(amountDouble);
    return formattedAmount.toString();
  }
}
