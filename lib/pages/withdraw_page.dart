import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/resources/constants.dart';
import 'package:nathan_app/widgets/long_button_view.dart';

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdraw"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const WidthDrawView(),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "TO",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorPrimary,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const WidthDrawView(),
              const SizedBox(
                height: 42,
              ),
              LongButtonView(
                text: "Change Currency",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidthDrawView extends StatelessWidget {
  const WidthDrawView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                appLogo,
                width: 72,
                height: 44,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 8,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MMK",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: colorWhite,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Myanmar",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: colorWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorWhite,
            size: 16,
          ),
        ],
      ),
    );
  }
}
