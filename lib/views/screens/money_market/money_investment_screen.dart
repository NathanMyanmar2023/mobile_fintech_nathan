import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:nathan_app/bloc/transfer/check_user_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/transfer/confirm_transfer_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:nathan_app/widgets/text_field_with_label_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/nathan_text_view.dart';
import 'bill_auction_screen.dart';

class MoneyInvestmentScreen extends StatefulWidget {

  const MoneyInvestmentScreen({
    super.key,
  });

  @override
  State<MoneyInvestmentScreen> createState() => _MoneyInvestmentScreenState();
}

class _MoneyInvestmentScreenState extends State<MoneyInvestmentScreen> {
  bool isLoading = false;

  var amount_tec = TextEditingController();
  var note_tec = TextEditingController();
  var phone_tec = TextEditingController();
  String _phone_code = '+66';

  String transfer_note = "";

  final _check_user_bloc = CheckUserBloc();
  late Stream<ResponseOb> _check_user_stream;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _check_user_stream = _check_user_bloc.checkUserStream();
  //   _check_user_stream.listen((ResponseOb resp) {
  //     if (resp.success == false) {
  //       //Presign Error
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return ErrorAlert(
  //             "Oppo !",
  //             Image.asset('images/welcome.png'),
  //             resp.message.toString(),
  //           );
  //         },
  //       );
  //       setState(() {
  //         isLoading = false;
  //       });
  //       return;
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //         return ConfirmTransferScreen(
  //           amount: resp.data.data.amount.toString(),
  //           currency: widget.main_wallet_currency,
  //           phone: resp.data.data.phone,
  //           user_name: resp.data.data.name,
  //           note: transfer_note,
  //         );
  //       }));
  //     }
  //   });
  // }

  bool isSixMonth = false;
  final scroll_controller = ScrollController();

  Future refersh() async {
    setState(() {

    });
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
        child: AppBarTitleView(text: "Money Market",),
      ),
          body: RefreshIndicator(
            onRefresh: refersh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView.builder(
                controller: scroll_controller,
                itemCount: 15,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: AspectRatio(
                      aspectRatio: 5 / 2,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (co) => BillAuctionScreen(auctionId: index)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: !isSixMonth
                                  ? colorPrimary
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("odoeor",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.timer_outlined, color: colorPrimary,),
                                      const SizedBox(width: 5,),
                                      NathanTextView(
                                        text: "Bill Auction amout",
                                        fontSize: 15,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.group, color: colorPrimary,),
                                      const SizedBox(width: 5,),
                                      NathanTextView(
                                        text: "10 persons",
                                        fontSize: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
