import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/brands_ob.dart';
import 'package:rxdart/subjects.dart';

class BrandsBloc extends BaseNetwork {
  PublishSubject<ResponseOb> brandsController = PublishSubject();

  Stream<ResponseOb> brandsStream() => brandsController.stream;

  getBrandsList(int categoryId) async {
    getReq("$Brands_url/$categoryId/brands", onDataCallBack: (ResponseOb resp) {
      resp.data = BrandsOb.fromJson(resp.data);
      brandsController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      brandsController.sink.add(resp);
    });
  }
}
