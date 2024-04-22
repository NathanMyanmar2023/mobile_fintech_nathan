import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/objects/money_market/Auction_round_ob.dart';
import 'package:nathan_app/views/screens/money_market/auction_round/round_detail_screen.dart';

import '../../../../bloc/money_market/auction_round_bloc.dart';
import '../../../../helpers/response_ob.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets/nathan_text_view.dart';


class AuctionRoundView extends StatefulWidget {
  final int autionId;
  const AuctionRoundView({Key? key, required this.autionId}) : super(key: key);

  @override
  State<AuctionRoundView> createState() => _AuctionRoundViewState();
}

class _AuctionRoundViewState extends State<AuctionRoundView> {
  final scroll_controller = ScrollController();
  bool isLoading = true;


  final _auctionRound_bloc = AuctionRoundBloc();
  late Stream<ResponseOb> _auctionRound_stream;

  //payment metnod list
  List auctionRoundList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _auctionRound_stream = _auctionRound_bloc.auctionRoundStream();
    _auctionRound_stream.listen((ResponseOb resp) {
      if (resp.success) {
        auctionRoundList = (resp.data as AuctionRoundOb).data ?? [];
        print("auctionRoundList ${auctionRoundList.length}");
      } else {
        print("error");
      }
      setState(() {
        isLoading = false;
      });
    });
  //  _auctionRound_bloc.getAuctionRound(widget.autionId);
  }

  @override
  Widget build(BuildContext context) {

    return
      Expanded(
        child: GridView.builder(
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2),
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
          ),
          padding: EdgeInsets.zero, // padding around the grid
          itemCount: 10, // total number of items
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (co) => RoundDetailScreen(roundId: index+1,)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: colorPrimary.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Round ${index+1}",
                      style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Real Amount - 3000.00",
                      style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Estimate - 5000.00",
                      style: TextStyle(fontSize: 13.0, color: Colors.white,fontWeight: FontWeight.w600),
                    ),
                    Column(
                      children: [
                        Text(
                          "Winner Bidder name",
                          style: TextStyle(fontSize: 14.0, color: Colors.white,fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Tun Lin",
                          style: TextStyle(fontSize: 14.0, color: Colors.white,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Text(
                      "Status - pending",
                      style: TextStyle(fontSize: 10.0, color: Colors.white),
                    ),
                  ],
                )
              ),
            );
          },
        ),
      );

  }
}
