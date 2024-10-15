import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/message_model.dart';
import '../repository/message_repo.dart';

class MessageController extends GetxController {
  static MessageController get instance => Get.find();
  final _messageRepo = Get.put(MessageRepo());
  createMsgController(
      MessageModel msg, String specialite, Uint8List selectedImageInBytes) {
    _messageRepo.createMsg(msg, specialite, selectedImageInBytes);
  }

  Stream<List<dynamic>> getMessageController(String specialite) {
    return _messageRepo.getMessage(specialite);
  }

  void deleteMsgController(MessageModel msg, String specialite) async {
    await _messageRepo.deleteImageMsg(msg.nomImg!);
    await _messageRepo.deleteMsg(msg.idMsg!, specialite);
  }
}
