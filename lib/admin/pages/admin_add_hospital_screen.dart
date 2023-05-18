import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savelife_web/admin/pages/admin_home_page.dart';
import 'package:savelife_web/constants/city.dart';
import 'package:savelife_web/constants/constant.dart';
import 'package:savelife_web/constants/text_strings.dart';

class AdminAddHospitalScreen extends StatefulWidget {
  static const String id = "admin-add-hospital-screen";
  const AdminAddHospitalScreen({super.key});

  @override
  State<AdminAddHospitalScreen> createState() => _AdminAddHospitalScreenState();
}

class _AdminAddHospitalScreenState extends State<AdminAddHospitalScreen> {
  //Constructor for selection
  _RegisterPageState() {
    _selectedCityL = _cityL[0];
  }

  final _cityL = cityL;
  String? _selectedCityL = 'Select';

  //text controllers
  final _hospitalNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  void dispose() {
    _hospitalNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();

    super.dispose();
  }

  Future addDetails() async {
    try {
      addHospitalDetails(
        _hospitalNameController.text.trim(),
        _phoneController.text.trim(),
        _cityController.text.trim(),
        _addressController.text.trim(),
        _latitudeController.text.trim(),
        _longitudeController.text.trim(),
      );
      DelayedMultiDragGestureRecognizer;
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const AdminHomePage();
      }));
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
              'Hospital Added Successfully!',
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
  }

  addHospitalDetails(
    String hospitalName,
    String phone,
    String city,
    String address,
    String latitude,
    String longitude,
  ) async {
    await FirebaseFirestore.instance.collection('hospitals').doc().set(
      {
        "hospital name": hospitalName,
        "phone": phone,
        "city": city,
        "address": address,
        "latitude": double.parse(latitude),
        "longitude": double.parse(longitude),
        "distance": 0.0,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Add a Hospital below!',
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //Title Image Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Text(
                  '',
                  style: GoogleFonts.figtree(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            //Add Hospital Up Form
            Form(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Blood Bank Name
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.30,
                          child: TextField(
                            controller: _hospitalNameController,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4),
                            decoration: InputDecoration(
                              label: const Text(
                                'Hospital Name',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              prefixIcon: const Icon(
                                Icons.local_hospital,
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

                        const SizedBox(width: 70),
                        // Phone Text Field
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.30,
                          child: TextField(
                            controller: _phoneController,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.4,
                            ),
                            decoration: InputDecoration(
                              label: const Text(
                                aPhone,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              prefixIcon: const Icon(
                                Icons.mail_outline_rounded,
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
                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // City Drop Down
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.30,
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

                        const SizedBox(width: 70),

                        //Full Address Text Field
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.30,
                          child: TextField(
                            controller: _addressController,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.4,
                            ),
                            decoration: InputDecoration(
                              label: const Text(
                                'Full Address',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              prefixIcon: const Icon(
                                Icons.gps_fixed,
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

                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Latitude
                        SizedBox(
                          height: 50,
                          width: screenSize.width * 0.30,
                          child: TextField(
                            controller: _latitudeController,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.4,
                            ),
                            decoration: InputDecoration(
                              label: const Text(
                                'Latitude',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              prefixIcon: const Icon(
                                Icons.location_on,
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

                        const SizedBox(width: 70),

                        //Longitude
                        SizedBox(
                          height: 50,
                          width: screenSize.width * 0.30,
                          child: TextField(
                            controller: _longitudeController,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.4,
                            ),
                            decoration: InputDecoration(
                              label: const Text(
                                'Longitude',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              prefixIcon: const Icon(
                                Icons.location_on,
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

                    const SizedBox(height: 60),

                    //Sign in button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: GestureDetector(
                        onTap: addDetails,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: kred,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Add Hospital',
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
