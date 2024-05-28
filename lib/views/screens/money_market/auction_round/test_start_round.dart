import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../bloc/money_market/auction_round_monthly_bid_bloc.dart';
import '../../../../bloc/money_market/request_auction_round_monthly_bid_bloc.dart';
import '../../../../helpers/response_ob.dart';
import '../../../../helpers/shared_pref.dart';
import '../../../../objects/money_market/auction_round_monthly_bid_ob.dart';
import '../../../../widgets/app_bar_title_view.dart';
import '../../../../widgets/h_m_s_row_view.dart';
import '../../../../widgets/long_button_view.dart';
import '../../../../widgets/nathan_text_view.dart';

class TestStartRound extends StatefulWidget {
  final int roundId;
  final String roundNumber;
  final String baseAmount;
  const TestStartRound({Key? key, required this.roundId, required this.roundNumber, required this.baseAmount}) : super(key: key);

  @override
  State<TestStartRound> createState() => _TestStartRoundState();
}

class _TestStartRoundState extends State<TestStartRound> {
  Future refersh() async {
    setState(() {
      _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
    });
  }

  var ticketTec = TextEditingController();


  // late Duration _difference;
  Duration _difference = const Duration(seconds: 1);

  final _roundMonthlyBidBloc = AuctionRoundMonthlyBidBloc();
  late Stream<ResponseOb> _roundMonthlyBidStream;
  List<BidUsersLists> bidUsersLists = [];

