import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/deposit/payment_method_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/deposit/deposit_accounts_screen.dart';
import 'package:nathan_app/views/screens/withdraw/withdraw_screen.dart';
import 'package:nathan_app/views/widgets/payment_method_selector_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';

class DepositSelectPaymentMethodScreen extends StatefulWidget {
  final int currency_id;
  final bool isForDeposit;
  final String main_wallet_balance;
  final String main_wallet_currency;

  const DepositSelectPaymentMethodScreen({
    super.key,
    required this.currency_id,
    required this.isForDeposit,
    required this.main_wallet_balance,
    required this.main_wallet_currency,
  });

  @override
  State<DepositSelectPaymentMethodScreen> createState() =>
      _DepositSelectPaymentMethodScreenState();
}

class _DepositSelectPaymentMethodScreenState
    extends State<DepositSelectPaymentMethodScreen> {
  final _payment_method_bloc = PaymentMethodBloc();
  late Stream<ResponseOb> _payment_method_stream;

  //payment metnod list
  List payment_method_list = [];

  bool isLoading = true;

  int selected_payment_method_id = 0;
  String selected_payment_method_name = "";
  String selected_payment_method_icon = "";
  String selected_payment_currency_type = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _payment_method_stream = _payment_method_bloc.paymentMethodStream();
    _payment_method_stream.listen((ResponseOb resp) {
      if (resp.success) {
        for (var new_payment_method in resp.data.data) {
          setState(() {
            payment_method_list.add([
              widget.currency_id,
              new_payment_method.paymentId,
              new_payment_method.paymentName.toString(),
              new_payment_method.paymentImage.toString(),
              new_payment_method.currencyType.toString(),
            ]);
          });
        }
      } else {
        print("error");
      }
      setState(() {
        isLoading = false;
      });
    });

    _payment_method_bloc.getPaymentMethods(widget.currency_id);
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
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: colorPrimary,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  widget.isForDeposit ? "Deposit" : "Withdraw",
                  style: const TextStyle(
                    fontSize: 18,
                    color: colorPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15,
                    crossAxisCount: 3,
                    childAspectRatio: (1 / 1.3),
                    children: payment_method_list
                        .map((paymentMethod) => PaymentMethodSelectorWidget(
                              currency_id: paymentMethod[0],
                              payment_id: paymentMethod[1],
                              payment_name: paymentMethod[2],
                              payment_icon: paymentMethod[3],
                              currency_type: paymentMethod[4],
                              select_payment_method: select_payment_method,
                              selected_id: selected_payment_method_id,
                            ))
                        .toList(),
                  ),
                ),
                LongButtonView(
                    text: "NEXT",
                    onTap: () {
                      if (selected_payment_method_id != 0) {
                        if (widget.isForDeposit) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DepositAccountsScreen(
                              currency_id: widget.currency_id,
                              currency: selected_payment_currency_type,
                              payment_method_id: selected_payment_method_id,
                              payment_method_name: selected_payment_method_name,
                              payment_method_icon: selected_payment_method_icon,
                            );
                          }));
                        } else {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return WithdrawScreen(
                              currency_id: widget.currency_id,
                              currency: selected_payment_currency_type,
                              payment_method_id: selected_payment_method_id,
                              payment_method_name: selected_payment_method_name,
                              payment_method_icon: selected_payment_method_icon,
                              main_wallet_balance: widget.main_wallet_balance,
                              main_wallet_currency: widget.main_wallet_currency,
                            );
                          }));
                        }
                      } else {
                        print("select a payment method");
                      }
                    }),
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

  void select_payment_method(int paymentMethodId, String paymentMethodName,
      String paymentMethodIcon, String paymentMethodCurrencyType) {
    setState(() {
      selected_payment_method_id = paymentMethodId;
      selected_payment_method_name = paymentMethodName;
      selected_payment_method_icon = paymentMethodIcon;
      selected_payment_currency_type = paymentMethodCurrencyType;
    });
  }
}
