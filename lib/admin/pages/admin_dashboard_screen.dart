import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  static const String id = "admin-dashboard-screen";

  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int totalDonors = 0;
  int totalHospitals = 0;
  int totalBloodBanks = 0;
  int liveBloodRequests = 0;
  int fulfilledBloodRequests = 0;

  @override
  void initState() {
    super.initState();
    getCollectionCounts();
  }

  Future<void> getCollectionCounts() async {
    final totalDonorsQuery = FirebaseFirestore.instance.collection('donors');
    final totalHospitalsQuery =
        FirebaseFirestore.instance.collection('hospitals');
    final totalBloodBanksQuery =
        FirebaseFirestore.instance.collection('blood banks');
    final liveBloodRequestsQuery =
        FirebaseFirestore.instance.collection('blood request');
    final fulfilledBloodRequestsQuery =
        FirebaseFirestore.instance.collection('fulfilled requests');

    final totalDonorsCountFuture =
        totalDonorsQuery.get().then((value) => value.size);
    final totalHospitalsCountFuture =
        totalHospitalsQuery.get().then((value) => value.size);
    final totalBloodBanksCountFuture =
        totalBloodBanksQuery.get().then((value) => value.size);
    final liveBloodRequestsCountFuture =
        liveBloodRequestsQuery.get().then((value) => value.size);
    final fulfilledBloodRequestsCountFuture =
        fulfilledBloodRequestsQuery.get().then((value) => value.size);

    final counts = await Future.wait([
      totalDonorsCountFuture,
      totalHospitalsCountFuture,
      totalBloodBanksCountFuture,
      liveBloodRequestsCountFuture,
      fulfilledBloodRequestsCountFuture,
    ]);
    setState(() {
      totalDonors = counts[0];
      totalHospitals = counts[1];
      totalBloodBanks = counts[2];
      liveBloodRequests = counts[3];
      fulfilledBloodRequests = counts[4];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  //Add in this padding

                  //Total Donors
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Total Donors',
                                  style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 0.5,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${totalDonors}',
                                  style: const TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.person,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Total Hospitals
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Total Hospitals',
                                  style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 0.5,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${totalHospitals}',
                                  style: const TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.local_hospital,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Total Blood Banks
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Total BloodBanks',
                                  style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 0.5,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${totalBloodBanks}',
                                  style: const TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.home,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Total live blood requests
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Live Requests',
                                  style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 0.5,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${liveBloodRequests}',
                                  style: const TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.note_add,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //total fulfilled requests
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Fulfilled Requests',
                                  style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 0.5,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${fulfilledBloodRequests}',
                                  style: const TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.done_all_rounded,
                                  color: Colors.green,
                                  size: 40,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
