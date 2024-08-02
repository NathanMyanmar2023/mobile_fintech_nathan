import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/resources/constants.dart';

class BalanceOptionItemView extends StatelessWidget {
  final String title;
  final Function onTap;

  const BalanceOptionItemView({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              appLogo,
              width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.width * 0.12,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: colorPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
