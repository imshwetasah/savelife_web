import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BloodbankDashboardScreen extends StatefulWidget {
  const BloodbankDashboardScreen({super.key});
  static const String id = "bloodbank-dashboard-screen";

  @override
  State<BloodbankDashboardScreen> createState() =>
      _BloodbankDashboardScreenState();
}

class _BloodbankDashboardScreenState extends State<BloodbankDashboardScreen> {
  int liveBloodRequests = 0;
  int fulfilledBloodRequests = 0;

  @override
  void initState() {
    super.initState();
    getCollectionCounts();
  }

  Future<void> getCollectionCounts() async {
    final liveBloodRequestsQuery =
        FirebaseFirestore.instance.collection('blood request');
    final fulfilledBloodRequestsQuery =
        FirebaseFirestore.instance.collection('fulfilled requests');

    final liveBloodRequestsCountFuture =
        liveBloodRequestsQuery.get().then((value) => value.size);
    final fulfilledBloodRequestsCountFuture =
        fulfilledBloodRequestsQuery.get().then((value) => value.size);

    final counts = await Future.wait([
      liveBloodRequestsCountFuture,
      fulfilledBloodRequestsCountFuture,
    ]);
    setState(() {
      liveBloodRequests = counts[0];
      fulfilledBloodRequests = counts[1];
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
