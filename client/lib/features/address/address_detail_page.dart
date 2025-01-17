import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/address/address_controller.dart';
import 'package:plantial/features/commons/custom_back_button.dart';
import 'package:plantial/features/styles/styles.dart';

class AddressDetail extends StatefulWidget {
  final String email;
  final String appBarTitle;

  const AddressDetail(
      {super.key, required this.appBarTitle, required this.email});

  @override
  State<AddressDetail> createState() => _AddressDetailState();
}

class _AddressDetailState extends State<AddressDetail> {
  final formKey = GlobalKey<FormState>();
  final addressController = AddressController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressDetailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressDetailController.dispose();
    super.dispose();
  }

  Future loadData() async {
    var d = await rootBundle.loadString("assets/sorted.json");
    addressController.data = json.decode(d);
    return "success";
  }

  bool isValidPhoneNumber(String number){
      return RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})\b').hasMatch(number);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.appBarTitle,
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
          leading: const CustomBackButton(color: Colors.black),
        ),
        body: FutureBuilder(
          future: loadData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primary),
              ));
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Empty'),
              );
            } else {
              return Form(
                key: formKey,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "Liên hệ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập Họ và tên';
                                }
                                return null;
                              },
                              controller: nameController,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: errorColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: errorColor)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 1, color: primary)),
                                  hintText: "Họ và tên",
                                  focusColor: primary,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey)),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập Số điện thoại';
                                }else{
                                  if(isValidPhoneNumber(value) == false){
                                    return "Số điện thoại không hợp lệ";
                                  }
                                }
                                return null;
                              },
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: errorColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: errorColor)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 1, color: primary)),
                                  hintText: "Số điện thoại",
                                  focusColor: primary,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey)),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "Địa chỉ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                isDense: true,
                                isExpanded: true,
                                icon: Transform.rotate(
                                    angle: 270 * pi / 180,
                                    child: const Icon(
                                      Icons.chevron_left,
                                      size: 18,
                                    )),
                                iconSize: 24,
                                value: addressController.provinceValue,
                                hint: const Text("Tỉnh/Thành phố",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14)),
                                items: addressController.getProvinceList(),
                                onChanged: (value) {
                                  setState(() {
                                    addressController.provinceValue =
                                        value.toString();
                                    addressController.districtValue = null;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                isDense: true,
                                isExpanded: true,
                                icon: Transform.rotate(
                                    angle: 270 * pi / 180,
                                    child: const Icon(
                                      Icons.chevron_left,
                                      size: 18,
                                    )),
                                iconSize: 24,
                                value: addressController.districtValue,
                                hint: const Text("Quận/Huyện",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14)),
                                onChanged: (value) {
                                  setState(() {
                                    addressController.districtValue =
                                        value.toString();
                                    addressController.wardValue = null;
                                  });
                                },
                                items: addressController.getDistrictList(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                isDense: true,
                                isExpanded: true,
                                icon: Transform.rotate(
                                    angle: 270 * pi / 180,
                                    child: const Icon(
                                      Icons.chevron_left,
                                      size: 18,
                                    )),
                                iconSize: 24,
                                value: addressController.wardValue,
                                hint: const Text(
                                  "Phường/Xã",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    addressController.wardValue =
                                        value.toString();
                                    addressController.getWard();
                                  });
                                },
                                items: addressController.getWardList(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập địa chỉ';
                                }
                                return null;
                              },
                              controller: addressDetailController,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: errorColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: errorColor)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 1, color: primary)),
                                  hintText: "Tên đường, Tòa nhà, Số nhà",
                                  focusColor: primary,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey)),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            }
          },
        ),
        bottomNavigationBar: Container(
          height: 85,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 55,
                  child: TextButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final response = await post(
                          Uri.parse(apiAddress),
                          headers: {'Content-Type': 'application/json'},
                          body: json.encode({
                            'email': widget.email,
                            'name': nameController.text,
                            'phone': phoneController.text,
                            'street': addressDetailController.text,
                            'ward': addressController.ward,
                            'province': addressController.province,
                            'district': addressController.district
                          }),
                        );
                        if (response.statusCode == 200 && context.mounted) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(primary),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)))),
                    child: const Text(
                      "Xác nhận",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
