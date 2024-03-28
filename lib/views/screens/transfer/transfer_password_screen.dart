import 'package:flutter/material.dart';
import 'package:nathan_app/bloc/transfer/transfer_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/register_screen.dart';
import 'package:nathan_app/views/screens/transfer/success_transfer_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';

class TransferPasswordScreen extends StatefulWidget {
  final String phone;
  final String amount;
  final String note;

  const TransferPasswordScreen({
    super.key,
    required this.phone,
    required this.amount,
    required this.note,
  });

  @override
  State<TransferPasswordScreen> createState() => _TransferPasswordScreenState();
}

class _TransferPasswordScreenState extends State<TransferPasswordScreen> {
  //Text Controllers
  var password_tec = TextEditingController();
  bool _passwordVisible = true;

  bool isLoading = false;

  final _transfer_bloc = TransferBloc();
  late Stream<ResponseOb> _transfer_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _transfer_stream = _transfer_bloc.transferStream();
    _transfer_stream.listen((ResponseOb resp) {
      if (resp.success == false) {
        //Presign Error
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SuccessTransferScreen(
            amount: resp.data.data.amount,
            currency: resp.data.data.currency,
            receiver_name: resp.data.data.receiverName,
            receiver_phone: resp.data.data.receiverPhone,
            note: resp.data.data.note,
            transfer_id: resp.data.data.id,
          );
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
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
              title: const Text(
                "Confirm",
                style: TextStyle(
                  fontSize: 18,
                  color: colorPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Icon(
                Icons.lock_outline,
                size: 50,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Enter Password",
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please enter your password to proceed",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Password",
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: password_tec,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "password",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        obscureText: _passwordVisible,
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.blue,
                          value: !_passwordVisible,
                          onChanged: (value) {
                            setState(() {
                              _passwordVisible = !value!;
                            });
                          },
                        ),
                        const Text(
                          "Show Password",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LongButtonView(
                  text: 'Transfer',
                  onTap: () {
                    Map<String, dynamic> map = {
                      'phone': widget.phone,
                      'amount': widget.amount,
                      'password': password_tec.text,
                      'note': widget.note,
                    };
                    _transfer_bloc.transfer(map);
                    setState(() {
                      isLoading = true;
                    });
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: MaterialButton(
              //     color: Colors.blue,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(45),
              //     ),
              //     height: 45,
              //     elevation: 0,
              //     onPressed: () {
              //       Map<String, dynamic> map = {
              //         'phone': widget.phone,
              //         'amount': widget.amount,
              //         'password': password_tec.text,
              //         'note': widget.note,
              //       };
              //       _transfer_bloc.transfer(map);
              //       setState(() {
              //         isLoading = true;
              //       });
              //     },
              //     child: const SizedBox(
              //       height: 30,
              //       child: Center(
              //         child: Text(
              //           'Transfer',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const RegisterScreen();
                  }));
                },
                child: Text(
                  "Forgot Pin ?",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
