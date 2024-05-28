import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/check_mail_bloc.dart';
import 'package:nathan_app/bloc/check_phone_bloc.dart';
import 'package:nathan_app/bloc/check_refer_bloc.dart';
import 'package:nathan_app/bloc/check_username_bloc.dart';
import 'package:nathan_app/bloc/countries_bloc.dart';
import 'package:nathan_app/bloc/register_bloc.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/resources/constants.dart';
import 'package:nathan_app/views/screens/phone_verify_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/auth_title_and_description_section_view.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:nathan_app/widgets/show_password_section_view.dart';
import 'package:nathan_app/widgets/text_field_with_label_view.dart';

import '../../helpers/shared_pref.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<RegisterState> registerStateList = [
    RegisterState.accountType,
    RegisterState.phoneNumber,
    RegisterState.email,
    RegisterState.chooseUserName,
    RegisterState.createPassword,
    RegisterState.selectGender,
    RegisterState.contactInfo,
  ];
  RegisterState currentState = RegisterState.accountType;

  bool _passwordVisible = true;
  bool _isDtr = false;
  String _country = "119";
  String? city;
  String _phoneCode = '+95';

  bool isLoading = false;

  //CountryList
  List countryList = [];
  String deviceIp = "";

  //End CountryList

//Text Controllers
  var referralTec = TextEditingController();
  var phoneTec = TextEditingController();

  var usernameTec = TextEditingController();
  var nameTec = TextEditingController();

  var passwordTec = TextEditingController();
  var confirmPasswordTec = TextEditingController();

  var emailTec = TextEditingController();
  var emailVerifyTec = TextEditingController();

  var countryTec = TextEditingController();
  var addressTec = TextEditingController();
  var regionTec = TextEditingController();
  var cityTec = TextEditingController();
  var postalCodeTec = TextEditingController();

//End Text Controllers

//Collect Data
  int _parentId = 1;
  int _countryId = 119;

  late String _phoneNumber;
  late String _email;
  late String _username;
  late String _name;

  late String _password;
  late String _passwordConfirmation;

  int _gender = 1;

  String _countryName = "Myanmar";
  late String _region;
  late String _city;
  late String _address;
  late String _postalCode;

  late String _referCode;

//End Collect Data

//BLOC
  final _countriesBloc = CountriesBloc();
  late Stream<ResponseOb> _countriesStream;

  final _checkReferBloc = CheckReferBloc();
  late Stream<ResponseOb> _checkReferStream;

  final _checkPhoneBloc = CheckPhoneBloc();
  late Stream<ResponseOb> _checkPhoneStream;

  final _checkEmailBloc = CheckEmailBloc();
  late Stream<ResponseOb> _checkEmailStream;

  final _checkUsernameBloc = CheckUsernameBloc();
  late Stream<ResponseOb> _checkUsernameStream;

  final _registerBloc = RegisterBloc();
  late Stream<ResponseOb> _registerStream;

//BLOC end

//Check password
  bool isPasswordValid(String password) {
    // Check if password is at least 8 characters long and contains at least one number
    RegExp regExp = RegExp(r'^(?=.*?[0-9]).{8,}$');
    return regExp.hasMatch(password);
  }

//Check password end

//Check phone
  //check phone number
  bool isPhoneValid(String phone) {
    RegExp regExp = RegExp(r'^[0-9]{6,15}$');
    return regExp.hasMatch(phone);
  }

//Check phone end

  //Check password end

//Check email
  //check email number
  bool isEmailValid(String email) {
    RegExp regExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regExp.hasMatch(email);
  }

