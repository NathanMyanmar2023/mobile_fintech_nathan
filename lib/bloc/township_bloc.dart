import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/township_ob.dart';
import 'package:rxdart/subjects.dart';

class TownshipBloc extends BaseNetwork {
  PublishSubject<ResponseOb> townshipController = PublishSubject();

  Stream<ResponseOb> townshipStream() => townshipController.stream;

  getTownShip({required int id}) async {
    getReq("${API_URL}delivery/townships/$id",
        onDataCallBack: (ResponseOb resp) {
      resp.data = TownshipOb.fromJson(resp.data);
      townshipController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      townshipController.sink.add(resp);
    });
  }
}
