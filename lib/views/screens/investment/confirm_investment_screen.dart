import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/investment/investment_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/investment/investment_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/investment/success_investment_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmInvestmentScreen extends StatefulWidget {
  final String amount;
  final bool is_yearly;
  final String investmentType;
  final int investmentPlanId;

  const ConfirmInvestmentScreen({
    super.key,
    required this.amount,
    required this.is_yearly,
    required this.investmentPlanId,
    required this.investmentType,
  });
  @override
  State<ConfirmInvestmentScreen> createState() =>
      _ConfirmInvestmentScreenState();
}

class _ConfirmInvestmentScreenState extends State<ConfirmInvestmentScreen> {
  bool isLoading = false;

  final _investment_bloc = InvestmentBloc();
  late Stream<ResponseOb> _investment_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _investment_stream = _investment_bloc.investmentStream();
    _investment_stream.listen((ResponseOb resp) {
      if (resp.success == false) {
        //Presign Error
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
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SuccessInvestmentScreen(
            investment: resp.data as InvestmentOb,
            isYearly: widget.is_yearly,
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
                title: Text(
                  AppLocalizations.of(context)!.confirm,
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
                          'images/investment.png',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                       Text(
                         AppLocalizations.of(context)!.investment_confirmation,
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
                        "${AppLocalizations.of(context)!.are_u_want_invest} ${widget.amount} ${AppLocalizations.of(context)!.usd_for_one_year}",
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
                                AppLocalizations.of(context)!.amount,
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
                                AppLocalizations.of(context)!.currency,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.usd,
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
                                AppLocalizations.of(context)!.invest_type,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                widget.investmentType,
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
                    text: AppLocalizations.of(context)!.confirm_investment,
                    onTap: () {
                      Map<String, dynamic> map = {
                        'invest_amount': widget.amount,
                        'plan_id': widget.investmentPlanId,
                      };
                      _investment_bloc.invest(map);
                      setState(() {
                        isLoading = true;
                      });
                    }),
                // MaterialButton(
                //   color: Colors.blue,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(45),
                //   ),
                //   height: 45,
                //   elevation: 0,
                //   onPressed: () {
                //     Map<String, dynamic> map = {
                //       'invest_amount': widget.amount,
                //       'is_yearly': widget.is_yearly ? 1 : 0,
                //     };
                //     _investment_bloc.invest(map);
                //     setState(() {
                //       isLoading = true;
                //     });
                //   },
                //   child: const SizedBox(
                //     height: 20,
                //     child: Center(
                //       child: Text(
                //         'Confirm Investment',
                //         style: TextStyle(
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
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
