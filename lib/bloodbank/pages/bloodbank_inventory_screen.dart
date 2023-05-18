import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:savelife_web/bloodbank/controller/bloodbank_profile_controller.dart';
import 'package:savelife_web/bloodbank/model/bloodbank_user_model.dart';
import 'package:savelife_web/bloodbank/model/bloodbank_user_repository.dart';
import 'package:savelife_web/constants/colors.dart';
import 'package:savelife_web/constants/image_strings.dart';

class BloodbankInventoryScreen extends StatefulWidget {
  const BloodbankInventoryScreen({super.key});
  static const String id = "bloodbank-inventory-screen";

  @override
  State<BloodbankInventoryScreen> createState() =>
      _BloodbankInventoryScreenState();
}

class _BloodbankInventoryScreenState extends State<BloodbankInventoryScreen> {
  late TextEditingController countController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    countController.dispose();
    super.dispose();
  }

  final bloodbankUser = FirebaseAuth.instance.currentUser;
  final _bloodbankUserRepo = BloodbankUserRepository();
  getUserData() {
    final email = bloodbankUser!.email;
    if (email != null) {
      return _bloodbankUserRepo.getBloodbankUserDetails(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = BloodbankProfileController();
    String count = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory Management',
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

                  var aPosCount = userData.bgApos.toString();
                  var aNegCount = userData.bgAneg.toString();

                  var bPosCount = userData.bgBpos.toString();
                  var bNegCount = userData.bgBneg.toString();

                  var oPosCount = userData.bgOpos.toString();
                  var oNegCount = userData.bgOneg.toString();

                  var abPosCount = userData.bgABpos.toString();
                  var abNegCount = userData.bgABneg.toString();

                  //Inventory data
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
                            Icons.inventory,
                            size: 70,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 10),

                        //Information

                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            //A+ blood count
                            SizedBox(
                              height: 100,
                              width: 320,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                height: 300,
                                width: 400,
                                child: ListTile(
                                  //change here for logo
                                  leading: Image.asset(
                                    aAPositive,
                                    scale: 2.4,
                                  ),
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        //change here for blood bag count
                                        aPosCount,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'units',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 30),
                                      SizedBox(
                                        height: 50,
                                        width: 50,
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
                                                  Colors.grey[800]),
                                          onPressed: () async {
                                            final count = showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                  //change the text for hint
                                                  'Edit A+ Blood Bags Count',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: TextField(
                                                  controller: countController,
                                                  decoration: InputDecoration(
                                                    //change the text for hint
                                                    hintText: userData.bgApos
                                                        .toString(),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            side: BorderSide(
                                                                color:
                                                                    Colors.red),
                                                          ))),
                                                      onPressed: () async {
                                                        final userId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        //change update bloodgroup
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'blood banks')
                                                            .doc(userId)
                                                            .update({
                                                          'A+ Count':
                                                              double.parse(
                                                                  countController
                                                                      .text
                                                                      .trim()),
                                                        });
                                                        setState(() {
                                                          //cahnge count variable
                                                          aPosCount =
                                                              countController
                                                                  .text
                                                                  .trim();
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop(countController
                                                                .text);
                                                        countController.clear();
                                                      },
                                                      child:
                                                          const Text('Submit'))
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //
                            //A- blood count
                            SizedBox(
                              height: 100,
                              width: 320,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                height: 300,
                                width: 400,
                                child: ListTile(
                                  //change here for logo
                                  leading: Image.asset(
                                    aANegative,
                                    scale: 2.4,
                                  ),
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        //change here for blood bag count
                                        aNegCount,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'units',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 30),
                                      SizedBox(
                                        height: 50,
                                        width: 50,
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
                                                  Colors.grey[800]),
                                          onPressed: () async {
                                            final count = showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                  //change the text for hint
                                                  'Edit A- Blood Bags Count',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: TextField(
                                                  controller: countController,
                                                  decoration: InputDecoration(
                                                    //change the text for hint
                                                    hintText: userData.bgAneg
                                                        .toString(),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            side: BorderSide(
                                                                color:
                                                                    Colors.red),
                                                          ))),
                                                      onPressed: () async {
                                                        final userId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        //change update bloodgroup
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'blood banks')
                                                            .doc(userId)
                                                            .update({
                                                          'A- Count':
                                                              double.parse(
                                                                  countController
                                                                      .text
                                                                      .trim()),
                                                        });
                                                        setState(() {
                                                          //cahnge count variable
                                                          aNegCount =
                                                              countController
                                                                  .text
                                                                  .trim();
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop(countController
                                                                .text);
                                                        countController.clear();
                                                      },
                                                      child:
                                                          const Text('Submit'))
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //
                            //B+ blood count
                            SizedBox(
                              height: 100,
                              width: 320,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                height: 300,
                                width: 400,
                                child: ListTile(
                                  //change here for logo
                                  leading: Image.asset(
                                    aBPositive,
                                    scale: 2.4,
                                  ),
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        //change here for blood bag count
                                        bPosCount,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'units',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 30),
                                      SizedBox(
                                        height: 50,
                                        width: 50,
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
                                                  Colors.grey[800]),
                                          onPressed: () async {
                                            final count = showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                  //change the text for hint
                                                  'Edit B+ Blood Bags Count',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: TextField(
                                                  controller: countController,
                                                  decoration: InputDecoration(
                                                    //change the text for hint
                                                    hintText: userData.bgBpos
                                                        .toString(),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            side: BorderSide(
                                                                color:
                                                                    Colors.red),
                                                          ))),
                                                      onPressed: () async {
                                                        final userId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        //change update bloodgroup
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'blood banks')
                                                            .doc(userId)
                                                            .update({
                                                          'B+ Count':
                                                              double.parse(
                                                                  countController
                                                                      .text
                                                                      .trim()),
                                                        });
                                                        setState(() {
                                                          //cahnge count variable
                                                          bPosCount =
                                                              countController
                                                                  .text
                                                                  .trim();
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop(countController
                                                                .text);
                                                        countController.clear();
                                                      },
                                                      child:
                                                          const Text('Submit'))
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //
                            //B- blood count
                            SizedBox(
                              height: 100,
                              width: 320,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                height: 300,
                                width: 400,
                                child: ListTile(
                                  //change here for logo
                                  leading: Image.asset(
                                    aBNegative,
                                    scale: 2.4,
                                  ),
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        //change here for blood bag count
                                        bNegCount,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'units',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 30),
                                      SizedBox(
                                        height: 50,
                                        width: 50,
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
                                                  Colors.grey[800]),
                                          onPressed: () async {
                                            final count = showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                  //change the text for hint
                                                  'Edit B- Blood Bags Count',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: TextField(
                                                  controller: countController,
                                                  decoration: InputDecoration(
                                                    //change the text for hint
                                                    hintText: userData.bgBneg
                                                        .toString(),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            side: BorderSide(
                                                                color:
                                                                    Colors.red),
                                                          ))),
                                                      onPressed: () async {
                                                        final userId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        //change update bloodgroup
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'blood banks')
                                                            .doc(userId)
                                                            .update({
                                                          'B- Count':
                                                              double.parse(
                                                                  countController
                                                                      .text
                                                                      .trim()),
                                                        });
                                                        setState(() {
                                                          //cahnge count variable
                                                          bNegCount =
                                                              countController
                                                                  .text
                                                                  .trim();
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop(countController
                                                                .text);
                                                        countController.clear();
                                                      },
                                                      child:
                                                          const Text('Submit'))
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //
                            //O+ blood count
                            SizedBox(
                              height: 100,
                              width: 320,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                height: 300,
                                width: 400,
                                child: ListTile(
                                  //change here for logo
                                  leading: Image.asset(
                                    aOPositive,
                                    scale: 2.4,
                                  ),
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        //change here for blood bag count
                                        oPosCount,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'units',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 30),
                                      SizedBox(
                                        height: 50,
                                        width: 50,
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
                                                  Colors.grey[800]),
                                          onPressed: () async {
                                            final count = showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                  //change the text for hint
                                                  'Edit O+ Blood Bags Count',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: TextField(
                                                  controller: countController,
                                                  decoration: InputDecoration(
                                                    //change the text for hint
                                                    hintText: userData.bgOpos
                                                        .toString(),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            side: BorderSide(
                                                                color:
                                                                    Colors.red),
                                                          ))),
                                                      onPressed: () async {
                                                        final userId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        //change update bloodgroup
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'blood banks')
                                                            .doc(userId)
                                                            .update({
                                                          'O+ Count':
                                                              double.parse(
                                                                  countController
                                                                      .text
                                                                      .trim()),
                                                        });
                                                        setState(() {
                                                          //cahnge count variable
                                                          oPosCount =
                                                              countController
                                                                  .text
                                                                  .trim();
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop(countController
                                                                .text);
                                                        countController.clear();
                                                      },
                                                      child:
                                                          const Text('Submit'))
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //
                            //O- blood count
                            SizedBox(
                              height: 100,
                              width: 320,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                height: 300,
                                width: 400,
                                child: ListTile(
                                  //change here for logo
                                  leading: Image.asset(
                                    aONegative,
                                    scale: 2.4,
                                  ),
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        //change here for blood bag count
                                        oNegCount,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'units',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 30),
                                      SizedBox(
                                        height: 50,
                                        width: 50,
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
                                                  Colors.grey[800]),
                                          onPressed: () async {
                                            final count = showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                  //change the text for hint
                                                  'Edit O- Blood Bags Count',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: TextField(
                                                  controller: countController,
                                                  decoration: InputDecoration(
                                                    //change the text for hint
                                                    hintText: userData.bgOneg
                                                        .toString(),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            side: BorderSide(
                                                                color:
                                                                    Colors.red),
                                                          ))),
                                                      onPressed: () async {
                                                        final userId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        //change update bloodgroup
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'blood banks')
                                                            .doc(userId)
                                                            .update({
                                                          'O- Count':
                                                              double.parse(
                                                                  countController
                                                                      .text
                                                                      .trim()),
                                                        });
                                                        setState(() {
                                                          //cahnge count variable
                                                          oNegCount =
                                                              countController
                                                                  .text
                                                                  .trim();
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop(countController
                                                                .text);
                                                        countController.clear();
                                                      },
                                                      child:
                                                          const Text('Submit'))
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //
                            //AB+ blood count
                            SizedBox(
                              height: 100,
                              width: 320,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                height: 300,
                                width: 400,
                                child: ListTile(
                                  //change here for logo
                                  leading: Image.asset(
                                    aABPositive,
                                    scale: 2.4,
                                  ),
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        //change here for blood bag count
                                        abPosCount,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'units',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 30),
                                      SizedBox(
                                        height: 50,
                                        width: 50,
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
                                                  Colors.grey[800]),
                                          onPressed: () async {
                                            final count = showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                  //change the text for hint
                                                  'Edit AB+ Blood Bags Count',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: TextField(
                                                  controller: countController,
                                                  decoration: InputDecoration(
                                                    //change the text for hint
                                                    hintText: userData.bgABpos
                                                        .toString(),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            side: BorderSide(
                                                                color:
                                                                    Colors.red),
                                                          ))),
                                                      onPressed: () async {
                                                        final userId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        //change update bloodgroup
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'blood banks')
                                                            .doc(userId)
                                                            .update({
                                                          'AB+ Count':
                                                              double.parse(
                                                                  countController
                                                                      .text
                                                                      .trim()),
                                                        });
                                                        setState(() {
                                                          //cahnge count variable
                                                          abPosCount =
                                                              countController
                                                                  .text
                                                                  .trim();
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop(countController
                                                                .text);
                                                        countController.clear();
                                                      },
                                                      child:
                                                          const Text('Submit'))
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //
                            //AB- blood count
                            SizedBox(
                              height: 100,
                              width: 320,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                height: 300,
                                width: 400,
                                child: ListTile(
                                  //change here for logo
                                  leading: Image.asset(
                                    aABNegative,
                                    scale: 2.4,
                                  ),
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        //change here for blood bag count
                                        abNegCount,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'units',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      const SizedBox(width: 30),
                                      SizedBox(
                                        height: 50,
                                        width: 50,
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
                                                  Colors.grey[800]),
                                          onPressed: () async {
                                            final count = showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                  //change the text for hint
                                                  'Edit AB- Blood Bags Count',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: TextField(
                                                  controller: countController,
                                                  decoration: InputDecoration(
                                                    //change the text for hint
                                                    hintText: userData.bgABneg
                                                        .toString(),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            side: BorderSide(
                                                                color:
                                                                    Colors.red),
                                                          ))),
                                                      onPressed: () async {
                                                        final userId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        //change update bloodgroup
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'blood banks')
                                                            .doc(userId)
                                                            .update({
                                                          'AB- Count':
                                                              double.parse(
                                                                  countController
                                                                      .text
                                                                      .trim()),
                                                        });
                                                        setState(() {
                                                          //cahnge count variable
                                                          abNegCount =
                                                              countController
                                                                  .text
                                                                  .trim();
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop(countController
                                                                .text);
                                                        countController.clear();
                                                      },
                                                      child:
                                                          const Text('Submit'))
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
