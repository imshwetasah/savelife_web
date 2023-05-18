import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savelife_web/constants/city.dart';
import 'package:savelife_web/constants/constant.dart';
import 'package:savelife_web/constants/image_strings.dart';
import 'package:savelife_web/constants/text_strings.dart';

class RegisterBloodBankPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterBloodBankPage({super.key, required this.showLoginPage});

  @override
  State<RegisterBloodBankPage> createState() => _RegisterBloodBankPageState();
}

class _RegisterBloodBankPageState extends State<RegisterBloodBankPage> {
  //Constructor for selection
  _RegisterPageState() {
    _selectedCityL = _cityL[0];
  }

  final _cityL = cityL;
  String? _selectedCityL = 'Select';

  //text Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _bloodbankNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _fullAddressController = TextEditingController();
  final _aPosController = TextEditingController();
  final _aNegController = TextEditingController();
  final _bPosController = TextEditingController();
  final _bNegController = TextEditingController();
  final _oPosController = TextEditingController();
  final _oNegController = TextEditingController();
  final _abPosController = TextEditingController();
  final _abNegController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _bloodbankNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _fullAddressController.dispose();
    _aPosController.dispose();
    _aNegController.dispose();
    _bPosController.dispose();
    _bNegController.dispose();
    _oPosController.dispose();
    _oNegController.dispose();
    _abPosController.dispose();
    _abNegController.dispose();

    super.dispose();
  }

  Future signUp() async {
    //Check if blood group and gender field is empty
    //Check if city field is empty
    if (_cityController.text.trim() == '' ||
        _cityController.text.trim() == 'Select') {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
              'Please select a City!',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          );
        },
      );
    } else {
      if (passwordConfirmed()) {
        try {
          // create donor
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          //add donor details
          addBloodbankDetails(
            _bloodbankNameController.text.trim(),
            _cityController.text.trim(),
            _emailController.text.trim(),
            _phoneController.text.trim(),
            _fullAddressController.text.trim(),
            _aPosController.text.trim(),
            _aNegController.text.trim(),
            _bPosController.text.trim(),
            _bNegController.text.trim(),
            _oPosController.text.trim(),
            _oNegController.text.trim(),
            _abPosController.text.trim(),
            _abNegController.text.trim(),
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
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                'Passwords doesn\'t match !',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            );
          },
        );
      }
    }
  }

  Future addBloodbankDetails(
    String bloodbankName,
    String city,
    String email,
    String phone,
    String fullAddress,
    String aPosCount,
    String aNegCount,
    String bPosCount,
    String bNegCount,
    String oPosCount,
    String oNegCount,
    String abPosCount,
    String abNegCount,
  ) async {
    var user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('blood banks')
        .doc(user.uid)
        .set(
      {
        'bloodbank name': bloodbankName,
        'city': city,
        'email': email,
        'phone': phone,
        'full address': fullAddress,
        'A+ Count': int.parse(aPosCount),
        'A- Count': int.parse(aNegCount),
        'B+ Count': int.parse(bPosCount),
        'B- Count': int.parse(bNegCount),
        'O+ Count': int.parse(oPosCount),
        'O- Count': int.parse(oNegCount),
        'AB+ Count': int.parse(abPosCount),
        'AB- Count': int.parse(abNegCount),
      },
    );
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
      {
        'name': bloodbankName,
        'city': city,
        'email': email,
        'phone': phone,
        'role': 'bloodbank',
      },
    );
  }

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
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        centerTitle: true,
        title: const Text('SaveLife'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Title Image Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    'Get On Board!',
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),
                  Text(
                    'Register below as BloodBank!',
                    style: GoogleFonts.figtree(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              //Sign Up Form
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Blood Bank Name
                          SizedBox(
                            height: 60,
                            width: screenSize.width * 0.41,
                            child: TextField(
                              controller: _bloodbankNameController,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.4),
                              decoration: InputDecoration(
                                label: const Text(
                                  'Blood Bank Name',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: const Icon(
                                  Icons.house_rounded,
                                  color: Colors.red,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),

                          const SizedBox(width: 70),
                          // Email Text Field
                          SizedBox(
                            height: 60,
                            width: screenSize.width * 0.41,
                            child: TextField(
                              controller: _emailController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  aEmail,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
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
                                  borderSide:
                                      const BorderSide(color: Colors.red),
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

                      // City Drop Down
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Phone Number Text Field
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.18,
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: const Icon(
                                  Icons.phone_iphone_rounded,
                                  color: Colors.red,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),

                          const SizedBox(width: 75),
                          // City Drop Down
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.18,
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),

                          const SizedBox(width: 75),

                          //Full Address Text Field
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.41,
                            child: TextField(
                              controller: _fullAddressController,
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
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
                                  borderSide:
                                      const BorderSide(color: Colors.red),
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

                      // Boood Bags Count A+, A-, B+, B-
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //A+ Blood bag count
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.18,
                            child: TextField(
                              controller: _aPosController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  'A +ve blood bags count',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: Image.asset(
                                  aAPositive,
                                  scale: 8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 75),

                          //A- Blood bag count
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.18,
                            child: TextField(
                              controller: _aNegController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  'A -ve blood bags count',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: Image.asset(
                                  aANegative,
                                  scale: 8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 75),

                          //B+ Blood bag count
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.18,
                            child: TextField(
                              controller: _bPosController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  'B +ve blood bags count',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: Image.asset(
                                  aBPositive,
                                  scale: 8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 75),
                          //B- Blood bag count
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.18,
                            child: TextField(
                              controller: _bNegController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  'B -ve blood bags count',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: Image.asset(
                                  aBNegative,
                                  scale: 8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
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

                      //
                      // Boood Bags Count O+, O-, AB+, AB-
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //O+ Blood bag count
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.18,
                            child: TextField(
                              controller: _oPosController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  'O +ve blood bags count',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: Image.asset(
                                  aOPositive,
                                  scale: 8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 75),

                          //O- Blood bag count
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.18,
                            child: TextField(
                              controller: _oNegController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  'O -ve blood bags count',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: Image.asset(
                                  aONegative,
                                  scale: 8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 75),

                          //AB+ Blood bag count
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.18,
                            child: TextField(
                              controller: _abPosController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  'AB +ve blood bags count',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: Image.asset(
                                  aABPositive,
                                  scale: 8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 75),
                          //AB- Blood bag count
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.18,
                            child: TextField(
                              controller: _abNegController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  'AB -ve blood bags count',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: Image.asset(
                                  aABNegative,
                                  scale: 8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
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
                          //Password Text Field
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.30,
                            child: TextField(
                              obscureText: true,
                              controller: _passwordController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  aPassword,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: const Icon(
                                  Icons.fingerprint_rounded,
                                  color: Colors.red,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),

                          const SizedBox(width: 70),

                          //Confirm Password
                          SizedBox(
                            height: 50,
                            width: screenSize.width * 0.30,
                            child: TextField(
                              obscureText: true,
                              controller: _confirmpasswordController,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  aConfirmPassword,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                prefixIcon: const Icon(
                                  Icons.fingerprint_rounded,
                                  color: Colors.red,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
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

                      const SizedBox(height: 15),

                      //Sign in button
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: GestureDetector(
                          onTap: signUp,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: kred,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'Sign Up',
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

              //Already have an account! Login now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an Account!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      '  Login now',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
