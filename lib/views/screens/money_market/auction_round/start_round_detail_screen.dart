import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../bloc/money_market/auction_round_monthly_bid_bloc.dart';
import '../../../../bloc/money_market/request_auction_round_monthly_bid_bloc.dart';
import '../../../../helpers/response_ob.dart';
import '../../../../objects/money_market/auction_round_monthly_bid_ob.dart';
import '../../../../widgets/app_bar_title_view.dart';
import '../../../../widgets/h_m_s_row_view.dart';
import '../../../../widgets/long_button_view.dart';
import '../../../../widgets/nathan_text_view.dart';

class StartRoundDetailScreen extends StatefulWidget {
  final int roundId;
  final String roundNumber;
  const StartRoundDetailScreen({Key? key, required this.roundId, required this.roundNumber}) : super(key: key);

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

  late Timer _timer;
  late Duration _difference;

  final _roundMonthlyBidBloc = AuctionRoundMonthlyBidBloc();
  late Stream<ResponseOb> _roundMonthlyBidStream;
  List<BidUsersLists> bidUsersLists = [];

  String lastBidAmount = "";
  String lastBidUsername = "";
  String bidStarTime = "";
  final _requestRoundMonthlyBidBloc = RequestAuctionRoundMonthlyBidBloc();
  late Stream<ResponseOb> _requestRoundMonthlyBidStream;
  @override
  void initState() {
    super.initState();

    // get round bid history
    _roundMonthlyBidStream = _roundMonthlyBidBloc.auctionRoundMonthlyStream();
    _roundMonthlyBidStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          lastBidAmount = resp.data.data.lastBidUser.amount ?? "";
          bidStarTime = resp.data.data.bitStartime ?? "";
          bidUsersLists = (resp.data as AuctionRoundMonthlyBidOb).data!.bidUsersLists ?? [];
          checkDateTime(bidStarTime);
        });
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
                        startTimer();
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

  checkDateTime(String defaultDate) {
    DateTime dateTime = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(defaultDate);
    String year = DateFormat.y().format(dateTime);
    String month = DateFormat.M().format(dateTime);
    String date = DateFormat.d().format(dateTime);
    String hour = DateFormat.H().format(dateTime);
    String min = DateFormat.m().format(dateTime);
    String sec = DateFormat.s().format(dateTime);
    print("def $defaultDate");
    print("dda $dateTime");
    print("year $year & $month & $date & $hour & $min & $sec");
    // Calculate the time difference
    DateTime now = DateTime.now();
    DateTime targetTime = DateTime(2024, 4, 31, 0, 0); // 5:00 PM today
    _difference = targetTime.difference(now);
    print("d ${targetTime}");
    // Start the countdown timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_difference.inSeconds > 0) {
          _difference -= const Duration(seconds: 1);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void requestPayBid(String bidAmount) {
    Map<String, dynamic> map = {
      'giveAmount': bidAmount,
    };
    _requestRoundMonthlyBidBloc.requestRoundMonthlyBid(roundID: widget.roundId, data: map);
  }
  @override
  void dispose() {
    _timer.cancel();
    _waittimer.cancel();
    super.dispose();
  }
  late Timer _waittimer;
  int _start = 10;
  bool hideBid = false;
  bool hideButton = false;
  var unixTime = DateTime.now().millisecondsSinceEpoch / 1000;

  void startTimer() {
    setState(() {
      hideBid = true;
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
            _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => super.widget));
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int hours = _difference.inHours;
    int minutes = _difference.inMinutes.remainder(60);
    int seconds = _difference.inSeconds.remainder(60);
    print("so $hours & $minutes & $seconds");
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
                  Container(
                    height: hours > 0 || minutes > 0 || seconds > 0 ? hideBid ? MediaQuery.of(context).size.height * 0.269
                        : MediaQuery.of(context).size.height * 0.21 :
                    MediaQuery.of(context).size.height * 0.2,
                 //  color: hours > 0 || minutes > 0 || seconds > 0 ? hideBid ? Colors.red : Colors.green : Colors.blue,
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
                              hours > 0 || minutes > 0 || seconds > 0 ? Row(
                                children: [
                                  const Text(
                                    "Ends In ",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  HMSRowView(hour: hours.toString(), min: minutes.toString(), sec: seconds.toString(),),
                                ],
                              ) : const SizedBox(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  NathanTextView(
                                    text: "Estimate",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  NathanTextView(
                                    text: "5000.00",
                                    fontSize: 16,
                                    color: colorPrimary,
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                                width: 2,
                                color: colorSeconary,
                              ),
                              Column(
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
                        hideBid ? Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NathanTextView(
                                text: "Please wait who can pay of lower bid within ",
                                fontSize: 16.sp,
                                color: colorBlack,
                              ),
                              NathanTextView(
                                text: "$_start",
                                fontSize: 16.sp,
                                color: Colors.red,
                              ),
                              NathanTextView(
                                text: " s.",
                                fontSize: 16.sp,
                                color: colorBlack,
                              ),
                            ],
                          ),
                        ) : const SizedBox(),
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
            hideButton ? const SizedBox() : Padding(
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
                        setState(() {
                          hideButton = true;
                          requestPayBid(ticketTec.text);
                          ticketTec.clear();
                        });
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
