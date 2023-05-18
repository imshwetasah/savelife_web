import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savelife_web/bloodbank/model/bloodbank_user_model.dart';

class BloodbankUserRepository {
  final _db = FirebaseFirestore.instance;

  Future<BloodbankUserModel> getBloodbankUserDetails(String email) async {
    final snapshot = await _db
        .collection("blood banks")
        .where("email", isEqualTo: email)
        .get();
    final userData =
        snapshot.docs.map((e) => BloodbankUserModel.fromSnapshot(e)).single;

    return userData;
  }
}
