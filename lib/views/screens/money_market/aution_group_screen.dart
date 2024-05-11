import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/money_market/auction_detail_bloc.dart';
import 'package:nathan_app/bloc/money_market/auction_leave_bloc.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../bloc/money_market/auction_insterest_bloc.dart';
import '../../../bloc/money_market/auction_round_bloc.dart';
import '../../../helpers/response_ob.dart';
import '../../../helpers/shared_pref.dart';
import '../../../objects/money_market/Auction_round_ob.dart';
import '../../../objects/money_market/auction_detail_ob.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/long_button_view.dart';
import '../../../widgets/nathan_text_view.dart';
import '../../Ads_banner/ads_banner_widget.dart';
import 'all_member_view.dart';
import 'auction_round/end_bid_round_screen.dart';
import 'auction_round/owner_round_detail_screen.dart';
import 'auction_round/round_detail_screen.dart';
import 'auction_round/start_round_detail_screen.dart';
import 'money_market_screen.dart';

class AuctionGroupScreen extends StatefulWidget {
  final int auctionId;
  const AuctionGroupScreen({required this.auctionId,
    Key? key})
      : super(key: key);

  @override
  State<AuctionGroupScreen> createState() => _AuctionGroupScreenState();
}

class _AuctionGroupScreenState extends State<AuctionGroupScreen> {
  bool isLoading = false;
  bool _agreeVisible = true;
  final scroll_controller = ScrollController();

  final _auctionRound_bloc = AuctionRoundBloc();
  late Stream<ResponseOb> _auctionRound_stream;
  //payment metnod list
  List auctionRoundList = [];

  Future refersh() async {
    setState(() {
      _auctionDetailBloc.getAuctionDetail(widget.auctionId);
      _auctionRound_bloc.getAuctionRound(widget.auctionId);
    });
  }
  final _auctionDetailBloc = AuctionDetailBloc();
  late Stream<ResponseOb> _auctionDetailStream;
  List<BillAuctionUserLists> billAuctionUserLists = [];

  final _auctionInstBloc = AuctionInsterestBloc();
  late Stream<ResponseOb> _auctionInsteStream;

  final _auctionLeaveBloc = AuctionLeaveBloc();
  late Stream<ResponseOb> _auctionLeaveStream;

  String title = "";
  String description = "";
  String amount = "";
  int limitCount = 0;
  int existingUsers = 0;
  int leftUser = 10;
  @override
  void initState() {
    super.initState();
    getUserData();
    _auctionDetailBloc.getAuctionDetail(widget.auctionId);
    _auctionDetailStream = _auctionDetailBloc.auctionDetailStream();
    _auctionDetailStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          title = resp.data.data.title;
          description = resp.data.data.description;
          amount = resp.data.data.amount;
          limitCount = resp.data.data.stardardLimit;
          leftUser = resp.data.data.leftUser;
          existingUsers = resp.data.data.existingUsers;
          billAuctionUserLists = (resp.data as AuctionDetailOb).data!.billAuctionUserLists ?? [];
        });
      } else {}
    });

    /// request join stream
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (co) => const MoneyMarketScreen()));
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

    // round monthly
    _auctionRound_stream = _auctionRound_bloc.auctionRoundStream();
    _auctionRound_stream.listen((ResponseOb resp) {
      if (resp.success) {
        auctionRoundList = (resp.data as AuctionRoundOb).data ?? [];
        print("auctionRoundList ${auctionRoundList.length}");
      } else {
        print("error");
      }
      setState(() {
        isLoading = false;
      });
    });
    _auctionRound_bloc.getAuctionRound(widget.auctionId);
  }
  int? userId = 0;
  getUserData() async {
    String? accountId = await SharedPref.getData(key: SharedPref.accountId);
    userId = int.parse(accountId!);
  }

  void requestAuctionLeave(int auctionId, int isSecure) {
    Map<String, dynamic> map = {
      'isSecure': isSecure,
    };
    _auctionLeaveBloc.getAuctionLeave(auctionID: auctionId, data: map);
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
              text: "Bill Auction Group",
            ),
          ),
          body: RefreshIndicator(
            onRefresh: refersh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NathanTextView(
                            text: title,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          NathanTextView(
                            text: amount,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: colorPrimary,
                          ),
                        ],
                      ),
                      description.isNotEmpty ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const NathanTextView(
                              text: "Description",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            NathanTextView(
                              text: description,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ],
                        ),
                      ) : const SizedBox(),
                      const Divider(height: 10,),
                      const AdsBannerWidget(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: leftUser > 0 ? 0 : 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const NathanTextView(
                              text: "All Round Bid",
                              fontWeight: FontWeight.w600,
                              color: colorPrimary,
                              fontSize: 20,),
                            textButtonView(
                              width: 120,
                              text: "Members View",
                              size: 14,
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: colorSeconary.withOpacity(0.3),
                              textColor: colorPrimary,
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (co)=> AllMemberView(auctionId: widget.auctionId,))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // get round
                  AuctionRoundView(auctionRoundList: auctionRoundList,)
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

class AuctionRoundView extends StatelessWidget {
  final List auctionRoundList;
  const AuctionRoundView({Key? key, required this.auctionRoundList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2),
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.zero, // padding around the grid
        itemCount: auctionRoundList.length, // total number of items
        itemBuilder: (context, index) {
          return auctionRoundList[index].statusMessage == "Pending" ? const SizedBox() : GestureDetector(
            onTap: (){
              auctionRoundList[index].userId != null ? print("can't go") : Navigator.push(context, MaterialPageRoute(builder: (co) =>
              // auctionRoundList[index].userId != null ? OwnerRoundDetailScreen(
              //   roundId: auctionRoundList[index].id,
              //   roundNumber: auctionRoundList[index].roundNumber,
              //   realAmt: auctionRoundList[index].realAmount.toString(),
              //   estimateAmt: auctionRoundList[index].baseAmount.toString(),
              //    winnerBidName: auctionRoundList[index].userinfo.username,
              // ) :
              auctionRoundList[index].roundBidStop == 1 ? DoneBidRoundScreen(roundId: auctionRoundList[index].id, roundName: auctionRoundList[index].roundNumber,) :
              StartRoundDetailScreen(roundId: auctionRoundList[index].id, roundNumber: auctionRoundList[index].roundNumber,
                baseAmount: auctionRoundList[index].baseAmount.toString(),
              ),
              )
              );
            },
            child: Container(
                decoration: BoxDecoration(
                  color: topColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${auctionRoundList[index].roundNumber}",
                      style: const TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    auctionRoundList[index].userId == null ? const SizedBox() : Text(
                      "Bid Price - ${auctionRoundList[index].realAmount}",
                      style: const TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Ask Price - ${auctionRoundList[index].baseAmount}",
                      style: const TextStyle(fontSize: 14.0, color: Colors.white,fontWeight: FontWeight.w600),
                    ),
                    Column(
                      children: [
                        Text(
                          auctionRoundList[index].userId == null ? "" : "Winner Bidder name",
                          style: const TextStyle(fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.w600),
                        ),
                        Text(
                          auctionRoundList[index].userId == null ? "" : "${auctionRoundList[index].userinfo.username ?? ""}",
                          style: const TextStyle(fontSize: 18.0, color: colorPrimary,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                )
            ),
          );
        },
      ),
    );
  }
}

