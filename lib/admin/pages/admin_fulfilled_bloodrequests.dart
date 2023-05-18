import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:savelife_web/functions/find_image.dart';
import 'package:z_time_ago/z_time_ago.dart';

class AdminFulfilledBloodRequests extends StatefulWidget {
  static const String id = "admin-fulfilled-bloodrequest-screen";
  const AdminFulfilledBloodRequests({super.key});

  @override
  State<AdminFulfilledBloodRequests> createState() =>
      _AdminFulfilledBloodRequestsState();
}

class _AdminFulfilledBloodRequestsState
    extends State<AdminFulfilledBloodRequests> {
  final CollectionReference _referenceBloodRequests =
      FirebaseFirestore.instance.collection('fulfilled requests');
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
          'All Fulfilled Blood Requests',
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

                              const SizedBox(width: 70),
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
