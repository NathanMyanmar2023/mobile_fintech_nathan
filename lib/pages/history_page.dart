import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/resources/constants.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HistoryItemView(),
    );
  }
}

class HistoryItemView extends StatelessWidget {
  const HistoryItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(
          top: 12,
          left: 12,
          right: 12,
        ),
        decoration: BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              appLogo,
              width: 38,
              height: 38,
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "Deposit History",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: colorWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
