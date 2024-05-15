import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/investment/confirm_investment_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvestmentScreen extends StatefulWidget {
  final bool isSixMonth;
  final int investmentPlanId;
  final String investmentType;
  final String second_wallet_balance;
  final String promotionName;
  final String promotionAmt;
  final String promotionStartDate;
  final String promotionEndDate;
  final int promotionMinInve;
  final String promotionNetworkAmt;
  final bool isPromotion;
  final int percentage;

  const InvestmentScreen({
    super.key,
    required this.isSixMonth,
    required this.second_wallet_balance,
    required this.investmentPlanId,
    required this.investmentType,
    required this.percentage,
    required this.promotionName,
    required this.promotionAmt,
    required this.promotionStartDate,
    required this.promotionEndDate,
    required this.promotionMinInve,
    required this.promotionNetworkAmt,
    this.isPromotion = false,
  });

  @override
  State<InvestmentScreen> createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  var amount_tec = TextEditingController();
  String amount = "0";
  @override
  Widget build(BuildContext context) {
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
                AppLocalizations.of(context)!.investment,
                style: TextStyle(
                  fontSize: 18,
                  color: colorPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            money_format(widget.second_wallet_balance),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: colorWhite,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.usd,
                            style: TextStyle(
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
                        AppLocalizations.of(context)!.united_state,
                        style: TextStyle(
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
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: colorPrimary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${widget.investmentType} ${widget.percentage}%.",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                widget.isPromotion
                    ? Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colorPrimary),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.discount,
                                      color: colorPrimary,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Promotion",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.promotionAmt,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                widget.promotionName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Min Investment Amount",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      " - ${widget.promotionMinInve} USD",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: colorPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Network Percentage",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      " - ${widget.promotionNetworkAmt}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: colorPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Duration Date",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${widget.promotionStartDate} to ${widget.promotionEndDate}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: colorPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.investment_amt,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              amount = value;
                            });
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: amount_tec,
                          decoration: const InputDecoration(
                            hintText: "100",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          obscureText: false,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.usd,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: const Flag.fromString(
                          "US",
                          height: 35,
                          width: 40,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text("or"),
                  ),
                ),
                Row(
                  children: [
                    SelectAmount("100"),
                    const SizedBox(width: 10),
                    SelectAmount("300"),
                    const SizedBox(width: 10),
                    SelectAmount("500"),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SelectAmount("1000"),
                    const SizedBox(width: 10),
                    SelectAmount("5000"),
                  ],
                ),
                const SizedBox(height: 30),
                LongButtonView(
                    text: AppLocalizations.of(context)!.next,
                    onTap: () {
                      if (double.parse(amount) < 1) {
                        return;
                      } else {
                        if (double.parse(widget.second_wallet_balance) <
                            double.parse(amount)) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ErrorAlert(
                                "Oops !",
                                Image.asset('images/welcome.png'),
                                "You don't have enough USD",
                              );
                            },
                          );
                          return;
                        } else {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ConfirmInvestmentScreen(
                              amount: amount,
                              is_yearly: widget.isSixMonth,
                              investmentPlanId: widget.investmentPlanId,
                              investmentType: widget.investmentType,
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
                //     if (double.parse(amount) < 1) {
                //       return;
                //     } else {
                //       if (double.parse(widget.second_wallet_balance) <
                //           double.parse(amount)) {
                //         showDialog(
                //           context: context,
                //           builder: (context) {
                //             return ErrorAlert(
                //               "Oops !",
                //               Image.asset('images/welcome.png'),
                //               "You don't have enough USD",
                //             );
                //           },
                //         );
                //         return;
                //       } else {
                //         Navigator.of(context)
                //             .push(MaterialPageRoute(builder: (context) {
                //           return ConfirmInvestmentScreen(
                //             amount: amount,
                //             is_yearly: widget.is_yearly,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded SelectAmount(String value) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            amount = value;
            amount_tec.text = value;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: amount == value ? colorPrimary : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(50),
          ),
          height: 40,
          child: Center(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: amount == value ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
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
