import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/screens/deposit/deposit_select_payment_method_screen.dart';

class CurrencySelectorWidget extends StatelessWidget {
  final String country_name;
  final String currency_code;
  final String country_code;
  final int currency_id;
  final bool isForDeposit;
  final String main_wallet_balance;
  final String main_wallet_currency;

  const CurrencySelectorWidget({
    super.key,
    required this.country_name,
    required this.currency_code,
    required this.country_code,
    required this.currency_id,
    required this.isForDeposit,
    required this.main_wallet_balance,
    required this.main_wallet_currency,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: MaterialButton(
        color: colorPrimary,
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DepositSelectPaymentMethodScreen(
              currency_id: currency_id,
              isForDeposit: isForDeposit,
              main_wallet_balance: main_wallet_balance,
              main_wallet_currency: main_wallet_currency,
            );
          }));
        },
        child: SizedBox(
          height: 70,
          width: double.infinity,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                child: Flag.fromString(
                  country_code,
                  height: 40,
                  width: 50,
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
                    currency_code,
                    style: const TextStyle(
                      fontSize: 17,
                      color: colorWhite,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    country_name,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.teal.shade400,
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
                color: Colors.grey.shade400,
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
