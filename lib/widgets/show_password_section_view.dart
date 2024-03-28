import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';

class ShowPasswordSectionView extends StatelessWidget {
  final Function(bool) onChange;
  final bool isSelected;

  const ShowPasswordSectionView({
    super.key,
    required this.onChange,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 25,
          height: 25,
          child: Checkbox(
            value: !isSelected,
            onChanged: (value) => onChange(!isSelected),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        const Text(
          "Show Password",
          style: TextStyle(
            color: colorPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        )
      ],
    );
  }
}
