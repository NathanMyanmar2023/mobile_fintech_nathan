import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fnge/config/config.dart';
import 'package:fnge/helpers/shared_pref.dart';
import 'package:fnge/models/response_objects/cart/cart_response_object.dart';
import 'package:fnge/models/services/api_service.dart';

class CartViewModel extends ChangeNotifier {
  bool _loading = false;
  List<CartItems> _cartItemList = [];
  final apiService =
      ApiService(Dio(BaseOptions(contentType: "application/json")));
  late CartItems _selectedCartItem;
  late Address _address = Address(
    region: "",
    regionId: 0,
    township: "",
    townshipId: 0,
    addressLine: "",
    phone: "",
    receiverName: "",
    isHome: 0,
    deliveryFee: 0,
  );
  String _subTotal = "00.00";
  String _grandTotal = "00.00";
  bool _haveAddress = true;

  //Getters
  bool get loading => _loading;
  List<CartItems> get cartItemList => _cartItemList;
  Address get address => _address;
  String get subTotal => _subTotal;
  String get grandTotal => _grandTotal;
  bool get haveAddress => _haveAddress;

  CartViewModel() {
    getCart();
  }

  refresh() async {
    getCart();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setTotal(String subTotal, String grandTotal, bool haveAddress) async {
    _subTotal = subTotal;
    _grandTotal = grandTotal;
    _haveAddress = haveAddress;
  }

  setAddress(Address address) async {
    _address = address;
  }

  setCartItemList(List<CartItems> cartItemList) async {
    _cartItemList = cartItemList;
  }

  getCart() async {
    String? token = await SharedPref.getData(key: SharedPref.token);
    String? language = await SharedPref.getData(key: SharedPref.language_code);
    print("languagelanguage1 $language");
    print(token);
    setLoading(true);
    try {
      var response =
          await apiService.getCart("Bearer $token", Config.apiKey, "$language");
      print(response);
      setCartItemList(response.data!.items);
      setAddress(response.data!.address);
      String subTotal = response.data!.subTotal.toString();
      String grandTotal = response.data!.grandTotal.toString();
      bool? haveAddress = response.data!.haveAddress;
      setTotal(subTotal, grandTotal, haveAddress);
    } catch (e) {
      print('Error: $e');
    }
    setLoading(false);
  }
}
