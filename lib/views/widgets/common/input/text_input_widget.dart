import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    required this.textEditingController,
    required this.label,
    required this.icon,
    required this.hint,
  });

  final TextEditingController textEditingController;
  final String label;
  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            label,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              hintText: hint,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
            obscureText: false,
          ),
        ),
      ],
    );
  }
}
