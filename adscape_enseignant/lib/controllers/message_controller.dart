import 'package:adscape_enseignant/repository/message_repo.dart';
import 'package:get/get.dart';

import '../models/message_model.dart';

class MessageController extends GetxController {
  static MessageController get instance => Get.find();
  final _messageRepo = Get.put(MessageRepo());
  createMsgController(MessageModel msg, String specialite, String urlImg) {
    _messageRepo.createMsg(msg, specialite, urlImg);
  }

  Stream<List<dynamic>> getMessageController(String specialite, String idUser) {
    return _messageRepo.getMessage(specialite, idUser);
  }

  void deleteMsgController(MessageModel msg, String specialite) async {
    await _messageRepo.deleteImageMsg(msg.nomImg!);
    await _messageRepo.deleteMsg(msg.idMsg!, specialite);
  }
}
