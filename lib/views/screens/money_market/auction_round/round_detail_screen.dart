import 'package:flutter/material.dart';

import '../../../../widgets/app_bar_title_view.dart';

class RoundDetailScreen extends StatefulWidget {
  final int roundId;
  const RoundDetailScreen({Key? key, required this.roundId}) : super(key: key);

  @override
  State<RoundDetailScreen> createState() => _RoundDetailScreenState();
}

class _RoundDetailScreenState extends State<RoundDetailScreen> {

  Future refersh() async {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarTitleView(
          text: "Place Bid for Round ${widget.roundId}",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refersh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Text('dfoeore')
            ],
          )
        ),
      ),
    );
  }
}
