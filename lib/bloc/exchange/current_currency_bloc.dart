import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/exchange/current_currency_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class CurrentCurrencyBloc extends BaseNetwork {
  PublishSubject<ResponseOb> currentCurrencyController = PublishSubject();
  Stream<ResponseOb> currencyStream() => currentCurrencyController.stream;

  getCurrentCurrencies() async {
    getReq(GET_CURRENT_CURRENCIES, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = CurrentCurrencyOb.fromJson(resp.data);
      }
      currentCurrencyController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      currentCurrencyController.sink.add(resp);
    });
  }
}
