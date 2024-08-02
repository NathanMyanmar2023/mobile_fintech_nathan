import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/bloc/checkout_bloc.dart';
import 'package:fnge/bloc/region_bloc.dart';
import 'package:fnge/bloc/township_bloc.dart';
import 'package:fnge/extensions/navigation_extensions.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/region_ob.dart';
import 'package:fnge/objects/township_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/resources/constants.dart';
import 'package:fnge/widgets/long_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final _checkoutBloc = CheckoutBloc();
  late Stream<ResponseOb> _checkoutStream;

  final _regionBloc = RegionBloc();
  late Stream<ResponseOb> _regionStream;
  List<RegionData> regionList = [];

  final _townShipBloc = TownshipBloc();
  late Stream<ResponseOb> _townshipStream;
  List<TownShipData> townShipList = [];
  bool ischange = false;
  bool isTownchange = false;
  @override
  void initState() {
    super.initState();

    /// region list stream
    _regionStream = _regionBloc.regionStream();
    _regionStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          regionList = (resp.data as RegionOb).data ?? [];
          _townShipBloc.getTownShip(id: regionList.first.id ?? 0);
        });
      } else {}
    });

    /// township list stream
    _townshipStream = _townShipBloc.townshipStream();
    _townshipStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          townShipList = (resp.data as TownshipOb).data ?? [];
        });
      } else {}
    });

    _regionBloc.getRegions();

    /// make checkout
    _checkoutStream = _checkoutBloc.checkoutStream();
    _checkoutStream.listen((ResponseOb resp) {
      if (resp.success) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  AppLocalizations.of(context)!.success,
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(welcomeLogo, height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      resp.message.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
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
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error!'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(welcomeLogo, height: 100, width: 100),
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
      }
    });
  }

  int selectedRegionId = 0;
  int selectedTownshipId = 0;
  TownShipData? valueData;
  @override
  Widget build(BuildContext context) {
    return regionList.isEmpty || townShipList.isEmpty
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
        : Scaffold(
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
                    "Check Out",
                    style: TextStyle(
                      fontSize: 16,
                      color: colorPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Region',
                          style: TextStyle(
                            color: colorPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        DropdownButton<RegionData>(
                          isExpanded: true,
                          value: ischange
                              ? regionList[selectedRegionId - 1]
                              : regionList.first,
                          onChanged: (newValue) {
                            _townShipBloc.getTownShip(id: newValue?.id ?? 0);
                            selectedRegionId = newValue!.id ?? 0;
                            setState(() {
                              ischange = true;
                              isTownchange = false;
                            });
                          },
                          items: regionList.map((option) {
                            return DropdownMenuItem<RegionData>(
                              value: option,
                              child: Text(option.name ?? "-"),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Township',
                          style: TextStyle(
                            color: colorPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        DropdownButton<TownShipData>(
                          isExpanded: true,
                          value: isTownchange ? valueData : townShipList.first,
                          onChanged: (newValue) {
                            selectedTownshipId = newValue!.id ?? 0;
                            setState(() {
                              valueData = newValue;
                              isTownchange = true;
                            });
                          },
                          items: townShipList.map((option) {
                            return DropdownMenuItem<TownShipData>(
                              value: option,
                              child: Text(option.name ?? "-"),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact Person',
                          style: TextStyle(
                            color: colorPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "Tun***",
                            labelStyle: const TextStyle(color: colorPrimary),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorGrey.withOpacity(0.3)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: colorPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recipient Contact Number',
                          style: TextStyle(
                            color: colorPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "09****",
                            labelStyle: const TextStyle(color: colorPrimary),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorGrey.withOpacity(0.3)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: colorPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery Address',
                          style: TextStyle(
                            color: colorPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                            hintText: "No.45,***",
                            labelStyle: const TextStyle(color: colorPrimary),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorGrey.withOpacity(0.3)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: colorPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Note:',
                          style: TextStyle(
                            color: colorPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: noteController,
                          decoration: InputDecoration(
                            hintText: "note****",
                            labelStyle: const TextStyle(color: colorPrimary),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorGrey.withOpacity(0.3)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: colorPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    LongButtonView(
                      text: "Confirm",
                      onTap: () {
                        _checkoutBloc.makeCheckout(data: {
                          "township_id": isTownchange
                              ? valueData!.id
                              : townShipList.first.id,
                          "receiver_name": nameController.text.trim(),
                          "receiver_phone": phoneController.text.trim(),
                          "address": addressController.text.trim(),
                          "note": noteController.text.trim(),
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
