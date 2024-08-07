import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/bloc/money_market/auction_detail_bloc.dart';
import 'package:fnge/bloc/money_market/auction_leave_bloc.dart';
import 'package:fnge/extensions/navigation_extensions.dart';
import 'package:fnge/resources/colors.dart';
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
import 'auction_round/owner_round_detail_screen.dart';
import 'auction_round/round_detail_screen.dart';
import 'auction_round/start_round_detail_screen.dart';
import 'money_market_screen.dart';

class BillAuctionJoinedScreen extends StatefulWidget {
  final int auctionId;
  const BillAuctionJoinedScreen({required this.auctionId, Key? key})
      : super(key: key);

  @override
  State<BillAuctionJoinedScreen> createState() =>
      _BillAuctionJoinedScreenState();
}

class _BillAuctionJoinedScreenState extends State<BillAuctionJoinedScreen> {
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
  int leftUser = 0;
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
          billAuctionUserLists =
              (resp.data as AuctionDetailOb).data!.billAuctionUserLists ?? [];
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
                title: Text(
                  AppLocalizations.of(context)!.success,
                ),
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
                      Navigator.pop(context);
                      _auctionDetailBloc.getAuctionDetail(widget.auctionId);
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
            child: SingleChildScrollView(
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
                        description.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
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
                              )
                            : const SizedBox(),
                        const Divider(
                          height: 10,
                        ),
                        //  const AdsBannerWidget(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const NathanTextView(
                              text: "All Members",
                              fontWeight: FontWeight.w600,
                              color: colorPrimary,
                              fontSize: 20,
                            ),
                            NathanTextView(
                              text: "Left - $leftUser",
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                              fontSize: 18,
                            )
                          ],
                        ),
                        ListView.builder(
                          controller: scroll_controller,
                          itemCount: billAuctionUserLists.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              colorPrimary.withOpacity(0.8),
                                          child: const Icon(
                                            Icons.person,
                                            color: colorWhite,
                                            size: 25,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: NathanTextView(
                                          text:
                                              "${billAuctionUserLists[index].username}",
                                        )),
                                      ],
                                    ),
                                  ),
                                  leftUser > 0
                                      ? billAuctionUserLists[index].userId ==
                                              userId
                                          ? textButtonView(
                                              width: 70,
                                              text: "Leave",
                                              size: 14,
                                              backgroundColor: colorSeconary
                                                  .withOpacity(0.3),
                                              textColor: Colors.red,
                                              onTap: () {
                                                requestAuctionLeave(
                                                    billAuctionUserLists[index]
                                                        .auctionId!,
                                                    0);
                                                _auctionLeaveStream =
                                                    _auctionLeaveBloc
                                                        .auctionLeaveStream();
                                                _auctionLeaveStream
                                                    .listen((ResponseOb resp) {
                                                  if (resp.success) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Success'),
                                                            content: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Image.asset(
                                                                    'images/welcome.png',
                                                                    height: 100,
                                                                    width: 100),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  resp.message
                                                                      .toString(),
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  popBack(
                                                                      context:
                                                                          context);
                                                                  // _cartBloc.cartList();
                                                                  _auctionDetailBloc
                                                                      .getAuctionDetail(
                                                                          widget
                                                                              .auctionId);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'OK',
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        colorPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Leave group!'),
                                                            content: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Image.asset(
                                                                    'images/welcome.png',
                                                                    height: 100,
                                                                    width: 100),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  resp.message
                                                                      .toString(),
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  popBack(
                                                                      context:
                                                                          context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Cancel',
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        colorPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  popBack(
                                                                      context:
                                                                          context);
                                                                  requestAuctionLeave(
                                                                      billAuctionUserLists[
                                                                              index]
                                                                          .auctionId!,
                                                                      1);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'OK',
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        colorPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  }
                                                });
                                              })
                                          : const SizedBox()
                                      : const SizedBox(),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    leftUser == 0
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: LongButtonView(
                                text: "Join New bidder this group",
                                onTap: () {
                                  requestAuctionRule();
                                }),
                          ),
                  ],
                ),
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
