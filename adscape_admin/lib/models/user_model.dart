import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? role;

  const UserModel({
    this.id,
    this.email,
    this.password,
    this.fullName,
    this.role,
  });
  UserModel setId(String IdUser) {
    return UserModel(
      id: IdUser,
      email: this.email,
      password: this.password,
      fullName: this.fullName,
      role: this.role,
    );
  }

  toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "password": password,
      "role": role,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data["email"],
      password: data["password"],
      fullName: data["fullName"],
      role: data["role"],
    );
  }
}
