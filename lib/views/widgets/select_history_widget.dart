import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';

class SelectHistoryWidget extends StatelessWidget {
  final String history_name;
  final IconData history_icon;
  final Widget target_page;
  const SelectHistoryWidget({
    super.key,
    required this.history_name,
    required this.history_icon,
    required this.target_page,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return target_page;
          }));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                history_icon,
                size: 28,
                color: colorWhite,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                // softWrap: false,
                // overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                maxLines: 2,
                history_name,
                style: const TextStyle(fontSize: 13, color: colorWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
