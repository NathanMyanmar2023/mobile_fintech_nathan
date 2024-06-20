import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';
import 'package:nathan_app/widgets/nathan_text_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../resources/colors.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/long_button_view.dart';

class MyanmarLotteryScreen extends StatefulWidget {
  const MyanmarLotteryScreen({
    super.key,
  });

  @override
  State<MyanmarLotteryScreen> createState() => _MyanmarLotteryScreenState();
}

class _MyanmarLotteryScreenState extends State<MyanmarLotteryScreen> {
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
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBarTitleView(
              text: "Myanmar Lottery",
            ),
          ),
          body: Padding(
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
