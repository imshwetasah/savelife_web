import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savelife_web/admin/pages/admin_home_page.dart';
import 'package:savelife_web/auth/auth_page.dart';
import 'package:savelife_web/bloodbank/pages/bloodbank_home_page.dart';
import 'package:savelife_web/pages/login_page.dart';
import 'package:savelife_web/pages/mobile_home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(snapshot.data!.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final userroles = snapshot.data?.data() as Map<String, dynamic>;
                if (userroles != null && userroles.containsKey('role')) {
                  if (userroles['role'] == 'admin') {
                    return const AdminHomePage();
                  } else if (userroles['role'] == 'bloodbank') {
                    return const BloodbankHomePage();
                  } else {
                    return const MobileHomePage();
                  }
                } else {
                  // handle the case where the userroles map or the 'role' key is null
                  return const Material(
                    child: Center(
                      child: Text('User role not found.'),
                    ),
                  );
                }
              }
              return const Material(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
