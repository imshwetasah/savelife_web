import 'package:firebase_auth/firebase_auth.dart';
import 'package:savelife_web/bloodbank/model/bloodbank_user_repository.dart';

class BloodbankProfileController {
  final user = FirebaseAuth.instance.currentUser;
  final userRepo = BloodbankUserRepository();
  getBloodBankUserData() {
    final email = user!.email;
    if (email != null) {
      return userRepo.getBloodbankUserDetails(email);
    }
  }
}
