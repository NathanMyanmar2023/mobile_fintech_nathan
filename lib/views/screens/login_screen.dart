import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/login_bloc.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/resources/constants.dart';
import 'package:nathan_app/views/screens/forgot_password/forgot_password_screen.dart';
import 'package:nathan_app/views/screens/main_screen.dart';
import 'package:nathan_app/views/screens/password/change_password_screen.dart';
import 'package:nathan_app/views/screens/phone_verify_screen.dart';
import 'package:nathan_app/views/screens/register_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:nathan_app/widgets/show_password_section_view.dart';

import '../../bloc/otp/request_otp_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Text Controllers
  var emailTec = TextEditingController();
  var passwordTec = TextEditingController();

  bool _passwordVisible = true;
  bool isLoading = false;

  final _loginBloc = LoginBloc();
  late Stream<ResponseOb> _loginStream;

  final _requestOtpBloc = RequestOtpBloc();
  late Stream<ResponseOb> _requestOtpStream;
  ResendToEmail(String userEmail) {
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

    _requestOtpBloc.requestOtp(email: userEmail);
  }

  @override
  void initState() {
    super.initState();
    _loginStream = _loginBloc.loginStream();
    _loginStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          isLoading = false;
        });
        print("ddata ${resp.data.data.verified}");
        if (resp.data.data.verified == true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return const MainScreen();
          }), (route) => false);
        } else {
          ResendToEmail(emailTec.text);
          print("emailTec ${emailTec.text}");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return VerifyScreen(email: emailTec.text);
          }), (route) => false);
        }
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Fail to Login !'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/welcome.png', height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      resp.message.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      popBack(context: context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
        setState(() {
          isLoading = false;
        });
        return;
      }
    });
  }

  //check phone number
  bool isEmailValid(String email) {
    RegExp regExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regExp.hasMatch(email);
  }

  void login() async {
    String email = emailTec.text.toString();
    String password = passwordTec.text.toString();

    if (!isEmailValid(email)) {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Error",
              Image.asset('images/welcome.png'),
              "Email is invalid",
            );
          });
      setState(() {
        isLoading = false;
      });
      return;
    }

    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $fcmToken');
    Map<String, dynamic> map = {
      'email': email,
      'password': password,
     // 'fcm_token': fcmToken,
    };
    _loginBloc.login(map);
    setState(() {
      isLoading = true;
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
          backgroundColor: Colors.white,
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: Image.asset(loginLogo),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: colorPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 14,
                          color: colorPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: colorPrimary),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: TextField(
                        controller: emailTec,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: colorPrimary,
                          ),
                          hintText: "someone@example.org",
                          border: InputBorder.none,
                          prefixIconColor: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 14,
                          color: colorPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: colorPrimary),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: TextField(
                        controller: passwordTec,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: colorPrimary,
                          ),
                          hintText: "password",
                          border: InputBorder.none,
                          prefixIconColor: Colors.blue,
                        ),
                        obscureText: _passwordVisible,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShowPasswordSectionView(
                          isSelected: _passwordVisible,
                          onChange: (value) {
                            setState(() {
                              _passwordVisible = value;
                            });
                          },
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const ForgotPasswordScreen();
                            }));
                          },
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                                color: colorBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: 13),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    LongButtonView(
                      text: "LOGIN",
                      onTap: () => login(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Do not have an account?",
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
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const RegisterScreen();
                                }));
                              },
                              child: const Text(
                                "Create new account",
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
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
