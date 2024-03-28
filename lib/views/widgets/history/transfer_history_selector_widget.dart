import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransferHistorySelectorWidget extends StatelessWidget {
  final String id;
  final int is_transfer;
  final String sender_name;
  final String sender_phone;
  final String currency;
  final String receiver_name;
  final String receiver_phone;
  final String amount;
  final String note;
  final String created_at;
  const TransferHistorySelectorWidget({
    super.key,
    required this.id,
    required this.is_transfer,
    required this.sender_name,
    required this.sender_phone,
    required this.currency,
    required this.receiver_name,
    required this.receiver_phone,
    required this.amount,
    required this.note,
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
                color: is_transfer == 1
                    ? Colors.green.shade50
                    : Colors.blue.shade50,
              ),
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: Icon(
                    is_transfer == 1
                        ? Icons.arrow_circle_right
                        : Icons.arrow_circle_left,
                    color: is_transfer == 1 ? Colors.green : Colors.blue,
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
                  '${money_format(amount)} $currency',
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
                  is_transfer == 1 ? AppLocalizations.of(context)!.transfer : AppLocalizations.of(context)!.receive,
                  style: TextStyle(
                    fontSize: 14,
                    color: is_transfer == 1 ? Colors.green : Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  is_transfer == 1 ? "To $receiver_name" : "From $sender_name",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                    // fontWeight: FontWeight.bold,
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
