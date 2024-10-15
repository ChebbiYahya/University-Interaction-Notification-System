import 'package:get/get.dart';
import '../repository/message_repo.dart';

class MessageController extends GetxController {
  static MessageController get instance => Get.find();
  final _messageRepo = Get.put(MessageRepo());

  Stream<List<dynamic>> getMessageStremController(String specialite) {
    return _messageRepo.getMessageStream(specialite);
  }
}
