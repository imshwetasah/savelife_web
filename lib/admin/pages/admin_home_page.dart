import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:savelife_web/admin/pages/admin%20_manage_donor_screen.dart';
import 'package:savelife_web/admin/pages/admin_add_bloodrequest_screen.dart';
import 'package:savelife_web/admin/pages/admin_add_hospital_screen.dart';
import 'package:savelife_web/admin/pages/admin_dashboard_screen.dart';
import 'package:savelife_web/admin/pages/admin_fulfilled_bloodrequests.dart';
import 'package:savelife_web/admin/pages/admin_manage_bloodbank_screen.dart';
import 'package:savelife_web/admin/pages/admin_manage_bloodrequest_screen.dart';
import 'package:savelife_web/admin/pages/admin_manage_hospital_screen.dart';
import 'package:savelife_web/admin/pages/admin_my_bloodrequest_screen.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});
  static const String id = "admin-home-screen";

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  Widget _selectedScreen = const AdminDashboardScreen();
  currentScreen(item) {
    switch (item.route) {
      case AdminDashboardScreen.id:
        setState(() {
          _selectedScreen = const AdminDashboardScreen();
        });
        break;

      case AdminManageDonorScreen.id:
        setState(() {
          _selectedScreen = const AdminManageDonorScreen();
        });
        break;

      case AdminManageBloodbankScreen.id:
        setState(() {
          _selectedScreen = const AdminManageBloodbankScreen();
        });
        break;

      case AdminAddBloodrequestScreen.id:
        setState(() {
          _selectedScreen = const AdminAddBloodrequestScreen();
        });
        break;

      case AdminManageBloodrequestScreen.id:
        setState(() {
          _selectedScreen = const AdminManageBloodrequestScreen();
        });
        break;

      case AdminMyBloodrequestScreen.id:
        setState(() {
          _selectedScreen = const AdminMyBloodrequestScreen();
        });
        break;

      case AdminAddHospitalScreen.id:
        setState(() {
          _selectedScreen = const AdminAddHospitalScreen();
        });
        break;

      case AdminManageHospitalScreen.id:
        setState(() {
          _selectedScreen = const AdminManageHospitalScreen();
        });
        break;

      case AdminFulfilledBloodRequests.id:
        setState(() {
          _selectedScreen = const AdminFulfilledBloodRequests();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: const Text(
          'SaveLife | Admin Panel',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
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
            route: AdminDashboardScreen.id,
            icon: Icons.dashboard,
          ),

          //Donors
          AdminMenuItem(
            title: 'Manage Donor',
            route: AdminManageDonorScreen.id,
            icon: Icons.person,
          ),

          //BloodBanks
          AdminMenuItem(
            title: 'Manage Blood Banks',
            route: AdminManageBloodbankScreen.id,
            icon: Icons.home,
          ),
          //Blood Requests
          AdminMenuItem(
            title: 'Blood Requests',
            icon: Icons.note_add,
            children: [
              AdminMenuItem(
                title: 'Add Blood Request',
                route: AdminAddBloodrequestScreen.id,
              ),
              AdminMenuItem(
                title: 'Manage Blood Request',
                route: AdminManageBloodrequestScreen.id,
              ),
              AdminMenuItem(
                title: 'My Blood Request',
                route: AdminMyBloodrequestScreen.id,
              ),
              AdminMenuItem(
                title: 'Fulfilled Blood Request',
                route: AdminFulfilledBloodRequests.id,
              ),
            ],
          ),

          //Hospitals
          AdminMenuItem(
            title: 'Hospital',
            icon: Icons.local_hospital,
            children: [
              AdminMenuItem(
                title: 'Add Hospital',
                route: AdminAddHospitalScreen.id,
              ),
              AdminMenuItem(
                title: 'Manage Hospital',
                route: AdminManageHospitalScreen.id,
              ),
            ],
          ),

          //Admins
          // AdminMenuItem(
          //   title: 'Admins',
          //   icon: Icons.admin_panel_settings,
          //   children: [
          //     AdminMenuItem(
          //       title: 'Add Admin',
          //       route: AdminAddAdminScreen.id,
          //     ),
          //     AdminMenuItem(
          //       title: 'Manage Admins',
          //       route: AdminManageAdminScreen.id,
          //     ),
          //   ],
          // ),
        ],
        selectedRoute: AdminHomePage.id,
        onSelected: (item) {
          currentScreen(item);
          // if (item.route != null) {
          //   Navigator.of(context).pushNamed(item.route!);
          // }
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

// Scaffold(
//       appBar: AppBar(
//         title: Text('Admin HomePage'),
//         actions: [
//           GestureDetector(
//               onTap: () {
//                 FirebaseAuth.instance.signOut();
//               },
//               child: const Icon(
//                 Icons.logout_rounded,
//                 size: 25,
//               )),
//         ],
//       ),
//       backgroundColor: Colors.amber,
//     );
