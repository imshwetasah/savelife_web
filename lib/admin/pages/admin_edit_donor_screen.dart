import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:savelife_web/admin/pages/admin_home_page.dart';
import 'package:savelife_web/constants/bloodgroup.dart';
import 'package:savelife_web/constants/city.dart';
import 'package:savelife_web/constants/constant.dart';
import 'package:savelife_web/constants/gender.dart';
import 'package:savelife_web/constants/image_strings.dart';
import 'package:savelife_web/constants/text_strings.dart';

class AdminEditDonorScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String bloodGroup;
  final String gender;
  final String phone;
  final String city;
  final String email;
  final String docId;
  const AdminEditDonorScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.bloodGroup,
    required this.gender,
    required this.phone,
    required this.city,
    required this.email,
    required this.docId,
  });

  @override
  State<AdminEditDonorScreen> createState() => _AdminEditDonorScreenState();
}

class _AdminEditDonorScreenState extends State<AdminEditDonorScreen> {
  //Constructor for selection
  // findIndex(List list1, String match) {
  //   int ind = 0;
  //   for (int i = 0; i < list1.length; i++) {
  //     if (list1[i] == match) {
  //       ind = i;
  //       break;
  //     }
  //   }
  //   return ind;
  // }

  _RegisterPageState() {
    // int genderIndex = _genderL[0];
    // int bgIndex = findIndex(bloodGroupL, _fromBG);
    // int cityIndex = findIndex(cityL, _fromCity);

    _selectedgenderL = _genderL[0];
    _selectedBloodGroupL = _bloodGroupL[0];
    _selectedCityL = _cityL[0];
  }

  // late final String _fromGender;
  // late final String _fromBG;
  // late final String _fromCity;

  // @override
  // void initState() {
  //   _fromGender = widget.gender;
  //   _fromCity = widget.city;
  //   _fromBG = widget.bloodGroup;
  //   super.initState();
  // }

  // For Dropdown selection
  final _bloodGroupL = bloodGroupL;

  final _genderL = genderL;

  final _cityL = cityL;

  String? _selectedBloodGroupL = 'Select';
  String? _selectedgenderL = 'Select';
  String? _selectedCityL = 'Select';

  //text Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _genderController = TextEditingController();
  final _bloodgroupController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _genderController.dispose();
    _bloodgroupController.dispose();
    _phoneController.dispose();
    _cityController.dispose();

    super.dispose();
  }

//password confirmation
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.menu),
        title: const Text(
          'Edit Donor Details',
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
            //Sign Up Form
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
                              Icons.verified_user_rounded,
                              color: Colors.green,
                              size: 60,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Edit Details of user: ',
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
                        //First Name Text Field
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.25,
                          child: TextField(
                            controller: _firstnameController
                              ..text = widget.firstName,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4),
                            decoration: InputDecoration(
                              label: const Text(
                                'First Name',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline_rounded,
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

                        //Last Name Text Field
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.25,
                          child: TextField(
                            controller: _lastnameController
                              ..text = widget.lastName,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4),
                            decoration: InputDecoration(
                              prefixIcon: const Text(''),
                              label: const Text(
                                '  Last Name',
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
                        // Gender
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.25,
                          child: DropdownButtonFormField(
                            value: _selectedgenderL,
                            items: _genderL
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedgenderL = val as String;
                                _genderController.text = val;
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
                              prefixIcon: Image.asset(
                                gender,
                                scale: 2,
                              ),
                              label: const Text(
                                'Gender',
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

                        //Blood Group Drop Down
                        SizedBox(
                          height: 60,
                          width: screenSize.width * 0.25,
                          child: DropdownButtonFormField(
                            value: _selectedBloodGroupL,
                            items: _bloodGroupL
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedBloodGroupL = val as String;
                                _bloodgroupController.text = val;
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
                              prefixIcon: Image.asset(
                                bloodGroup,
                                scale: 3,
                              ),
                              label: const Text(
                                'Blood Group',
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
                                    .collection('donors')
                                    .doc(widget.docId)
                                    .update({
                                  'first name':
                                      _firstnameController.text.trim(),
                                  'last name': _lastnameController.text.trim(),
                                  'gender': _genderController.text.trim(),
                                  'blood group':
                                      _bloodgroupController.text.trim(),
                                  'city': _cityController.text.trim(),
                                  'phone': _phoneController.text.trim(),
                                });

                                //updates users collection
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.docId)
                                    .update({
                                  'name':
                                      '${_firstnameController.text.trim()} ${_lastnameController.text.trim()}',
                                  'city': _cityController.text.trim(),
                                  'phone': _cityController.text.trim(),
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
                                        'Donor Info Updated Successfully!',
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
                            }, //signUp,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: kred,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  'Update Donor Info',
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
