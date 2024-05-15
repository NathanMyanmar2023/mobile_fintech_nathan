import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/withdraw/withdraw_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/withdraw/success_withdraw_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';

class ConfirmWithdrawScreen extends StatefulWidget {
  final String amount;
  final String account_username;
  final String account_numbar;
  final int payment_method_id;
  final String payment_method_name;
  final String currency;

  const ConfirmWithdrawScreen({
    super.key,
    required this.amount,
    required this.account_username,
    required this.account_numbar,
    required this.payment_method_id,
    required this.payment_method_name,
    required this.currency,
  });

  @override
  State<ConfirmWithdrawScreen> createState() => _ConfirmWithdrawScreenState();
}

class _ConfirmWithdrawScreenState extends State<ConfirmWithdrawScreen> {
  bool isLoading = false;

  final _withdraw_bloc = WithdrawBloc();
  late Stream<ResponseOb> _withdraw_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _withdraw_stream = _withdraw_bloc.withdrawStream();
    _withdraw_stream.listen((ResponseOb resp) {
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
          return SuccessWithdrawScreen(
              amount: resp.data.data.amount,
              account_username: resp.data.data.accountName,
              account_numbar: resp.data.data.accountNumber,
              payment_method_name: resp.data.data.paymentMethodName,
              currency: widget.currency,
              withdraw_id: resp.data.data.withdrawId);
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
                        width: 220,
                        child: Image.asset(
                          'images/withdraw.png',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Withdraw Confirmation",
                        style: TextStyle(
                          fontSize: 18,
                          color: colorPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Are you sure want to withdraw ${widget.amount} ${widget.currency} from your main wallet",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                widget.amount,
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
                                "Currency",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                widget.currency,
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Payment Method",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                widget.payment_method_name,
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Account Name",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                widget.account_username,
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Account Number",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                widget.account_numbar,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                LongButtonView(
                  text: "Confirm Withdraw",
                  onTap: () {
                    Map<String, dynamic> map = {
                      'amount': widget.amount,
                      'payment_id': widget.payment_method_id,
                      'account_name': widget.account_username,
                      'account_number': widget.account_numbar
                    };
                    _withdraw_bloc.withdraw(map);
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
                //       'amount': widget.amount,
                //       'payment_id': widget.payment_method_id,
                //       'account_name': widget.account_username,
                //       'account_number': widget.account_numbar
                //     };
                //     _withdraw_bloc.withdraw(map);
                //     setState(() {
                //       isLoading = true;
                //     });
                //   },
                //   child: const SizedBox(
                //     height: 20,
                //     child: Center(
                //         child: Text(
                //       'Confirm Withdraw',
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
