import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nathan_app/extensions/string_extensions.dart';

class GiftCardHistorySelectorWidget extends StatelessWidget {
  final String id;
  final String userId;
  final String tag;
  final String playerId;
  final String serverId;
  final String giftCardAmount;
  final String unit;
  final String priceMmk;
  final String status;
  final String remarks;
  final String purchasedTime;
  final String completedTime;
  const GiftCardHistorySelectorWidget({
    super.key,
  required this.id,
  required this.userId,
  required this.tag,
  required this.playerId,
  required this.serverId,
  required this.giftCardAmount,
  required this.unit,
  required this.priceMmk,
  required this.status,
  required this.remarks,
  required this.purchasedTime,
  required this.completedTime,

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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: status == "Success"
                    ? Colors.green.shade50 : status == "Fail" ? Colors.red.shade50
                    : Colors.orange.shade50,
              ),
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: Icon(
                    status == "Success" ? Icons.check_outlined : status == "Fail" ? Icons.close : Icons.access_time,
                    color: status == "Success" ? Colors.green : status == "Fail" ? Colors.red : Colors.orange,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Zone ID - $serverId",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 14,
                            color: status == "Success" ? Colors.green : status == "Fail" ? Colors.red : Colors.orange,
                          ),),
                      ),
                    ],
                  ),
                  Text(
                   "Player ID - $playerId",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Gift Card - $giftCardAmount $unit",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Text(
                    "Amount - $priceMmk Ks",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  remarks.isNotEmpty ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Remarks",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        remarks,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ) : const SizedBox(),
                  const SizedBox(height: 5,),
                  Text(
                    "Purchased Time - $purchasedTime",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  completedTime.isNotEmpty ? Text(
                    "Completed Time - $completedTime",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                    ),
                  ) : const SizedBox(),
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
