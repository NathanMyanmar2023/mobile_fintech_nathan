import 'package:flutter/foundation.dart';
import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/money_market/Auction_rule_ob.dart';
import 'package:rxdart/subjects.dart';

class AuctionRuleBloc extends BaseNetwork {
  PublishSubject<ResponseOb> auctionRuleController = PublishSubject();
  Stream<ResponseOb> auctionRuleStream() => auctionRuleController.stream;

  getAuctionRule({required Map<String, dynamic> data}) async {
    postReq(GET_AUCTION_RULE, params: data, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if(kIsWeb) {
          resp.data = AuctionRuleOb.fromJson(resp.data);
        } else {
          resp.data = AuctionRuleOb.fromJson(resp.data);
        }
      } 
      auctionRuleController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      auctionRuleController.sink.add(resp);
    });
  }
}
