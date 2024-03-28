import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/withdraw/confirm_withdraw_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:nathan_app/widgets/text_field_with_label_view.dart';

class WithdrawScreen extends StatefulWidget {
  final int currency_id;
  final int payment_method_id;
  final String payment_method_name;
  final String payment_method_icon;
  final String currency;
  final String main_wallet_balance;
  final String main_wallet_currency;

  const WithdrawScreen({
    super.key,
    required this.currency_id,
    required this.payment_method_id,
    required this.payment_method_name,
    required this.payment_method_icon,
    required this.currency,
    required this.main_wallet_balance,
    required this.main_wallet_currency,
  });

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  bool isLoading = false;
  var amount_tec = TextEditingController();
  var account_name_tec = TextEditingController();
  var account_number_tec = TextEditingController();

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
                  "Withdraw",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: widget.payment_method_icon,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Withdraw with ${widget.payment_method_name}",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: colorPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Provide your ${widget.payment_method_name} username and account number correctly.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Mainwallet Balance",
                              style: TextStyle(fontSize: 14, color: colorWhite),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  money_format(widget.main_wallet_balance),
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
                              widget.main_wallet_currency,
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
                            label: "Amount (${widget.currency})",
                            controller: amount_tec,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            keyboardType: TextInputType.number,
                          ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: Text(
                          //     "Amount (${widget.currency})",
                          //   ),
                          // ),
                          // const SizedBox(height: 10),
                          // Container(
                          //   height: 45,
                          //   padding: const EdgeInsets.symmetric(horizontal: 10),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          //   child: TextField(
                          //     keyboardType: TextInputType.number,
                          //     inputFormatters: [
                          //       FilteringTextInputFormatter.digitsOnly,
                          //     ],
                          //     controller: amount_tec,
                          //     decoration: InputDecoration(
                          //       prefixIcon: const Icon(Icons.attach_money),
                          //       hintText: "200,000 ${widget.currency}",
                          //       border: InputBorder.none,
                          //       contentPadding:
                          //           const EdgeInsets.symmetric(vertical: 14),
                          //     ),
                          //     obscureText: false,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWithLabelView(
                            label: "Account Name",
                            controller: account_name_tec,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          // const SizedBox(
                          //   width: double.infinity,
                          //   child: Text("Account Name"),
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 45,
                          //   padding: const EdgeInsets.symmetric(horizontal: 10),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          //   child: TextField(
                          //     keyboardType: TextInputType.text,
                          //     controller: account_name_tec,
                          //     decoration: InputDecoration(
                          //       prefixIcon:
                          //           const Icon(Icons.account_box_outlined),
                          //       hintText:
                          //           "${widget.payment_method_name} username",
                          //       border: InputBorder.none,
                          //       contentPadding:
                          //           const EdgeInsets.symmetric(vertical: 14),
                          //     ),
                          //     obscureText: false,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWithLabelView(
                            label: "Account Number",
                            controller: account_number_tec,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          // const SizedBox(
                          //   width: double.infinity,
                          //   child: Text(
                          //     "Account Number",
                          //   ),
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 45,
                          //   padding: const EdgeInsets.symmetric(horizontal: 10),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          //   child: TextField(
                          //     keyboardType: TextInputType.text,
                          //     controller: account_number_tec,
                          //     decoration: const InputDecoration(
                          //       prefixIcon: Icon(Icons.credit_card),
                          //       hintText: "Account Number",
                          //       border: InputBorder.none,
                          //       contentPadding:
                          //           EdgeInsets.symmetric(vertical: 14),
                          //     ),
                          //     obscureText: false,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LongButtonView(
                      text: "Next",
                      onTap: () {
                        if (amount_tec.text == "" ||
                            account_name_tec.text == "" ||
                            account_number_tec.text == "") {
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
                                  "You don't have enough balance",
                                );
                              },
                            );
                            return;
                          } else {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ConfirmWithdrawScreen(
                                amount: amount_tec.text,
                                account_username: account_name_tec.text,
                                account_numbar: account_number_tec.text,
                                payment_method_id: widget.payment_method_id,
                                payment_method_name: widget.payment_method_name,
                                currency: widget.currency,
                              );
                            }));
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
                  //     if (amount_tec.text == "" ||
                  //         account_name_tec.text == "" ||
                  //         account_number_tec.text == "") {
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
                  //         Navigator.of(context)
                  //             .push(MaterialPageRoute(builder: (context) {
                  //           return ConfirmWithdrawScreen(
                  //             amount: amount_tec.text,
                  //             account_username: account_name_tec.text,
                  //             account_numbar: account_number_tec.text,
                  //             payment_method_id: widget.payment_method_id,
                  //             payment_method_name: widget.payment_method_name,
                  //             currency: widget.currency,
                  //           );
                  //         }));
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
