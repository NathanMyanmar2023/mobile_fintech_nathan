import 'package:flutter/material.dart';
import 'package:fnge/itemviews/wallet_item_view.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/resources/constants.dart';
import 'package:fnge/widgets/long_button_view.dart';
import 'package:fnge/widgets/text_field_with_label_view.dart';

class WalletExchangePage extends StatelessWidget {
  const WalletExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet Exchange"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Image.asset(
                    appLogo,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Column(
                    children: [
                      Text(
                        "Currency Exchange Rate",
                        style: TextStyle(
                          fontSize: 16,
                          color: colorBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "1.0 USD = 150.00 MMK",
                        style: TextStyle(
                          color: colorGrey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 52,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: CurrencyView()),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(child: CurrencyView()),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const WalletItemView(
                walletType: 'Main Wallet',
                balance: "main_wallet_amount",
                currency: "main_wallet_currency",
                country: "main_wallet_country",
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextFieldWithLabelView(
                label: "Exchange Amount",
                crossAxisAlignment: CrossAxisAlignment.start,
                controller: TextEditingController(),
              ),
              const SizedBox(
                height: 32,
              ),
              TextFieldWithLabelView(
                label: "",
                crossAxisAlignment: CrossAxisAlignment.start,
                controller: TextEditingController(),
              ),
              const SizedBox(
                height: 32,
              ),
              LongButtonView(
                text: "Exchange",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyView extends StatelessWidget {
  const CurrencyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(
            appLogo,
            width: 30,
            height: 30,
          ),
          const SizedBox(
            width: 8,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "To USD",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorBlack,
                ),
              ),
              Text(
                "Second Wallet",
                style: TextStyle(
                  color: colorGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
