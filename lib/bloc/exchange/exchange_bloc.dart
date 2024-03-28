import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/exchange/exchange_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class ExchangeBloc extends BaseNetwork {
  PublishSubject<ResponseOb> exchangeController = PublishSubject();
  Stream<ResponseOb> exchangeStream() => exchangeController.stream;

  exchange(Map<String, dynamic> map) async {
    postReq(EXCHANGE, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = ExchangeOb.fromJson(resp.data);
      }
      exchangeController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      exchangeController.sink.add(resp);
    });
  }
}