  String lastBidAmount = "";
  String lastBidUsername = "";
  String bidStarTime = "";
  String bitstandardAmount = "";
  bool noOneUserPage = false;
  final _requestRoundMonthlyBidBloc = RequestAuctionRoundMonthlyBidBloc();
  late Stream<ResponseOb> _requestRoundMonthlyBidStream;
  Timer? callTimer;
  @override
  void initState() {
    super.initState();
    callTimer = Timer.periodic(const Duration(seconds: 10), (Timer t) => firstCallTimer());

    // get round bid history
    _roundMonthlyBidStream = _roundMonthlyBidBloc.auctionRoundMonthlyStream();
    _roundMonthlyBidStream.listen((ResponseOb resp) {
      if (resp.success) {
        if(resp.message == "Sorry, there are no one users") {
          setState(() {
            noOneUserPage = true;
          });
        } else {
          setState(() {
            lastBidAmount = resp.data.data.lastBidUser.amount ?? "0";
            bitstandardAmount = resp.data.data.bitstandardAmount ?? "0";
            bidStarTime = resp.data.data.bitStartime ?? "0";
            bidUsersLists = (resp.data as AuctionRoundMonthlyBidOb).data!.bidUsersLists ?? [];
          });
        }
      } else {}
    });
    _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);

// request new bid
    _requestRoundMonthlyBidStream = _requestRoundMonthlyBidBloc.requestAuctionRoundMonthlyStream();
    _requestRoundMonthlyBidStream.listen((ResponseOb resp) {
      if (resp.message == "Success") {
        setState(() {
          _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
          startTimer();
          hideButton = true;
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
                      if(resp.message.toString() == "Sorry, there are not have other one bid user") {
                        setState(() {
                          hideButton = true;
                          startTimer();
                          Timer.periodic(const Duration(seconds: 10), (Timer t) => firstCallTimer());
                        });
                      }else {
                        setState(() {
                          hideButton = false;
                          _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
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

  firstCallTimer() async {
    print("calling final");
    _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
    String? accountId = await SharedPref.getData(key: SharedPref.accountId);
    int userId = int.parse(accountId!);
    print("usood $userId & ${userId.runtimeType}");
    print("bidUsersLists.last.userId ${bidUsersLists.first.userId} & ${bidUsersLists.last.userId.runtimeType}");
    print("acccu $accountId");
    if(bidUsersLists.first.userId == userId) {
      print("samme");
      setState(() {
        startTimer();
      });
    } else {
      setState(() {
        hideBid = true;
        _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
      });
      print("no same");
      print("noOneUserPage $noOneUserPage");
      print("hid bi $hideBid");
    }
  }

  finalCallTimer() async {
    print("calling final");
    setState(() {
      hideBid = false;
    });
    _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
    String? accountId = await SharedPref.getData(key: SharedPref.accountId);
    int userId = int.parse(accountId!);
    print("usood $userId & ${userId.runtimeType}");
    print("bidUsersLists.last.userId ${bidUsersLists.first.userId} & ${bidUsersLists.last.userId.runtimeType}");
    print("acccu $accountId");
    if(bidUsersLists.first.userId == userId) {
      print("samme");
      setState(() {
        callTimer!.cancel();
        resultBidPrice(bidUsersLists.first.amount.toString());
      });
    } else {
      print("no same");
      setState(() {
        hideBid = true;
      });
      setState(() {
        _start = 0;
      });
    }
  }
  // checkDateTime(String defaultDate) {
  //   DateTime dateTime = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(defaultDate);
  //   String year = DateFormat.y().format(dateTime);
  //   String month = DateFormat.M().format(dateTime);
  //   String date = DateFormat.d().format(dateTime);
  //   String hour = DateFormat.H().format(dateTime);
  //   String min = DateFormat.m().format(dateTime);
  //   String sec = DateFormat.s().format(dateTime);
  //   print("def $defaultDate");
  //   print("dda $dateTime");
  //   print("year $year & $month & $date & $hour & $min & $sec");
  //   // Calculate the time difference
  //   DateTime now = DateTime.now();
  //   DateTime targetTime = DateTime(2024, 4, 31, 2, 20); // 5:00 PM today
  //   _difference = targetTime.difference(now);
  //   // Start the countdown timer
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (_difference.inSeconds > 0) {
  //         _difference -= const Duration(seconds: 1);
  //       } else {
  //         _timer!.cancel();
  //       }
  //     });
  //   });
  // }

  void requestPayBid(String bidAmount) {
    Map<String, dynamic> map = {
      'giveAmount': bidAmount,
    };
    _requestRoundMonthlyBidBloc.requestRoundMonthlyBid(roundID: widget.roundId, data: map);
  }
  @override
  void dispose() {
    _waittimer!.cancel();
    callTimer!.cancel();
    super.dispose();
  }
  Timer? _waittimer;
  int _start = 10;
  int _finalCount = 10;
  bool hideBid = true;
  bool hideButton = false;
  var unixTime = DateTime.now().millisecondsSinceEpoch / 1000;

  void startTimer() {
    setState(() {
      hideBid = false;
    });
    const oneSec = Duration(seconds: 1);
    _waittimer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            hideBid = false;
            hideButton = false;
            timer.cancel();
            callTimer!.cancel();
            finalCallTimer();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void resultBidPrice(String amount) async {
    String message = "You are winner of Bid Price $amount";
    String btnLabel = "Ok";
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
                "Congratulations!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colorPrimary,
                ),
              )),
          // content:  AlertVersionInfoView(),
          content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            // margin: const EdgeInsets.only(top: 10),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NathanTextView(
                  text: message,
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text(
                        btnLabel,
                        style: TextStyle(color: colorWhite),
                      ),
                      onPressed: () => Navigator.pop(context),
                      style:
                      ElevatedButton.styleFrom(backgroundColor: colorPrimary),
                    ),
                  ],
                )
              ],
            ),
          ),
          backgroundColor: colorWhite,
          contentPadding: EdgeInsets.zero,
          titlePadding: const EdgeInsets.only(top: 15),
          surfaceTintColor: Colors.transparent,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // int hours = _difference.inHours;
    // int minutes = _difference.inMinutes.remainder(60);
    // int seconds = _difference.inSeconds.remainder(60);
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
                              noOneUserPage ? const SizedBox() : hideBid ? const SizedBox() : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NathanTextView(
                                    text: "Count Timer ",
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
                              ),
                              // noOneUserPage ? const SizedBox() : hours > 0 || minutes > 0 || seconds > 0 ? Row(
                              //   children: [
                              //     const Text(
                              //       "Count ",
                              //       style: TextStyle(
                              //           fontSize: 18.0,
                              //           fontWeight: FontWeight.w600),
                              //     ),
                              //     HMSRowView(hour: hours.toString(), min: minutes.toString(), sec: seconds.toString(),),
                              //   ],
                              // ) : const SizedBox(),
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
                            mainAxisAlignment: noOneUserPage ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
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
                                    text: noOneUserPage ? widget.baseAmount : bitstandardAmount,
                                    fontSize: 16,
                                    color: colorPrimary,
                                  ),
                                ],
                              ),
                              noOneUserPage ? const SizedBox() : Container(
                                height: 30,
                                width: 2,
                                color: colorSeconary,
                              ),
                              noOneUserPage ? const SizedBox() : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                        const SizedBox(height: 15,),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorSeconary.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                        border: Border.all(
                          width: 2,
                          color: colorPrimary,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20, left: 25, right: 25),
                        child: bidUsersLists.isEmpty ? const Center(child: Text("No More Data"),) : ListView.builder(
                          itemCount: bidUsersLists.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: topColors.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: NathanTextView(text: "${bidUsersLists[index].username}",)),
                                  NathanTextView(text: "${bidUsersLists[index].amount}",),
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
                  const SizedBox(width: 20,),
                  Expanded(
                    child: LongButtonView(
                        text: "Confirm",
                        onTap: () {
                          if(ticketTec.text.isEmpty) {
                            context.showSnack("Enter your Bid amount first!",
                              Colors.white,
                              Colors.red,
                              Icons.close,
                            );
                          } else {
                            setState(() {
                              noOneUserPage = false;
                              hideButton = true;
                              requestPayBid(ticketTec.text);
                              ticketTec.clear();
                            });
                          }
                        }
                    ),
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
