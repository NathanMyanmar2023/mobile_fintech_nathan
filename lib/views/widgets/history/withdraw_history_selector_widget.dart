import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WithdrawHistorySelectorWidget extends StatelessWidget {
  final String id;
  final String amount;
  final String currency;
  final String account_name;
  final String account_number;
  final String payment_method_name;
  final String payment_method_icon;
  final int status;
  final String created_at;
  const WithdrawHistorySelectorWidget({
    super.key,
    required this.id,
    required this.amount,
    required this.currency,
    required this.account_name,
    required this.account_number,
    required this.payment_method_name,
    required this.payment_method_icon,
    required this.status,
    required this.created_at,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Column(
        children: [
        MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              print("History");
            },
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: SizedBox(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: payment_method_icon,
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
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
                        payment_method_name,
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
                        status == 1 ? "${AppLocalizations.of(context)!.completed}" : "${AppLocalizations.of(context)!.waiting}",
                        style: TextStyle(
                          fontSize: 14,
                          color: status == 1 ? Colors.green : Colors.orange,
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
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
        ],
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
