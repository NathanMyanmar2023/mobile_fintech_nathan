import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnge/bloc/money_market/bid_stop_bloc.dart';
import 'package:fnge/extensions/navigation_extensions.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/custom/snack_bar.dart';
import 'package:fnge/views/screens/money_market/auction_round/success_bid_round_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../bloc/money_market/auction_round_monthly_bid_bloc.dart';
import '../../../../bloc/money_market/request_auction_round_monthly_bid_bloc.dart';
import '../../../../helpers/response_ob.dart';
import '../../../../helpers/shared_pref.dart';
import '../../../../objects/money_market/auction_round_monthly_bid_ob.dart';
import '../../../../widgets/app_bar_title_view.dart';
import '../../../../widgets/long_button_view.dart';
import '../../../../widgets/nathan_text_view.dart';
import 'end_bid_round_screen.dart';
import 'no_pay_done_screen.dart';

class StartRoundDetailScreen extends StatefulWidget {
  final int roundId;
  final String roundNumber;
  final String baseAmount;
  const StartRoundDetailScreen(
      {Key? key,
      required this.roundId,
      required this.roundNumber,
      required this.baseAmount})
      : super(key: key);

  @override
  State<StartRoundDetailScreen> createState() => _StartRoundDetailScreenState();
}

class _StartRoundDetailScreenState extends State<StartRoundDetailScreen> {
  Future refersh() async {
    setState(() {
      _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
    });
  }

  var ticketTec = TextEditingController();

  final _roundMonthlyBidBloc = AuctionRoundMonthlyBidBloc();
  late Stream<ResponseOb> _roundMonthlyBidStream;
  List<BidUsersLists> bidUsersLists = [];

  int totalBidUser = 0;
  int roundBidStop = 0;
  String lastBidAmount = "";
  String lastBidUsername = "";
  String bidStarTime = "";
  String bitstandardAmount = "";
  bool noOneUserPage = false;
  final _requestRoundMonthlyBidBloc = RequestAuctionRoundMonthlyBidBloc();
  late Stream<ResponseOb> _requestRoundMonthlyBidStream;
  Timer? autoRefersh;

  final _bidStopBloc = BidStopBloc();
  late Stream<ResponseOb> _bidStopStream;

  Timer? payTime;
  int payStart = 10;

  bool noOneStartCheck = false;
  bool noOne = false;
  Timer? noOneTime;
  int noOneStart = 10;
  @override
  void initState() {
    super.initState();
    autoRefersh = Timer.periodic(const Duration(seconds: 10),
        (Timer t) => _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId));
    oneStartBillTimer();
    // get round bid history
    _roundMonthlyBidStream = _roundMonthlyBidBloc.auctionRoundMonthlyStream();
    _roundMonthlyBidStream.listen((ResponseOb resp) {
      print("resp.message ${resp.message}");
      if (resp.success) {
        if (resp.message == "Sorry, there are no one users") {
          setState(() {
            noOneUserPage = true;
            noOneStartCheck = true;
            // print("No one pay of bid $totalBidUser");
            // Timer.periodic(const Duration(seconds: 10),
            //         (Timer t) {
            //   setState(() {
            //     context.showSnack("There are no one users pay of bid. Now Starting final Count time!",
            //       Colors.white,
            //       Colors.red,
            //       Icons.close,
            //     );
            //     noOneStart = 10;
            //     noOne = true;
            //     const oneSec = Duration(seconds: 1);
            //     noOneTime = Timer.periodic(
            //       oneSec,
            //           (Timer timer) {
            //         if (noOneStart == 0) {
            //           setState(() {
            //             timer.cancel();
            //             noOneTime!.cancel();
            //             context.showSnack("Now Bill Auction is stop. We will inform Tomorrow who is winner for ${widget.roundNumber}",
            //               Colors.white,
            //               Colors.red,
            //               Icons.close,
            //             );
            //           });
            //         } else {
            //           setState(() {
            //             noOneStart--;
            //           });
            //         }
            //       },
            //     );
            //   });
            //         },);
          });
        } else {
          setState(() {
            noOneStartCheck = false;
            totalBidUser = resp.data.data.totalBidUser ?? 0;
            roundBidStop = resp.data.data.roundBidStop ?? 0;
            lastBidAmount = resp.data.data.lastBidUser.amount ?? "0";
            bitstandardAmount = resp.data.data.bitstandardAmount ?? "0";
            bidStarTime = resp.data.data.bitStartime ?? "0";
            bidUsersLists =
                (resp.data as AuctionRoundMonthlyBidOb).data!.bidUsersLists ??
                    [];

            if (roundBidStop == 1) {
              setState(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (co) => DoneBidRoundScreen(
                      roundId: widget.roundId,
                      roundName: widget.roundNumber,
                    ),
                  ),
                );
              });
            }
          });
        }
      } else {}
    });
    _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);

