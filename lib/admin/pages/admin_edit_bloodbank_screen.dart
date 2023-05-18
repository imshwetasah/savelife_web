import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:savelife_web/admin/pages/admin_home_page.dart';
import 'package:savelife_web/constants/bloodgroup.dart';
import 'package:savelife_web/constants/city.dart';
import 'package:savelife_web/constants/constant.dart';
import 'package:savelife_web/constants/gender.dart';
import 'package:savelife_web/constants/text_strings.dart';

class AdminEditBloodbankScreen extends StatefulWidget {
  final String bloodbankName;
  final String phone;
  final String city;
  final String fullAddress;
  final String email;
  final String docId;
  const AdminEditBloodbankScreen(
      {super.key,
      required this.bloodbankName,
      required this.phone,
      required this.city,
      required this.fullAddress,
      required this.email,
      required this.docId});

  @override
  State<AdminEditBloodbankScreen> createState() =>
      _AdminEditBloodbankScreenState();
}

class _AdminEditBloodbankScreenState extends State<AdminEditBloodbankScreen> {
  _RegisterPageState() {
    _selectedgenderL = _genderL[0];
    _selectedBloodGroupL = _bloodGroupL[0];
    _selectedCityL = _cityL[0];
  }

  // For Dropdown selection
  final _bloodGroupL = bloodGroupL;

  final _genderL = genderL;

  final _cityL = cityL;

  String? _selectedBloodGroupL = 'Select';
  String? _selectedgenderL = 'Select';
  String? _selectedCityL = 'Select';

  //text Controllers
  final _emailController = TextEditingController();
  final _bloodbankNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _fullAddressController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _bloodbankNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _fullAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.menu),
        title: const Text(
          'Edit Blood Bank Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            // color: Colors.wh,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Edit Blood Bank Form
            Form(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: screenSize.width * 0.90,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.verified_rounded,
                              color: Colors.green,
                              size: 60,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Edit Details of Blood Bank: ',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.4),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              widget.email,
                              style: TextStyle(
                                fontSize: 28,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w600,
                                color: Colors.indigo[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Blood Bank Name Text Field
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.25,
                          child: TextField(
                            controller: _bloodbankNameController
                              ..text = widget.bloodbankName,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4),
                            decoration: InputDecoration(
                              label: const Text(
                                'Blood Bank Name',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              prefixIcon: const Icon(
                                Icons.home_rounded,
                                color: Colors.red,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        //Full Address Text Field
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.25,
                          child: TextField(
                            controller: _fullAddressController
                              ..text = widget.fullAddress,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.gps_fixed,
                                color: Colors.red,
                              ),
                              label: const Text(
                                'Full Address',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // City Drop Down
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.25,
                          child: DropdownButtonFormField(
                            value: _selectedCityL,
                            items: _cityL
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedCityL = val as String;
                                _cityController.text = val;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                            ),
                            alignment: Alignment.bottomCenter,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.location_city_rounded,
                                color: Colors.red,
                                size: 27,
                              ),
                              label: const Text(
                                aCity,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        //Phone Number Text Field
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.25,
                          child: TextField(
                            controller: _phoneController..text = widget.phone,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4),
                            decoration: InputDecoration(
                              label: const Text(
                                'Phone',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              prefixIcon: const Icon(
                                Icons.phone_android_rounded,
                                color: Colors.red,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    const SizedBox(height: 30),

                    //Update User Info button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.25,
                          child: GestureDetector(
                            onTap: () async {
                              try {
                                //updates donors collection
                                await FirebaseFirestore.instance
                                    .collection('blood banks')
                                    .doc(widget.docId)
                                    .update({
                                  'bloodbank name':
                                      _bloodbankNameController.text.trim(),
                                  'full address':
                                      _fullAddressController.text.trim(),
                                  'city': _cityController.text.trim(),
                                  'phone': _phoneController.text.trim(),
                                });

                                //updates users collection
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.docId)
                                    .update({
                                  'name': _bloodbankNameController.text.trim(),
                                  'city': _cityController.text.trim(),
                                  'phone': _phoneController.text.trim(),
                                });
                                DelayedMultiDragGestureRecognizer;
                                // ignore: use_build_context_synchronously
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const AdminHomePage();
                                }));
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      content: Text(
                                        'Blood Bank Info Updated Successfully!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } on FirebaseAuthException catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(e.message.toString()),
                                    );
                                  },
                                );
                              }
                            }, //Update info,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: kred,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  'Update Blood Bank Info',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
