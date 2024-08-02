import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/screens/transfer/transfer_password_screen.dart';
import 'package:fnge/widgets/long_button_view.dart';

class ConfirmTransferScreen extends StatefulWidget {
  final String amount;
  final String currency;
  final String phone;
  final String user_name;
  final String note;

  const ConfirmTransferScreen({
    super.key,
    required this.amount,
    required this.currency,
    required this.phone,
    required this.user_name,
    required this.note,
  });

  @override
  State<ConfirmTransferScreen> createState() => _ConfirmTransferScreenState();
}

class _ConfirmTransferScreenState extends State<ConfirmTransferScreen> {
  bool isLoading = false;

  // final _withdraw_bloc = WithdrawBloc();
  // late Stream<ResponseOb> _withdraw_stream;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _withdraw_stream = _withdraw_bloc.withdrawStream();
  //   _withdraw_stream.listen((ResponseOb resp) {
  //     if (resp.success == false) {
  //       //Presign Error
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return ErrorAlert(
  //             "Oops !",
  //             Image.asset('images/welcome.png'),
  //             resp.message.toString(),
  //           );
  //         },
  //       );
  //       setState(() {
  //         isLoading = false;
  //       });
  //       return;
  //     } else {
  //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //         return SuccessWithdrawScreen(
  //             amount: resp.data.data.amount,
  //             account_username: resp.data.data.accountName,
  //             account_numbar: resp.data.data.accountNumber,
  //             payment_method_name: resp.data.data.paymentMethodName,
  //             currency: widget.currency,
  //             withdraw_id: resp.data.data.withdrawId);
  //       }));
  //     }
  //   });
  // }

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
                  icon: const Icon(Icons.arrow_back_ios, color: colorPrimary),
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
                      Container(
                        child: SizedBox(
                          width: 220,
                          child: Image.asset(
                            'images/transfer.png',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Transfer Confirmation",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Are you sure want to transfer ${widget.amount} to ${widget.user_name}?",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Column(
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
                                  widget.amount.toString(),
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
                                  widget.currency.toString(),
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
                                  "Phone",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                Text(
                                  widget.phone.toString(),
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
                                  "User Name",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                Text(
                                  widget.user_name.toString(),
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
                                  "Note",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                Text(
                                  widget.note.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                LongButtonView(
                    text: "Next",
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return TransferPasswordScreen(
                          phone: widget.phone,
                          amount: widget.amount,
                          note: widget.note,
                        );
                      }));
                    }),
                // MaterialButton(
                //   color: Colors.blue,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(45),
                //   ),
                //   height: 45,
                //   elevation: 0,
                //   onPressed: () {
                //     Navigator.of(context)
                //         .push(MaterialPageRoute(builder: (context) {
                //       return TransferPasswordScreen(
                //         phone: widget.phone,
                //         amount: widget.amount,
                //         note: widget.note,
                //       );
                //     }));
                //   },
                //   child: const SizedBox(
                //     height: 20,
                //     child: Center(
                //         child: Text(
                //       'Next',
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