//Check email end

  @override
  void initState() {
    super.initState();
//Get Countries
    _countriesBloc.getCountries();

    _countriesStream = _countriesBloc.countriesStream();
    _countriesStream.listen((ResponseOb resp) {
      if (resp.success) {
        for (var newCountry in resp.data.data) {
          countryList.add([newCountry.id, newCountry.countryName.toString()]);
        }
      } else {
        print("error");
      }
    });

//End Get Countries

//Check Referral
    _checkReferStream = _checkReferBloc.checkReferStream();
    _checkReferStream.listen((ResponseOb resp) {
      if (resp.success) {
        _parentId = resp.data.data.parentId;
        _countryId = resp.data.data.countryId;
        _country = _countryId.toString();
        _countryName = resp.data.data.countryName;
        _referCode = referralTec.text.toString();
        setState(() {
          currentState = RegisterState.phoneNumber;
          countryTec.text = _countryName.toString();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
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
        return;
      }
    });
//End Check Referral

//Check Phone
    _checkPhoneStream = _checkPhoneBloc.checkPhoneStream();
    _checkPhoneStream.listen((ResponseOb resp) {
      if (resp.success) {
        _phoneNumber = resp.data.data.phone;
        setState(() {
          currentState = RegisterState.email;
          isLoading = false;
        });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorAlert(
                "Oops !",
                Image.asset('images/welcome.png'),
                resp.message.toString(),
              );
            });
        setState(() {
          isLoading = false;
        });
        return;
      }
    });
//End Check Phone

//Check Email
    _checkEmailStream = _checkEmailBloc.checkEmailStream();
    _checkEmailStream.listen((ResponseOb resp) {
      if (resp.success) {
        _email = resp.data.data.email;
        setState(() {
          currentState = RegisterState.chooseUserName;
          isLoading = false;
        });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorAlert(
                "Oops !",
                Image.asset('images/welcome.png'),
                resp.message.toString(),
              );
            });
        setState(() {
          isLoading = false;
        });
        return;
      }
    });
//End Check Phone

//Check Username
    _checkUsernameStream = _checkUsernameBloc.checkUsernameStream();
    _checkUsernameStream.listen((ResponseOb resp) {
      if (resp.success) {
        _username = resp.data.data.username;
        _name = nameTec.text.toString();
        setState(() {
          currentState = RegisterState.createPassword;
          isLoading = false;
        });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorAlert(
                "Oops !",
                Image.asset('images/welcome.png'),
                resp.message.toString(),
              );
            });
        setState(() {
          isLoading = false;
        });
        return;
      }
    });
//End Check Username

//Register
    _registerStream = _registerBloc.registerStream();
    _registerStream.listen((ResponseOb resp) {
      if (resp.success) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
          return VerifyScreen(
            email: _email,
          );
        }), (route) => false);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorAlert(
                "Fail to create account !",
                Image.asset('images/welcome.png'),
                resp.message.toString(),
              );
            });
        setState(() {
          isLoading = false;
        });
        return;
      }
    });
