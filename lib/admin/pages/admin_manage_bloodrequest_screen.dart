import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:savelife_web/admin/pages/admin_home_page.dart';
import 'package:savelife_web/functions/find_image.dart';
import 'package:z_time_ago/z_time_ago.dart';

class AdminManageBloodrequestScreen extends StatefulWidget {
  static const String id = "admin-manage-bloodrequest-screen";
  const AdminManageBloodrequestScreen({super.key});

  @override
  State<AdminManageBloodrequestScreen> createState() =>
      _AdminManageBloodrequestScreenState();
}

class _AdminManageBloodrequestScreenState
    extends State<AdminManageBloodrequestScreen> {
  // ignore: prefer_final_fields
  CollectionReference _referenceBloodRequests =
      FirebaseFirestore.instance.collection('blood request');
  late Stream<QuerySnapshot> _streamBloodRequests;
  @override
  void initState() {
    super.initState();
    _streamBloodRequests = _referenceBloodRequests
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.menu),
        title: const Text(
          'All Live Blood Requests',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
      ),
      body: StreamBuilder(
        stream: _streamBloodRequests,
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
          var requests = snapshot.data!.docs;

          //List View Building starts
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              Timestamp date = snapshot.data!.docs[index]['timestamp'];
              var finalDate = DateTime.parse(date.toDate().toString());
              var docId = snapshot.data!.docs[index].id;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: SizedBox(
                  width: 320,
                  height: 200,
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
                                    findImage(requests[index]['blood group']),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${requests[index]['full name']}",
                                      style: txtTheme.displayMedium?.apply(
                                          fontSizeFactor: 1.1,
                                          color: Colors.indigo[800]),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Blood Required: ${requests[index]['blood group']}",
                                      style: txtTheme.headlineMedium?.apply(
                                          fontSizeFactor: 1, color: Colors.red),
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
                                          "${requests[index]['gender']}",
                                          style: txtTheme.headlineMedium?.apply(
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
                                          "${requests[index]['city']}",
                                          style: txtTheme.headlineMedium?.apply(
                                              fontSizeFactor: 1,
                                              color: Colors.indigo[800]),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Posted: ${ZTimeAgo().getTimeAgo(date: finalDate, language: Language.english)}",
                                      style: txtTheme.bodySmall?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.orange.shade800),
                                    )
                                  ],
                                ),
                              ),

                              //Contact hospital and remarks
                              const SizedBox(width: 25),
                              SizedBox(
                                width: 500,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          "+977-${requests[index]['phone']}",
                                          style: txtTheme.headlineMedium?.apply(
                                              fontSizeFactor: 1,
                                              color: Colors.indigo[800]),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    //Hospital
                                    Row(
                                      children: [
                                        Text(
                                          "Hospital: ",
                                          style: txtTheme.headlineMedium
                                              ?.apply(fontSizeFactor: 1),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${requests[index]['hospital']}",
                                          style: txtTheme.headlineMedium?.apply(
                                              fontSizeFactor: 1,
                                              color: Colors.indigo[800]),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    //Remarks
                                    Row(
                                      children: [
                                        Text(
                                          "Remarks: ",
                                          style: txtTheme.headlineMedium
                                              ?.apply(fontSizeFactor: 1),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${requests[index]['remarks']}",
                                          style: txtTheme.headlineMedium?.apply(
                                              fontSizeFactor: 1,
                                              color: Colors.indigo[800]),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    //Posted By user
                                    Row(
                                      children: [
                                        Text(
                                          "Posted By User: ",
                                          style: txtTheme.headlineMedium
                                              ?.apply(fontSizeFactor: 1),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${requests[index]['added by user']}",
                                          style: txtTheme.headlineMedium?.apply(
                                              fontSizeFactor: 1,
                                              color: Colors.indigo[800]),
                                        ),
                                      ],
                                    ),
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
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('fulfilled requests')
                                            .doc()
                                            .set({
                                          'added by user': requests[index]
                                              ['added by user'],
                                          'blood group': requests[index]
                                              ['blood group'],
                                          'city': requests[index]['city'],
                                          'full name': requests[index]
                                              ['full name'],
                                          'gender': requests[index]['gender'],
                                          'hospital': requests[index]
                                              ['hospital'],
                                          'phone': requests[index]['phone'],
                                          'remarks': requests[index]['remarks'],
                                          'timestamp': requests[index]
                                              ['timestamp'],
                                          'status': 'fulfilled',
                                        });
                                        await FirebaseFirestore.instance
                                            .collection('blood request')
                                            .doc(docId)
                                            .delete();
                                        DelayedMultiDragGestureRecognizer;
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const AdminHomePage();
                                        }));
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              content: Text(
                                                'Request Marked as Fulfilled Successfully!',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.done_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
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
                                          backgroundColor: Colors.red.shade900),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('blood request')
                                            .doc(docId)
                                            .delete();
                                        DelayedMultiDragGestureRecognizer;
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const AdminHomePage();
                                        }));
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              content: Text(
                                                'Request Deleted Successfully!',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
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
            },
          );
        },
      ),
    );
  }
}
