import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnge/models/services/api_status.dart';
import 'package:fnge/view_models/add_address_view_model.dart';
import 'package:fnge/view_models/cart_view_model.dart';
import 'package:fnge/views/widgets/common/input/text_input_widget.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    AddAddressViewModel addAddressViewModel =
        context.watch<AddAddressViewModel>();
    CartViewModel cartViewModel = context.watch<CartViewModel>();
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              "Delivery Address",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: addAddressViewModel.loading
            ? SpinKitFadingFour(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index.isEven ? Colors.blue : Colors.grey.shade800,
                    ),
                  );
                },
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Region",
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton(
                              hint:
                                  Text(addAddressViewModel.selectedRegion.name),
                              isExpanded: true,
                              items: addAddressViewModel.regionList
                                  .map(
                                    (region) => DropdownMenuItem(
                                      value: region,
                                      child: Text(region.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                addAddressViewModel.setSelectedRegion(value!);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Township",
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton(
                              hint: Text(
                                addAddressViewModel.selectedTownship.name,
                              ),
                              isExpanded: true,
                              items: addAddressViewModel.townshipList
                                  .map(
                                    (township) => DropdownMenuItem(
                                      value: township,
                                      child: Text(township.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (township) {
                                addAddressViewModel
                                    .setSelectedTownship(township!);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextInputWidget(
                        textEditingController:
                            addAddressViewModel.addressLineTec,
                        label: "Address Line",
                        icon: Icons.pin_drop_outlined,
                        hint: "Address Line",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputWidget(
                        textEditingController: addAddressViewModel.phoneTec,
                        label: "Phone",
                        icon: Icons.phone_outlined,
                        hint: 'Receivery Phone Number',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputWidget(
                        textEditingController:
                            addAddressViewModel.receiverNameTec,
                        label: "Name",
                        icon: Icons.person_2_outlined,
                        hint: 'Receiver Name',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Address Type",
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio<bool>(
                                value: true,
                                groupValue: addAddressViewModel.isHome,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.green), //<-- SEE HERE
                                onChanged: (bool? value) {
                                  addAddressViewModel.setIsHome(value!);
                                },
                              ),
                              const Text("Home"),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              Radio<bool>(
                                value: false,
                                groupValue: addAddressViewModel.isHome,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.green), //<-- SEE HERE
                                onChanged: (bool? value) {
                                  addAddressViewModel.setIsHome(value!);
                                },
                              ),
                              const Text("Office"),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          ApiStatus apiStatus =
                              await addAddressViewModel.updateAddress();
                          if (apiStatus.success == true) {
                            Fluttertoast.showToast(
                              msg: apiStatus.message,
                              backgroundColor: Colors.green,
                            );
                            cartViewModel.getCart();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          } else {
                            Fluttertoast.showToast(
                              msg: apiStatus.message,
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              "Update",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
