import 'package:flutter/material.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeHistorySelectorWidget extends StatelessWidget {
  final String id;
  final int is_to_main_wallet;
  final String from_amount;
  final String from_currency;
  final String to_amount;
  final String to_currency;
  final String created_at;
  const ExchangeHistorySelectorWidget({
    super.key,
    required this.id,
    required this.is_to_main_wallet,
    required this.from_amount,
    required this.from_currency,
    required this.to_amount,
    required this.to_currency,
    required this.created_at,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: is_to_main_wallet == 1
                    ? Colors.green.shade50
                    : Colors.blue.shade50,
              ),
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: Icon(
                    Iconic.exchange,
                    size: 20,
                    color: is_to_main_wallet == 1 ? Colors.green : Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${money_format(from_amount)} $from_currency",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey.shade800,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt_sharp,
                        size: 30,
                        color: Colors.grey.shade400,
                      ),
                      Text(
                        "${money_format(to_amount)} $to_currency",
                        style: TextStyle(
                          fontSize: 17,
                          color: is_to_main_wallet == 1
                              ? Colors.green
                              : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        created_at,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
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
