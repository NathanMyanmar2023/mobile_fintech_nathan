import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/Operator_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class OperatorBloc extends BaseNetwork {
  PublishSubject<ResponseOb> operatorController = PublishSubject();
  Stream<ResponseOb> operatorStream() => operatorController.stream;

  getPhoneOperator() async {
    getReq(PHONE_OPERATOR_URL, onDataCallBack: (ResponseOb resp) {
      operatorController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      operatorController.sink.add(resp);
    });
  }
}