//End Register
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
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ForwardAndBackwardButtonSectionView(
                    onTapBackward: () => onHandleStep(),
                    onTapForward: () => onHandleStep(isNextStep: true),
                  ),
                  AuthTitleAndDescriptionSectionView(
                    title: getRegisterInstructionTitle(
                      currentState: currentState,
                    ),
                    titleColor: colorPrimary,
                    descriptionColor: colorPrimary,
                    description: getRegisterInstructionDescription(
                      currentState: currentState,
                    ),
                    margin: EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: MediaQuery.of(context).size.height * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: currentState == RegisterState.accountType
                        ? ChooseAccountTypeSectionView(
                            onChange: (value) {
                              setState(() {
                                _isDtr = value == 2;
                              });
                            },
                            selectedAccountType: _isDtr ? 2 : 1,
                          )
                        : currentState == RegisterState.phoneNumber
                            ? PhoneNumberSectionView(
                                phoneController: phoneTec,
                              )
                            : currentState == RegisterState.email
                                ? EmailSectionView(
                                    emailController: emailTec,
                                  )
                                : currentState == RegisterState.chooseUserName
                                    ? ChooseUserNameSectionView(
                                        nameController: nameTec,
                                        usernameController: usernameTec,
                                      )
                                    : currentState ==
                                            RegisterState.createPassword
                                        ? CreatePasswordSectionView(
                                            passwordController: passwordTec,
                                            confirmPasswordController:
                                                confirmPasswordTec,
                                            onChangePassword: (value) {
                                              setState(() {
                                                _passwordVisible = value;
                                              });
                                            },
                                            showPassword: _passwordVisible,
                                          )
                                        : currentState ==
                                                RegisterState.selectGender
                                            ? SelectGenderSectionView(
                                                onChange: (value) {
                                                  setState(() {
                                                    _gender = value;
                                                  });
                                                },
                                                selectedGender: _gender,
                                              )
                                            : ContactInformationSectionView(
                                                country: _country,
                                                countryList: countryList,
                                                onChangeCountry: (value) {
                                                  setState(() {
                                                    _country = value;
                                                    _countryId =
                                                        int.parse(value);
                                                  });
                                                },
                                                regionController: regionTec,
                                                cityController: cityTec,
                                                addressController: addressTec,
                                                postalController: postalCodeTec,
                                              ),
                  ),
                  CancelAndNextButtonSectionView(
                    state: currentState,
                    onTapCancel: () => currentState == RegisterState.accountType
                        ? popBack(context: context)
                        : onHandleStep(),
                    onTapNext: () => onTapNext(context),
                  ),
                  currentState == RegisterState.contactInfo
                      ? Column(
                          children: [
                            const Text(
                              "By Signing up, you confirm that you agree to our\nEULA and Terms and Conditions,",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorBlack,
                              ),
                            ),
                            CancelAndNextButtonSectionView(
                              visibility: true,
                              onTapCancel: () => onHandleStep(),
                              onTapNext: () => register(),
                              state: currentState,
                              textColor: colorWhite,
                              backgroundColor: colorPrimary,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 20,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void register() {
    _region = regionTec.text.toString();
    _city = cityTec.text.toString();
    _address = addressTec.text.toString();
    _postalCode = postalCodeTec.text.toString();

    if (_region.length < 3 ||
        _city.length < 3 ||
        _address.length < 3 ||
        _postalCode.length < 4) {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Oops !",
              Image.asset('images/welcome.png'),
              "Please fill all data correctly !",
            );
          });
      setState(() {
        isLoading = false;
      });
    } else {
      //Register

      Map<String, dynamic> map = {
        'name': _name,
        'username': _username,
        'email': _email,
        'password': _password,
        'password_confirmation': _passwordConfirmation,
        'phone': _phoneNumber,
        'country_id': _countryId,
        'region': _region,
        'city': _city,
        'address_line': _address,
        'postal_code': _postalCode,
        'gender': _gender,
        if (_isDtr) 'refer_code': _referCode
      };
      setState(() {
        isLoading = true;
      });
      _registerBloc.register(map);
    }
  }

  /// step forward
  void onHandleStep({bool isNextStep = false}) {
    final int newIndex = isNextStep
        ? currentState == RegisterState.contactInfo
            ? RegisterState.contactInfo.index
            : currentState.index + 1
        : currentState == RegisterState.accountType
            ? RegisterState.accountType.index
            : currentState.index - 1;

    if (newIndex >= 0 && newIndex < registerStateList.length) {
      setState(() {
        currentState = registerStateList[newIndex];
      });
    }
  }

  void onTapNext(BuildContext context) {
    if (currentState != RegisterState.accountType) {
      currentState == RegisterState.phoneNumber
          ? checkPhoneNumber()
          : currentState == RegisterState.email
              ? checkEmail()
              : currentState == RegisterState.chooseUserName
                  ? checkName()
                  : currentState == RegisterState.createPassword
                      ? createPassword()
                      : currentState == RegisterState.selectGender
                          ? selectGender()
                          : onHandleStep(isNextStep: true);
    } else {
      if (_isDtr) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) => ReferralCodeRequestBottomSheetView(
            onTapNext: () {
              checkReferCode();
              popBack(context: context);
            },
            controller: referralTec,
          ),
        );
      } else {
        setState(() {
          currentState = RegisterState.phoneNumber;
        });
      }
    }
  }

  String getRegisterInstructionTitle({required RegisterState currentState}) {
    switch (currentState) {
      case RegisterState.accountType:
        return "Choose Account Type";
      case RegisterState.phoneNumber:
        return "Phone Number";
      case RegisterState.email:
        return "Email";
      case RegisterState.chooseUserName:
        return "What Is Your Name?";
      case RegisterState.createPassword:
        return "Create a Password";
      case RegisterState.selectGender:
        return "Select Gender";
      case RegisterState.contactInfo:
        return "Contact Information";
    }
  }

  String getRegisterInstructionDescription(
      {required RegisterState currentState}) {
    switch (currentState) {
      case RegisterState.accountType:
        return "What type of account you want to create,\ncustomer or distributor";
      case RegisterState.phoneNumber:
        return "Please provide your phone number below. This will be used as a unique identifier for your account. Ensure that you include the correct country code.";
      case RegisterState.email:
        return "Please provide your email below.";
      case RegisterState.chooseUserName:
        return "Please provide your real name and application user name to continue registration.";
      case RegisterState.createPassword:
        return "Creating a strong password with at least eight characters with numbers";
      case RegisterState.selectGender:
        return "Can you please provide your gender to get better experience with customer services.";
      case RegisterState.contactInfo:
        return "You need to provide detail information to contact you";
    }
  }

  void checkReferCode() {
    if (_isDtr) {
      String referCode = referralTec.text.toString();
      _checkReferBloc.checkRefer(referCode);
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        currentState = RegisterState.phoneNumber;
      });
    }
  }

  void checkPhoneNumber() {
    String phone = phoneTec.text.toString();
    print("Phon $phone");
    if (!isPhoneValid(phone)) {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Error",
              Image.asset('images/welcome.png'),
              "Phone number is invalid",
            );
          });
      setState(() {
        isLoading = false;
      });
      return;
    }
    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }
    Map<String, String> map = {
      'phone': _phoneCode + phone,
    };
    _checkPhoneBloc.checkPhone(map);
    setState(() {
      isLoading = true;
    });
  }

  void checkEmail() {
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
    Map<String, String> map = {
      'email': email,
    };
    _checkEmailBloc.checkEmail(map);
    setState(() {
      isLoading = true;
    });
  }

  void checkName() {
    String nameInput = nameTec.text.toString();
    String usernameInput = usernameTec.text.toString();

    if (nameInput.length < 3) {
      print("Name count >>>>>>>> ${nameInput.length}");
    } else if (usernameInput.length < 3) {
      print("user name count >>>>>>>>> ${usernameInput.length}");
    } else {
      Map<String, String> map = {
        'username': usernameInput,
      };
      _checkUsernameBloc.checkUsername(map);
      setState(() {
        isLoading = true;
      });
    }
  }

  void createPassword() {
    String passwordInput = passwordTec.text.toString();
    String passwordConfirmInput = confirmPasswordTec.text.toString();

    if (passwordInput != passwordConfirmInput) {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert("Oops !", Image.asset('images/welcome.png'),
                "Password does not metch");
          });
      setState(() {
        isLoading = false;
      });
      return;
    } else {
      if (!isPasswordValid(passwordInput)) {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorAlert(
                "Oops !",
                Image.asset('images/welcome.png'),
                "Password need to be at least 8 character and at least one number",
              );
            });
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        _password = passwordInput;
        _passwordConfirmation = passwordConfirmInput;
        setState(() {
          currentState = RegisterState.selectGender;
        });
      }
    }
  }

  void selectGender() {
    print(">>>>>>>> $_gender");
    setState(() {
      currentState = RegisterState.contactInfo;
    });
  }
}

