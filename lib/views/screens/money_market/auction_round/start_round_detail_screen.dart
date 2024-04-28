import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:marquee/marquee.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
    setState(() {});
  }

  var ticketTec = TextEditingController();

  late Timer _timer;
  late Duration _difference;

  @override
  void initState() {
    super.initState();
    // Calculate the time difference
    DateTime now = DateTime.now();
    DateTime targetTime = DateTime(now.year, now.month, now.day, 20, 45); // 5:00 PM today
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

  @override
  void dispose() {
    _timer.cancel();
    _waittimer.cancel();
    super.dispose();
  }
  late Timer _waittimer;
  int _start = 10;
  bool hideBid = false;
  var unixTime = DateTime.now().millisecondsSinceEpoch / 1000;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _waittimer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            hideBid = false;
            timer.cancel();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => super.widget));
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
              child: SingleChildScrollView(
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
                                    color: Colors.red,
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
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NathanTextView(
                                text: "Lowest Bid",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              NathanTextView(
                                text: "USD 3000.00",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                        Container(
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
                            child: ListView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
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
                                      Expanded(child: NathanTextView(text: "name ${index+1}",)),
                                      NathanTextView(text: "USD1000${index+1}",),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            hideBid ? const SizedBox() : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: ticketTec,
                      onChanged: (value) {

                        print("dooer ");
                      },
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
                          startTimer();
                          hideBid = true;
                          print('saao ${_start}');
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
