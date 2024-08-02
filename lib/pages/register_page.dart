//
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fnge/bloc/check_phone_bloc.dart';
// import 'package:fnge/bloc/check_refer_bloc.dart';
// import 'package:fnge/bloc/check_username_bloc.dart';
// import 'package:fnge/bloc/countries_bloc.dart';
// import 'package:fnge/bloc/register_bloc.dart';
// import 'package:fnge/helpers/response_ob.dart';
// import 'package:fnge/views/screens/eula.dart';
// import 'package:fnge/views/screens/phone_verify_screen.dart';
// import 'package:fnge/views/screens/t_and_c_screen.dart';
// import 'package:fnge/views/screens/welcome_screen.dart';
// import 'package:fnge/views/widgets/error_alert_widget.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   static String id = 'register_screen';
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   int _currentStep = 0;
//   final int _stepCount = 5;
//   bool _passwordVisible = true;
//   bool _isDtr = false;
//   String _country = "119";
//   String? city;
//   String _phoneCode = '+95';
//
//   bool isLoading = false;
//
//   //CountryList
//   List countryList = [];
//   String deviceIp = "";
//
//   //End CountryList
//
// //Text Controllers
//   var referralTec = TextEditingController();
//   var phoneTec = TextEditingController();
//
//   var usernameTec = TextEditingController();
//   var nameTec = TextEditingController();
//
//   var passwordTec = TextEditingController();
//   var confirmPasswordTec = TextEditingController();
//
//   var emailTec = TextEditingController();
//
//   var countryTec = TextEditingController();
//   var addressTec = TextEditingController();
//   var regionTec = TextEditingController();
//   var cityTec = TextEditingController();
//   var postalCodeTec = TextEditingController();
//
// //End Text Controllers
//
// //Collect Data
//   int _parentId = 1;
//   int _countryId = 119;
//
//   late String _phoneNumber;
//
//   late String _username;
//   late String _name;
//
//   late String _password;
//   late String _passwordConfirmation;
//
//   int _gender = 1;
//
//   String _countryName = "Myanmar";
//   late String _region;
//   late String _city;
//   late String _address;
//   late String _postalCode;
//
//   late String _referCode;
//
// //End Collect Data
//
// //BLOC
//   final _countriesBloc = CountriesBloc();
//   late Stream<ResponseOb> _countriesStream;
//
//   final _checkReferBloc = CheckReferBloc();
//   late Stream<ResponseOb> _checkReferStream;
//
//   final _checkPhoneBloc = CheckPhoneBloc();
//   late Stream<ResponseOb> _checkPhoneStream;
//
//   final _checkUsernameBloc = CheckUsernameBloc();
//   late Stream<ResponseOb> _checkUsernameStream;
//
//   final _registerBloc = RegisterBloc();
//   late Stream<ResponseOb> _registerStream;
//
// //BLOC end
//
// //Check password
//   bool isPasswordValid(String password) {
//     // Check if password is at least 8 characters long and contains at least one number
//     RegExp regExp = RegExp(r'^(?=.*?[0-9]).{8,}$');
//     return regExp.hasMatch(password);
//   }
//
// //Check password end
//
// //Check phone
//   //check phone number
//   bool isPhoneValid(String phone) {
//     RegExp regExp = RegExp(r'^[0-9]{6,15}$');
//     return regExp.hasMatch(phone);
//   }
//
// //Check phone end
//
//   @override
//   void initState() {
//     super.initState();
// //Get Countries
//     _countriesBloc.getCountries();
//
//     _countriesStream = _countriesBloc.countriesStream();
//     _countriesStream.listen((ResponseOb resp) {
//       if (resp.success) {
//         for (var newCountry in resp.data.data) {
//           countryList.add([newCountry.id, newCountry.countryName.toString()]);
//         }
//       } else {
//         print("error");
//       }
//     });
//
// //End Get Countries
//
// //Check Referral
//     _checkReferStream = _checkReferBloc.checkReferStream();
//     _checkReferStream.listen((ResponseOb resp) {
//       if (resp.success) {
//         _parentId = resp.data.data.parentId;
//         _countryId = resp.data.data.countryId;
//         _country = _countryId.toString();
//         _countryName = resp.data.data.countryName;
//         _referCode = referralTec.text.toString();
//         setState(() {
//           _currentStep = 1;
//           countryTec.text = _countryName.toString();
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         showDialog(
//           context: context,
//           builder: (context) {
//             return ErrorAlert(
//               "Oops !",
//               Image.asset('images/welcome.png'),
//               resp.message.toString(),
//             );
//           },
//         );
//         return;
//       }
//     });
// //End Check Referral
//
// //Check Phone
//     _checkPhoneStream = _checkPhoneBloc.checkPhoneStream();
//     _checkPhoneStream.listen((ResponseOb resp) {
//       if (resp.success) {
//         _phoneNumber = resp.data.data.phone;
//         setState(() {
//           _currentStep = 2;
//           isLoading = false;
//         });
//       } else {
//         showDialog(
//             context: context,
//             builder: (context) {
//               return ErrorAlert(
//                 "Oops !",
//                 Image.asset('images/welcome.png'),
//                 resp.message.toString(),
//               );
//             });
//         setState(() {
//           isLoading = false;
//         });
//         return;
//       }
//     });
// //End Check Phone
//
// //Check Username
//     _checkUsernameStream = _checkUsernameBloc.checkUsernameStream();
//     _checkUsernameStream.listen((ResponseOb resp) {
//       if (resp.success) {
//         _username = resp.data.data.username;
//         _name = nameTec.text.toString();
//         setState(() {
//           _currentStep = 3;
//           isLoading = false;
//         });
//       } else {
//         showDialog(
//             context: context,
//             builder: (context) {
//               return ErrorAlert(
//                 "Oops !",
//                 Image.asset('images/welcome.png'),
//                 resp.message.toString(),
//               );
//             });
//         setState(() {
//           isLoading = false;
//         });
//         return;
//       }
//     });
// //End Check Username
//
// //Register
//     _registerStream = _registerBloc.registerStream();
//     _registerStream.listen((ResponseOb resp) {
//       if (resp.success) {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (BuildContext context) {
//               return PhoneVerifyScreen(
//                 phone_number: _phoneCode +
//                     (phoneTec.text.startsWith('0')
//                         ? phoneTec.text.substring(1)
//                         : phoneTec.text),
//               );
//             }), (route) => false);
//       } else {
//         showDialog(
//             context: context,
//             builder: (context) {
//               return ErrorAlert(
//                 "Fail to create account !",
//                 Image.asset('images/welcome.png'),
//                 resp.message.toString(),
//               );
//             });
//         setState(() {
//           isLoading = false;
//         });
//         return;
//       }
//     });
// //End Register
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return MediaQuery(
//         data: MediaQuery.of(context)
//             .copyWith(textScaler: const TextScaler.linear(1.0)),
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: SpinKitFadingFour(
//             itemBuilder: (BuildContext context, int index) {
//               return DecoratedBox(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: index.isEven ? Colors.blue : Colors.grey.shade800,
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//     } else {
//       return MediaQuery(
//         data: MediaQuery.of(context)
//             .copyWith(textScaler: const TextScaler.linear(1.0)),
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: Container(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Theme(
//                     data: ThemeData(
//                       shadowColor: Colors.transparent,
//                       canvasColor: Colors.white,
//                       colorScheme: Theme.of(context).colorScheme.copyWith(
//                         primary: Colors.blue,
//                         background: Colors.red,
//                         secondary: Colors.blue,
//                       ),
//                     ),
//                     child: SafeArea(
//                       child: Stepper(
//                         currentStep: _currentStep,
//                         type: StepperType.horizontal,
//                         physics: const ScrollPhysics(),
//                         onStepContinue: () {
//                           final isLastStep = _currentStep == _stepCount;
//                           final isReferCodeStep = _currentStep == 0;
//                           final isPhoneStep = _currentStep == 1;
//                           final isNameStep = _currentStep == 2;
//                           final isPasswordStep = _currentStep == 3;
//                           if (isReferCodeStep) {
//                             //TODO : Check referral code
//                             if (_isDtr) {
//                               String referCode = referralTec.text.toString();
//                               _checkReferBloc.checkRefer(referCode);
//                               setState(() {
//                                 isLoading = true;
//                               });
//                             } else {
//                               setState(() {
//                                 _currentStep = 1;
//                               });
//                             }
//                             //End
//                           } else if (isPhoneStep) {
//                             String phone = phoneTec.text.toString();
//                             if (!isPhoneValid(phone)) {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return ErrorAlert(
//                                       "Error",
//                                       Image.asset('images/welcome.png'),
//                                       "Phone number is invalid",
//                                     );
//                                   });
//                               setState(() {
//                                 isLoading = false;
//                               });
//                               return;
//                             }
//                             if (phone.startsWith('0')) {
//                               phone = phone.substring(1);
//                             }
//                             Map<String, String> map = {
//                               'phone': _phoneCode + phone,
//                             };
//                             _checkPhoneBloc.checkPhone(map);
//                             setState(() {
//                               isLoading = true;
//                             });
//                             //End
//                           } else if (isNameStep) {
//                             //TODO: Check username
//                             String nameInput = nameTec.text.toString();
//                             String usernameInput = usernameTec.text.toString();
//
//                             if (nameInput.length < 3) {
//                               print("Name count");
//                             } else if (usernameInput.length < 3) {
//                               print("user name count");
//                             } else {
//                               Map<String, String> map = {
//                                 'username': usernameInput,
//                               };
//                               _checkUsernameBloc.checkUsername(map);
//                               setState(() {
//                                 isLoading = true;
//                               });
//                             }
//                             //End
//                           } else if (isPasswordStep) {
//                             String passwordInput = passwordTec.text.toString();
//                             String passwordConfirmInput =
//                             confirmPasswordTec.text.toString();
//
//                             if (passwordInput != passwordConfirmInput) {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return ErrorAlert(
//                                         "Oops !",
//                                         Image.asset('images/welcome.png'),
//                                         "Password does not metch");
//                                   });
//                               setState(() {
//                                 isLoading = false;
//                               });
//                               return;
//                             } else {
//                               if (!isPasswordValid(passwordInput)) {
//                                 showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return ErrorAlert(
//                                         "Oops !",
//                                         Image.asset('images/welcome.png'),
//                                         "Password need to be at least 8 character and at least one number",
//                                       );
//                                     });
//                                 setState(() {
//                                   isLoading = false;
//                                 });
//                                 return;
//                               } else {
//                                 _password = passwordInput;
//                                 _passwordConfirmation = passwordConfirmInput;
//                                 setState(() {
//                                   _currentStep += 1;
//                                 });
//                               }
//                             }
//                           } else if (isLastStep) {
//                             //
//                           } else {
//                             setState(() {
//                               _currentStep += 1;
//                             });
//                           }
//                         },
//                         onStepCancel: () {
//                           if (_currentStep == 0) {
//                             print("Go back to welcome screen");
//                           } else {
//                             setState(() {
//                               _currentStep -= 1;
//                             });
//                           }
//                         },
//                         controlsBuilder: (context, details) {
//                           return Container(
//                             margin: const EdgeInsets.only(top: 30),
//                             child: Row(
//                               children: [
//                                 if (_currentStep == 0)
//                                   Expanded(
//                                     child: MaterialButton(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                       ),
//                                       color: Colors.grey.shade200,
//                                       onPressed: () {
//                                         Navigator.pushNamed(
//                                             context, WelcomeScreen.id);
//                                       },
//                                       child: const SizedBox(
//                                         height: 20,
//                                         child: Center(
//                                           child: Text(
//                                             'CANCEL',
//                                             style: TextStyle(
//                                               color: Colors.black87,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 if (_currentStep > 0)
//                                   Expanded(
//                                     child: MaterialButton(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                       ),
//                                       color: Colors.grey.shade200,
//                                       onPressed: details.onStepCancel,
//                                       child: const SizedBox(
//                                         height: 20,
//                                         child: Center(
//                                           child: Text(
//                                             'BACK',
//                                             style: TextStyle(
//                                               color: Colors.black87,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 if (_currentStep == _stepCount)
//                                   Expanded(
//                                     child: MaterialButton(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                       ),
//                                       color: Colors.blue,
//                                       onPressed: () {
//                                         _region = regionTec.text.toString();
//                                         _city = cityTec.text.toString();
//                                         _address = addressTec.text.toString();
//                                         _postalCode =
//                                             postalCodeTec.text.toString();
//
//                                         if (_region.length < 3 ||
//                                             _city.length < 3 ||
//                                             _address.length < 3 ||
//                                             _postalCode.length < 4) {
//                                           showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return ErrorAlert(
//                                                   "Oops !",
//                                                   Image.asset(
//                                                       'images/welcome.png'),
//                                                   "Please fill all data correctly !",
//                                                 );
//                                               });
//                                           setState(() {
//                                             isLoading = false;
//                                           });
//                                         } else {
//                                           //Register
//                                           Map<String, dynamic> map = {
//                                             'name': _name,
//                                             'username': _username,
//                                             'email': "mail@gmail.com",
//                                             'password': _password,
//                                             'password_confirmation':
//                                             _passwordConfirmation,
//                                             'phone': _phoneNumber,
//                                             'country_id': _countryId,
//                                             'region': _region,
//                                             'city': _city,
//                                             'address_line': _address,
//                                             'postal_code': _postalCode,
//                                             'gender': _gender,
//                                             if (_isDtr) 'refer_code': _referCode
//                                           };
//                                           _registerBloc.register(map);
//                                         }
//                                       },
//                                       child: const SizedBox(
//                                         height: 20,
//                                         child: Center(
//                                             child: Text(
//                                               'REGISTER',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                               ),
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                                 if (_currentStep < _stepCount)
//                                   Expanded(
//                                     child: MaterialButton(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                       ),
//                                       color: Colors.blue,
//                                       onPressed: details.onStepContinue,
//                                       child: const SizedBox(
//                                         height: 20,
//                                         child: Center(
//                                             child: Text(
//                                               'NEXT',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                               ),
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           );
//                         },
//                         steps: [
//                           StepOne(),
//                           StepTwo(),
//                           StepThree(),
//                           StepFour(),
//                           StepFive(),
//                           StepSix()
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//   }
//
// //STEP ONE #################################
//
//   Step StepOne() {
//     return Step(
//       state: _currentStep > 0 ? StepState.complete : StepState.indexed,
//       isActive: _currentStep >= 0,
//       title: const Text(""),
//       content: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Choose account Type",
//                 style: TextStyle(
//                   letterSpacing: 1,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text(
//                 "What type of account you want to create, customer or distributor",
//                 style: TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: AspectRatio(
//                       aspectRatio: 1 / 1,
//                       child: MaterialButton(
//                         onPressed: () {
//                           if (_isDtr) {
//                             setState(() {
//                               _isDtr = false;
//                             });
//                           }
//                         },
//                         color:
//                         !_isDtr ? Colors.grey.shade200 : Colors.transparent,
//                         child: Image.asset(
//                           'images/customer.png',
//                           width: 100,
//                           height: 100,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: AspectRatio(
//                       aspectRatio: 1 / 1,
//                       child: MaterialButton(
//                         onPressed: () {
//                           if (!_isDtr) {
//                             setState(() {
//                               _isDtr = true;
//                             });
//                           }
//                         },
//                         color:
//                         _isDtr ? Colors.grey.shade200 : Colors.transparent,
//                         child: Image.asset(
//                           'images/distributor.png',
//                           width: 100,
//                           height: 100,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     "Customer",
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: !_isDtr ? FontWeight.bold : FontWeight.normal,
//                     ),
//                   ),
//                   Text(
//                     "Distributor",
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: _isDtr ? FontWeight.bold : FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           Visibility(
//             visible: _isDtr,
//             child: Column(
//               children: [
//                 const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "To create a distributor account, you are required to provide a referral code that you have obtained from another distributor.",
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 30),
//                 const SizedBox(
//                   width: double.infinity,
//                   child: Text(
//                     "Referral Code",
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Container(
//                   height: 45,
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade200,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: TextField(
//                     controller: referralTec,
//                     decoration: const InputDecoration(
//                       prefixIcon: Icon(Icons.person_outline),
//                       hintText: "NT-000000",
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     obscureText: false,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// //STEP TWO #################################
//
//   Step StepTwo() {
//     return Step(
//       state: _currentStep > 1 ? StepState.complete : StepState.indexed,
//       isActive: _currentStep >= 1,
//       title: const Text(""),
//       content: Column(
//         children: [
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Phone Number",
//                 style: TextStyle(
//                   letterSpacing: 1,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Please provide your phone number below. This will be used as a unique identifier for your account. Ensure that you include the correct country code. ",
//                 style: TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "Phone",
//             ),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Row(
//               children: [
//                 CountryCodePicker(
//                   initialSelection: 'MM',
//                   onChanged: (value) {
//                     print(value.dialCode);
//                     setState(() {
//                       _phoneCode = value.dialCode.toString();
//                     });
//                   },
//                 ),
//                 Flexible(
//                   child: TextField(
//                     keyboardType: TextInputType.phone,
//                     controller: phoneTec,
//                     decoration: const InputDecoration(
//                       // prefixIcon: const Icon(Icons.phone_outlined),
//                       hintText: "000 000 00",
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.symmetric(vertical: 14),
//                       prefixIconColor: Colors.blue,
//                     ),
//                     obscureText: false,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// //STEP THREE #################################
//
//   Step StepThree() {
//     return Step(
//       state: _currentStep > 2 ? StepState.complete : StepState.indexed,
//       isActive: _currentStep >= 2,
//       title: const Text(""),
//       content: Column(
//         children: [
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "What is your name?",
//                 style: TextStyle(
//                   letterSpacing: 1,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Please provide your real name and application username to continue registration.",
//                 style: TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "Name",
//             ),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: TextField(
//               controller: nameTec,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.person_outline),
//                 hintText: "Real Name",
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(vertical: 14),
//               ),
//               obscureText: false,
//             ),
//           ),
//           const SizedBox(height: 20),
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "Username",
//             ),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: TextField(
//               controller: usernameTec,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.person_outline),
//                 hintText: "Username",
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(vertical: 14),
//               ),
//               obscureText: false,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// //STEP FOUR #################################
//
//   Step StepFour() {
//     return Step(
//       state: _currentStep > 3 ? StepState.complete : StepState.indexed,
//       isActive: _currentStep >= 3,
//       title: const Text(""),
//       content: Column(
//         children: [
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Create a password",
//                 style: TextStyle(
//                   letterSpacing: 1,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Create a strong password with at least eaight character with numbers",
//                 style: TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "Password",
//             ),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: TextField(
//               controller: passwordTec,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.person_outline),
//                 hintText: "password",
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(vertical: 14),
//               ),
//               obscureText: _passwordVisible,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "Confirm Password",
//             ),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: TextField(
//               controller: confirmPasswordTec,
//               decoration: const InputDecoration(
//                   prefixIcon: Icon(Icons.email_outlined),
//                   hintText: "confirm password",
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(vertical: 14)),
//               obscureText: _passwordVisible,
//             ),
//           ),
//           Row(
//             children: [
//               Checkbox(
//                 activeColor: Colors.blue,
//                 value: !_passwordVisible,
//                 onChanged: (value) {
//                   setState(() {
//                     _passwordVisible = !value!;
//                   });
//                 },
//               ),
//               const Text(
//                 "Show Password",
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
// // //STEP FOUR #################################
//
// //   Step StepFour() {
// //     return Step(
// //       state: _currentstep > 3 ? StepState.complete : StepState.indexed,
// //       isActive: _currentstep >= 3,
// //       title: Text(""),
// //       content: Column(
// //         children: [
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 "Choose account Type",
// //                 style: TextStyle(
// //                   letterSpacing: 1,
// //                   fontSize: 25,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               Text(
// //                 "What type of account you want to create, customer or distributor",
// //                 style: TextStyle(
// //                   fontSize: 15,
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 30,
// //               ),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: AspectRatio(
// //                       aspectRatio: 1 / 1,
// //                       child: NeumorphicButton(
// //                         onPressed: () {
// //                           if (_is_dtr) {
// //                             setState(() {
// //                               _is_dtr = false;
// //                             });
// //                           }
// //                         },
// //                         style: NeumorphicStyle(
// //                           shape: NeumorphicShape.flat,
// //                           boxShape: NeumorphicBoxShape.roundRect(
// //                               BorderRadius.circular(10)),
// //                           depth: 0,
// //                           lightSource: LightSource.top,
// //                           color: Colors.grey.shade100,
// //                           border: NeumorphicBorder(
// //                             color: !_is_dtr ? Colors.blue : Colors.transparent,
// //                             width: 3,
// //                           ),
// //                         ),
// //                         child: Image.asset(
// //                           'images/customer.png',
// //                           width: 100,
// //                           height: 100,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 20,
// //                   ),
// //                   Expanded(
// //                     child: AspectRatio(
// //                       aspectRatio: 1 / 1,
// //                       child: NeumorphicButton(
// //                         onPressed: () {
// //                           if (!_is_dtr) {
// //                             setState(() {
// //                               _is_dtr = true;
// //                             });
// //                           }
// //                         },
// //                         style: NeumorphicStyle(
// //                           shape: NeumorphicShape.flat,
// //                           boxShape: NeumorphicBoxShape.roundRect(
// //                               BorderRadius.circular(10)),
// //                           depth: 0,
// //                           lightSource: LightSource.top,
// //                           color: Colors.grey.shade100,
// //                           border: NeumorphicBorder(
// //                             color: _is_dtr ? Colors.blue : Colors.transparent,
// //                             width: 3,
// //                           ),
// //                         ),
// //                         child: Image.asset(
// //                           'images/distributor.png',
// //                           width: 100,
// //                           height: 100,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(
// //                 height: 15,
// //               ),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: [
// //                   Text(
// //                     "Customer",
// //                     style: TextStyle(
// //                       fontSize: 17,
// //                       fontWeight:
// //                           !_is_dtr ? FontWeight.bold : FontWeight.normal,
// //                     ),
// //                   ),
// //                   Text(
// //                     "Distributor",
// //                     style: TextStyle(
// //                       fontSize: 17,
// //                       fontWeight: _is_dtr ? FontWeight.bold : FontWeight.normal,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
//
// //STEP FIVE #################################
//
//   Step StepFive() {
//     return Step(
//       state: _currentStep > 4 ? StepState.complete : StepState.indexed,
//       isActive: _currentStep >= 4,
//       title: const Text(""),
//       content: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Select gender",
//                 style: TextStyle(
//                   letterSpacing: 1,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text(
//                 "can you please provide your gender to get better experience with custommer services.",
//                 style: TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: AspectRatio(
//                       aspectRatio: 1 / 1,
//                       child: MaterialButton(
//                         onPressed: () {
//                           if (_gender != 1) {
//                             setState(() {
//                               _gender = 1;
//                             });
//                           }
//                         },
//                         color: _gender == 1
//                             ? Colors.grey.shade200
//                             : Colors.transparent,
//                         child: Image.asset(
//                           'images/boy.png',
//                           width: 100,
//                           height: 100,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: AspectRatio(
//                       aspectRatio: 1 / 1,
//                       child: MaterialButton(
//                         onPressed: () {
//                           if (_gender != 0) {
//                             setState(() {
//                               _gender = 0;
//                             });
//                           }
//                         },
//                         color: _gender == 0
//                             ? Colors.grey.shade200
//                             : Colors.transparent,
//                         child: Image.asset(
//                           'images/girl.png',
//                           width: 100,
//                           height: 100,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     "Male",
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight:
//                       _gender == 1 ? FontWeight.bold : FontWeight.normal,
//                     ),
//                   ),
//                   Text(
//                     "Female",
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight:
//                       _gender == 0 ? FontWeight.bold : FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
// //STEP SIX #################################
//
//   Step StepSix() {
//     return Step(
//       state: _currentStep > 5 ? StepState.complete : StepState.indexed,
//       isActive: _currentStep >= 5,
//       title: const Text(""),
//       content: Column(
//         children: [
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Contact Informations",
//                 style: TextStyle(
//                   letterSpacing: 1,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "You need to provide detail informations to contact you",
//                 style: TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "Country",
//             ),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: DropdownButtonHideUnderline(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: DropdownButton(
//                   value: _country,
//                   hint: const Text("Select Country"),
//                   isExpanded: true,
//                   items: countryList
//                       .map((country) => DropdownMenuItem(
//                       value: country[0].toString(),
//                       child: Text(country[1].toString())))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _country = value!;
//                       _countryId = int.parse(value);
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "Region",
//             ),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: TextField(
//               controller: regionTec,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.pin_drop_outlined),
//                 hintText: "Region",
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(vertical: 14),
//               ),
//               obscureText: false,
//             ),
//           ),
//           const SizedBox(height: 20),
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "City",
//             ),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: TextField(
//               controller: cityTec,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.account_balance_outlined),
//                 hintText: "City",
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(vertical: 14),
//               ),
//               obscureText: false,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "Address",
//             ),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: TextField(
//               controller: addressTec,
//               decoration: const InputDecoration(
//                   prefixIcon: Icon(Icons.location_city_outlined),
//                   hintText: "Address line ...",
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(vertical: 14)),
//               obscureText: false,
//             ),
//           ),
//           const SizedBox(height: 20),
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "Postal Code",
//             ),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: TextField(
//               controller: postalCodeTec,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.email_outlined),
//                 hintText: "000000",
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(vertical: 14),
//               ),
//               obscureText: false,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "By signing up, you confirm that you agree to our",
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//               const SizedBox(
//                 height: 3,
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return const EULA();
//                       }));
//                     },
//                     child: Text(
//                       "EULA",
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 6,
//                   ),
//                   Text(
//                     "and",
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 6,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return const TAndCScreen();
//                       }));
//                     },
//                     child: Text(
//                       "Terms and Conditions",
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
