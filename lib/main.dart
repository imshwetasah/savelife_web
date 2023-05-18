import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:savelife_web/admin/pages/admin%20_manage_donor_screen.dart';
import 'package:savelife_web/admin/pages/admin_add_bloodrequest_screen.dart';
import 'package:savelife_web/admin/pages/admin_add_hospital_screen.dart';
import 'package:savelife_web/admin/pages/admin_dashboard_screen.dart';
import 'package:savelife_web/admin/pages/admin_fulfilled_bloodrequests.dart';
import 'package:savelife_web/admin/pages/admin_home_page.dart';
import 'package:savelife_web/admin/pages/admin_manage_bloodbank_screen.dart';
import 'package:savelife_web/admin/pages/admin_manage_bloodrequest_screen.dart';
import 'package:savelife_web/admin/pages/admin_manage_hospital_screen.dart';
import 'package:savelife_web/admin/pages/admin_my_bloodrequest_screen.dart';
import 'package:savelife_web/auth/main_page.dart';
import 'package:savelife_web/bloodbank/pages/bloodbank_dashboard_screen.dart';
import 'package:savelife_web/bloodbank/pages/bloodbank_home_page.dart';
import 'package:savelife_web/bloodbank/pages/bloodbank_inventory_screen.dart';
import 'package:savelife_web/bloodbank/pages/bloodbank_profile_screen.dart';
import 'package:savelife_web/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB-qDRESfMwZiiP88GxFYNesvZTti1MESs",
          authDomain: "savelife-76fea.firebaseapp.com",
          databaseURL:
              "https://savelife-76fea-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "savelife-76fea",
          storageBucket: "savelife-76fea.appspot.com",
          messagingSenderId: "221714316217",
          appId: "1:221714316217:web:fcc969a716c3f7e9d09468",
          measurementId: "G-CRG5T2Z157"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'savelife',
      theme: ATheme.lightTheme,
      darkTheme: ATheme.darkTheme,
      themeMode: ThemeMode.light,
      routes: {
        AdminHomePage.id: (context) => const AdminHomePage(),
        AdminAddBloodrequestScreen.id: (context) =>
            const AdminAddBloodrequestScreen(),
        AdminAddHospitalScreen.id: (context) => const AdminAddHospitalScreen(),
        AdminDashboardScreen.id: (context) => const AdminDashboardScreen(),
        AdminManageBloodbankScreen.id: (context) =>
            const AdminManageBloodbankScreen(),
        AdminManageBloodrequestScreen.id: (context) =>
            const AdminManageBloodrequestScreen(),
        AdminMyBloodrequestScreen.id: (context) =>
            const AdminMyBloodrequestScreen(),
        AdminManageDonorScreen.id: (context) => const AdminManageDonorScreen(),
        AdminManageHospitalScreen.id: (context) =>
            const AdminManageHospitalScreen(),
        AdminFulfilledBloodRequests.id: (context) =>
            const AdminFulfilledBloodRequests(),
        BloodbankHomePage.id: (context) => const BloodbankHomePage(),
        BloodbankDashboardScreen.id: (context) =>
            const BloodbankDashboardScreen(),
        BloodbankInventoryScreen.id: (context) =>
            const BloodbankInventoryScreen(),
        BloodbankProfileScreen.id: (context) => const BloodbankProfileScreen(),
      },
      home: const MainPage(),
    );
  }
}
