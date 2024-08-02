import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/screens/main_screen.dart';
import 'package:fnge/views/widgets/my_separator.dart';
import 'package:fnge/widgets/long_button_view.dart';

class SuccessExchangeScreen extends StatefulWidget {
  final String from_currency;
  final String to_currency;
  final String from_amount;
  final String to_amount;
  final bool is_to_main_wallet;

  const SuccessExchangeScreen({
    super.key,
    required this.from_currency,
    required this.to_currency,
    required this.from_amount,
    required this.to_amount,
    required this.is_to_main_wallet,
  });

  @override
  State<SuccessExchangeScreen> createState() => _SuccessExchangeScreenState();
}

class _SuccessExchangeScreenState extends State<SuccessExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorPrimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorPrimary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorPrimary.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(
                            Icons.check,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Exchange Successful!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorPrimary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Exchange main wallet to second wallet successfully",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: MySeparator(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Wallet",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                widget.is_to_main_wallet
                                    ? "Second Wallet"
                                    : "Main Wallet",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Currency",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                widget.from_currency,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                widget.from_amount,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: MySeparator(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "To",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Wallet",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                widget.is_to_main_wallet
                                    ? "Main Wallet"
                                    : "Second Wallet",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Currency",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                widget.to_currency,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                widget.to_amount,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LongButtonView(
                  text: "Finish",
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const MainScreen();
                    }), (route) => false);
                  }),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: MaterialButton(
            //     color: Colors.blue,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(45),
            //     ),
            //     height: 45,
            //     elevation: 0,
            //     onPressed: () {
            //       Navigator.of(context).pushAndRemoveUntil(
            //           MaterialPageRoute(builder: (BuildContext context) {
            //         return const MainScreen();
            //       }), (route) => false);
            //     },
            //     child: const SizedBox(
            //       height: 30,
            //       child: Center(
            //         child: Text(
            //           'Finish',
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
