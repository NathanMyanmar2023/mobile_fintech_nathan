import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/countries_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class CountriesBloc extends BaseNetwork {
  PublishSubject<ResponseOb> countriesController = PublishSubject();
  Stream<ResponseOb> countriesStream() => countriesController.stream;

  getCountries() async {
    getReq(GET_COUNTRIES, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = CountriesOb.fromJson(resp.data);
      }
      countriesController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      countriesController.sink.add(resp);
    });
  }
}
