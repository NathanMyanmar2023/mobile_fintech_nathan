import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/bloc/otp/request_otp_bloc.dart';
import 'package:fnge/bloc/otp/verify_otp_bloc.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/screens/main_screen.dart';
import 'package:fnge/views/widgets/error_alert_widget.dart';
import 'package:fnge/widgets/long_button_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'choose_language_screen.dart';

class VerifyScreen extends StatefulWidget {
  final String email;
  const VerifyScreen({
    super.key,
    required this.email,
  });

  static String id = "email_verify_screen";

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  //Text Controllers
  var otpTec = TextEditingController();
  bool isLoading = false;
  String otpCode = "";

  final _requestOtpBloc = RequestOtpBloc();
  late Stream<ResponseOb> _requestOtpStream;

  final _verifyOtpBloc = VerifyOtpBloc();
  late Stream<ResponseOb> _verifyOtpStream;

  @override
  void initState() {
    super.initState();
    _verifyOtpStream = _verifyOtpBloc.verifyOtpStream();
    _verifyOtpStream.listen((ResponseOb resp) {
      if (resp.success == false) {
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
      } else {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const ChooseLanguageScreen();
        }));
      }
    });
  }

  ResendToEmail() {
    setState(() {
      isLoading = false;
    });
    _requestOtpStream = _requestOtpBloc.requestOtpStream();
    _requestOtpStream.listen((ResponseOb resp) {
      if (resp.success == false) {
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
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });

    _requestOtpBloc.requestOtp(email: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MediaQuery(
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
          )
        : MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('images/sms.png'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "OTP Verification",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Enter the OTP sent to ${widget.email}",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: PinCodeTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.scale,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeColor: colorPrimary,
                          inactiveColor: Colors.grey.shade400,
                          selectedColor: colorPrimary,
                        ),
                        onChanged: (String value) {
                          otpCode = value.toString();
                        },
                        appContext: context,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LongButtonView(
                        text: 'Verify',
                        onTap: () {
                          if (otpCode.length > 5) {
                            Map<String, dynamic> map = {
                              'code': otpCode,
                              'email': widget.email,
                            };
                            _verifyOtpBloc.verifyOtp(map);
                            setState(() {
                              isLoading = true;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Do not received any code?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              InkWell(
                                onTap: () {
                                  //  _requestOtpBloc.requestOtp(email: widget.email);
                                  ResendToEmail();
                                },
                                child: const Text(
                                  "Resend Code",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: colorPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
