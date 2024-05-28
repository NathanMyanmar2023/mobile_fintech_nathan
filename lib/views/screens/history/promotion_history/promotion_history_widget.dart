import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nathan_app/resources/colors.dart';

class PromotionHistoryWidget extends StatelessWidget {
  final String id;
  final String promotionName;
  final String percentage;
  final String cashAmt;
  final String investAmt;
  final String createAt;
  const PromotionHistoryWidget({
    super.key,
    required this.id,
    required this.promotionName,
    required this.percentage,
    required this.cashAmt,
    required this.investAmt,
    required this.createAt,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorPrimary.withOpacity(0.2),
                  ),
                  padding: EdgeInsets.zero,
                  child: const SizedBox(
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Icon(
                        Icons.discount,
                        color: colorPrimary,
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
                      Text(
                        promotionName,
                        style: TextStyle(
                          fontSize: 18, color: Colors.grey.shade600,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Amount - ${moneyFormat(investAmt ?? "0")} ${AppLocalizations.of(context)!.usd}',
                        style: TextStyle(
                          fontSize: 17, color: Colors.grey.shade800,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Cash Back - ${moneyFormat(cashAmt ?? "0")} ${AppLocalizations.of(context)!.usd}',
                        style: TextStyle(
                          fontSize: 17, color: Colors.grey.shade800,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Promotion - $percentage',
                        style: TextStyle(
                          fontSize: 17, color: Colors.grey.shade800,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        createAt,
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


  String currentTime(String time)  {
print("tti $time");
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(time);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMMM dd yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);

    // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(time);
    // String currentTime = DateFormat("yyyyMMddHHmmss").format(tempDate);
    return outputDate;
  }
}
