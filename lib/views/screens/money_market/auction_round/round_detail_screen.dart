import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fnge/resources/colors.dart';

import '../../../../widgets/app_bar_title_view.dart';
import '../../../../widgets/nathan_text_view.dart';

class RoundDetailScreen extends StatefulWidget {
  final int roundId;
  final String roundNumber;
  const RoundDetailScreen(
      {Key? key, required this.roundId, required this.roundNumber})
      : super(key: key);

  @override
  State<RoundDetailScreen> createState() => _RoundDetailScreenState();
}

class _RoundDetailScreenState extends State<RoundDetailScreen> {
  Future refersh() async {
    setState(() {});
  }

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "${widget.roundNumber}",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: colorBlack,
                      fontWeight: FontWeight.w600),
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
                          text: "Real Amount",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        NathanTextView(
                          text: "3000.00",
                          fontSize: 16,
                          color: colorPrimary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: NathanTextView(
                    text: "Winner Bidder name Tun Lin",
                    fontSize: 18,
                    color: colorPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const NathanTextView(
                        text: "Bids History",
                        fontSize: 18,
                        color: colorBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: topColors.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: NathanTextView(
                                    text: "name ${index + 1}",
                                  )),
                                  NathanTextView(
                                    text: "USD1000${index + 1}",
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
