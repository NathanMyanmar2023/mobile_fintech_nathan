import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/objects/money_market/Auction_rule_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../bloc/money_market/auction_insterest_bloc.dart';
import '../../../bloc/money_market/auction_rule_bloc.dart';
import '../../../helpers/response_ob.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/long_button_view.dart';
import '../../../widgets/nathan_text_view.dart';
import 'agree_selection_view.dart';
import 'money_market_screen.dart';

class BillAuctionScreen extends StatefulWidget {
  final int auctionId;
  final String auctionName;
  final String auctionAmt;
  const BillAuctionScreen({required this.auctionId, required this.auctionName, required this.auctionAmt, Key? key})
      : super(key: key);

  @override
  State<BillAuctionScreen> createState() => _BillAuctionScreenState();
}

class _BillAuctionScreenState extends State<BillAuctionScreen> {
  bool isLoading = false;
  bool _agreeVisible = true;
  final scroll_controller = ScrollController();

  Future refersh() async {
    setState(() {});
  } 
  final _auctionRuleBloc = AuctionRuleBloc();
  late Stream<ResponseOb> _auctionRuleStream;
  List auctionRuleList = [];

  final _auctionInstBloc = AuctionInsterestBloc();
  late Stream<ResponseOb> _auctionInsteStream;

  @override
  void initState() {
    super.initState();
    getAuctionRule();
    _auctionRuleStream = _auctionRuleBloc.auctionRuleStream();
    _auctionRuleStream.listen((ResponseOb resp) {
      print("ress ${resp.success}");
      if (resp.success) {
        setState(() {
          auctionRuleList = (resp.data as AuctionRuleOb).data ?? [];
          print("auctionRuleList $auctionRuleList");
        });
      } else {}
    });

    /// add to cart stream
    _auctionInsteStream = _auctionInstBloc.auctionInstStream();
    _auctionInsteStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title:  Text(AppLocalizations.of(context)!.success,),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/welcome.png', height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      resp.message.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      popBack(context: context);
                      popBack(context: context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
      } else {
        setState(() {
        isLoading = false;
      });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error!'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/welcome.png', height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      resp.message.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      popBack(context: context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
      }
    });
  }


  void getAuctionRule() {
    Map<String, dynamic> map = {
    'auctionID': widget.auctionId,
  };
    _auctionRuleBloc.getAuctionRule(data: map);
  }

  void requestAuctionRule() {
    Map<String, dynamic> map = {
      'agress': 1,
      'auctionID': widget.auctionId,
    };
    _auctionInstBloc.requestAuctionInst(data: map);
    setState(() {
      isLoading = true;
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
            child: AppBarTitleView(
              text: "Bill Auction",
            ),
          ),
          body: RefreshIndicator(
            onRefresh: refersh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NathanTextView(
                              text: widget.auctionName,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            NathanTextView(
                              text: widget.auctionAmt,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: colorPrimary,
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20,),
                          child: NathanTextView(
                            text: "Terms & Conditions",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,),
                          child: Container(
                            height: 2,
                            width: 100,
                            color: colorPrimary,
                          ),
                        ),
                        ListView.builder(
                          controller: scroll_controller,
                          itemCount: auctionRuleList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return NathanTextView(text: "${auctionRuleList[index]}");
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: AgreeSectionView(
                            isSelected: _agreeVisible,
                            onChange: (value) {
                              setState(() {
                                _agreeVisible = value;
                                print("dooe $_agreeVisible}");
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: LongButtonView(
                      text: "Join",
                      onTap: () {
                        _agreeVisible ? context.showSnack("Please make sure of agree our Terms & Condition",
                          Colors.white,
                          Colors.red,
                          Icons.close,
                        ) : requestAuctionRule();
                      }
                    ),
                  )
                ],
              ),
            ),
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
}
