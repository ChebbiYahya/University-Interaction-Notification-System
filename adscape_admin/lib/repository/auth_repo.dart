import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
  }

  //Create a user
  createUser(UserModel user) async {
    final docUser = _db.collection(user.role!).doc();
    user = user.setId(docUser.id);
    await docUser.set(user.toJson());
  }

  //Get User
  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Admin").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;

    return userData;
  }

//Sign Up
  Future<bool?> SignUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
  //Sign In

  Future<bool?> SignIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserModel usr = await getUserDetails(email);
      if (usr.role == "Admin")
        return true;
      else
        return false;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //Logout
  Future<void> logout() async => await _auth.signOut();
}
