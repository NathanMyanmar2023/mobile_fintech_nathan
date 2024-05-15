import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/exchange/exchange_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/exchange/exchange_success_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';

class ConfirmExchangeScreen extends StatefulWidget {
  final String from_amount;
  final String from_currency;
  final String from_country_code;

  final String to_amount;
  final String to_currency;
  final String to_country_code;

  final bool to_main_wallet;

  const ConfirmExchangeScreen({
    super.key,
    required this.from_amount,
    required this.from_currency,
    required this.from_country_code,
    required this.to_amount,
    required this.to_currency,
    required this.to_country_code,
    required this.to_main_wallet,
  });

  @override
  State<ConfirmExchangeScreen> createState() => _ConfirmExchangeScreenState();
}

class _ConfirmExchangeScreenState extends State<ConfirmExchangeScreen> {
  bool isLoading = false;

  final _exchange_bloc = ExchangeBloc();
  late Stream<ResponseOb> _exchange_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _exchange_stream = _exchange_bloc.exchangeStream();
    _exchange_stream.listen((ResponseOb resp) {
      if (resp.success == false) {
        //Presign Error
        showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Oops !",
              Image.asset('images/welcome.png'),
              resp.message.toString(),
            );
          },
        );
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SuccessExchangeScreen(
            from_amount: resp.data.data.fromAmount,
            to_amount: resp.data.data.toAmount,
            is_to_main_wallet: resp.data.data.isToMainWallet,
            from_currency: resp.data.data.fromCurrency,
            to_currency: resp.data.data.toCurrency,
          );
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SpinKitFadingFour(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven ? Colors.blue : Colors.grey.shade800,
                ),
              );
            },
          ),
        ),
      );
    } else {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AppBar(
                toolbarHeight: 70,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: colorPrimary,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 18,
                    color: colorPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200,
                        child: Image.asset(
                          'images/exchange.png',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Exchange Confirmation",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: colorPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Are you sure want to exchange ${widget.from_amount} ${widget.from_currency} to ${widget.to_amount} ${widget.to_currency}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: colorPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorPrimary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.from_amount,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                Text(
                                  ' ${widget.from_currency}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Flag.fromString(
                                    widget.from_country_code,
                                    height: 25,
                                    width: 35,
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
                                      widget.to_main_wallet
                                          ? "Second Wallet"
                                          : "Main Wallet",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade800,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.from_currency,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Icon(
                          Icons.arrow_downward,
                          size: 25,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorPrimary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.to_amount,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                Text(
                                  ' ${widget.to_currency}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Flag.fromString(
                                  widget.to_country_code,
                                  height: 25,
                                  width: 35,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.to_main_wallet
                                          ? "Main Wallet"
                                          : "Second Wallet",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade800,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.to_currency,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                LongButtonView(
                  text: "Confirm Exchange",
                  onTap: () {
                    Map<String, dynamic> map = {
                      'amount': widget.from_amount,
                      'is_to_main_wallet': widget.to_main_wallet,
                    };
                    _exchange_bloc.exchange(map);
                    setState(() {
                      isLoading = true;
                    });
                  },
                ),
                // MaterialButton(
                //   color: Colors.blue,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(45),
                //   ),
                //   height: 45,
                //   elevation: 0,
                //   onPressed: () {
                //     Map<String, dynamic> map = {
                //       'amount': widget.from_amount,
                //       'is_to_main_wallet': widget.to_main_wallet,
                //     };
                //     _exchange_bloc.exchange(map);
                //     setState(() {
                //       isLoading = true;
                //     });
                //   },
                //   child: const SizedBox(
                //     height: 20,
                //     child: Center(
                //         child: Text(
                //       'Confirm Exchange',
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //     )),
                //   ),
                // ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
