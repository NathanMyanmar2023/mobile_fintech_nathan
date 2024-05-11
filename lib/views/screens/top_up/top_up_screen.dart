import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';
import 'package:nathan_app/views/screens/top_up/success_bill_screen.dart';
import 'package:nathan_app/views/screens/top_up/top_up_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../bloc/top_up/operator_bloc.dart';
import '../../../bloc/top_up/top_up_bloc.dart';
import '../../../helpers/response_ob.dart';
import '../../../objects/default_info_ob.dart';
import '../../../objects/operator_ob.dart';
import '../../../resources/colors.dart';
import '../../../resources/constants.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/long_button_view.dart';
import '../../../widgets/text_field_with_label_view.dart';
import '../../Ads_banner/ads_banner_widget.dart';
import '../../widgets/error_alert_widget.dart';
import 'custom_amout_widget.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({Key? key}) : super(key: key);

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  bool isLoading = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otherAmtController = TextEditingController();

  final _topUp_bloc = TopUpBloc();
  late Stream<ResponseOb> _topUpStream;

  final _operator_bloc = OperatorBloc();
  late Stream<ResponseOb> _operatorStream;
  List<OperatorData?> operatorList = [];
  OperatorData? newData;
  bool changeOp = false;
  @override
  void initState() {
    super.initState();

    /// operator list stream
    _operatorStream = _operator_bloc.operatorStream();
    _operatorStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          operatorList = OperatorOb.fromJson(resp.data).data ?? [];
        });
      } else {}
    });
    _operator_bloc.getPhoneOperator();

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

  String _phone_code = '+95';

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MediaQuery(
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
    )
        : Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarTitleView(
          text: "Top-Up",
        ),
      ),
      body: operatorList.isEmpty
          ? const Center(child: Text("No More Data"))
          : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Select Operator",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<OperatorData>(
                      padding: EdgeInsets.zero,
                      isExpanded: true,
                      value: changeOp ? newData : operatorList.first,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 10, right: 5, top: 0, bottom: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          changeOp = true;
                          newData = newValue;
                        });
                      },
                      items: operatorList.map((option) {
                        newData = changeOp ? newData : operatorList.first;
                        return DropdownMenuItem<OperatorData>(
                          value: option,
                          child: Row(
                            children: [
                              Text(option!.name ?? '-'),
                              //   changeOp ? const SizedBox() : Text("Select options"),
                            ],
                          ),
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
                        labelStyle:
                            const TextStyle(color: colorPrimary, fontSize: 18),
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
                          textStyle:
                              const TextStyle(fontSize: 16, color: colorBlack),
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
                    const AdsBannerWidget(paddingTop: 0),
                    const Text(
                      "Air Time Top-Up",
                      style: TextStyle(
                        fontSize: 18,
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
                            target: () => alertTopUpPay('1,000', newData!.name!),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TopUpButtonWidget(
                            amt_name: '2,000',
                            target: () => alertTopUpPay('2,000', newData!.name!),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TopUpButtonWidget(
                            amt_name: '3,000',
                            target: () => alertTopUpPay('3,000', newData!.name!),
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
                            target: () => alertTopUpPay('4,000', newData!.name!),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TopUpButtonWidget(
                            amt_name: '5,000',
                            target: () => alertTopUpPay('5,000', newData!.name!),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TopUpButtonWidget(
                            amt_name: '10,000',
                            target: () => alertTopUpPay('10,000', newData!.name!),
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
                            target: () => alertTopUpPay('20,000', newData!.name!),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TopUpButtonWidget(
                            amt_name: '30,000',
                            target: () => alertTopUpPay('30,000', newData!.name!),
                          ),
                        ],
                      ),
                    ),

                    Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child:
            CustomAmountWidget(
              label: "Custom Amount",
              hintText: "Other Amount",
              controller: otherAmtController,
              billFunction: () => alertTopUpPay(otherAmtController.text.trim(), newData!.name!),
            ),
                    ),
                  ],
                ),
              ),
          ),
    );
  }

  void alertTopUpPay(
    String amount,
      String opName,
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
                        "${AppLocalizations.of(context)!.pay_for} $opName",
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
                              setState(() {
                                Navigator.pop(context);
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
                              String billPhone = '';
                              if (phoneController.text.trim().substring(0, 1) ==
                                  '0') {
                                billPhone = phoneController.text
                                    .trim()
                                    .replaceRange(0, 1, '');
                              } else {
                                billPhone = phoneController.text.trim();
                              }
                              print("_phone_code $_phone_code");
                              print("fullph $_phone_code${phoneController.text.trim()}");
                              String billAmt = amount.replaceAll(',', '');
                              print("neww $newData");
                              if (newData == null) {
                                newData = operatorList.first;
                              } else {
                                newData = newData;
                              }
                              print("nee ${newData!.id} & ${newData!.name}");
                              String opType = "";
                              String phone = billPhone.substring(1, 3);
                              print(
                                  "phoneLen ${phoneController.text.trim().length}");
                              if (phoneController.text.trim().length == 8) {
                                if (newData!.name!.toLowerCase() == "mpt") {
                                  List<String> mptList = [
                                    "20",
                                    "21",
                                    "50",
                                    "51",
                                    "52",
                                    "53",
                                    "54",
                                    "55",
                                    "56",
                                    "57",
                                    "58",
                                    "59",
                                  ];
                                  opType = mptList.contains(phone) ? "${newData!.id}" : "";
                                  print("type8 $opType");
                                }
                              } else if (phoneController.text.trim().length ==
                                  9) {
                                if (newData!.name!.toLowerCase() == "mpt") {
                                  List<String> mptList = [
                                    "73",
                                    "49",
                                  ];
                                  opType = mptList.contains(phone) ? "${newData!.id}" : "";
                                  print("type9 $opType");
                                }
                              } else if (newData!.name!.toLowerCase() ==
                                  "mpt") {
                                List<String> mptList = [
                                  "25",
                                  "26",
                                  "27",
                                  "40",
                                  "41",
                                  "42",
                                  "43",
                                  "44",
                                  "45",
                                  "88","89",
                                ];
                                opType = mptList.contains(phone) ? "${newData!.id}" : "";
                                print("type $opType");
                              } else if (newData!.name!.toLowerCase() ==
                                  "atom") {
                                List<String> atomList = ["75","76","77", "78", "79"];
                                opType = atomList.contains(phone) ? "${newData!.id}" : "";
                                print("type $opType");
                              } else if (newData!.name!.toLowerCase() ==
                                  "ooredoo") {
                                List<String> ooredooList = [
                                  "95",
                                  "96",
                                  "97",
                                  "98",
                                  "99",
                                ];
                                opType = ooredooList.contains(phone)
                                    ? "${newData!.id}"
                                    : "";
                                print("type $opType");
                              } else if (newData!.name!.toLowerCase() ==
                                  "mytel") {
                                List<String> mytelList = [
                                  "66",
                                  "67",
                                  "68",
                                  "69",
                                ];
                                opType =
                                    mytelList.contains(phone) ? "${newData!.id}" : "";
                                print("type $opType");
                              }
                              opType == ""
                                  ? failOperator()
                                  : successOperator(
                                      "$_phone_code$billPhone", billAmt, opType);
                            },
                        ),
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

  failOperator() {
    setState(() {
      isLoading = false;
    });
    context.showSnack(
      "Please Make sure your Correct Operator with mobile number",
      Colors.white,
      Colors.red,
      Icons.close,
    );
  }

  successOperator(String phone, String amount, String operatorId) {
    _topUp_bloc.addPhoneBill(data: {
      "phone": phone,
      "amount": amount,
      "operator_id": operatorId,
    });
  }
}
