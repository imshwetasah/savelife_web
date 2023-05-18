import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:savelife_web/bloodbank/controller/bloodbank_profile_controller.dart';
import 'package:savelife_web/bloodbank/model/bloodbank_user_model.dart';
import 'package:savelife_web/bloodbank/model/bloodbank_user_repository.dart';
import 'package:savelife_web/constants/colors.dart';

class BloodbankProfileScreen extends StatefulWidget {
  const BloodbankProfileScreen({super.key});
  static const String id = "bloodbank-profile-screen";

  @override
  State<BloodbankProfileScreen> createState() => _BloodbankProfileScreenState();
}

class _BloodbankProfileScreenState extends State<BloodbankProfileScreen> {
  final bloodbankUser = FirebaseAuth.instance.currentUser;
  final _bloodbankUserRepo = BloodbankUserRepository();
  getUserData() {
    final email = bloodbankUser!.email;
    if (email != null) {
      return _bloodbankUserRepo.getBloodbankUserDetails(email);
    }
  }

  // ignore: non_constant_identifier_names
  DateConverter(String date) {
    int length = date.length;
    String newDate = '';
    for (int i = 0; i < 10; i++) {
      newDate += date[i];
    }
    return newDate;
  }

  @override
  Widget build(BuildContext context) {
    final controller = BloodbankProfileController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        backgroundColor: Colors.transparent,
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: FutureBuilder(
            future: controller.getBloodBankUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  BloodbankUserModel userData =
                      snapshot.data as BloodbankUserModel;
                  //Profile data
                  return Center(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 1),
                        const SizedBox(
                          width: 90,
                          height: 90,
                          child: Icon(
                            Icons.home,
                            size: 70,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: Text(
                              "Created on: ${DateConverter(bloodbankUser!.metadata.creationTime.toString())}",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),

                        const SizedBox(height: 1),
                        const Divider(),
                        //Information
                        //Name
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: aAccentColor.withOpacity(0.1),
                            ),
                            child: const Icon(
                              Icons.home,
                              color: Colors.red,
                            ),
                          ),
                          title: Text(
                            userData.name,
                            style: const TextStyle(
                                fontSize: 28,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5),
                          ),
                        ),

                        const SizedBox(height: 30),

                        Row(
                          children: [
                            SizedBox(
                              width: 500,
                              child: Column(
                                children: [
                                  //Email
                                  ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: aAccentColor.withOpacity(0.1),
                                      ),
                                      child: const Icon(
                                        Icons.mail,
                                        color: Colors.red,
                                      ),
                                    ),
                                    title: Text(
                                      userData.email,
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  //Phone
                                  ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: aAccentColor.withOpacity(0.1),
                                      ),
                                      child: const Icon(
                                        Icons.phone,
                                        color: Colors.red,
                                      ),
                                    ),
                                    title: Text(
                                      userData.phone,
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 500,
                              child: Column(
                                children: [
                                  //City
                                  ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: aAccentColor.withOpacity(0.1),
                                      ),
                                      child: const Icon(
                                        Icons.location_city,
                                        color: Colors.red,
                                      ),
                                    ),
                                    title: Text(
                                      userData.city,
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  //FUll address
                                  ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: aAccentColor.withOpacity(0.1),
                                      ),
                                      child: const Icon(
                                        Icons.location_on_rounded,
                                        color: Colors.red,
                                      ),
                                    ),
                                    title: Text(
                                      userData.fullAddress,
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     SizedBox(
                        //       height: 50,
                        //       width: 200,
                        //       child: ElevatedButton(
                        //           style: ElevatedButton.styleFrom(
                        //             shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(10),
                        //             ),
                        //             side: const BorderSide(
                        //               color: Colors.transparent,
                        //             ),
                        //             elevation: 0.0,
                        //             backgroundColor: Colors.redAccent,
                        //           ),
                        //           onPressed: () async {
                        //             final String userId =
                        //                 FirebaseAuth.instance.currentUser!.uid;
                        //             await FirebaseAuth.instance.currentUser!
                        //                 .delete();
                        //             await FirebaseAuth.instance.signOut();
                        //             await FirebaseFirestore.instance
                        //                 .collection('blood banks')
                        //                 .doc(userId)
                        //                 .delete();
                        //             await FirebaseFirestore.instance
                        //                 .collection('users')
                        //                 .doc(userId)
                        //                 .delete();
                        //           },
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceEvenly,
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.center,
                        //             // ignore: prefer_const_literals_to_create_immutables
                        //             children: [
                        //               const Icon(Icons.delete_forever),
                        //               const Text(
                        //                 ' Delete Account ',
                        //                 style: TextStyle(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.bold,
                        //                 ),
                        //               ),
                        //             ],
                        //           )),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              } else {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 250.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
