import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fnge/views/custom/snack_bar.dart';
import 'package:fnge/views/screens/lottery/myanmar_lottery_screen.dart';
import 'package:fnge/views/screens/lottery/thai_lottery_screen.dart';
import 'package:fnge/widgets/nathan_text_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../resources/colors.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/long_button_view.dart';

class LotteryScreen extends StatefulWidget {
  const LotteryScreen({
    super.key,
  });

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  bool isLoading = false;

  var amount_tec = TextEditingController();
  var note_tec = TextEditingController();
  var phone_tec = TextEditingController();
  String _phone_code = '+66';

  String transfer_note = "";

  // final _billAuctionBloc = BillAuctionBloc();
  // late Stream<ResponseOb> _billAuctionStream;
  // List<BillAuctionData> billAuctionList = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _billAuctionStream = _billAuctionBloc.billAuctionStream();
  //   _billAuctionStream.listen((ResponseOb resp) {
  //     if (resp.success) {
  //       setState(() {
  //         billAuctionList = (resp.data as BillAuctionOb).data ?? [];
  //       });
  //     } else {}
  //   });
  //
  //   _billAuctionBloc.getBillAuction();
  // }

  final scroll_controller = ScrollController();

  // Future refersh() async {
  //   setState(() {
  //     print("odododo");
  //     _billAuctionBloc.getBillAuction();
  //   });
  // }

  List countryList = ['Myanmar Lottery', 'Thai Lottery'];
  int? selectedIndex;
  int? countryID = 3;

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
              text: "Lottery",
            ),
          ),
          body: countryList.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.no_more_data,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const NathanTextView(
                        text: "Select Lottery Type",
                        isCenter: true,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const NathanTextView(
                        text:
                            "please first select which type of lottery you want buy!",
                        isCenter: true,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                        controller: scroll_controller,
                        itemCount: countryList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.8.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? topColors
                                    : colorWhite,
                                border: Border.all(
                                    color: selectedIndex == index
                                        ? colorWhite
                                        : colorGrey.withOpacity(0.8)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: NathanTextView(
                                  text: "${countryList[index]}",
                                  isCenter: true,
                                  color: selectedIndex == index
                                      ? colorBlack
                                      : colorPrimary,
                                ),
                                tileColor:
                                    selectedIndex == index ? topColors : null,
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    setState(() {
                                      countryID = index;
                                    });
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: LongButtonView(
                            text: "Next",
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              if (countryID == 3) {
                                context.showSnack(
                                  "Please select which type of Lottery!",
                                  Colors.white,
                                  Colors.red,
                                  Icons.close,
                                );
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (co) => countryID == 1
                                            ? const ThaiLotteryScreen()
                                            : const MyanmarLotteryScreen()));
                              }
                            }),
                      ),
                    ],
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

  String money_format(String amount) {
    double amountDouble = double.parse(amount);
    String formattedAmount = NumberFormat.currency(
      locale: 'en_US',
      decimalDigits: 2,
      symbol: '',
    ).format(amountDouble);
    return formattedAmount.toString();
  }
}
