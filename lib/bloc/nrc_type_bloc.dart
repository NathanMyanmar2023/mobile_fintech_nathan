import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/Nrc_type_ob.dart';
import 'package:fnge/objects/region_ob.dart';
import 'package:rxdart/subjects.dart';

class NRCTypeBloc extends BaseNetwork {
  PublishSubject<ResponseOb> nrcTypeController = PublishSubject();

  Stream<ResponseOb> nrcTypeStream() => nrcTypeController.stream;

  getNRCType() async {
    getReq(NRC_TYPE, onDataCallBack: (ResponseOb resp) {
      if (kIsWeb) {
        resp.data = NrcTypeOb.fromJson(resp.data);
        nrcTypeController.sink.add(resp);
      } else {
        resp.data = NrcTypeOb.fromJson(resp.data);
        nrcTypeController.sink.add(resp);
      }
    }, errorCallBack: (ResponseOb resp) {
      nrcTypeController.sink.add(resp);
    });
  }
}
