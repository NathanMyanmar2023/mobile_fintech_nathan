import 'package:flutter/material.dart';
import 'package:fnge/itemviews/wallet_item_view.dart';
import 'package:fnge/widgets/long_button_view.dart';
import 'package:fnge/widgets/text_field_with_label_view.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
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
                height: 28,
              ),
              TextFieldWithLabelView(
                label: "Amount (MMK)",
                crossAxisAlignment: CrossAxisAlignment.start,
                controller: TextEditingController(),
              ),
              const SizedBox(
                height: 28,
              ),
              TextFieldWithLabelView(
                label: "Phone Number",
                crossAxisAlignment: CrossAxisAlignment.start,
                controller: TextEditingController(),
              ),
              const SizedBox(
                height: 28,
              ),
              TextFieldWithLabelView(
                label: "Note",
                crossAxisAlignment: CrossAxisAlignment.start,
                controller: TextEditingController(),
              ),
              const SizedBox(
                height: 28,
              ),
              LongButtonView(
                text: "Next",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
