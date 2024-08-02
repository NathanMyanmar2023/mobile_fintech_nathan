import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fnge/objects/history/investment_history_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvestmentHistorySelectorWidget extends StatelessWidget {
  final InvestmentHistoryData history;
  final bool isYearly;

  const InvestmentHistorySelectorWidget({
    super.key,
    required this.history,
    required this.isYearly,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        isYearly ? Colors.green.shade50 : Colors.blue.shade50,
                  ),
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Icon(
                        isYearly
                            ? Icons.calendar_month
                            : Icons.dark_mode_outlined,
                        color: isYearly ? Colors.green : Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${moneyFormat(history.amount ?? "0")} ${AppLocalizations.of(context)!.usd}',
                            style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade800,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${history.plan?.profit.toString() ?? ""}%",
                            style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade600,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        history.plan?.name ?? "-",
                        style: TextStyle(
                          fontSize: 14,
                          color: isYearly ? Colors.green : colorPrimary,
                        ),
                      ),
                      Text(
                        '${history.investDate} ${AppLocalizations.of(context)!.to} ${history.finishDate}',
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
          Divider(
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  String moneyFormat(String amount) {
    double amountDouble = double.parse(amount);
    String formattedAmount = NumberFormat.currency(
      locale: 'en_US',
      decimalDigits: 2,
      symbol: '',
    ).format(amountDouble);
    return formattedAmount.toString();
  }
}
