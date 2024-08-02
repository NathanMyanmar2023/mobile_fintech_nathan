import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/investment/investment_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class InvestmentBloc extends BaseNetwork {
  PublishSubject<ResponseOb> investmentController = PublishSubject();
  Stream<ResponseOb> investmentStream() => investmentController.stream;

  invest(Map<String, dynamic> map) async {
    postReq(INVEST, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = InvestmentOb.fromJson(resp.data);
        } else {
          resp.data = InvestmentOb.fromJson(resp.data);
        }
      }
      investmentController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      investmentController.sink.add(resp);
    });
  }
}
