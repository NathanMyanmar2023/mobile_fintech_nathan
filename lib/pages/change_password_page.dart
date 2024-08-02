import 'package:flutter/material.dart';
import 'package:fnge/widgets/long_button_view.dart';
import 'package:fnge/widgets/text_field_with_label_view.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            TextFieldWithLabelView(
              label: "Current Password",
              controller: TextEditingController(),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWithLabelView(
              label: "New Password",
              controller: TextEditingController(),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWithLabelView(
              label: "Confirm Password",
              controller: TextEditingController(),
            ),
            // const ShowPasswordSectionView(),
            const SizedBox(
              height: 20,
            ),
            LongButtonView(text: "Update", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
