import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savelife_web/constants/constant.dart';
import 'package:savelife_web/constants/image_strings.dart';
import 'package:savelife_web/constants/text_strings.dart';
import 'package:savelife_web/pages/forgot_password_page.dart';
import 'package:savelife_web/pages/register_bloodbank_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback ShowRegisterBloodBank;
  static const String id = "login-screen";
  const LoginPage({super.key, required this.ShowRegisterBloodBank});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //Sign In Method
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
              'Incorrect Username or Password !',
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // //Page Controller for carousel
  // late final PageController _pageController;
  // @override
  // void initState() {
  //   _pageController = PageController();
  //   super.initState();
  // }

  //caousel images banner
  List bannerImages = [
    {"id": 1, "image_path": 'assets/images/banner1.jpg'},
    {"id": 2, "image_path": 'assets/images/banner2.jpg'},
    {"id": 3, "image_path": 'assets/images/banner3.jpg'},
    {"id": 5, "image_path": 'assets/images/banner5.jpg'},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Carousel
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: CarouselSlider(
                            items: bannerImages
                                .map((item) => Image.asset(
                                      item['image_path'],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ))
                                .toList(),
                            carouselController: carouselController,
                            options: CarouselOptions(
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlay: true,
                                aspectRatio: 4,
                                viewportFraction: 0.8,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                })),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: bannerImages.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    carouselController.animateToPage(entry.key),
                                child: Container(
                                  width: currentIndex == entry.key ? 17 : 7,
                                  height: 7.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: currentIndex == entry.key
                                          ? Colors.red
                                          : Colors.white),
                                ),
                              );
                            }).toList(),
                          ))
                    ],
                  ),

                  //Later part of login page

                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/login.png',
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    'SaveLife',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 52,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Web Portal - BloodBank | Admin',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Email Text Field
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Form(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                label: const Text(
                                  aEmail,
                                  style: TextStyle(color: Colors.red),
                                ),
                                prefixIcon: const Icon(
                                  Icons.mail_outline_rounded,
                                  color: Colors.red,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kred),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Email',
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //Password Text Field
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              label: const Text(
                                aPassword,
                                style: TextStyle(color: Colors.red),
                              ),
                              prefixIcon: const Icon(
                                Icons.fingerprint_rounded,
                                color: Colors.red,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kred),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Password',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),
                      //Sign in Button
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: signIn,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: kred,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign In',
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
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //Forgot Password
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 65,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Register a BloodBank?',
                              style: TextStyle(
                                letterSpacing: 0.3,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.ShowRegisterBloodBank,
                              child: Text(
                                '  Click Here!',
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
                        const SizedBox(width: 50),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ForgotPasswordPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //Sign in button

                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
