import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/extensions/string_extensions.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/login_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:nathan_app/widgets/show_password_section_view.dart';
import 'package:nathan_app/widgets/text_field_with_label_view.dart';
import '../../../bloc/forgot_password/forgot_pass_reset_bloc.dart';
import '../../../helpers/shared_pref.dart';

class ForgotPassResetScreen extends StatefulWidget {
  final String email;
  const ForgotPassResetScreen({
    super.key,
    required this.email,
  });

  @override
  State<ForgotPassResetScreen> createState() => _ForgotPassResetScreenState();
}

class _ForgotPassResetScreenState extends State<ForgotPassResetScreen> {
  bool isLoading = false;
  bool _passwordVisible = true;
  File? _file;
  var new_password_tec = TextEditingController();
  var confirm_new_password_tec = TextEditingController();

  bool is_completed = false;

  final _change_password_bloc = ForgotPassResetBloc();
  late Stream<ResponseOb> _change_password_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _change_password_stream = _change_password_bloc.changePasswordStream();
    _change_password_stream.listen((ResponseOb resp) {
      print("rest ${resp.success}");
      if (resp.success == true) {
        setState(() {
          isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
                return const LoginScreen();
              }), (route) => false);
        });
      } else {
        //Request Deposit Error
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
                title: const Text(
                  "Reset Password",
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
                    label: "New Password",
                    controller: new_password_tec,
                    isPassword: _passwordVisible,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWithLabelView(
                    label: "Confirm Password",
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
                    text: "Reset",
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

  changePassword() async {
    setState(() {
      isLoading = true;
    });
    if (new_password_tec.text.isNullOrEmpty() ||
        new_password_tec.text != confirm_new_password_tec.text) {
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
    } else {
print("ooo ${widget.email}");
String? otpCode = await SharedPref.getData(key: SharedPref.otpCode);
print("ot $otpCode");
      Map<String, dynamic> map = {
        'email': widget.email,
        'code': otpCode,
        'new_password': new_password_tec.text,
        'new_password_confirm': confirm_new_password_tec.text,
      };
      _change_password_bloc.changePassword(map);
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
