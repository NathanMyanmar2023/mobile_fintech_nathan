import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fnge/objects/application_fee_ob.dart';
import 'package:fnge/resources/colors.dart';

class ApplicationFeesWidget extends StatelessWidget {
  final ApplicationFeeData data;
  const ApplicationFeesWidget({
    super.key,
    required this.data,
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        margin: const EdgeInsets.symmetric(vertical: 5),
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
                    Icons.feed_outlined,
                    color: colorPrimary,
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
                  "${data.amount.toString() ?? "-"} ${data.currencyType}",
                  style: TextStyle(
                    fontSize: 18, color: Colors.grey.shade800,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${data.date ?? " - "} ${data.forYear ?? "-"}",
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
