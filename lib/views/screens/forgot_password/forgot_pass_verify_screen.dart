import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/otp/request_otp_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../bloc/forgot_password/forgot_verify_bloc.dart';
import '../../../helpers/shared_pref.dart';
import 'forgot_pass_reset_screen.dart';

class ForgotPassVerifyScreen extends StatefulWidget {
  final String email;
  const ForgotPassVerifyScreen({
    super.key,
    required this.email,
  });

  static String id = "email_verify_screen";

  @override
  State<ForgotPassVerifyScreen> createState() => _ForgotPassVerifyScreenState();
}

class _ForgotPassVerifyScreenState extends State<ForgotPassVerifyScreen> {
  //Text Controllers
  var otpTec = TextEditingController();
  bool isLoading = false;
  String otpCode = "";

  final _requestOtpBloc = RequestOtpBloc();
  late Stream<ResponseOb> _requestOtpStream;

  final _verifyOtpBloc = ForgotVerifyBloc();
  late Stream<ResponseOb> _verifyOtpStream;

  @override
  void initState() {
    super.initState();
    _verifyOtpStream = _verifyOtpBloc.verifyOtpStream();
    _verifyOtpStream.listen((ResponseOb resp) async {
      print("ree1 ${resp.message}");
      print("ree2 ${resp.data.runtimeType}");
      print("ree3 ${resp.success}");
       if (resp.data.runtimeType == ResponseOb && resp.message == null) {
        setState(() {
        isLoading = false;
        });
      }
      if (resp.success == false) {
        if(resp.message == null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
            return ForgotPassResetScreen(email: widget.email);
          }));
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
        }
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
  }

  void verifyOTP() {

    Map<String, dynamic> map = {
      'code': otpCode,
      'email': widget.email,
    };
    _verifyOtpBloc.verifyOtp(map);
    print("doo ${otpCode}");
    SharedPref.setData(
      key: SharedPref.otpCode,
      value: otpCode,
    );
    setState(() {
      isLoading = true;
    });
  }
   ResendToEmail() {
     setState(() {
       isLoading = true;
     });
    _requestOtpStream = _requestOtpBloc.requestOtpStream();
     _requestOtpStream.listen((ResponseOb resp) {
       print("dodo resend;");
       if (resp.success == false) {
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
       } else {
         setState(() {
           isLoading = false;
         });}
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
                      verifyOTP();
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
                         //   _requestOtpBloc.requestOtp(email: widget.email);
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
