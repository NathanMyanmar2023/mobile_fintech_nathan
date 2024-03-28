import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nathan_app/bloc/profile/profile_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/views/screens/profile/edit_profile_success_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final String current_name;
  final String current_profile_picture;

  final String current_email;

  final String current_address_line;
  final String current_region;
  final String current_city;

  const EditProfileScreen({
    super.key,
    required this.current_name,
    required this.current_profile_picture,
    required this.current_email,
    required this.current_address_line,
    required this.current_region,
    required this.current_city,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isLoading = false;
  File? _file;
  var name_tec = TextEditingController();
  var email_tec = TextEditingController();
  var address_tec = TextEditingController();
  var region_tec = TextEditingController();
  var city_tec = TextEditingController();
  String profile_picture = "";

  bool is_edited = false;

  final _profile_bloc = ProfileBloc();
  late Stream<ResponseOb> _profile_stream;
  late Stream<ResponseOb> _presign_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      name_tec.text = widget.current_name;
      email_tec.text = widget.current_email;
      address_tec.text = widget.current_address_line;
      region_tec.text = widget.current_region;
      city_tec.text = widget.current_city;
      profile_picture = widget.current_profile_picture;
    });

    _presign_stream = _profile_bloc.presignStream();
    _presign_stream.listen((ResponseOb resp) {
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
      }
    });

    _profile_stream = _profile_bloc.profileStream();
    _profile_stream.listen((ResponseOb resp) {
      if (resp.success == true) {
        setState(() {
          isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return const EditProfileSuccessScreen();
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
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: SpinKitFadingFour(
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
        ),
      );
    } else {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
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
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: pickImage,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: _file != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(180),
                                      child: Image.file(
                                        _file!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : profile_picture != ""
                                      ? CachedNetworkImage(
                                          imageUrl: profile_picture,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 120.0,
                                            height: 120.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : const Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 30,
                                          ),
                                        ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 5, right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45),
                                  color: Colors.white,
                                ),
                                width: 30,
                                height: 30,
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text("Name"),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        check_edited();
                      },
                      keyboardType: TextInputType.text,
                      controller: name_tec,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outlined),
                        hintText: "Name",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text("Email"),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        check_edited();
                      },
                      keyboardType: TextInputType.text,
                      controller: email_tec,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Email",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text("Address"),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        check_edited();
                      },
                      keyboardType: TextInputType.text,
                      controller: address_tec,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Address",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text("Region"),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        check_edited();
                      },
                      keyboardType: TextInputType.text,
                      controller: region_tec,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Region",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text("City"),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        check_edited();
                      },
                      keyboardType: TextInputType.text,
                      controller: city_tec,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "City",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: is_edited ? Colors.blue : Colors.blue.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    height: 45,
                    elevation: 0,
                    onPressed: !is_edited
                        ? () {
                            return;
                          }
                        : edit_profile,
                    child: const SizedBox(
                      height: 20,
                      child: Center(
                          child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                    ),
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

  edit_profile() {
    setState(() {
      isLoading = true;
    });
    if (name_tec.text == "" ||
        email_tec.text == "" ||
        address_tec.text == "" ||
        region_tec.text == "" ||
        city_tec.text == "") {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorAlert(
            "Oppo !",
            Image.asset('images/welcome.png'),
            "Please complet the fields",
          );
        },
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    Map<String, dynamic> map = {
      'name': name_tec.text,
      'email': email_tec.text,
      'address_line': address_tec.text,
      'region': region_tec.text,
      'city': city_tec.text,
    };

    if (_file != null) {
      _profile_bloc.updateProfileWithPicture(map, _file!);
    } else {
      _profile_bloc.updateProfile(map);
    }
  }

  check_edited() {
    if (name_tec.text != widget.current_name ||
        email_tec.text != widget.current_email ||
        address_tec.text != widget.current_address_line ||
        region_tec.text != widget.current_region ||
        city_tec.text != widget.current_city ||
        _file != null) {
      if (is_edited == false) {
        setState(() {
          is_edited = true;
        });
      }
    } else {
      if (is_edited == true) {
        setState(() {
          is_edited = false;
        });
      }
    }
  }

  //Select Image
  final ImagePicker _picker = ImagePicker();
  pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
        is_edited = true;
      });
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
