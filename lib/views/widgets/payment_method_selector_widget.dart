import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';

class PaymentMethodSelectorWidget extends StatefulWidget {
  final String payment_name;
  final String payment_icon;
  final int payment_id;
  final int currency_id;
  final String currency_type;
  final Function(
      int payment_method_id,
      String payment_method_name,
      String payment_method_icon,
      String payment_method_currency_type) select_payment_method;
  final int selected_id;

  const PaymentMethodSelectorWidget({
    super.key,
    required this.currency_id,
    required this.currency_type,
    required this.payment_id,
    required this.payment_name,
    required this.payment_icon,
    required this.select_payment_method,
    required this.selected_id,
  });

  @override
  State<PaymentMethodSelectorWidget> createState() =>
      _PaymentMethodSelectorWidgetState();
}

class _PaymentMethodSelectorWidgetState
    extends State<PaymentMethodSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: MaterialButton(
        onPressed: () {
          widget.select_payment_method(widget.payment_id, widget.payment_name,
              widget.payment_icon, widget.currency_type);
        },
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            color: colorPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.selected_id == widget.payment_id
                  ? Colors.blue
                  : Colors.transparent,
              width: 3,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.payment_icon,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                widget.payment_name.toString(),
                // widget.radios.
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
