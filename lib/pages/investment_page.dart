import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/resources/constants.dart';
import 'package:nathan_app/widgets/long_button_view.dart';

class InvestmentPage extends StatelessWidget {
  const InvestmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Investment"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: InvestmentView(
                      label: "Monthly 15%",
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: InvestmentView(
                      label: "One Year 30%",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: colorGrey,
              ),
              const SizedBox(
                height: 48,
              ),
              const Text(
                "MONTHLY 15% FOR ONE YEAR",
                style: TextStyle(
                  color: colorPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "For the next year, you will receive a 15% monthly reward on your investment. At the end of the one-year period, your investment will be automatically transferred to your USD wallet",
                style: TextStyle(
                  color: colorPrimary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 32,
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

class InvestmentView extends StatelessWidget {
  final String label;
  final Function onTap;

  const InvestmentView({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          Image.asset(
            appLogo,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            label,
            style: const TextStyle(
              color: colorPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
