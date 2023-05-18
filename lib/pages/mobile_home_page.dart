import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:savelife_web/constants/image_strings.dart';
import 'package:savelife_web/constants/text_strings.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.local_hospital),
        title: const Text(
          aAppName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(
                Icons.logout_rounded,
                size: 25,
              )),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                sorry,
                scale: 10,
              ),
              const SizedBox(height: 30),
              const Text(
                'You\'re a Donor!',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Please logout and login through mobile app',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: const BorderSide(color: Colors.transparent),
                      backgroundColor: Colors.red.shade500,
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
