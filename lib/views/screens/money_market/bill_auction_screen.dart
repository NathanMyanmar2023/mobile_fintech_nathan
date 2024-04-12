import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';

import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/long_button_view.dart';
import '../../../widgets/nathan_text_view.dart';
import 'agree_selection_view.dart';

class BillAuctionScreen extends StatefulWidget {
  final int? auctionId;
  const BillAuctionScreen({required this.auctionId, Key? key})
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
                        NathanTextView(
                          text: "Bill Auction amout ${widget.auctionId}",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListView.builder(
                            controller: scroll_controller,
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              return NathanTextView(text: "Rule $index");
                            },
                          ),
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
                        ) : print("go");
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
