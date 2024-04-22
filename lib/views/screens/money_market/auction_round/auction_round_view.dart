import 'package:flutter/material.dart';

import '../../../../resources/colors.dart';
import '../../../../widgets/nathan_text_view.dart';


class AuctionRoundView extends StatefulWidget {
  const AuctionRoundView({Key? key}) : super(key: key);

  @override
  State<AuctionRoundView> createState() => _AuctionRoundViewState();
}

class _AuctionRoundViewState extends State<AuctionRoundView> {
  final scroll_controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListView.builder(
          controller: scroll_controller,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                         // backgroundColor: colorPrimary.withOpacity(0.8),
                          child:  NathanTextView(text:"Round ${index+1}"),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(child: NathanTextView(text: "dfle",)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
