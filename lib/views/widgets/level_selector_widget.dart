import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/network/network_users_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LevelSelectorWidget extends StatelessWidget {
  final int level;
  final String level_text;
  final String user_count;
  final String investment_amount;
  const LevelSelectorWidget({
    super.key,
    required this.level,
    required this.level_text,
    required this.user_count,
    required this.investment_amount,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return NetworkUsersScreen(
              level: level_text,
              user_count: user_count,
            );
          }));
        },
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 70,
          width: double.infinity,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.level} - $level",
                    style: TextStyle(
                      fontSize: 17, color: Colors.grey.shade800,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$user_count ${AppLocalizations.of(context)!.members}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: colorPrimary,
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Text(
                "$investment_amount ${AppLocalizations.of(context)!.usd}",
                style: TextStyle(
                  fontSize: 15, color: Colors.grey.shade800,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
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
