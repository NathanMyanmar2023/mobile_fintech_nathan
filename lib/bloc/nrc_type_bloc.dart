import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/Nrc_type_ob.dart';
import 'package:nathan_app/objects/region_ob.dart';
import 'package:rxdart/subjects.dart';

class NRCTypeBloc extends BaseNetwork {
  PublishSubject<ResponseOb> nrcTypeController = PublishSubject();

  Stream<ResponseOb> nrcTypeStream() => nrcTypeController.stream;

  getNRCType() async {
    getReq(NRC_TYPE, onDataCallBack: (ResponseOb resp) {
      resp.data = NrcTypeOb.fromJson(resp.data);
      nrcTypeController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      nrcTypeController.sink.add(resp);
    });
  }
}
