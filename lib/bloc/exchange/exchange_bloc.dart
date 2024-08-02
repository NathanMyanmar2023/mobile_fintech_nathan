import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/exchange/exchange_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class ExchangeBloc extends BaseNetwork {
  PublishSubject<ResponseOb> exchangeController = PublishSubject();
  Stream<ResponseOb> exchangeStream() => exchangeController.stream;

  exchange(Map<String, dynamic> map) async {
    postReq(EXCHANGE, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = ExchangeOb.fromJson(resp.data);
        } else {
          resp.data = ExchangeOb.fromJson(resp.data);
        }
      }
      exchangeController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      exchangeController.sink.add(resp);
    });
  }
}
