import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fnge/config/config.dart';
import 'package:fnge/helpers/shared_pref.dart';
import 'package:fnge/models/services/api_service.dart';
import 'package:fnge/models/services/api_status.dart';

class ProductViewModel extends ChangeNotifier {
  bool _loading = false;
  final apiService =
      ApiService(Dio(BaseOptions(contentType: "application/json")));

  bool get loading => _loading;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  addToCart(int productId, int quantity) async {
    String? token = await SharedPref.getData(key: SharedPref.token);
    String? language = await SharedPref.getData(key: SharedPref.language_code);
    setLoading(true);
    try {
      var response = await apiService.addToCart(
          "Bearer $token", Config.apiKey, quantity, productId, "$language");
      setLoading(false);
      if (response.success) {
        return ApiStatus(success: true, message: response.message);
      } else {
        return ApiStatus(success: false, message: response.message);
      }
    } catch (e) {
      setLoading(false);
      return ApiStatus(success: false, message: "Something went wrong");
    }
  }

  makeCheckOut(int townShipId, String address) async {
    String? token = await SharedPref.getData(key: SharedPref.token);
    String? language = await SharedPref.getData(key: SharedPref.language_code);
    setLoading(true);
    try {
      var response = await apiService.makeCheckOut(
          "Bearer $token", Config.apiKey, townShipId, address, "$language");
      setLoading(false);
      if (response.success) {
        return ApiStatus(success: true, message: response.message);
      } else {
        return ApiStatus(success: false, message: response.message);
      }
    } catch (e) {
      setLoading(false);
      return ApiStatus(success: false, message: "Something went wrong");
    }
  }
}
