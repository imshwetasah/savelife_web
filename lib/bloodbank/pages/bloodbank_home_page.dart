import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:savelife_web/bloodbank/model/bloodbank_user_model.dart';
import 'package:savelife_web/bloodbank/model/bloodbank_user_repository.dart';
import 'package:savelife_web/bloodbank/pages/bloodbank_dashboard_screen.dart';
import 'package:savelife_web/bloodbank/pages/bloodbank_inventory_screen.dart';
import 'package:savelife_web/bloodbank/pages/bloodbank_profile_screen.dart';

class BloodbankHomePage extends StatefulWidget {
  const BloodbankHomePage({super.key});
  static const String id = "bloobank-home-screen";

  @override
  State<BloodbankHomePage> createState() => _BloodbankHomePageState();
}

class _BloodbankHomePageState extends State<BloodbankHomePage> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc =
        FirebaseFirestore.instance.collection('blood banks').doc(userId);
    final userData = await userDoc.get();
    final userName = userData.get('bloodbank name');
    setState(() {
      _userName = userName;
    });
  }

  Widget _selectedScreen = const BloodbankDashboardScreen();
  currentScreen(item) {
    switch (item.route) {
      case BloodbankDashboardScreen.id:
        setState(() {
          _selectedScreen = const BloodbankDashboardScreen();
        });
        break;

      case BloodbankInventoryScreen.id:
        setState(() {
          _selectedScreen = const BloodbankInventoryScreen();
        });
        break;

      case BloodbankProfileScreen.id:
        setState(() {
          _selectedScreen = const BloodbankProfileScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'SaveLife | BloodBank Panel',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            Text(
              _userName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.indigo),
            )
          ],
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Row(
                children: const [
                  Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.logout,
                    size: 25,
                  ),
                ],
              )),
        ],
      ),
      sideBar: SideBar(
        activeIconColor: Colors.red,
        textStyle: TextStyle(
            color: Colors.red[900],
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5),
        items: const [
          //Dashboard
          AdminMenuItem(
            title: 'Dashboard',
            route: BloodbankDashboardScreen.id,
            icon: Icons.dashboard,
          ),

          //Donors
          AdminMenuItem(
            title: 'Manage Inventory',
            route: BloodbankInventoryScreen.id,
            icon: Icons.person,
          ),

          //BloodBanks
          AdminMenuItem(
            title: 'Profile',
            route: BloodbankProfileScreen.id,
            icon: Icons.home,
          ),
        ],
        selectedRoute: BloodbankHomePage.id,
        onSelected: (item) {
          currentScreen(item);
        },
        // header: Container(
        //   height: 50,
        //   width: double.infinity,
        //   color: const Color(0xff444444),
        //   child: const Center(
        //     child: Text(
        //       'header',
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
        // footer: Container(
        //   height: 50,
        //   width: double.infinity,
        //   color: const Color(0xff444444),
        //   child: const Center(
        //     child: Text(
        //       'footer',
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ),
      //  sideBar: SideBar(items: , selectedRoute: .) ,
      body: SafeArea(
        child: _selectedScreen,
      ),
    );
  }
}
