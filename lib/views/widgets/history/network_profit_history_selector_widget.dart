import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fnge/objects/history/network_profit_history_ob.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworkProfitHistorySelectorWidget extends StatelessWidget {
  final NetworkProfitHistoryData data;

  const NetworkProfitHistorySelectorWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Column(
        children: [
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              print("History");
            },
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    child: const SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.from} ${data.fromUserName ?? "-"}',
                          style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${money_format(data.amount ?? "0")} ${AppLocalizations.of(context)!.usd}',
                          style: TextStyle(
                            fontSize: 17, color: Colors.grey.shade800,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data.createdAt ?? "-",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
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
