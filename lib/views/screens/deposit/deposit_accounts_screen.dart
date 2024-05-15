import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nathan_app/bloc/deposit/payment_account_bloc.dart';
import 'package:nathan_app/bloc/deposit/request_deposit_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/deposit/success_deposit_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/views/widgets/payment_account_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:nathan_app/widgets/text_field_with_label_view.dart';

import '../../../helpers/shared_pref.dart';

class DepositAccountsScreen extends StatefulWidget {
  final int currency_id;
  final int payment_method_id;
  final String payment_method_name;
  final String payment_method_icon;
  final String currency;

  const DepositAccountsScreen({
    super.key,
    required this.currency_id,
    required this.payment_method_id,
    required this.payment_method_name,
    required this.payment_method_icon,
    required this.currency,
  });

  @override
  State<DepositAccountsScreen> createState() => _DepositAccountsScreenState();
}

class _DepositAccountsScreenState extends State<DepositAccountsScreen> {
  bool isLoading = false;
  var amount_tec = TextEditingController();
  File? _file;

  final _payment_account_bloc = PaymentAccountBloc();
  late Stream<ResponseOb> _payment_account_stream;

  final _request_deposit_bloc = RequestDepositBloc();
  late Stream<ResponseOb> _request_deposit_stream;
  late Stream<ResponseOb> _presign_stream;

  //payment metnod list
  List payment_account_list = [];

  @override
  void initState() {
    super.initState();

    _payment_account_stream = _payment_account_bloc.paymentAccountStream();
    _payment_account_stream.listen((ResponseOb resp) {
      if (resp.success) {
        for (var new_payment_account in resp.data.data) {
          setState(() {
            payment_account_list.add([
              new_payment_account.id,
              new_payment_account.name.toString(),
              new_payment_account.number.toString(),
            ]);
          });
        }
      } else {
        print("error");
      }
    });

    _payment_account_bloc.getPaymentAccounts(widget.payment_method_id);

    _presign_stream = _request_deposit_bloc.presignStream();
    _presign_stream.listen((ResponseOb resp) {
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
      }
    });

    _request_deposit_stream = _request_deposit_bloc.requestDepositStream();
    _request_deposit_stream.listen((ResponseOb resp) {
      if (resp.success == true) {
        setState(() {
          isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return SuccessDepositScreen(
              currency: resp.data.data.currency,
              country: resp.data.data.country,
              transaction_id: resp.data.data.transactionId,
              payment_method: resp.data.data.paymentMethod,
              amount: resp.data.data.amount,
            );
          }), (route) => false);
        });
      } else {
        //Request Deposit Error
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
          backgroundColor: Colors.grey.shade200,
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
                  "Deposit",
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: widget.payment_method_icon,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Deposit with ${widget.payment_method_name}",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: colorPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Transfer the payment and send screenshot with amount",
                        style: TextStyle(
                          fontSize: 14,
                          color: colorPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: payment_account_list
                            .map((account) => PaymentAccountWidget(
                                  account_name: account[1],
                                  account_number: account[2],
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          TextFieldWithLabelView(
                            label: "Amount (${widget.currency})",
                            controller: amount_tec,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            keyboardType: TextInputType.number,
                          ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: Text(
                          //     "Amount (${widget.currency})",
                          //   ),
                          // ),
                          // const SizedBox(height: 10),
                          // Container(
                          //   height: 45,
                          //   padding: const EdgeInsets.symmetric(horizontal: 10),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          //   child: TextField(
                          //     keyboardType: TextInputType.number,
                          //     inputFormatters: [
                          //       FilteringTextInputFormatter.digitsOnly,
                          //     ],
                          //     controller: amount_tec,
                          //     decoration: InputDecoration(
                          //       prefixIcon: const Icon(Icons.attach_money),
                          //       hintText: "200,000 ${widget.currency}",
                          //       border: InputBorder.none,
                          //       contentPadding:
                          //           const EdgeInsets.symmetric(vertical: 14),
                          //     ),
                          //     obscureText: false,
                          //   ),
                          // ),
                          const SizedBox(height: 20),
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Transaction Screenshot",
                              style: TextStyle(
                                color: colorPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          MaterialButton(
                            color: colorPrimary.withOpacity(0.2),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: pickImage,
                            padding: const EdgeInsets.all(0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 120,
                              child: _file != null
                                  ? Image.file(
                                      _file!,
                                      fit: BoxFit.cover,
                                    )
                                  : const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.screenshot_monitor_outlined,
                                          color: colorWhite,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Upload Screenshot",
                                          style: TextStyle(color: colorWhite),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LongButtonView(
                    text: "Request Deposit",
                    onTap: () => requestDeposit(),
                  ),
                  // MaterialButton(
                  //   color: Colors.blue,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(45),
                  //   ),
                  //   height: 45,
                  //   elevation: 0,
                  //   onPressed: requestDeposit,
                  //   child: const SizedBox(
                  //     height: 20,
                  //     child: Center(
                  //         child: Text(
                  //       'Request Deposit',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     )),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  //Select Image
  final ImagePicker _picker = ImagePicker();

  pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
    accountId = await SharedPref.getData(key: SharedPref.accountId);
    token = await SharedPref.getData(key: SharedPref.token);
    print("accountId $accountId /// $token");
  }

  String? accountId = "0";
  String? token = "0";
  requestDeposit() {
    setState(() {
      isLoading = true;
    });

    if (amount_tec.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Oops !",
              Image.asset('images/welcome.png'),
              "Need to provide deposit amount",
            );
          });
      setState(() {
        isLoading = false;
      });
      return;
    }

    RegExp digitPattern = RegExp(r'^[0-9]+$');
    if (!digitPattern.hasMatch(amount_tec.text)) {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorAlert(
            "Oops !",
            Image.asset('images/welcome.png'),
            "Invilad input amount",
          );
        },
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (_file == null) {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorAlert(
            "Oops !",
            Image.asset('images/welcome.png'),
            "Need to provide screenshot",
          );
        },
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    Map<String, dynamic> map = {
      'account_id': accountId,
      'currency_id': widget.currency_id,
      'payment_method_id': widget.payment_method_id,
      'amount': amount_tec.text,
    };
    _request_deposit_bloc.requestDeposit(map, _file!);
  }
}
