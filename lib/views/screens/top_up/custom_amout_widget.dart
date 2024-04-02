import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';

import '../../../resources/colors.dart';
import '../../../widgets/long_button_view.dart';

class CustomAmountWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final Function() billFunction;

  const CustomAmountWidget({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.phone,
    this.hintText = "",
    this.inputFormatters,
    required this.billFunction,
  });

  @override
  State<CustomAmountWidget> createState() => _CustomAmountWidgetState();
}

class _CustomAmountWidgetState extends State<CustomAmountWidget> {
   bool showNext = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: colorPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: widget.controller,
          onChanged: (valu) {
            if(valu.length >= 4) {
              setState(() {
                showNext = true;
              });
            } else {
              setState(() {
                showNext = false;
              });
            }
          },keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5),
              ],
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          ),
        ),
        showNext ? Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: LongButtonView(
              text: "Next",
              onTap: ()
              {
print("connn ${widget.controller.text.trim()}");
String billAmt = widget.controller.text.trim();
print("lenco ${billAmt.length}");
    if(billAmt.length == 4) {
    if(billAmt[0].startsWith(RegExp(r'[1-9]')) && billAmt[1] ==  '0' && billAmt[2] ==  '0' && billAmt[3] ==  '0') {
    print("Validate true");
    print(billAmt);
widget.billFunction();
    } else {
      print('fals');
      failBillPay();
    }

    } else if(billAmt.length == 5) {
    if((billAmt == '49999') || (billAmt[0].startsWith(RegExp(r'[1-4]')) && billAmt[1] == '0' && billAmt[2] == '0' && billAmt[3] == '0' && billAmt[4] ==  '0') ) {
    print("Validate true");
    print(billAmt);
    widget.billFunction();

    } else {
      print("other Validate false");
      print(billAmt);
      failBillPay();
    }
    }
              }
          ),
        ) : const SizedBox(),
      ],
    );
  }
   failBillPay() {
     context.showSnack(
       "Please fill correct amount of bill",
       Colors.white,
       Colors.red,
       Icons.close,
     );
   }
}
