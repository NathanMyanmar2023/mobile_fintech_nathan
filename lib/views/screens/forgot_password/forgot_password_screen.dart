import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:fnge/extensions/navigation_extensions.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/resources/constants.dart';
import '../../../helpers/response_ob.dart';
import '../../../widgets/long_button_view.dart';
import '../../custom/snack_bar.dart';
import '../../widgets/error_alert_widget.dart';
import 'forgot_pass_verify_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var emailTec = TextEditingController();
  bool isLoading = false;

  final _forgotPassBloc = ForgotPasswordBloc();
  late Stream<ResponseOb> _forgotPassStream;

  @override
  void initState() {
    super.initState();
    _forgotPassStream = _forgotPassBloc.forgotPassStream();
    _forgotPassStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          isLoading = false;
        });
        if (resp.data.success == true) {
          context.showSnack(
            resp.data.message,
            Colors.white,
            Colors.green,
            Icons.check,
          );
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ForgotPassVerifyScreen(
              email: emailTec.text.trim(),
            );
          }));
        } else {
          context.showSnack(
            resp.data.message,
            Colors.white,
            Colors.red,
            Icons.close,
          );
        }
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Fail to send Email !'),
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

  void sendMail() {
    String email = emailTec.text.toString();

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

    Map<String, dynamic> map = {
      'email': email,
    };
    _forgotPassBloc.forgotPass(map);
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
                  "Forgot Password",
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: Image.asset(lockLogo),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: colorPrimary,
                            ),
                          ),
                          Text(
                            "You can reset your password here.",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: colorBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
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
                      height: 30,
                    ),
                    LongButtonView(
                      text: "Send",
                      onTap: () => sendMail(),
                    ),
                  ],
                )),
          ),
        ),
      );
    }
  }
}
