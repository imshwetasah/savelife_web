import 'package:flutter/material.dart';
import 'package:savelife_web/pages/login_page.dart';
import 'package:savelife_web/pages/register_bloodbank_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show the login page
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        ShowRegisterBloodBank: toggleScreens,
      );
    } else {
      return RegisterBloodBankPage(
        showLoginPage: toggleScreens,
      );
    }
  }
}
