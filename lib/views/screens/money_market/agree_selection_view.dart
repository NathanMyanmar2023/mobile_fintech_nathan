import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';

class AgreeSectionView extends StatelessWidget {
  final Function(bool) onChange;
  final bool isSelected;

  const AgreeSectionView({
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
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(100),
            // ),
          ),
        ),
        const SizedBox(width: 5,),
        const Text(
          "I agree to the Terms & Condition",
          style: TextStyle(
            color: colorPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
