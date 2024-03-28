import 'package:flutter/material.dart';

class EULA extends StatelessWidget {
  const EULA({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            title: const Text(
              "End-user license agreement",
              style: TextStyle(
                fontSize: 18,
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
                  "Terms And Conditions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "These terms and conditions are between you and us, and are applicable to the Fintech Nathan Group of Companies services we provide (‘Terms and Conditions')",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "By registering or using Fintech Nathan Group of Companies services, you have to agree to our Terms and Conditions.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Our Fintech Nathan Group of Companies services allow different groups of users to provide some/all of the Transaction types offered by us from time to time. We reserve the right to limit or allowing any Transaction types to all the users in our application.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Our Fintech Nathan Group of Companies need your real identity for better experience and allowing to use all of our services.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "We will issue you with a user account after you successfully register for Fintech Nathan Group of Companies services. ",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "At the time of initial registration or at a later date, you may apply to upgrade your Nathan Investment account for more upgrades and new services.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "The collection, verification, audit and maintenance of coreect and updated Customer informantion is a continuous process.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "We reserve the right, at any time, to take steps necessary to ensure compliance.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "We also reserve the right to discontinue the Fintech Nathan Group of Companies services, reject transaction and applications for Fintech Nathan Group of Companies services, and suspend or terminate your Nathan Investment account and retain the balance at any time if there are discrepancies or inaccuracies in any information or documentation that you provide to us.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "You must notify us of any change in any personal information that you previously provided to us, including changes in your address  or registration information, within serveral days of such change, along with such proof as required in our discretion.",
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
