import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const token = 'token';
  static const accountId = 'accountId';
  static const countryCode = "countryCode";
  static const otpCode = "otpCode";
  static const responseError = "responseError";
  static const setLanId = 'setLanId';
  static const locale = 'locale';
  static const language_code = 'language_code';
  static const currency = "currency";

  static Future<bool> setData({String? key, String? value}) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    return shp.setString(key!, value!);
  }

  static Future<String?> getData({required String key}) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    String? str = shp.getString(key);
    return str;
  }

  static void clear() async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    shp.clear();
  }
}
