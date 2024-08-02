import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';
import '../../objects/shopping/category_view_ob.dart';

class CategoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> categoryController = PublishSubject();

  Stream<ResponseOb> categoryStream() => categoryController.stream;

  getCategoryList() async {
    getReq(Category_url, onDataCallBack: (ResponseOb resp) {
      resp.data = CategoryViewOb.fromJson(resp.data);
      categoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      categoryController.sink.add(resp);
    });
  }
}
