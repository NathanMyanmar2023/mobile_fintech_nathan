import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nathan_app/objects/investment/investment_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/main_screen.dart';
import 'package:nathan_app/views/widgets/my_separator.dart';
import 'package:nathan_app/widgets/long_button_view.dart';

import '../../../../bloc/money_market/auction_round_monthly_bid_bloc.dart';
import '../../../../helpers/response_ob.dart';
import '../../../../helpers/shared_pref.dart';

class DoneBidRoundScreen extends StatefulWidget {
   final int roundId;
   final String roundName;
  const DoneBidRoundScreen({
    Key? key,
     required this.roundId,
    required this.roundName,
  }) : super(key: key);

  @override
  State<DoneBidRoundScreen> createState() => _DoneBidRoundScreenState();
}

class _DoneBidRoundScreenState extends State<DoneBidRoundScreen> {

  final _roundMonthlyBidBloc = AuctionRoundMonthlyBidBloc();
  late Stream<ResponseOb> _roundMonthlyBidStream;

  String lastBidAmount = "";
  String lastBidUsername = "";
  int lastBidID = 0;
  int lastBidUserID = 0;
  String bidStarTime = "";
  String bitstandardAmount = "";
  bool successUser = false;
  @override
  void initState() {
    super.initState();
    // get round bid history
    _roundMonthlyBidBloc.getRoundMonthlyBid(widget.roundId);
    _roundMonthlyBidStream = _roundMonthlyBidBloc.auctionRoundMonthlyStream();
    _roundMonthlyBidStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          lastBidAmount = resp.data.data.lastBidUser.amount ?? "0";
          lastBidUsername = resp.data.data.lastBidUser.username ?? "";
          lastBidID = resp.data.data.lastBidUser.id ?? 0;
          lastBidUserID = resp.data.data.lastBidUser.userId ?? 0;
          bitstandardAmount = resp.data.data.bitstandardAmount ?? "0";
          bidStarTime = resp.data.data.bitStartime ?? "0";
          checkUser(lastBidUserID);
        });
      } else {}
    });
  }

  checkUser(int lastBidUserID) async {
    String? accountId = await SharedPref.getData(key: SharedPref.accountId);
    int userId = int.parse(accountId!);
    if(lastBidUserID == userId) {
      setState(() {
        successUser = true;
      });
    } else {
      setState(() {
        successUser = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorPrimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorPrimary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorPrimary.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            successUser ? Icons.check : Icons.attach_money,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      successUser ? "Congratulations!" : "Auction Done!",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorPrimary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        textAlign: TextAlign.center,
                        successUser ? "Your are successfully for ${widget.roundName}." : "Winner Bidder name is $lastBidUsername for ${widget.roundName}.",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: MySeparator(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bid Price",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                lastBidAmount,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Currency",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                "USD",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bid ID",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                lastBidID.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                successUser ?  "Transaction Date" : "Transaction Pay Date",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                formatDateTimeFromUtc(bidStarTime),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LongButtonView(
                text: "Ok",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }

  String formatDateTimeFromUtc(dynamic time){
    try {
      return new DateFormat("MMM d, yyyy").format(new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parseUTC(time).toLocal());
    } catch (e){
      return new DateFormat("MMM d, yyyy").format(new DateTime.now());
    }
  }
}
