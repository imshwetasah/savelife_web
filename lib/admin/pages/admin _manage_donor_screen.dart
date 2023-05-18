import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:savelife_web/admin/pages/admin_edit_donor_screen.dart';
import 'package:savelife_web/functions/find_image.dart';

class AdminManageDonorScreen extends StatefulWidget {
  static const String id = "admin-manage-donor-screen";
  const AdminManageDonorScreen({super.key});

  @override
  State<AdminManageDonorScreen> createState() => _AdminManageDonorScreenState();
}

class _AdminManageDonorScreenState extends State<AdminManageDonorScreen> {
  String name = "";
  // ignore: prefer_final_fields
  CollectionReference _referenceDonors =
      FirebaseFirestore.instance.collection('donors');
  late Stream<QuerySnapshot> _streamDonors;
  @override
  void initState() {
    super.initState();
    _streamDonors =
        _referenceDonors.orderBy('first name', descending: false).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.menu),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'All Donors',
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 400,
              child: Card(
                child: TextField(
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                      hintText: 'Donor Search...',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
      ),
      body: StreamBuilder(
        stream: _streamDonors,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ignore: prefer_const_constructors
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 250),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          //for Search through name module
          //Variable Creations
          //requests stores all snapshot docs
          var donors = snapshot.data!.docs;

          //List View Building starts
          return ListView.builder(
            itemCount: donors.length,
            itemBuilder: (context, index) {
              var docId = snapshot.data!.docs[index].id;
              var firstName = snapshot.data!.docs[index]['first name'];
              var lastName = snapshot.data!.docs[index]['last name'];
              var bloodGroup = snapshot.data!.docs[index]['blood group'];
              var gender = snapshot.data!.docs[index]['gender'];
              var phone = snapshot.data!.docs[index]['phone'];
              var city = snapshot.data!.docs[index]['city'];
              var email = snapshot.data!.docs[index]['email'];

              var data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              if (name.isEmpty) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SizedBox(
                    width: 320,
                    height: 170,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300]),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      findImage(donors[index]['blood group']),
                                      scale: 2.2,
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                                const SizedBox(width: 75),
                                //full name bg required etc

                                SizedBox(
                                  width: 350,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${donors[index]['first name']}  ${donors[index]['last name']}",
                                        style: txtTheme.displayMedium?.apply(
                                            fontSizeFactor: 1.1,
                                            color: Colors.indigo[800]),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Blood Group: ${donors[index]['blood group']}",
                                        style: txtTheme.headlineMedium?.apply(
                                            fontSizeFactor: 1,
                                            color: Colors.red),
                                      ),
                                      const SizedBox(height: 5),

                                      //Gender
                                      Row(
                                        children: [
                                          Text(
                                            "Gender: ",
                                            style: txtTheme.headlineMedium
                                                ?.apply(fontSizeFactor: 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${donors[index]['gender']}",
                                            style: txtTheme.headlineMedium
                                                ?.apply(
                                                    fontSizeFactor: 1,
                                                    color: Colors.indigo[800]),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),

                                      //City
                                      Row(
                                        children: [
                                          Text(
                                            "City: ",
                                            style: txtTheme.headlineMedium
                                                ?.apply(fontSizeFactor: 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${donors[index]['city']}",
                                            style: txtTheme.headlineMedium
                                                ?.apply(
                                                    fontSizeFactor: 1,
                                                    color: Colors.indigo[800]),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),

                                //Contact hospital and remarks
                                const SizedBox(width: 25),
                                SizedBox(
                                  width: 500,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(height: 5),

                                      //Contact
                                      Row(
                                        children: [
                                          Text(
                                            "Contact: ",
                                            style: txtTheme.headlineMedium
                                                ?.apply(fontSizeFactor: 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "+977-${donors[index]['phone']}",
                                            style: txtTheme.headlineMedium
                                                ?.apply(
                                                    fontSizeFactor: 1,
                                                    color: Colors.indigo[800]),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      //Hospital

                                      const SizedBox(height: 5),
                                      //Remarks
                                      Row(
                                        children: [
                                          Text(
                                            "Email: ",
                                            style: txtTheme.headlineMedium
                                                ?.apply(fontSizeFactor: 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${donors[index]['email']}",
                                            style: txtTheme.headlineMedium
                                                ?.apply(
                                                    fontSizeFactor: 1,
                                                    color: Colors.indigo[800]),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),

                                // Delete  and Mark as Done button
                                const SizedBox(width: 70),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 60,
                                      child: TextButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            elevation: 0.0,
                                            side: const BorderSide(
                                                color: Colors.transparent),
                                            backgroundColor:
                                                Colors.green.shade500),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminEditDonorScreen(
                                                        firstName: firstName,
                                                        lastName: lastName,
                                                        bloodGroup: bloodGroup,
                                                        gender: gender,
                                                        phone: phone,
                                                        city: city,
                                                        email: email,
                                                        docId: docId,
                                                      )));
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              if ('${data['first name']} ${data['last name']}'
                  .toString()
                  .toLowerCase()
                  .startsWith(name.toLowerCase())) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SizedBox(
                    width: 320,
                    height: 170,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300]),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      findImage(donors[index]['blood group']),
                                      scale: 2.2,
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                                const SizedBox(width: 75),
                                //full name bg required etc

                                SizedBox(
                                  width: 350,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${donors[index]['first name']}  ${donors[index]['last name']}",
                                        style: txtTheme.displayMedium?.apply(
                                            fontSizeFactor: 1.1,
                                            color: Colors.indigo[800]),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Blood Group: ${donors[index]['blood group']}",
                                        style: txtTheme.headlineMedium?.apply(
                                            fontSizeFactor: 1,
                                            color: Colors.red),
                                      ),
                                      const SizedBox(height: 5),

                                      //Gender
                                      Row(
                                        children: [
                                          Text(
                                            "Gender: ",
                                            style: txtTheme.headlineMedium
                                                ?.apply(fontSizeFactor: 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${donors[index]['gender']}",
                                            style: txtTheme.headlineMedium
                                                ?.apply(
                                                    fontSizeFactor: 1,
                                                    color: Colors.indigo[800]),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),

                                      //City
                                      Row(
                                        children: [
                                          Text(
                                            "City: ",
                                            style: txtTheme.headlineMedium
                                                ?.apply(fontSizeFactor: 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${donors[index]['city']}",
                                            style: txtTheme.headlineMedium
                                                ?.apply(
                                                    fontSizeFactor: 1,
                                                    color: Colors.indigo[800]),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),

                                //Contact hospital and remarks
                                const SizedBox(width: 25),
                                SizedBox(
                                  width: 500,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(height: 5),

                                      //Contact
                                      Row(
                                        children: [
                                          Text(
                                            "Contact: ",
                                            style: txtTheme.headlineMedium
                                                ?.apply(fontSizeFactor: 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "+977-${donors[index]['phone']}",
                                            style: txtTheme.headlineMedium
                                                ?.apply(
                                                    fontSizeFactor: 1,
                                                    color: Colors.indigo[800]),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      //Hospital

                                      const SizedBox(height: 5),
                                      //Remarks
                                      Row(
                                        children: [
                                          Text(
                                            "Email: ",
                                            style: txtTheme.headlineMedium
                                                ?.apply(fontSizeFactor: 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${donors[index]['email']}",
                                            style: txtTheme.headlineMedium
                                                ?.apply(
                                                    fontSizeFactor: 1,
                                                    color: Colors.indigo[800]),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),

                                // Delete  and Mark as Done button
                                const SizedBox(width: 70),
                                Column(
                                  children: [
                                    // ElevatedButton(
                                    //   style: ElevatedButton.styleFrom(
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(15),
                                    //       ),
                                    //       elevation: 0.0,
                                    //       side: const BorderSide(
                                    //           color: Colors.transparent),
                                    //       backgroundColor:
                                    //           Colors.lightGreen.shade500),
                                    //   onPressed: () async {
                                    //     final Uri url = Uri(
                                    //       scheme: 'tel',
                                    //       path: "+977${requests[index]['phone']}",
                                    //     );
                                    //     if (await canLaunchUrl(url)) {
                                    //       await launchUrl(url);
                                    //     } //else {
                                    //     //   print('cannot launch');
                                    //     // }
                                    //   },
                                    //   child: const Text(
                                    //     'Call',
                                    //     style: TextStyle(
                                    //         fontSize: 18, letterSpacing: 0.6),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 50,
                                      width: 60,
                                      child: TextButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            elevation: 0.0,
                                            side: const BorderSide(
                                                color: Colors.transparent),
                                            backgroundColor:
                                                Colors.green.shade500),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminEditDonorScreen(
                                                        firstName: firstName,
                                                        lastName: lastName,
                                                        bloodGroup: bloodGroup,
                                                        gender: gender,
                                                        phone: phone,
                                                        city: city,
                                                        email: email,
                                                        docId: docId,
                                                      )));
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
