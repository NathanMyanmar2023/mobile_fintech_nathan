import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/region_ob.dart';
import 'package:rxdart/subjects.dart';

class RegionBloc extends BaseNetwork {
  PublishSubject<ResponseOb> regionController = PublishSubject();

  Stream<ResponseOb> regionStream() => regionController.stream;

  getRegions() async {
    getReq(REGIONS, onDataCallBack: (ResponseOb resp) {
      resp.data = RegionOb.fromJson(resp.data);
      regionController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      regionController.sink.add(resp);
    });
  }
}
