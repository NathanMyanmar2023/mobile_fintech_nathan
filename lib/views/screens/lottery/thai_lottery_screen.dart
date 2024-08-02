import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fnge/views/custom/snack_bar.dart';
import 'package:fnge/widgets/nathan_text_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../resources/colors.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/long_button_view.dart';

class ThaiLotteryScreen extends StatefulWidget {
  const ThaiLotteryScreen({
    super.key,
  });

  @override
  State<ThaiLotteryScreen> createState() => _ThaiLotteryScreenState();
}

class _ThaiLotteryScreenState extends State<ThaiLotteryScreen> {
  bool isLoading = false;

  var first_tec = TextEditingController();
  var sec_tec = TextEditingController();
  var third_tec = TextEditingController();
  var four_tec = TextEditingController();
  var five_tec = TextEditingController();
  var six_tec = TextEditingController();
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
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBarTitleView(
                text: "Thai Lottery",
              ),
            ),
            body: const Column(
              children: [
                TabBar(tabs: [
                  Tab(
                    text: "Home",
                  ),
                  Tab(
                    text: "Purchase Ticket",
                  ),
                  Tab(
                    text: "Lottery Winners",
                  ),
                ]),
                Expanded(
                  child: SizedBox(
                    height: 300,
                    child: TabBarView(
                      children: [
                        Center(
                          child: Text("Chats"),
                        ),
                        Center(
                          child: Text("Calls"),
                        ),
                        Center(
                          child: Text("Settings"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //           body: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 25),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 const NathanTextView(
            //                   text: "Enter digit number",
            //                   isCenter: true,
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w600,
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 OtpTextField(
            //                   numberOfFields: 6,
            //                   focusedBorderColor: colorPrimary.withOpacity(0.5),
            //                   enabledBorderColor: colorPrimary,
            //                   cursorColor: colorPrimary,
            //                   showFieldAsBox: false,
            //                   borderWidth: 4.0,
            //                   //runs when a code is typed in
            //                   onCodeChanged: (String code) {
            //                     //handle validation or checks here if necessary
            //                   },
            //                   //runs when every textfield is filled
            //                   onSubmit: (String verificationCode) {
            // print("verificationCode $verificationCode");
            //                   },
            //                 ),
            //               ],
            //             ),
            //           ),
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
