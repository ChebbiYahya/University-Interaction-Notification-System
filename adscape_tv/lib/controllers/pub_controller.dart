import 'dart:typed_data';

import 'package:get/get.dart';
import '../models/pub_model.dart';
import '../repository/pub_repo.dart';

class PubController extends GetxController {
  static PubController get instance => Get.find();
  final _pubRepo = Get.put(PubRepo());

  createPubController(PubModel pub, Uint8List selectedImageInBytes) {
    _pubRepo.createPub(pub, selectedImageInBytes);
  }

  Stream<List<dynamic>> getPubController() {
    return _pubRepo.getPub();
  }
}
