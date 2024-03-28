import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentAccountWidget extends StatefulWidget {
  final String account_number;
  final String account_name;

  const PaymentAccountWidget({
    super.key,
    required this.account_name,
    required this.account_number,
  });

  @override
  State<PaymentAccountWidget> createState() => _PaymentAccountWidgetState();
}

class _PaymentAccountWidgetState extends State<PaymentAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.account_number,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.account_name,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(text: widget.account_number),
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      content: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Copy : ${widget.account_number}",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.check_circle,
                                color: Colors.green.shade500),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text(
                "Copy",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
