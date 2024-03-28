import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepositHistorySelectorWidget extends StatelessWidget {
  final String id;
  final String amount;
  final String status;
  final String country;
  final String currency;
  final String payment_method;
  final String created_at;
  const DepositHistorySelectorWidget({
    super.key,
    required this.id,
    required this.amount,
    required this.status,
    required this.country,
    required this.currency,
    required this.payment_method,
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
                color: status == "1"
                    ? Colors.green.shade50
                    : Colors.orange.shade50,
              ),
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: Icon(
                    status == "1" ? Icons.check_outlined : Icons.access_time,
                    color: status == "1" ? Colors.green : Colors.orange,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${money_format(amount)} $currency",
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
                  created_at,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  payment_method,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  status == "1" ? "${AppLocalizations.of(context)!.completed}" : "${AppLocalizations.of(context)!.waiting}",
                  style: TextStyle(
                    fontSize: 14,
                    color: status == "1" ? Colors.green : Colors.orange,
                  ),
                ),
              ],
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
