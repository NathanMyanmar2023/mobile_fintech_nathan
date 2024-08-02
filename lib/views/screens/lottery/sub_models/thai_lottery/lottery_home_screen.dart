import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fnge/views/custom/snack_bar.dart';
import 'package:fnge/widgets/nathan_text_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../resources/colors.dart';

enum SingingCharacter { lafayette, jefferson }

class LotteryHomeScreen extends StatefulWidget {
  const LotteryHomeScreen({
    super.key,
  });

  @override
  State<LotteryHomeScreen> createState() => _LotteryHomeScreenState();
}

class _LotteryHomeScreenState extends State<LotteryHomeScreen> {
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
  SingingCharacter? _character = SingingCharacter.lafayette;
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RadioListTile<SingingCharacter>(
                title: const Text('Lafayette'),
                value: SingingCharacter.lafayette,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              RadioListTile<SingingCharacter>(
                title: const Text('Thomas Jefferson'),
                value: SingingCharacter.jefferson,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ],
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
