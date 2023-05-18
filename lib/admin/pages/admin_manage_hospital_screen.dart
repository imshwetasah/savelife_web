import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:savelife_web/admin/pages/admin_edit_hospital_screen.dart';

class AdminManageHospitalScreen extends StatefulWidget {
  static const String id = "admin-manage-hospital-screen";
  const AdminManageHospitalScreen({super.key});

  @override
  State<AdminManageHospitalScreen> createState() =>
      _AdminManageHospitalScreenState();
}

class _AdminManageHospitalScreenState extends State<AdminManageHospitalScreen> {
  String name = "";
  final CollectionReference _referenceHospitals =
      FirebaseFirestore.instance.collection('hospitals');
  late Stream<QuerySnapshot> _streamHospitals;
  @override
  void initState() {
    super.initState();
    _streamHospitals = _referenceHospitals
        .orderBy('hospital name', descending: false)
        .snapshots();
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
              'All Hospitals',
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
                      hintText: 'Hospitals Search...',
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
        stream: _streamHospitals,
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

          //Variable Creations
          //requests stores all snapshot docs
          var donors = snapshot.data!.docs;

          //List View Building starts
          return ListView.builder(
            itemCount: donors.length,
            itemBuilder: (context, index) {
              var docId = snapshot.data!.docs[index].id;
              var hospitalName = snapshot.data!.docs[index]['hospital name'];
              var phone = snapshot.data!.docs[index]['phone'];
              var city = snapshot.data!.docs[index]['city'];
              var address = snapshot.data!.docs[index]['address'];
              var latitude = snapshot.data!.docs[index]['latitude'];
              var longitude = snapshot.data!.docs[index]['longitude'];

              var data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              if (name.isEmpty) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SizedBox(
                    width: 320,
                    height: 160,
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
                            Text(
                              "${donors[index]['hospital name']}",
                              style: txtTheme.displayMedium?.apply(
                                  fontSizeFactor: 1.1,
                                  color: Colors.indigo[800]),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: const [
                                    Icon(
                                      Icons.local_hospital,
                                      size: 60,
                                      color: Colors.red,
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                ),
                                const SizedBox(width: 75),

                                //Blood bank name bg required etc

                                SizedBox(
                                  width: 350,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                                      //Full address
                                      Row(
                                        children: [
                                          Text(
                                            "Full Address: ",
                                            style: txtTheme.headlineMedium
                                                ?.apply(fontSizeFactor: 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${donors[index]['address']}",
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
                                    ],
                                  ),
                                ),

                                // Delete  and Mark as Done button
                                const SizedBox(width: 30),

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
                                        backgroundColor: Colors.green.shade500),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminEditHospitalScreen(
                                                      hospitalName:
                                                          hospitalName,
                                                      phone: phone,
                                                      city: city,
                                                      address: address,
                                                      latitude: latitude,
                                                      longitude: longitude,
                                                      docId: docId)));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (data['hospital name']
                  .toString()
                  .toLowerCase()
                  .startsWith(name.toLowerCase())) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SizedBox(
                    width: 320,
                    height: 160,
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
                            Text(
                              "${donors[index]['hospital name']}",
                              style: txtTheme.displayMedium?.apply(
                                  fontSizeFactor: 1.1,
                                  color: Colors.indigo[800]),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: const [
                                    Icon(
                                      Icons.local_hospital,
                                      size: 60,
                                      color: Colors.red,
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                ),
                                const SizedBox(width: 75),

                                //Blood bank name bg required etc

                                SizedBox(
                                  width: 350,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                                      //Full address
                                      Row(
                                        children: [
                                          Text(
                                            "Full Address: ",
                                            style: txtTheme.headlineMedium
                                                ?.apply(fontSizeFactor: 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${donors[index]['address']}",
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
                                    ],
                                  ),
                                ),

                                // Delete  and Mark as Done button
                                const SizedBox(width: 30),

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
                                        backgroundColor: Colors.green.shade500),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminEditHospitalScreen(
                                                      hospitalName:
                                                          hospitalName,
                                                      phone: phone,
                                                      city: city,
                                                      address: address,
                                                      latitude: latitude,
                                                      longitude: longitude,
                                                      docId: docId)));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
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
