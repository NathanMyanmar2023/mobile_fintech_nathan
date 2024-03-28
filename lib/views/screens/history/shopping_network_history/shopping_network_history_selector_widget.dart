import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingNetworkHistorySelectorWidget extends StatelessWidget {
  final String id;
  final String totalAmount;
  final String currency;
  final String fromUser;
  final String date;
  const ShoppingNetworkHistorySelectorWidget({
    super.key,
    required this.id,
    required this.totalAmount,
    required this.currency,
    required this.fromUser,
    required this.date,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${money_format(totalAmount)} $currency",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade800,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Text(
              "${AppLocalizations.of(context)!.from} $fromUser",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                // fontWeight: FontWeight.bold,
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
