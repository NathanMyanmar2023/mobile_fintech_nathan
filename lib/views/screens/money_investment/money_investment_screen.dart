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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AppBar(
                toolbarHeight: 70,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: colorPrimary,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  "Money Market",
                  style: TextStyle(
                    fontSize: 18,
                    color: colorPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          body: const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
