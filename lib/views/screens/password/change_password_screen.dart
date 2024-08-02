import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/bloc/password/change_password_bloc.dart';
import 'package:fnge/extensions/string_extensions.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/screens/password/change_password_success_screen.dart';
import 'package:fnge/views/widgets/error_alert_widget.dart';
import 'package:fnge/widgets/long_button_view.dart';
import 'package:fnge/widgets/show_password_section_view.dart';
import 'package:fnge/widgets/text_field_with_label_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isLoading = false;
  bool _passwordVisible = true;
  File? _file;
  var current_password_tec = TextEditingController();
  var new_password_tec = TextEditingController();
  var confirm_new_password_tec = TextEditingController();

  bool is_completed = false;

  final _change_password_bloc = ChangePasswordBloc();
  late Stream<ResponseOb> _change_password_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _change_password_stream = _change_password_bloc.changePasswordStream();
    _change_password_stream.listen((ResponseOb resp) {
      if (resp.success == true) {
        setState(() {
          isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return const ChangePasswordSuccessScreen();
          }), (route) => false);
        });
      } else {
        //Request Deposit Error
        showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Oops !",
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
                  color: index.isEven ? Colors.blue : Colors.grey.shade800,
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
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: colorPrimary,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  AppLocalizations.of(context)!.change_password,
                  style: TextStyle(
                    fontSize: 18,
                    color: colorPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFieldWithLabelView(
                    label: AppLocalizations.of(context)!.current_password,
                    controller: current_password_tec,
                    isPassword: _passwordVisible,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWithLabelView(
                    label: AppLocalizations.of(context)!.new_password,
                    controller: new_password_tec,
                    isPassword: _passwordVisible,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWithLabelView(
                    label: AppLocalizations.of(context)!.confirm_password,
                    controller: confirm_new_password_tec,
                    isPassword: _passwordVisible,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  ShowPasswordSectionView(
                    onChange: (value) {
                      setState(() {
                        _passwordVisible = value;
                      });
                    },
                    isSelected: _passwordVisible,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LongButtonView(
                    text: AppLocalizations.of(context)!.update,
                    onTap: () => changePassword(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  changePassword() {
    setState(() {
      isLoading = true;
    });
    if (current_password_tec.text.isNullOrEmpty() ||
        new_password_tec.text != confirm_new_password_tec.text) {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorAlert(
            "Oops !",
            Image.asset('images/welcome.png'),
            "Please complete the fields",
          );
        },
      );
      setState(() {
        isLoading = false;
      });
      return;
    } else {
      print(
          "${current_password_tec.text.isNullOrEmpty()} >>>>>> ${new_password_tec.text != confirm_new_password_tec.text}");

      Map<String, dynamic> map = {
        'old_password': current_password_tec.text,
        'new_password': new_password_tec.text,
        'new_password_confirm': confirm_new_password_tec.text,
      };
      _change_password_bloc.changePassword(map);
    }
  }

  // checkEdited() {
  //   print(
  //       "${current_password_tec.text} >>>>>> ${new_password_tec.text} >>>>>>> ${confirm_new_password_tec.text}");
  //   if (current_password_tec.text == "" ||
  //       new_password_tec.text == "" ||
  //       confirm_new_password_tec.text == "") {
  //     if (is_completed == true) {
  //       setState(() {
  //         is_completed = false;
  //       });
  //     }
  //   } else {
  //     if (is_completed == false) {
  //       setState(() {
  //         is_completed = true;
  //       });
  //     }
  //   }
  // }

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
