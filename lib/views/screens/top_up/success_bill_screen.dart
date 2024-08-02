import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/screens/main_screen.dart';

class SuccessBillScreen extends StatefulWidget {
  final bool isGift;
  const SuccessBillScreen({this.isGift = false, super.key});

  @override
  State<SuccessBillScreen> createState() => _SuccessBillScreenState();
}

class _SuccessBillScreenState extends State<SuccessBillScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: Container(
                        child: Image.asset('images/register_success.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Successful ${widget.isGift ? "Gift Card Package." : "Phone Bill."}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        textAlign: TextAlign.center,
                        "You have ${widget.isGift ? "package" : "bill"} successfully. Please wait for response",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  color: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  height: 45,
                  elevation: 0,
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const MainScreen();
                    }), (route) => false);
                  },
                  child: const SizedBox(
                    height: 30,
                    child: Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
