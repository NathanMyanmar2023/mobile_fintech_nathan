import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nathan_app/views/screens/top_up/success_bill_screen.dart';
import 'package:nathan_app/views/screens/top_up/top_up_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../bloc/top_up/top_up_bloc.dart';
import '../../../helpers/response_ob.dart';
import '../../../objects/default_info_ob.dart';
import '../../../resources/colors.dart';
import '../../../resources/constants.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/long_button_view.dart';
import '../../widgets/error_alert_widget.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({Key? key}) : super(key: key);

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  bool isLoading = false;
  TextEditingController phoneController = TextEditingController();

  final _topUp_bloc = TopUpBloc();
  late Stream<ResponseOb> _topUpStream;
  @override
  void initState() {
    super.initState();
    _topUpStream = _topUp_bloc.topUpStream();
    _topUpStream.listen((ResponseOb resp) {
      if (resp.success == true) {
        setState(() {
          isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return const SuccessBillScreen();
          }), (route) => false);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Oppo !",
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

  List<DefaultInfoOb> operatorList = [
    DefaultInfoOb(id: 1, name: "MPT"),
    DefaultInfoOb(id: 2, name: "ATOM"),
    DefaultInfoOb(id: 3, name: "Ooredoo"),
    DefaultInfoOb(id: 4, name: "MyTel"),
  ];
  DefaultInfoOb? newData;
  String _phone_code = '+95';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarTitleView(text: "Top-Up",),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Select Your SIM Card Name",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<DefaultInfoOb>(
              padding: EdgeInsets.zero,
              isExpanded: true,
              value: operatorList.first,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10, right: 5, top: 0, bottom: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  newData = newValue;
                });
              },
              items: operatorList.map((option) {
                return DropdownMenuItem<DefaultInfoOb>(
                  value: option,
                  child: Text(option.name ?? '-'),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                hintText: "959****34",
                labelText: "Mobile number",
                labelStyle: const TextStyle(color: colorPrimary, fontSize: 18),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                ),
                prefix: CountryCodePicker(
                  enabled: false,
                  padding: EdgeInsets.zero,
                  initialSelection: _phone_code,
                  showFlag: true,
                  textStyle: const TextStyle(fontSize: 16, color: colorBlack),
                  onChanged: (value) {
                    setState(() {
                      _phone_code = value.dialCode.toString();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Air Time Top-Up",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopUpButtonWidget(
                    amt_name: '1,000',
                    target: () => alertTopUpPay('1,000'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TopUpButtonWidget(
                    amt_name: '2,000',
                    target: () => alertTopUpPay('2,000'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TopUpButtonWidget(
                    amt_name: '3,000',
                    target: () => alertTopUpPay('3,000'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopUpButtonWidget(
                    amt_name: '4,000',
                    target: () => alertTopUpPay('4,000'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TopUpButtonWidget(
                    amt_name: '5,000',
                    target: () => alertTopUpPay('5,000'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TopUpButtonWidget(
                    amt_name: '10,000',
                    target: () => alertTopUpPay('10,000'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TopUpButtonWidget(
                    amt_name: '20,000',
                    target: () => alertTopUpPay('20,000'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TopUpButtonWidget(
                    amt_name: '30,000',
                    target: () => alertTopUpPay('30,000'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void alertTopUpPay(
    String amount,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.grey.shade200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30)),
      ),
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (BuildContext context, setStateBTS) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 2.2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: const Offset(
                            0, -40), // <- use half the height of the container
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              border:
                                  Border.all(color: colorPrimary, width: 3)),
                          width: 80,
                          height: 80, // Container has height 100
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Image.asset(topupLogo),
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.pay_for,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$amount.00",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Text(
                              "Ks",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: LongInfoView(
                          titleText: AppLocalizations.of(context)!.original_amt,
                          msgText: "$amount.00 Ks",
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                        ),
                      ),
                      Divider(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: LongInfoView(
                          titleText:
                              AppLocalizations.of(context)!.payment_method,
                          msgText: AppLocalizations.of(context)!.balance,
                          showIcon: true,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                        ),
                      ),
                      Divider(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: LongInfoView(
                          titleText: "Date",
                          msgText:
                              "${DateFormat.yMMMd().format(DateTime.now())} - ${DateFormat.jm().format(DateTime.now())}",
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: LongButtonView(
                            text: AppLocalizations.of(context)!.pay,
                            onTap: () async {
                              print("ee ${phoneController.text.trim()}");

                              setState(() {
                                isLoading = true;
                              });
                              if (phoneController.text == "") {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ErrorAlert(
                                      "Oppo !",
                                      Image.asset('images/welcome.png'),
                                      "Please complete the phone fields",
                                    );
                                  },
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                return;
                              }
                              String billPhone = '';
                              if(phoneController.text.trim().substring(0,1) == '0') {
                                billPhone = phoneController.text.trim().replaceRange(0, 1, '');
                              } else {
                                billPhone = phoneController.text.trim();
                              }
                              String billAmt = amount.replaceAll(',', '');
                              print("bill $billAmt");
                              print("billPhone $billPhone & $amount");
                              _topUp_bloc.addPhoneBill(data: {
                                "phone": "+$billPhone",
                                "amount": billAmt,
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  payTopUp() {
    setState(() {
      isLoading = true;
    });
    if (phoneController.text == "") {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorAlert(
            "Oppo !",
            Image.asset('images/welcome.png'),
            "Please complete the phone fields",
          );
        },
      );
      setState(() {
        isLoading = false;
      });
      return;
    }
    // Map<String, dynamic> map = {
    //   'full_name': full_name_tec.text,
    //   'nrc_number': nrc_number_tec.text,
    //   'bank_name': bank_name_tec.text,
    //   'payment_address': payment_address_tec.text,
    //   'bank_account_number': account_number_tec.text,
    //   'beneficial_name': beneficial_name_tec.text,
    //   'beneficial_phone': beneficial_phone_tec.text,
    //   'beneficial_nrc': beneficial_nrc_tec.text,
    //   'beneficial_email': beneficial_email_tec.text,
    // };

    // _kyc_bloc.uploadKyc(map, _photo, _nrc_front, _nrc_back, _bank_statement);
  }
}