// request new bid
    _requestRoundMonthlyBidStream =
        _requestRoundMonthlyBidBloc.requestAuctionRoundMonthlyStream();
    _requestRoundMonthlyBidStream.listen((ResponseOb resp) {
      if (resp.message == "Success") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Success Bid!'),
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
                      setState(() {
                        popBack(context: context);
                        _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
                        startTimer();
                      });
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
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('New Bid Error!'),
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
                      if (resp.message.toString() ==
                          "Sorry, there are not have other one bid user") {
                        setState(() {
                          startTimer();
                        });
                      } else {
                        setState(() {
                          _roundMonthlyBidBloc
                              .getRoundMonthlyBid(widget.roundId);
                        });
                      }
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

  oneStartBillTimer() async {
    setState(() {
      noOneStart = 10;
      const oneSec = Duration(seconds: 1);
      noOneTime = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (noOneStart == 0) {
            setState(() {
              _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
              timer.cancel();
              noOneTime!.cancel();
              if (noOneStartCheck == true) {
                setState(() {
                  context.showSnack(
                    "There are no one users pay of bid. Now Starting final Count time!",
                    Colors.white,
                    Colors.red,
                    Icons.close,
                  );
                  noOneStart = 10;
                  noOne = true;
                  const oneSec = Duration(seconds: 1);
                  noOneTime = Timer.periodic(
                    oneSec,
                    (Timer timer) {
                      if (noOneStart == 0) {
                        setState(() {
                          timer.cancel();
                          noOneTime!.cancel();
                          setState(() {
                            _roundMonthlyBidBloc
                                .getRoundMonthlyBid(widget.roundId);
                            print("totalBidUser $totalBidUser");
                            if (totalBidUser == 0 && noOneStartCheck == true) {
                              print("request stop bid round");
                              // request stop bid round
                              _bidStopBloc.requestBidStop(widget.roundId);
                              _bidStopStream = _bidStopBloc.bidStopStream();
                              _bidStopStream.listen((ResponseOb resp) {
                                print("roeo ${resp.message}");
                                if (resp.success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (co) => NoPayDoneScreen(
                                              roundNumber: widget.roundNumber,
                                            )),
                                  );
                                } else {}
                              });
                            } else {
                              noOneStartCheck = false;
                            }
                          });
                        });
                      } else {
                        setState(() {
                          noOneStart--;
                        });
                      }
                    },
                  );
                });
              }
            });
          } else {
            setState(() {
              noOneStart--;
            });
          }
        },
      );
    });
  }

  bool finalCount = false;

  Timer? _waittimer;
  int _start = 10;
  firstCallTimer() async {
    print("calling final");
    _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
    String? accountId = await SharedPref.getData(key: SharedPref.accountId);
    int userId = int.parse(accountId!);
    print("usood $userId & ${userId.runtimeType}");
    print(
        "bidUsersLists.last.userId ${bidUsersLists.first.userId} & ${bidUsersLists.last.userId.runtimeType}");
    print("acccu $accountId");
    if (bidUsersLists.first.userId == userId) {
      print("samme");
      setState(() {
        finalCount = true;
        _start = 10;
        const oneSec = Duration(seconds: 1);
        _waittimer = Timer.periodic(
          oneSec,
          (Timer timer) {
            if (_start == 0) {
              setState(() {
                timer.cancel();
                _waittimer!.cancel();
                setState(() {
                  _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
                  if (bidUsersLists.first.userId == userId) {
                    print("same;");
                    finalCallTimer();
                  } else {
                    finalCount = false;
                    print("noo same;");
                  }
                });
              });
            } else {
              setState(() {
                _start--;
              });
            }
          },
        );
      });
    } else {
      setState(() {
        finalCount = false;
        _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
      });
      print("no same");
      print("noOneUserPage $noOneUserPage");
    }
  }

  finalCallTimer() async {
    _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
    String? accountId = await SharedPref.getData(key: SharedPref.accountId);
    int userId = int.parse(accountId!);
    print("usood $userId & ${userId.runtimeType}");
    print(
        "bidUsersLists.last.userId ${bidUsersLists.first.userId} & ${bidUsersLists.last.userId.runtimeType}");
    print("acccu $accountId");

    Future.delayed(const Duration(seconds: 2), () async {
      print("calling finnal");
      if (bidUsersLists.first.userId == userId) {
        print("samme");
        setState(() {
          // request stop bid round
          _bidStopBloc.requestBidStop(widget.roundId);
          _bidStopStream = _bidStopBloc.bidStopStream();
          _bidStopStream.listen((ResponseOb resp) {
            if (resp.success) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (co) => SuccessBidRoundScreen(
                      roundId: widget.roundId,
                      roundNumber: widget.roundNumber,
                      baseAmount: widget.baseAmount,
                      realAmount: bidUsersLists.first.amount.toString(),
                      winnerBidName: bidUsersLists.first.username.toString(),
                      bitStartime: bidStarTime,
                      bidId: bidUsersLists.first.id!,
                    ),
                  ));
            } else {}
          });
        });
      } else {
        print("no smame");
        setState(() {
          finalCount = false;
        });
      }
    });
  }

  void requestPayBid(String bidAmount) {
    Map<String, dynamic> map = {
      'giveAmount': bidAmount,
    };
    _requestRoundMonthlyBidBloc.requestRoundMonthlyBid(
        roundID: widget.roundId, data: map);
  }

  @override
  void dispose() {
    autoRefersh!.cancel();
    payTime!.cancel();
    noOneTime!.cancel();
    _waittimer!.cancel();
    super.dispose();
  }

  var unixTime = DateTime.now().millisecondsSinceEpoch / 1000;

  void startTimer() {
    payStart = 10;
    const oneSec = Duration(seconds: 1);
    payTime = Timer.periodic(
      oneSec,
      (Timer timer) {
        print("start time $payStart");
        if (payStart == 0) {
          setState(() {
            timer.cancel();
            payTime!.cancel();
            firstCallTimer();
          });
        } else {
          setState(() {
            payStart--;
          });
        }
      },
    );
  }

  // void resultBidPrice(String amount) async {
  //   String message = "You are winner of Bid Price $amount";
  //   String btnLabel = "Ok";
  //   showDialog<String>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Center(
  //             child: Text(
  //               "Congratulations!",
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w500,
  //                 color: colorPrimary,
  //               ),
  //             )),
  //         // content:  AlertVersionInfoView(),
  //         content: Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 15),
  //           // margin: const EdgeInsets.only(top: 10),
  //           height: 130,
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(30),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               NathanTextView(
  //                 text: message,
  //                 fontSize: 14,
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   ElevatedButton(
  //                     child: Text(
  //                       btnLabel,
  //                       style: TextStyle(color: colorWhite),
  //                     ),
  //                     onPressed: () => Navigator.pop(context),
  //                     style:
  //                     ElevatedButton.styleFrom(backgroundColor: colorPrimary),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //         backgroundColor: colorWhite,
  //         contentPadding: EdgeInsets.zero,
  //         titlePadding: const EdgeInsets.only(top: 15),
  //         surfaceTintColor: Colors.transparent,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarTitleView(
          text: "Place Bid for ${widget.roundNumber}",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refersh,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.roundNumber,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    color: colorBlack,
                                    fontWeight: FontWeight.w600),
                              ),
                              noOneUserPage
                                  ? noOne
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            NathanTextView(
                                              text: "Final Count Timer ",
                                              fontSize: 16.sp,
                                              color: colorBlack,
                                            ),
                                            NathanTextView(
                                              text: "$noOneStart",
                                              fontSize: 18.sp,
                                              color: Colors.red,
                                            ),
                                            NathanTextView(
                                              text: " sec.",
                                              fontSize: 16.sp,
                                              color: colorBlack,
                                            ),
                                          ],
                                        )
                                      : const SizedBox()
                                  : finalCount
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            NathanTextView(
                                              text: "Final Count Timer ",
                                              fontSize: 16.sp,
                                              color: colorBlack,
                                            ),
                                            NathanTextView(
                                              text: "$_start",
                                              fontSize: 18.sp,
                                              color: Colors.red,
                                            ),
                                            NathanTextView(
                                              text: " sec.",
                                              fontSize: 16.sp,
                                              color: colorBlack,
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: topColors.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: noOneUserPage
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const NathanTextView(
                                    text: "Ask Price",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  NathanTextView(
                                    text: widget.baseAmount,
                                    fontSize: 16,
                                    color: colorPrimary,
                                  ),
                                ],
                              ),
                              noOneUserPage
                                  ? const SizedBox()
                                  : Container(
                                      height: 30,
                                      width: 2,
                                      color: colorSeconary,
                                    ),
                              noOneUserPage
                                  ? const SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const NathanTextView(
                                          text: "Lowest Bid",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        NathanTextView(
                                          text: lastBidAmount,
                                          fontSize: 16,
                                          color: colorPrimary,
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // SizedBox(
                        //   height: 50,
                        //   child: Marquee(
                        //     text: longText,
                        //     style: const TextStyle(
                        //         fontWeight: FontWeight.bold, fontSize: 15),
                        //     scrollAxis: Axis.horizontal,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     blankSpace: 10.0,
                        //     velocity: 100.0,
                        //     pauseAfterRound: const Duration(seconds: 2),
                        //     startPadding: 10.0,
                        //     accelerationDuration: const Duration(seconds: 2),
                        //     accelerationCurve: Curves.linear,
                        //     decelerationDuration: const Duration(seconds: 1),
                        //     decelerationCurve: Curves.easeOut,
                        //   ),
                        // ),
                        // hideBid ? Container(
                        //   color: Colors.white,
                        //   padding: const EdgeInsets.symmetric(vertical: 10),
                        //   margin: const EdgeInsets.only(bottom: 10),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       NathanTextView(
                        //         text: "Please wait who can pay of lower bid within ",
                        //         fontSize: 16.sp,
                        //         color: colorBlack,
                        //       ),
                        //       NathanTextView(
                        //         text: "$_start",
                        //         fontSize: 16.sp,
                        //         color: Colors.red,
                        //       ),
                        //       NathanTextView(
                        //         text: " s.",
                        //         fontSize: 16.sp,
                        //         color: colorBlack,
                        //       ),
                        //     ],
                        //   ),
                        // ) : const SizedBox(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: NathanTextView(
                            text: "Last Bid",
                            fontSize: 18,
                            color: colorBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorSeconary.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        border: Border.all(
                          width: 2,
                          color: colorPrimary,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 20, left: 25, right: 25),
                        child: bidUsersLists.isEmpty
                            ? const Center(
                                child: Text("No More Data"),
                              )
                            : ListView.builder(
                                itemCount: bidUsersLists.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  noOneUserPage = false;
                                  return Container(
                                    padding: const EdgeInsets.all(10.0),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color: topColors.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: NathanTextView(
                                          text:
                                              "${bidUsersLists[index].username}",
                                        )),
                                        NathanTextView(
                                          text:
                                              "${bidUsersLists[index].amount}",
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: ticketTec,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: "Your Bid",
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: LongButtonView(
                        text: "Confirm",
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (ticketTec.text.isEmpty) {
                            context.showSnack(
                              "Enter your Bid amount first!",
                              Colors.white,
                              Colors.red,
                              Icons.close,
                            );
                          } else {
                            setState(() {
                              noOneUserPage = false;
                              requestPayBid(ticketTec.text);
                              ticketTec.clear();
                            });
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
