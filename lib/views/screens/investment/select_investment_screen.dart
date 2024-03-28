import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/investment_plan_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/investment_plan_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';
import 'package:nathan_app/views/screens/investment/investment_screen.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectInvestmentScreen extends StatefulWidget {
  final String second_wallet_balance;

  const SelectInvestmentScreen(
      {super.key, required this.second_wallet_balance});

  @override
  State<SelectInvestmentScreen> createState() => _SelectInvestmentScreenState();
}

class _SelectInvestmentScreenState extends State<SelectInvestmentScreen> {
  final _investmentPlanBloc = InvestmentPlanBloc();
  late Stream<ResponseOb> _investmentPlanStream;

  //currency list
  List<Data?> investmentPlanList = [];

  bool isLoading = true;
  bool isSixMonth = false;

  @override
  void initState() {
    super.initState();

    _investmentPlanStream = _investmentPlanBloc.investmentPlanStream();
    _investmentPlanStream.listen((ResponseOb resp) {
      if (resp.success == true) {
        setState(() {
          investmentPlanList = InvestmentPlanOb.fromJson(resp.data).data ?? [];
        });
      } else {
        print("error");
      }

      setState(() {
        isLoading = false;
      });
    });

    // Map<String, String> map = {
    //   'amount': "22",
    //   'phone': "09777126169",
    //   'payment': "kapy",
    //   'bankAccOrTransferPhone': "xxxx44x4xxxx4345",
    // };
    _investmentPlanBloc.getInvestmentPlans();
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
                  icon: const Icon(Icons.arrow_back_ios, color: colorPrimary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title:  Text(AppLocalizations.of(context)!.investment,
                  style: TextStyle(
                    fontSize: 18,
                    color: colorPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: InkWell(
                            onTap: () {
                              if (isSixMonth) {
                                setState(() {
                                  isSixMonth = false;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: !isSixMonth
                                      ? colorPrimary
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'images/customer.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: InkWell(
                            onTap: () {
                              if (!isSixMonth) {
                                setState(() {
                                  isSixMonth = true;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSixMonth
                                      ? colorPrimary
                                      : Colors.grey.shade100,
                                  width: 3,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'images/distributor.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          investmentPlanList[0]?.name ?? "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: !isSixMonth
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Text(
                          investmentPlanList[1]?.name ?? "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSixMonth
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (!isSixMonth)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          investmentPlanList[0]?.name ?? "-",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          investmentPlanList[0]?.description ?? "-",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          investmentPlanList[1]?.name ?? "-",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          investmentPlanList[1]?.description ?? "-",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  LongButtonView(
                      text: AppLocalizations.of(context)!.next,
                      onTap: () {
                        isSixMonth ? investmentPlanList[1]?.is_allow == 0 ?
                        context.showSnack(AppLocalizations.of(context)!.sry_accept_trans_error_msg,
                          Colors.white,
                          Colors.red,
                          Icons.close,
                        ) : Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return InvestmentScreen(
                            isSixMonth: isSixMonth,
                            second_wallet_balance: widget.second_wallet_balance,
                            investmentPlanId: (isSixMonth
                                ? investmentPlanList[1]?.id
                                : investmentPlanList[0]?.id) ??
                                0,
                            investmentType: (isSixMonth
                                ? investmentPlanList[1]?.name
                                : investmentPlanList[0]?.name) ??
                                "-",
                            percentage: (isSixMonth
                                ? investmentPlanList[1]?.profit
                                : investmentPlanList[0]?.profit) ??
                                0,
                          );
                        })):
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return InvestmentScreen(
                            isSixMonth: isSixMonth,
                            second_wallet_balance: widget.second_wallet_balance,
                            investmentPlanId: (isSixMonth
                                    ? investmentPlanList[1]?.id
                                    : investmentPlanList[0]?.id) ??
                                0,
                            investmentType: (isSixMonth
                                    ? investmentPlanList[1]?.name
                                    : investmentPlanList[0]?.name) ??
                                "-",
                            percentage: (isSixMonth
                                    ? investmentPlanList[1]?.profit
                                    : investmentPlanList[0]?.profit) ??
                                0,
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
                  //       return InvestmentScreen(
                  //         is_yearly: is_yearly,
                  //         second_wallet_balance: widget.second_wallet_balance,
                  //       );
                  //     }));
                  //   },
                  //   child: const SizedBox(
                  //     height: 20,
                  //     child: Center(
                  //         child: Text(
                  //       '',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     )),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
