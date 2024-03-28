import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferralIncentiveHistorySelectorWidget extends StatelessWidget {
  final String id;
  final String from_user_name;
  final String amount;
  // final String seventy_percent_amount;
  // final String thirty_Percent_amount;
  final String percent;
  final String created_at;
  const ReferralIncentiveHistorySelectorWidget({
    super.key,
    required this.id,
    required this.from_user_name,
    required this.amount,
    // required this.seventy_percent_amount,
    // required this.thirty_Percent_amount,
    required this.percent,
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
              ),
              padding: EdgeInsets.zero,
              child: const SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.blue,
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
                  '${money_format(amount)} ${AppLocalizations.of(context)!.usd} ($percent %)',
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
                  "${AppLocalizations.of(context)!.from} $from_user_name",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
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