class ContactInformationSectionView extends StatelessWidget {
  final String country;
  final List countryList;
  final Function(String) onChangeCountry;
  final TextEditingController regionController;
  final TextEditingController cityController;
  final TextEditingController addressController;
  final TextEditingController postalController;

  const ContactInformationSectionView({
    super.key,
    required this.regionController,
    required this.cityController,
    required this.addressController,
    required this.postalController,
    required this.country,
    required this.countryList,
    required this.onChangeCountry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButton(
                value: country,
                hint: const Text("Select Country"),
                isExpanded: true,
                items: countryList
                    .map((country) => DropdownMenuItem(
                        value: country[0].toString(),
                        child: Text(country[1].toString())))
                    .toList(),
                onChanged: (value) => onChangeCountry(value ?? country),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFieldWithLabelView(
          crossAxisAlignment: CrossAxisAlignment.start,
          label: "Region",
          controller: regionController,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFieldWithLabelView(
          crossAxisAlignment: CrossAxisAlignment.start,
          label: "City",
          controller: cityController,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFieldWithLabelView(
          crossAxisAlignment: CrossAxisAlignment.start,
          label: "Address",
          controller: addressController,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFieldWithLabelView(
          crossAxisAlignment: CrossAxisAlignment.start,
          label: "Postal Code",
          controller: postalController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class SelectGenderSectionView extends StatelessWidget {
  final Function(int) onChange;
  final int selectedGender;

  const SelectGenderSectionView({
    super.key,
    required this.onChange,
    required this.selectedGender,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AccountTypeSelectionSectionView(
          url: appLogo,
          text: 'Male',
          onTap: () => onChange(1),
          isSelected: selectedGender == 1,
        ),
        const SizedBox(
          width: 20,
        ),
        AccountTypeSelectionSectionView(
          url: appLogo,
          text: 'Female',
          onTap: () => onChange(2),
          isSelected: selectedGender == 2,
        ),
      ],
    );
  }
}

class CreatePasswordSectionView extends StatelessWidget {
  final Function(bool) onChangePassword;
  final bool showPassword;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const CreatePasswordSectionView({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onChangePassword,
    required this.showPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWithLabelView(
          label: "Password",
          controller: passwordController,
          isPassword: showPassword,
          icon: Icons.lock_rounded,
        ),
        const SizedBox(
          height: 32,
        ),
        TextFieldWithLabelView(
          label: "Confirm Password",
          controller: confirmPasswordController,
          isPassword: showPassword,
          icon: Icons.lock_rounded,
        ),
        ShowPasswordSectionView(
          onChange: (value) => onChangePassword(value),
          isSelected: showPassword,
        ),
      ],
    );
  }
}

class ChooseUserNameSectionView extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;

  const ChooseUserNameSectionView({
    super.key,
    required this.nameController,
    required this.usernameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWithLabelView(
          label: "Name",
          controller: nameController,
        ),
        const SizedBox(
          height: 32,
        ),
        TextFieldWithLabelView(
          label: "User Name",
          controller: usernameController,
        ),
      ],
    );
  }
}

class PhoneNumberSectionView extends StatefulWidget {
  final TextEditingController phoneController;

  const PhoneNumberSectionView({
    super.key,
    required this.phoneController,
  });

  @override
  State<PhoneNumberSectionView> createState() => _PhoneNumberSectionViewState();
}

class _PhoneNumberSectionViewState extends State<PhoneNumberSectionView> {
  @override
  Widget build(BuildContext context) {
    String countryCode = '+95';
    return Column(
      children: [
        const Text(
          "PHONE",
          style: TextStyle(
            color: colorPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        // TextField(
        //   controller: phoneController,
        //   keyboardType: TextInputType.phone,
        //   decoration: InputDecoration(
        //     hintText: "09123456789",
        //     prefixIcon: const Icon(
        //       Icons.phone_rounded,
        //       color: colorPrimary,
        //     ),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(100.0),
        //     ),
        //     contentPadding:
        //         const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        //   ),
        // ),
        Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Icon(
                    Icons.phone_rounded,
                    color: colorPrimary,
                  ),
                ),
                Container(
                  width: 100,
                  child: CountryCodePicker(
                    padding: EdgeInsets.zero,
                    flagWidth: 30,
                    showFlag: true,
                    initialSelection: 'MM',
                    onChanged: (value) {
                      setState(() {
                        countryCode = value.dialCode.toString();
                        print("countryCode ${countryCode.substring(1)}");
                        SharedPref.setData(
                          key: SharedPref.countryCode,
                          value: countryCode.substring(1),
                        );
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    controller: widget.phoneController,
                    decoration: const InputDecoration(
                      hintText: "978*****02",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                      prefixIconColor: Colors.blue,
                    ),
                    obscureText: false,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}

class EmailSectionView extends StatelessWidget {
  final TextEditingController emailController;

  const EmailSectionView({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "EMAIL",
          style: TextStyle(
            color: colorPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "abc***@gmail.com",
            prefixIcon: const Icon(
              Icons.email_rounded,
              color: colorPrimary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          ),
        ),
      ],
    );
  }
}

class EmailVerifySectionView extends StatelessWidget {
  final TextEditingController emailVerifyController;

  const EmailVerifySectionView({
    super.key,
    required this.emailVerifyController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "CODE",
          style: TextStyle(
            color: colorPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: emailVerifyController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          ),
        ),
      ],
    );
  }
}

class ForwardAndBackwardButtonSectionView extends StatelessWidget {
  final Function onTapBackward;
  final Function onTapForward;

  const ForwardAndBackwardButtonSectionView({
    super.key,
    required this.onTapBackward,
    required this.onTapForward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButtonView(
            icon: Icons.arrow_back_ios_rounded,
            onTap: () => onTapBackward(),
          ),
          IconButtonView(
            icon: Icons.arrow_forward_ios_rounded,
            onTap: () => onTapForward(),
          ),
        ],
      ),
    );
  }
}

class CancelAndNextButtonSectionView extends StatelessWidget {
  final RegisterState state;
  final Function onTapCancel;
  final Function onTapNext;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final bool visibility;

  const CancelAndNextButtonSectionView({
    super.key,
    required this.onTapCancel,
    required this.onTapNext,
    required this.state,
    this.textColor,
    this.backgroundColor,
    this.margin,
    this.visibility = false,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: state != RegisterState.contactInfo || visibility,
      child: Container(
        margin: margin ??
            EdgeInsets.symmetric(
              horizontal: 40,
              vertical: MediaQuery.of(context).size.height * 0.08,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LongButtonView(
                text: state == RegisterState.accountType ? "CANCEL" : "BACK",
                onTap: () => onTapCancel(),
                textColor: textColor,
                backgroundColor: backgroundColor,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: LongButtonView(
                text: state == RegisterState.contactInfo ? "REGISTER" : "NEXT",
                onTap: () => onTapNext(),
                textColor: textColor,
                backgroundColor: backgroundColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChooseAccountTypeSectionView extends StatelessWidget {
  final Function(int) onChange;
  final int selectedAccountType;

  const ChooseAccountTypeSectionView({
    super.key,
    required this.onChange,
    required this.selectedAccountType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AccountTypeSelectionSectionView(
          url: appLogo,
          text: 'Customer',
          onTap: () => onChange(1),
          isSelected: selectedAccountType == 1,
        ),
        const SizedBox(
          width: 20,
        ),
        AccountTypeSelectionSectionView(
          url: appLogo,
          text: 'Distributor',
          onTap: () => onChange(2),
          isSelected: selectedAccountType == 2,
        ),
      ],
    );
  }
}

class IconButtonView extends StatelessWidget {
  final Function onTap;
  final IconData icon;

  const IconButtonView({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Icon(icon),
    );
  }
}

class ReferralCodeRequestBottomSheetView extends StatelessWidget {
  final TextEditingController controller;
  final Function onTapNext;

  const ReferralCodeRequestBottomSheetView({
    super.key,
    required this.onTapNext,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        decoration: const BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "To Continue a distributor account, you are required to provide a referral code that you have obtained from another distributor.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "REFERRAL CODE",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorWhite,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.66,
              child: TextField(
                controller: controller,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: MediaQuery.of(context).size.height * 0.08,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LongButtonView(
                      text: "CANCEL",
                      textColor: colorPrimary,
                      backgroundColor: colorWhite,
                      onTap: () => popBack(context: context),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: LongButtonView(
                      text: "NEXT",
                      textColor: colorPrimary,
                      backgroundColor: colorWhite,
                      onTap: () => onTapNext(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountTypeSelectionSectionView extends StatelessWidget {
  final Function onTap;
  final String url;
  final String text;
  final bool isSelected;

  const AccountTypeSelectionSectionView({
    super.key,
    required this.onTap,
    required this.url,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: isSelected ? 2 : 1,
                color: isSelected ? colorPrimary : colorGrey.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Image.asset(
              url,
              width: 70,
              height: 70,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          text,
          style: const TextStyle(
            color: colorPrimary,
          ),
        )
      ],
    );
  }
}

enum RegisterState {
  accountType,
  phoneNumber,
  email,
  chooseUserName,
  createPassword,
  selectGender,
  contactInfo,
}
