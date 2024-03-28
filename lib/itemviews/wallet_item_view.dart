import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';

class WalletItemView extends StatelessWidget {
  final String balance;
  final String walletType;
  final String currency;
  final String country;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const WalletItemView({
    super.key,
    this.margin,
    this.padding,
    required this.balance,
    required this.walletType,
    required this.currency,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          const EdgeInsets.symmetric(
            horizontal: 32,
          ),
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 12,
          ),
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            walletType,
            style: const TextStyle(
              fontSize: 14,
              color: colorWhite,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Text(
                balance,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: colorWhite,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                currency,
                style: const TextStyle(
                  fontSize: 20,
                  color: colorWhite,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
