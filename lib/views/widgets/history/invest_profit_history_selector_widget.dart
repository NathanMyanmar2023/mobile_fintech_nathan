import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fnge/objects/history/invest_profit_history_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvestProfitHistorySelectorWidget extends StatelessWidget {
  final InvestProfitHistoryData data;
  final bool isYearly;
  const InvestProfitHistorySelectorWidget({
    super.key,
    required this.data,
    required this.isYearly,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Container(
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
                color: isYearly ? Colors.green.shade50 : Colors.blue.shade50,
              ),
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: Icon(
                    isYearly ? Icons.calendar_month : Icons.dark_mode_outlined,
                    color: isYearly ? Colors.green : Colors.blue,
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
                    '${money_format(data.profitAmount ?? "0")} ${AppLocalizations.of(context)!.usd}',
                    style: TextStyle(
                      fontSize: 18, color: Colors.grey.shade800,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${data.plan?.name ?? "-"} ${data.plan?.profit ?? 0}% for ${money_format(data.investAmount ?? "0")} USD investment',
                    style: TextStyle(
                      fontSize: 14,
                      color: isYearly ? Colors.green : colorPrimary,
                    ),
                  ),
                  Text(
                    data.investDate ?? "-",
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
