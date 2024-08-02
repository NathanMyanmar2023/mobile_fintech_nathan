import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/deposit/currency_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class CurrencyBloc extends BaseNetwork {
  PublishSubject<ResponseOb> currencyController = PublishSubject();
  Stream<ResponseOb> currencyStream() => currencyController.stream;

  getCurrencies() async {
    getReq(GET_CURRENCIES, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = CurrencyOb.fromJson(resp.data);
        } else {
          resp.data = CurrencyOb.fromJson(resp.data);
        }
      }
      currencyController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      currencyController.sink.add(resp);
    });
  }
}
