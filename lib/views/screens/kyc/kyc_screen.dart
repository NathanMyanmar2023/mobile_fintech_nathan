import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nathan_app/bloc/kyc/kyc_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/kyc/success_kyc_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:nathan_app/widgets/text_field_with_label_view.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_converter/rabbit_converter.dart';
import '../../../view_models/app_language_view_model.dart';
import '../../../widgets/theme_text.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({
    super.key,
  });

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  String? _currentAddress;
  Position? _currentPosition;
  bool isLoading = false;
  File? _photo;
  File? _nrc_front;
  File? _nrc_back;
  File? _bank_statement;

  var full_name_tec = TextEditingController();
  var nrc_number_tec = TextEditingController();
  var current_address_tec = TextEditingController();
  var bank_name_tec = TextEditingController();
  var payment_address_tec = TextEditingController();
  var account_number_tec = TextEditingController();
  var beneficial_name_tec = TextEditingController();
  var beneficial_phone_tec = TextEditingController();
  var beneficial_nrc_tec = TextEditingController();
  var beneficial_email_tec = TextEditingController();

  final _kyc_bloc = KycBloc();
  late Stream<ResponseOb> _kyc_stream;
  late Stream<ResponseOb> _presign_stream;

  @override
  void initState() {
    super.initState();
    _kyc_stream = _kyc_bloc.uploadKycStream();
    _kyc_stream.listen((ResponseOb resp) {
      if (resp.success == true) {
        setState(() {
          isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return const SuccessKycScreen();
          }), (route) => false);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Oppo !",
              Image.asset('images/welcome.png'),
              resp.message.toString(),
            );
          },
        );
        setState(() {
          isLoading = false;
        });
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SpinKitFadingFour(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven ? colorPrimary : Colors.grey.shade800,
                ),
              );
            },
          ),
        ),
      );
    } else {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AppBar(
                toolbarHeight: 70,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: colorPrimary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  AppLocalizations.of(context)!.kyc_info,
                  style: TextStyle(
                    fontSize: 18,
                    color: colorPrimary,
                  ),
                ),
              ),
            ),
          ),
          body: Consumer<AppLanguageViewModel>(
              builder: (context, model, child) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      MaterialButton(
                        color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color:
                                _photo != null ? Colors.transparent : colorPrimary,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(180),
                        ),
                        elevation: 0,
                        onPressed: takeImage,
                        padding: const EdgeInsets.all(0),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: _photo != null
                              ? Image.file(
                                  _photo!,
                                  fit: BoxFit.cover,
                                )
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 50,
                                    color: colorPrimary,
                                  ),
                                  Text(AppLocalizations.of(context)!.upload_u_photo),
                                ],
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                          label: AppLocalizations.of(context)!.full_name, controller: full_name_tec, hintText: "*****Kyaw",
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                          label: AppLocalizations.of(context)!.nrc_no, controller: nrc_number_tec, hintText: "12/BaHaNa(N)*****23",
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9()/A-Za-z]')),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                          label: AppLocalizations.of(context)!.current_address, controller: current_address_tec, hintText: "*****,Yangon",
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9 ()/A-Za-z,-]')),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          AppLocalizations.of(context)!.nrc_lic_front,
                          style: TextStyle(
                            color: colorPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      MaterialButton(
                        color: colorPrimary.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        onPressed: pickNrcFront,
                        padding: const EdgeInsets.all(0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: _nrc_front != null
                              ? Image.file(
                                  _nrc_front!,
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 50,
                                    color: colorPrimary,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                       SizedBox(
                        width: double.infinity,
                        child: Text(AppLocalizations.of(context)!.nrc_lic_back,
                          style: const TextStyle(
                            color: colorPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      MaterialButton(
                        color: colorPrimary.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        onPressed: pickNrcBack,
                        padding: const EdgeInsets.all(0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: _nrc_back != null
                              ? Image.file(
                                  _nrc_back!,
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 50,
                                    color: colorPrimary,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                          label: AppLocalizations.of(context)!.bank_name, controller: bank_name_tec,
                        hintText: "KBZ/CB/AYA",
                          keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                          label: AppLocalizations.of(context)!.pay_address,
                          controller: payment_address_tec,
                        hintText: "*****Yangon",
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9 ()/A-Za-z,-]')),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                          label: AppLocalizations.of(context)!.bank_acc_no,
                          controller: account_number_tec,
                        hintText: "*****3456",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          AppLocalizations.of(context)!.bank_statement,
                          style: TextStyle(
                            color: colorPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      MaterialButton(
                        color: colorPrimary.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        onPressed: pickBankStatement,
                        padding: const EdgeInsets.all(0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: _bank_statement != null
                              ? Image.file(
                                  _bank_statement!,
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.document_scanner,
                                    size: 50,
                                    color: colorPrimary,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                          label: model.appLocal.languageCode != 'my' ? AppLocalizations.of(context)!.benefi_name
                              : "${ThemeText.mmText("အကျိုး")}${AppLocalizations.of(context)!.benefi_name}",
                          controller: beneficial_name_tec,
                        hintText: "*****Tun",
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                          label: model.appLocal.languageCode != 'my' ? AppLocalizations.of(context)!.benefi_phone
                              : "${ThemeText.mmText("အကျိုး")}${AppLocalizations.of(context)!.benefi_phone}",
                          controller: beneficial_phone_tec,
                        hintText: "925****4567",
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                          label: model.appLocal.languageCode != 'my' ? AppLocalizations.of(context)!.benefi_nrc_no
                              : "${ThemeText.mmText("အကျိုး")}${AppLocalizations.of(context)!.benefi_nrc_no}",
                          controller: beneficial_nrc_tec,
                        hintText: "12/BaHaNa(N)****24",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9()/A-Za-z]')),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabelView(
                          label: model.appLocal.languageCode != 'my' ? AppLocalizations.of(context)!.benefi_email
                              : "${ThemeText.mmText("အကျိုး")}${AppLocalizations.of(context)!.benefi_email}",
                          controller: beneficial_email_tec,
                        hintText: "*****abc@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9a-z@.]')),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LongButtonView(
                        text: _currentPosition?.latitude != null ? AppLocalizations.of(context)!.update  : AppLocalizations.of(context)!.next,
                        onTap: () => uploadKYC(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      );
    }
  }

  uploadKYC() {
    print('LAT: ${_currentPosition?.latitude ?? ""}');
    print('LNG: ${_currentPosition?.longitude ?? ""}');
    _currentAddress = _currentAddress;
    setState(() {
      isLoading = true;
    });
    if (full_name_tec.text == "" ||
        nrc_number_tec.text == "" ||
        bank_name_tec.text == "" ||
        payment_address_tec.text == "" ||
        account_number_tec.text == "" ||
        beneficial_name_tec.text == "" ||
        beneficial_phone_tec.text == "" ||
        beneficial_nrc_tec.text == "" ||
        beneficial_email_tec.text == "" ||
        current_address_tec.text == "" ||
        _photo == null ||
        _nrc_front == null ||
        _nrc_back == null ||
        _bank_statement == null) {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorAlert(
            "Oppo !",
            Image.asset('images/welcome.png'),
            "Please complete the fields",
          );
        },
      );
      setState(() {
        isLoading = false;
      });
      return;
    }



    if(_currentPosition?.latitude != null) {
      print("odoer ${_currentPosition?.latitude}");
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> map = {
        'full_name': full_name_tec.text,
        'nrc_number': nrc_number_tec.text,
        'bank_name': bank_name_tec.text,
        'current_address': current_address_tec.text,
        'payment_address': payment_address_tec.text,
        'bank_account_number': account_number_tec.text,
        'beneficial_name': beneficial_name_tec.text,
        'beneficial_phone': beneficial_phone_tec.text,
        'beneficial_nrc': beneficial_nrc_tec.text,
        'beneficial_email': beneficial_email_tec.text,
        'lat': _currentPosition?.latitude,
        'long': _currentPosition?.longitude,
      };

      _kyc_bloc.uploadKyc(map, _photo, _nrc_front, _nrc_back, _bank_statement);

      setState(() {
        isLoading = true;
      });
    }
    else {
      print("hooo");
      setState(() {
        _getCurrentPosition();
        isLoading = false;
      });
    }
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  //Select Image
  final ImagePicker _nrc_front_picker = ImagePicker();
  pickNrcFront() async {
    final XFile? pickedFile = await _nrc_front_picker.pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _nrc_front = File(pickedFile.path);
      });
    }
  }

  final ImagePicker _nrc_back_picker = ImagePicker();
  pickNrcBack() async {
    final XFile? pickedFile = await _nrc_back_picker.pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _nrc_back = File(pickedFile.path);
      });
    }
  }

  final ImagePicker _bank_statement_picker = ImagePicker();
  pickBankStatement() async {
    final XFile? pickedFile = await _bank_statement_picker.pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _bank_statement = File(pickedFile.path);
      });
    }
  }

  final ImagePicker _photo_picker = ImagePicker();
  takeImage() async {
    _getCurrentPosition();
    final XFile? pickedFile = await _photo_picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _photo = File(pickedFile.path);
      });
    }
  }

  showSnack(String msg, Color msgColor, Color bgColor, IconData icon) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            msg,
            style: TextStyle(
              color: msgColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: const StadiumBorder(),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: bgColor,
      elevation: 0,
    ));
  }
}
