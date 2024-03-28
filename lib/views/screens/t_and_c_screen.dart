import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TAndCScreen extends StatelessWidget {
  const TAndCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AppBar(
              toolbarHeight: 70,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                AppLocalizations.of(context)!.terms_conditions,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: SizedBox(
                      width: 150,
                      child: Image.asset('images/t_and_c.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.terms_conditions,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  AppLocalizations.of(context)!.these_terms_conditions_between,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context)!.by_registering_or_using,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context)!.our_nathan_investment_mm_services_allow,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context)!.our_nathan_investment_mm_services_need,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context)!.we_will_issue_user_account,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context)!.at_time_of_initial_registration,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context)!.collection_verification,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context)!.reserve_the_right_time,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context)!.reserve_the_right_discontinue,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context)!.must_notify_us_of_change,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
