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

class TransferScreen extends StatefulWidget {
  final String main_wallet_balance;
  final String main_wallet_currency;
  final String main_wallet_country;

  const TransferScreen({
    super.key,
    required this.main_wallet_balance,
    required this.main_wallet_country,
    required this.main_wallet_currency,
  });

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  bool isLoading = false;

  var amount_tec = TextEditingController();
  var note_tec = TextEditingController();
  var phone_tec = TextEditingController();
  String _phone_code = '+66';

  String transfer_note = "";

  final _check_user_bloc = CheckUserBloc();
  late Stream<ResponseOb> _check_user_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check_user_stream = _check_user_bloc.checkUserStream();
    _check_user_stream.listen((ResponseOb resp) {
      if (resp.success == false) {
        //Presign Error
        showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Oppo !",
              Image.asset('images/welcome.png'),
              resp.message.toString(),
            );
          },
        );
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ConfirmTransferScreen(
            amount: resp.data.data.amount.toString(),
            currency: widget.main_wallet_currency,
            phone: resp.data.data.phone,
            user_name: resp.data.data.name,
            note: transfer_note,
          );
        }));
      }
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
                title: Text(
                  AppLocalizations.of(context)!.transfer,
                  style: TextStyle(
                    fontSize: 18,
                    color: colorPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          AppLocalizations.of(context)!.main_wallet_balance,
                          style: TextStyle(
                            fontSize: 14,
                            color: colorWhite,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              money_format(
                                  widget.main_wallet_balance.toString()),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: colorWhite,
                              ),
                            ),
                            Text(
                              widget.main_wallet_currency,
                              style: const TextStyle(
                                fontSize: 25,
                                color: colorWhite,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.main_wallet_country,
                          style: const TextStyle(
                            fontSize: 14,
                            color: colorWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      TextFieldWithLabelView(
                        label: "${AppLocalizations.of(context)!.amount} (${widget.main_wallet_currency})",
                        controller: amount_tec,
                        keyboardType: TextInputType.number,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Text(
                      //     "Amount (${widget.main_wallet_currency})",
                      //   ),
                      // ),
                      // const SizedBox(height: 5),
                      // Container(
                      //   height: 45,
                      //   padding: const EdgeInsets.symmetric(horizontal: 10),
                      //   decoration: BoxDecoration(
                      //     color: Colors.grey.shade200,
                      //     borderRadius: BorderRadius.circular(30),
                      //   ),
                      //   child: TextField(
                      //     keyboardType: TextInputType.number,
                      //     inputFormatters: [
                      //       FilteringTextInputFormatter.digitsOnly,
                      //     ],
                      //     controller: amount_tec,
                      //     decoration: const InputDecoration(
                      //       prefixIcon: Icon(Icons.attach_money),
                      //       hintText: "200,000 " "CURRENCY",
                      //       border: InputBorder.none,
                      //       contentPadding: EdgeInsets.symmetric(vertical: 14),
                      //     ),
                      //     obscureText: false,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                       SizedBox(
                        width: double.infinity,
                        child: Text(
                          AppLocalizations.of(context)!.phone_no,
                          style: TextStyle(
                            color: colorPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            CountryCodePicker(
                              initialSelection: AppLocalizations.of(context)!.th,
                              onChanged: (value) {
                                setState(() {
                                  _phone_code = value.dialCode.toString();
                                });
                              },
                            ),
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: phone_tec,
                                decoration: const InputDecoration(
                                  hintText: "7829 62711",
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 14),
                                  prefixIconColor: Colors.blue,
                                ),
                                obscureText: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                        label: AppLocalizations.of(context)!.note,
                        controller: note_tec,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      // const SizedBox(
                      //   width: double.infinity,
                      //   child: Text(
                      //     "Note",
                      //   ),
                      // ),
                      // const SizedBox(height: 5),
                      // Container(
                      //   height: 45,
                      //   padding: const EdgeInsets.symmetric(horizontal: 10),
                      //   decoration: BoxDecoration(
                      //     color: Colors.grey.shade200,
                      //     borderRadius: BorderRadius.circular(30),
                      //   ),
                      //   child: TextField(
                      //     keyboardType: TextInputType.text,
                      //     controller: note_tec,
                      //     decoration: const InputDecoration(
                      //       prefixIcon: Icon(Icons.message),
                      //       hintText: "Transfer Note",
                      //       border: InputBorder.none,
                      //       contentPadding: EdgeInsets.symmetric(vertical: 14),
                      //     ),
                      //     obscureText: false,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LongButtonView(
                      text: AppLocalizations.of(context)!.next,
                      onTap: () {
                        if (amount_tec.text == "" || phone_tec.text == "") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ErrorAlert(
                                "Oppo !",
                                Image.asset('images/welcome.png'),
                                "Please fill all fields",
                              );
                            },
                          );
                          return;
                        } else {
                          if (double.parse(widget.main_wallet_balance) <
                              double.parse(amount_tec.text)) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ErrorAlert(
                                  "Oppo !",
                                  Image.asset('images/welcome.png'),
                                  AppLocalizations.of(context)!.u_dont_have_enought_balance,
                                );
                              },
                            );
                            return;
                          } else {
                            if (note_tec.text == "") {
                              transfer_note = AppLocalizations.of(context)!.transfer_note;
                            } else {
                              transfer_note = note_tec.text;
                            }

                            Map<String, dynamic> map = {
                              'amount': amount_tec.text.toString(),
                              'phone': _phone_code +
                                  (phone_tec.text.startsWith('0')
                                      ? phone_tec.text.substring(1)
                                      : phone_tec.text),
                            };
                            print(map);
                            _check_user_bloc.check_user(map);
                            setState(() {
                              isLoading = true;
                            });
                          }
                        }
                      }),
                  // MaterialButton(
                  //   color: Colors.blue,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(45),
                  //   ),
                  //   height: 45,
                  //   elevation: 0,
                  //   onPressed: () {
                  //     if (amount_tec.text == "" || phone_tec.text == "") {
                  //       showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return ErrorAlert(
                  //             "Oppo !",
                  //             Image.asset('images/welcome.png'),
                  //             "Please fill all fields",
                  //           );
                  //         },
                  //       );
                  //       return;
                  //     } else {
                  //       if (double.parse(widget.main_wallet_balance) <
                  //           double.parse(amount_tec.text)) {
                  //         showDialog(
                  //           context: context,
                  //           builder: (context) {
                  //             return ErrorAlert(
                  //               "Oppo !",
                  //               Image.asset('images/welcome.png'),
                  //               "You don't have enough balance",
                  //             );
                  //           },
                  //         );
                  //         return;
                  //       } else {
                  //         if (note_tec.text == "") {
                  //           transfer_note = "Transfer Note";
                  //         } else {
                  //           transfer_note = note_tec.text;
                  //         }
                  //
                  //         Map<String, dynamic> map = {
                  //           'amount': amount_tec.text.toString(),
                  //           'phone': _phone_code +
                  //               (phone_tec.text.startsWith('0')
                  //                   ? phone_tec.text.substring(1)
                  //                   : phone_tec.text),
                  //         };
                  //         print(map);
                  //         _check_user_bloc.check_user(map);
                  //         setState(() {
                  //           isLoading = true;
                  //         });
                  //       }
                  //     }
                  //   },
                  //   child: const SizedBox(
                  //     height: 20,
                  //     child: Center(
                  //         child: Text(
                  //       'Next',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     )),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
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
