import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repository/auth_repo.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final _authRepo = Get.put(AuthRepo());

  Future<bool?> createUserController(UserModel user) async {
    bool? status = await _authRepo.SignUp(user.email!, user.password!);
    if (status == true) await _authRepo.createUser(user);
    return status;
  }

  Future<bool?> loginUserController(UserModel user) async {
    return _authRepo.SignIn(user.email!, user.password!);
  }

  Future<bool?> forguetPasswordController(String email) async {
    return _authRepo.ForguetPassword(email);
  }

  Future<void> logoutController() async {
    _authRepo.logout();
  }

  getUserDetailsController() async {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _authRepo.getUserDetails(email);
    } else
      return null;
  }

  updateUserController(UserModel user) async {
    _authRepo.updateUserRecord(user);
  }

  addSpecialiteToListController(String userId, String element) {
    _authRepo.addSpecialiteToList(userId, element);
  }

  Stream<List<dynamic>> getListSpecilityController(String userId) {
    return _authRepo.getListSpecility(userId);
  }
}
