import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fnge/config/config.dart';
import 'package:fnge/helpers/shared_pref.dart';
import 'package:fnge/models/response_objects/delivery_region/delivery_region_response_object.dart';
import 'package:fnge/models/response_objects/delivery_township/delivery_township_response_object.dart';
import 'package:fnge/models/services/api_service.dart';
import 'package:fnge/models/services/api_status.dart';

class AddAddressViewModel extends ChangeNotifier {
  bool _loading = true;
  List<Regions> _regionList = [];
  List<Townships> _townshipList = [];
  final apiService =
      ApiService(Dio(BaseOptions(contentType: "application/json")));
  late Regions _selectedRegion;
  late Townships _selectedTownship;
  //TECs
  final TextEditingController _addressLineTec = TextEditingController();
  final TextEditingController _phoneTec = TextEditingController();
  final TextEditingController _receiverNameTec = TextEditingController();
  bool _isHome = true;

  //Getters
  bool get loading => _loading;
  List<Regions> get regionList => _regionList;
  List<Townships> get townshipList => _townshipList;

  Regions get selectedRegion => _selectedRegion;
  Townships get selectedTownship => _selectedTownship;

  TextEditingController get addressLineTec => _addressLineTec;
  TextEditingController get phoneTec => _phoneTec;
  TextEditingController get receiverNameTec => _receiverNameTec;
  bool get isHome => _isHome;

  AddAddressViewModel() {
    getRegions();
  }

  refresh() async {
    getRegions();
  }

  setIsHome(bool isHome) {
    _isHome = isHome;
    notifyListeners();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setRegionList(List<Regions> regionList) async {
    _regionList = regionList;
    setSelectedRegion(regionList[0]);
  }

  setTownshipList(List<Townships> townshipList) async {
    _townshipList = townshipList;
    _selectedTownship = townshipList[0];
  }

  setSelectedRegion(Regions region) async {
    _selectedRegion = region;
    getTownships(region.id);
  }

  setSelectedTownship(Townships township) async {
    setLoading(true);
    _selectedTownship = township;
    setLoading(false);
  }

  getRegions() async {
    String? token = await SharedPref.getData(key: SharedPref.token);
    String? language = await SharedPref.getData(key: SharedPref.language_code);
    print("languagelanguage2 $language");
    setLoading(true);
    try {
      var response = await apiService.getDeliveryRegions(
          "Bearer $token", Config.apiKey, "$language");
      print("Get Region Response >> ${response.data}");
      setRegionList(response.data);
    } catch (e) {
      print('Error: $e');
    }
    setLoading(false);
  }

  getTownships(int regionId) async {
    String? token = await SharedPref.getData(key: SharedPref.token);
    String? language = await SharedPref.getData(key: SharedPref.language_code);
    print("languagelanguage4 $language");
    setLoading(true);
    try {
      var response = await apiService.getDeliveryTownships(
          "Bearer $token", Config.apiKey, regionId, "$language");
      print("Get Township Response >> ${response.data}");
      setTownshipList(response.data);
    } catch (e) {
      print('Error: $e');
    }
    setLoading(false);
  }

  updateAddress() async {
    String? token = await SharedPref.getData(key: SharedPref.token);
    String? language = await SharedPref.getData(key: SharedPref.language_code);
    print("languagelanguage5 $language");
    setLoading(true);
    if (addressLineTec.text == "" ||
        phoneTec.text == "" ||
        receiverNameTec.text == "") {
      setLoading(false);
      return ApiStatus(success: false, message: "Please fill all field");
    }
    try {
      var response = await apiService.updateAddress(
        "Bearer $token",
        Config.apiKey,
        selectedRegion.id,
        selectedTownship.id,
        addressLineTec.text,
        phoneTec.text,
        receiverNameTec.text,
        isHome,
        "$language",
      );

      if (response.success) {
        setLoading(false);
        return ApiStatus(success: true, message: "Successfully update");
      } else {
        setLoading(false);
        return ApiStatus(success: false, message: response.message);
      }
    } catch (e) {
      print('Error: $e');
      setLoading(false);
      return ApiStatus(success: false, message: "Something went wrong");
    }
  }
}
