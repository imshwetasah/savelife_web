import 'package:cloud_firestore/cloud_firestore.dart';

class BloodbankUserModel {
  final String? uid;
  final String name;
  final String city;
  final String email;
  final String fullAddress;
  final String phone;
  final double bgApos;
  final double bgAneg;
  final double bgBpos;
  final double bgBneg;
  final double bgOpos;
  final double bgOneg;
  final double bgABpos;
  final double bgABneg;

  const BloodbankUserModel({
    this.uid,
    required this.name,
    required this.city,
    required this.email,
    required this.fullAddress,
    required this.phone,
    required this.bgApos,
    required this.bgAneg,
    required this.bgBpos,
    required this.bgBneg,
    required this.bgOpos,
    required this.bgOneg,
    required this.bgABpos,
    required this.bgABneg,
  });

  factory BloodbankUserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BloodbankUserModel(
      uid: document.id,
      name: data["bloodbank name"],
      city: data["city"],
      email: data["email"],
      fullAddress: data["full address"],
      phone: data["phone"],
      bgApos: data["A+ Count"],
      bgAneg: data["A- Count"],
      bgBpos: data["B+ Count"],
      bgBneg: data["B- Count"],
      bgOpos: data["O+ Count"],
      bgOneg: data["O- Count"],
      bgABpos: data["AB+ Count"],
      bgABneg: data["AB- Count"],
    );
  }
}
