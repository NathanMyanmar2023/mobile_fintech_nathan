import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../Ads_banner/ads_banner_widget.dart';

class TestGiftCard extends StatefulWidget {

  const TestGiftCard({
    super.key,
  });

  @override
  State<TestGiftCard> createState() => _TestGiftCardState();
}

class _TestGiftCardState extends State<TestGiftCard> {
  bool isLoading = false;

  var amount_tec = TextEditingController();
  var note_tec = TextEditingController();
  var phone_tec = TextEditingController();
  String _phone_code = '+66';

  String transfer_note = "";

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
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBarTitleView(text: "Gift Card",),
          ),
          body: const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   // AdsBannerWidget(paddingTop: 0, paddingbottom: 0,),
                    SizedBox(height: 30,),
                    Center(child: Text("Under pending status")),
                  ],
                )
            ),
          ),
        ),
      );
    }
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