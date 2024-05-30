import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';
import 'package:nathan_app/widgets/nathan_text_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../bloc/gift_card/gift_buy_bloc.dart';
import '../../../bloc/gift_card/gift_package_bloc.dart';
import '../../../helpers/response_ob.dart';
import '../../../helpers/shared_pref.dart';
import '../../../objects/gift_card/gift_package_ob.dart';
import '../../../widgets/long_button_view.dart';
import '../../../widgets/success_back_alert_widget.dart';
import '../../widgets/error_alert_widget.dart';
import '../top_up/success_bill_screen.dart';


class GiftCardDetailScreen extends StatefulWidget {
  final String shopCover;
  final String shopProfile;
  final String shopTag;
  final String shopName;
  final bool isServer;
  GiftCardDetailScreen({required this.shopCover, required this.shopProfile,
    required this.shopTag, required this.shopName, required this.isServer});

  @override
  State<GiftCardDetailScreen> createState() => _GiftCardDetailScreenState();
}

class _GiftCardDetailScreenState extends State<GiftCardDetailScreen> {
  bool isLoading = true;
  final double topWidgetHeight = 250.0;
  final double avatarRadius = 100.0;

  int? selectedIndex;

  final TextEditingController playerIdController = TextEditingController();
  final TextEditingController zoneIdController = TextEditingController();

  final _giftPackageBloc = GiftPackageBloc();
  late Stream<ResponseOb> _giftPackageStream;
  List<Packages> giftPackageList = [];

  final _gift_buy_Bloc = GiftBuyBloc();
  late Stream<ResponseOb> _gift_buy_Stream;

String packageName = "";
  @override
  void initState() {
    super.initState();
    getUserData();
    _giftPackageStream = _giftPackageBloc.giftPackageStream();
    _giftPackageStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          isLoading = false;
          giftPackageList = GiftPackageOb.fromJson(resp.data).data?.packages ?? [];
        });
      } else {}
    });
    _giftPackageBloc.getGiftPackageList(widget.shopTag);


    _gift_buy_Stream = _gift_buy_Bloc.giftBuyStream();
    _gift_buy_Stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
                return const SuccessBillScreen(isGift: true,);
              }), (route) => false);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Oops !",
              Image.asset('images/welcome.png'),
              resp.message.toString(),
            );
          },
        );
        setState(() {
          isLoading = false;
        });
        return;}
    });
  }
  String? userId = '0';
  getUserData() async {
    String? accountId = await SharedPref.getData(key: SharedPref.accountId);
    userId = accountId;
  }
  String pkgID = "0";
  void requestGiftBuy() {
    Map<String, dynamic> map = {
      "player_id": playerIdController.text.trim(),
      "server_id": widget.isServer ? zoneIdController.text.trim() : "0000",
      "package_id": pkgID,
      "user_id": userId,
    };
    _gift_buy_Bloc.requestGiftBuy(data: map);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
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
      return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 30.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:  NetworkImage(widget.shopCover),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          NathanTextView(text: "Input User ID", color: colorGrey.withOpacity(0.8), fontSize: 16,),
                                          const SizedBox(height: 5,),
                                          SizedBox(
                                            height: 50,
                                            child: TextField(
                                              controller: playerIdController,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly,
                                                LengthLimitingTextInputFormatter(12),
                                              ],
                                              keyboardType: TextInputType.number,
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    widget.isServer ? const SizedBox(width: 10,) : const SizedBox(),
                                    widget.isServer ? Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          NathanTextView(text: "Zone ID", color: colorGrey.withOpacity(0.8), fontSize: 16,),
                                          const SizedBox(height: 5,),
                                          SizedBox(
                                            height: 50,
                                            child: TextField(
                                              controller: zoneIdController,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly,
                                                LengthLimitingTextInputFormatter(6),
                                              ],
                                              keyboardType: TextInputType.number,
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ) : const SizedBox(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              NathanTextView(text: "Select", color: colorGrey.withOpacity(0.8), fontSize: 16.sp,),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 3),
                                  itemCount: giftPackageList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:  EdgeInsets.symmetric(vertical: 0.8.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: selectedIndex == index ? topColors : colorWhite,
                                          border: Border.all(color: selectedIndex == index ? topColors : colorGrey.withOpacity(0.8)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10,),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                                          title: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${giftPackageList[index].giftCardAmount} ${giftPackageList[index].unit}"),
                                              Text("${giftPackageList[index].priceMmk} Ks"),
                                            ],
                                          ),
                                          tileColor: selectedIndex == index ? topColors : null,
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = index;
                                              int pkgid = giftPackageList[index].id ?? 0;
                                              pkgID = pkgid.toString();
                                              packageName = "${giftPackageList[index].giftCardAmount} ${giftPackageList[index].unit}";
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 2.h),
                                child: LongButtonView(
                                    text: "Buy Now",
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      if(widget.isServer ? playerIdController.text.isEmpty || zoneIdController.text.isEmpty : playerIdController.text.isEmpty) {
                                        context.showSnack(widget.isServer ?"Please enter your Player Id & Server Id first!" : "Please enter your Player Id first!",
                                          Colors.white,
                                          Colors.red,
                                          Icons.close,
                                        );
                                      } else if(pkgID == "0") {
                                        context.showSnack("Please select which package!",
                                          Colors.white,
                                          Colors.red,
                                          Icons.close,
                                        );
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:  const Text("Gift Card Info Detail",),
                                                content: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Image.asset('images/welcome.png', height: 100, width: 100),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      "Player ID : ${playerIdController.text}",
                                                    ),
                                                    widget.isServer ? Text(
                                                      "Zone ID : ${zoneIdController.text}",
                                                    ) : const SizedBox(),
                                                    Text(
                                                      "Package : $packageName",
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      popBack(context: context);
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: colorPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      popBack(context: context);
                                                      requestGiftBuy();
                                                    },
                                                    child: const Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                        color: colorPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 30,
                  child: GestureDetector(
                    onTap: ()=> Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                  ),
                ),
                Positioned(
                  left: 3.h,//MediaQuery.of(context).size.width * 0.05,
                  top: 25.h,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image:  NetworkImage(widget.shopProfile),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 15.h, //MediaQuery.of(context).size.width * 0.28,
                  top: 30.h, //MediaQuery.of(context).size.height * 0.32,
                  child: NathanTextView(text: "${widget.shopName}", color: Colors.black, fontSize: 18.sp,),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}